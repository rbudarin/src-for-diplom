# VM Imagr
vm_image  = "ubuntu-2004-lts"

# Public ssh key for VM
ssh_public_key = "~/.ssh/k8s.pub"

# VM Configuration
vm_resources = {
  "master-01" = {
    zone        = "ru-central1-a"
    subnet_name = "subnet-a"
    role        = "master"
    cpu         = 2
    ram         = 4
    disk_type   = "network-ssd"
    disk_size   = 30
    preemptible = false
  },
  "worker-01" = {
    zone        = "ru-central1-a"
    subnet_name = "subnet-a"
    role        = "worker"
    cpu         = 2
    ram         = 4
    disk_type   = "network-hdd"
    disk_size   = 30
    preemptible = true
  },
  "worker-02" = {
    zone        = "ru-central1-b"
    subnet_name = "subnet-b"
    role        = "worker"
    cpu         = 2
    ram         = 4
    disk_type   = "network-hdd"
    disk_size   = 30
    preemptible = true
  }
}
