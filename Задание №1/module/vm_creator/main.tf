resource "yandex_compute_instance" "vm" {
  name        = var.vm_name
  zone        = var.zone
  hostname    = var.vm_hostname
  labels      = var.instance_labels

  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd8l4jle6f83dt7hsv30" # Debian 12
      size     = 10
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
    security_group_ids = [var.security_group_id]
  }

  metadata = {
    user-data = var.cloud_init_content
  }
}

output "vm" { value = yandex_compute_instance.vm }
output "external_ip" { value = yandex_compute_instance.vm.network_interface[0].nat_ip_address }
