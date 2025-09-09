# resource "openstack_networking_secgroup_v2" "k8s_sg" {
#   name        = "k8s-secgroup"
#   description = "Security group for Kubernetes"
# }
#
# resource "openstack_networking_secgroup_rule_v2" "ssh" {
#   direction         = "ingress"
#   ethertype         = "IPv4"
#   protocol          = "tcp"
#   port_range_min    = 22
#   port_range_max    = 22
#   remote_ip_prefix  = "0.0.0.0/0"
#   security_group_id = openstack_networking_secgroup_v2.k8s_sg.id
# }
#
# resource "openstack_networking_secgroup_rule_v2" "k8s_api" {
#   direction         = "ingress"
#   ethertype         = "IPv4"
#   protocol          = "tcp"
#   port_range_min    = 6443
#   port_range_max    = 6443
#   remote_ip_prefix  = "0.0.0.0/0"
#   security_group_id = openstack_networking_secgroup_v2.k8s_sg.id
# }