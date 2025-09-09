# Настройка провайдера Kubernetes для работы с созданным кластером
data "vkcs_kubernetes_cluster" "k8s-cluster" {
  name = vkcs_kubernetes_cluster.k8s-cluster.name
}

provider "kubernetes" {
  host                   = data.vkcs_kubernetes_cluster.k8s-cluster.api_address
  config_path = "~/.kube/ai-issue-genius-cluster_kubeconfig.yaml"
}

# 1. Создание неймспейса для приложения
resource "kubernetes_namespace_v1" "ai_issue_genius_ns" {
  metadata {
    name = "ai-issue-genius"
  }
}

resource "kubernetes_config_map_v1" "postgres_init_script" {
  metadata {
    name      = "postgres-init-script"
    namespace = kubernetes_namespace_v1.ai_issue_genius_ns.metadata[0].name
  }

  data = {
    "prepare_database.sql" = file("${path.module}/prepare_database.sql")
  }
}

resource "kubernetes_deployment_v1" "postgres" {
  depends_on = [kubernetes_persistent_volume_claim_v1.postgres_pvc]

  metadata {
    name      = "postgres"
    namespace = kubernetes_namespace_v1.ai_issue_genius_ns.metadata[0].name
    labels = {
      app = "postgres"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "postgres"
      }
    }
    template {
      metadata {
        labels = {
          app = "postgres"
        }
      }
      spec {
        security_context {
          fs_group = 999
        }

        container {
          name  = "postgres"
          image = "postgres:17.4"

          volume_mount {
            name       = "init-script"
            mount_path = "/docker-entrypoint-initdb.d"
          }

          security_context {
            run_as_user  = 999
            run_as_group = 999
          }

          port {
            container_port = 5432
          }

          env {
            name  = "POSTGRES_DB"
            value = "postgres"
          }
          env {
            name  = "POSTGRES_USER"
            value = "postgres"
          }
          env {
            name  = "POSTGRES_PASSWORD"
            value = "postgres"
          }

          env {
            name  = "PGDATA"
            value = "/var/lib/postgresql/data/pgdata"
          }

          volume_mount {
            name       = "postgres-storage"
            mount_path = "/var/lib/postgresql"
          }

          liveness_probe {
            exec {
              command = ["pg_isready", "-U", "postgres"]
            }
            initial_delay_seconds = 60
            period_seconds        = 10
          }

          readiness_probe {
            exec {
              command = ["pg_isready", "-U", "postgres"]
            }
            initial_delay_seconds = 30
            period_seconds        = 5
          }
        }

        volume {
          name = "init-script"
          config_map {
            name = kubernetes_config_map_v1.postgres_init_script.metadata[0].name
          }
        }

        volume {
          name = "postgres-storage"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim_v1.postgres_pvc.metadata[0].name
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "postgres" {
  metadata {
    name      = "postgres-service"
    namespace = kubernetes_namespace_v1.ai_issue_genius_ns.metadata[0].name
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.postgres.spec[0].template[0].metadata[0].labels.app
    }
    port {
      port        = 5432
      target_port = 5432
    }
    type = "ClusterIP"
  }
}

# # 4. Развертывание AI Issue Genius Server
# resource "kubernetes_deployment_v1" "ai_issue_genius_server" {
#   metadata {
#     name      = "ai-issue-genius-server"
#     namespace = kubernetes_namespace_v1.ai_issue_genius_ns.metadata[0].name
#     labels = {
#       app = "ai-issue-genius-server"
#     }
#   }
#
#   spec {
#     replicas = 1
#     selector {
#       match_labels = {
#         app = "ai-issue-genius-server"
#       }
#     }
#     template {
#       metadata {
#         labels = {
#           app = "ai-issue-genius-server"
#         }
#       }
#       spec {
#         image_pull_secrets {
#           name = "gitlab-registry"
#         }
#
#         container {
#           name  = "server"
#           image = "registry.gitlab.com/ai8595334/ai-issue-genius/ai-issue-genius-server"
#           # Укажите необходимые переменные среды для подключения к БД
#           env {
#             name  = "DB_HOST"
#             value = kubernetes_service_v1.postgres.metadata[0].name # Используем имя сервиса
#           }
#           env {
#             name  = "DB_PORT"
#             value = "5432"
#           }
#           env {
#             name  = "DB_NAME"
#             value = "ai_issue_genius"
#           }
#           env {
#             name  = "DB_USER"
#             value = "ai_issue_genius"
#           }
#           env {
#             name  = "DB_PASSWORD"
#             value = "ai_issue_genius"
#           }
#         }
#       }
#     }
#   }
# }
#
# # Сервис для доступа к AI Issue Genius Server (если нужен)
# resource "kubernetes_service_v1" "ai_issue_genius_server_svc" {
#   metadata {
#     name      = "ai-issue-genius-server-service"
#     namespace = kubernetes_namespace_v1.ai_issue_genius_ns.metadata[0].name
#   }
#   spec {
#     selector = {
#       app = kubernetes_deployment_v1.ai_issue_genius_server.spec[0].template[0].metadata[0].labels.app
#     }
#     port {
#       port        = 80 # Укажите правильный порт, который слушает ваш server
#       target_port = 80 # Укажите правильный порт контейнера
#     }
#     type = "ClusterIP" # Или LoadBalancer/NodePort для доступа снаружи
#   }
# }
#
# # 5. Развертывание AI Issue Genius Agent
# resource "kubernetes_deployment_v1" "ai_issue_genius_agent" {
#   metadata {
#     name      = "ai-issue-genius-agent"
#     namespace = kubernetes_namespace_v1.ai_issue_genius_ns.metadata[0].name
#     labels = {
#       app = "ai-issue-genius-agent"
#     }
#   }
#
#   spec {
#     replicas = 1
#     selector {
#       match_labels = {
#         app = "ai-issue-genius-agent"
#       }
#     }
#     template {
#       metadata {
#         labels = {
#           app = "ai-issue-genius-agent"
#         }
#       }
#       spec {
#         image_pull_secrets {
#           name = "gitlab-registry"
#         }
#
#         container {
#           name  = "agent"
#           image = "registry.gitlab.com/ai8595334/ai-issue-genius/ai-issue-genius-agent"
#           # Укажите необходимые переменные среды для подключения к server
#           env {
#             name  = "SERVER_URL"
#             value = "http://ai-issue-genius-server-service:80" # Используем имя сервиса
#           }
#         }
#       }
#     }
#   }
# }

resource "kubernetes_persistent_volume_claim_v1" "postgres_pvc" {
  metadata {
    name      = "postgres-pvc"
    namespace = kubernetes_namespace_v1.ai_issue_genius_ns.metadata[0].name
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    storage_class_name = "csi-ceph-ssd-ms1"

    resources {
      requests = {
        storage = "10Gi"
      }
    }
  }

  depends_on = [kubernetes_namespace_v1.ai_issue_genius_ns]
}
