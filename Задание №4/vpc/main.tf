terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.13.0"
}

resource "yandex_vpc_subnet" "subnet" {
  for_each = {
    for s in var.subnets : "${s.zone}-${s.cidr}" => s
  }
  name           = "${var.env_name}-subnet-${each.value.zone}"
  network_id     = var.network_id
  zone           = each.value.zone
  v4_cidr_blocks = [each.value.cidr]
}

output "subnet_ids" {
  value = { for k, s in yandex_vpc_subnet.subnet : k => s.id }
}
