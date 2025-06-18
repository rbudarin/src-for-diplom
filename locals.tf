# Subnet configuration
locals {
  subnets = {
    "subnet-a" = {
      zone           = "ru-central1-a"
      v4_cidr_blocks = ["192.168.1.0/24"]
    },
    "subnet-b" = {
      zone           = "ru-central1-b"
      v4_cidr_blocks = ["192.168.2.0/24"]
    },
    "subnet-d" = {
      zone           = "ru-central1-d"
      v4_cidr_blocks = ["192.168.3.0/24"]
    }
  }
}

# Subnet for VM
locals {
  subnets-vm = {
    "subnet-a" = yandex_vpc_subnet.subnets["subnet-a"].id
    "subnet-b" = yandex_vpc_subnet.subnets["subnet-b"].id
    "subnet-d" = yandex_vpc_subnet.subnets["subnet-d"].id
  }
}

