locals {
  hosts_count = var.ha ? 2 : 1 
}

resource "yandex_mdb_mysql_cluster" "cluster" {
  name        = var.cluster_name
  environment = "PRESTABLE"
  network_id  = var.network_id
  version     = "8.0"

  resources {
    resource_preset_id = "s1.micro"
    disk_type_id       = "network-hdd"
    disk_size          = 10
  }

  host {
    zone      = var.zone
    subnet_id = var.subnet_id 
  }

  dynamic "host" {
    for_each = local.hosts_count > 1 ? [1] : []
    content {
      zone      = "ru-central1-b"
      subnet_id = var.subnet_id_ha
    }
  }
}
