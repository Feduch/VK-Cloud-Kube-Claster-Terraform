output "kubeconfig" {
  value     = vkcs_kubernetes_cluster.k8s-cluster.k8s_config
  sensitive = true
}

output "cluster_name" {
  value = vkcs_kubernetes_cluster.k8s-cluster.name
}