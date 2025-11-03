terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.13.0"
}
provider "yandex" {
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
  service_account_key_file = var.sa_key_path
}

locals {
  ssh_keys_list = compact(split("\n", file(var.public_key_path)))
  cloud_init_content = templatefile("${path.module}/templates/cloud-init.yml.tpl", {
    ssh_keys = local.ssh_keys_list
  })
}

module "vpc_dev" {
  source   = "./vpc"
  env_name = "develop"
  zone     = var.zone
  cidr     = "10.0.1.0/24"
}

module "marketing_vm" {
  source = "./module/vm_creator"
  vm_name = "marketing-vm"
  vm_hostname = "marketing-vm"
  zone = var.zone
  instance_labels = { project = "marketing", team = "infra" }
  cloud_init_content = local.cloud_init_content
  subnet_id = module.vpc_dev.subnet_id # Используем output из VPC модуля
}

module "analytics_vm" {
  source = "./module/vm_creator"
  vm_name = "analytics-vm"
  vm_hostname = "analytics-vm"
  zone = var.zone
  instance_labels = { project = "analytics", env = "dev" }
  cloud_init_content = local.cloud_init_content
  subnet_id = module.vpc_dev.subnet_id
}
