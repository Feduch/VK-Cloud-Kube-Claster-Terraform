data "vkcs_compute_flavor" "k8s-master-flavor" {
    name = "STD2-2-6"
}

data "vkcs_compute_flavor" "k8s-node-group-flavor" {
 name = "STD2-2-4"
}

data "vkcs_kubernetes_clustertemplate" "k8s-template" {
    version = "1.31"
}

resource "vkcs_kubernetes_cluster" "k8s-cluster" {

  depends_on = [
    vkcs_networking_router_interface.k8s,
  ]

  name                = "ai-issue-genius-cluster"
  cluster_template_id = data.vkcs_kubernetes_clustertemplate.k8s-template.id
  master_flavor       = data.vkcs_compute_flavor.k8s-master-flavor.id
  master_count        = 1
  network_id          = vkcs_networking_network.k8s.id
  subnet_id           = vkcs_networking_subnet.k8s.id
  availability_zone   = "MS1"

  floating_ip_enabled = true

}

resource "vkcs_kubernetes_node_group" "k8s-node-group" {
  name = "ai-issue-genius-group"
  cluster_id = vkcs_kubernetes_cluster.k8s-cluster.id
  flavor_id = data.vkcs_compute_flavor.k8s-node-group-flavor.id

  node_count = 1


  labels {
        key = "env"
        value = "test"
    }

  labels {
        key = "disktype"
        value = "ssd"
    }
}
