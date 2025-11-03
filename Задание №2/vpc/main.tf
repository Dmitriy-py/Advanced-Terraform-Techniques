terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.13.0"

resource "yandex_vpc_network" "network" { name = "${var.env_name}-network" }

resource "yandex_vpc_subnet" "subnet" {
  name           = "${var.env_name}-subnet-${var.zone}"
  network_id     = yandex_vpc_network.network.id
  zone           = var.zone
  v4_cidr_blocks = [var.cidr]
}

output "subnet_id" { value = yandex_vpc_subnet.subnet.id }
output "subnet_info" { value = yandex_vpc_subnet.subnet }
