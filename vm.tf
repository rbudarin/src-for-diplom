# Image
data "yandex_compute_image" "image" {
  family = var.vm_image
}

# VM Master and Worker
resource "yandex_compute_instance" "k8s_nodes" {
  for_each = var.vm_resources

  name        = each.key
  hostname    = "${each.key}.k8s.local"
  platform_id = "standard-v2"
  zone        = each.value.zone

  resources {
    cores  = each.value.cpu
    memory = each.value.ram
  }

  scheduling_policy {
    preemptible = each.value.preemptible
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image.image_id
      size     = each.value.disk_size
      type     = each.value.disk_type
    }
  }

  network_interface {
    subnet_id = local.subnets-vm[each.value.subnet_name]
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_public_key)}"
    role     = each.value.role
  }

  labels = {
    environment = "production"
    managed-by  = "terraform"
    component   = "kubernetes"
    node-role   = each.value.role
  }
}
