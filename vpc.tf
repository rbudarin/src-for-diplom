resource "yandex_vpc_network" "network" {
  name = "main-network"
}

# Создание подсетей с использованием locals
resource "yandex_vpc_subnet" "subnets" {
  for_each = local.subnets

  name           = "${each.key}"
  zone           = each.value.zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = each.value.v4_cidr_blocks
}
