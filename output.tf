output "instance_public_ips" {
  description = "Public IP addresses of the created instances"
  value = {
    for name, instance in yandex_compute_instance.k8s_nodes :
    name => instance.network_interface.0.nat_ip_address
  }
}

output "ssh_commands" {
  description = "SSH commands to connect to instances"
  value = {
    for name, instance in yandex_compute_instance.k8s_nodes :
    name => "ssh ubuntu@${instance.network_interface.0.nat_ip_address}"
  }
}

output "masters" {
  description = "Master nodes information"
  value = {
    for name, instance in yandex_compute_instance.k8s_nodes :
    name => {
      public_ip  = instance.network_interface.0.nat_ip_address
      private_ip = instance.network_interface.0.ip_address
      fqdn = "${name}.k8s.local"
    } if instance.metadata.role == "master"
  }
}

output "workers" {
  description = "Worker nodes information"
  value = {
    for name, instance in yandex_compute_instance.k8s_nodes :
    name => {
      ip = instance.network_interface.0.nat_ip_address
      fqdn = "${name}.k8s.local"
    } if instance.metadata.role == "worker"
  }
}
