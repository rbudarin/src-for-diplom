resource "local_file" "ansible_inventory" {
  filename = "${path.module}/ansible/hosts.cfg"
  content = templatefile("${path.module}/templates/ansible_inventory.tpl", {
    masters = [
      for name, instance in yandex_compute_instance.k8s_nodes :
      {
        name       = name
        public_ip  = instance.network_interface.0.nat_ip_address
        private_ip = instance.network_interface.0.ip_address
      } if instance.metadata.role == "master"
    ]
    workers = [
      for name, instance in yandex_compute_instance.k8s_nodes :
      {
        name       = name
        public_ip  = instance.network_interface.0.nat_ip_address
        private_ip = instance.network_interface.0.ip_address
      } if instance.metadata.role == "worker"
    ]
  })
}
