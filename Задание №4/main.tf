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
  service_account_key_file = var.service_account_key_file
}

locals {
  ssh_keys_list = compact(split("\n", file(var.public_key_path)))

  rendered_cloud_init_marketing = templatefile("${path.module}/templates/cloud-init.yml.tpl", {
    ssh_keys = local.ssh_keys_list
  })
  rendered_cloud_init_analytics = templatefile("${path.module}/templates/cloud-init.yml.tpl", {
    ssh_keys = local.ssh_keys_list
  })
}

data "yandex_vpc_network" "existing_network" {
  name      = "develop-network" 
  folder_id = var.folder_id     
}

# 1. Вызов модуля VPC для разработки (DEVELOP)
module "vpc_dev" {
  source   = "./vpc"
  env_name = "develop"
  # Передаем ID найденной сети
  network_id = data.yandex_vpc_network.existing_network.id 
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" }, 
  ]
}

# 2. Вызов модуля VPC для производства (PRODUCTION)
module "vpc_prod" {
  source   = "./vpc"
  env_name = "production"
  network_id = data.yandex_vpc_network.existing_network.id 
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.2.0/24" }, 
    { zone = "ru-central1-b", cidr = "10.0.3.0/24" },
    { zone = "ru-central1-d", cidr = "10.0.4.0/24" },
  ]
}


# --- Вызовы модулей ВМ ---

# 3. Вызов модуля для Marketing VM (в зоне A)
module "marketing_vm" {
  source = "./module/vm_creator"

  vm_name            = "marketing-vm"
  vm_hostname        = "marketing-vm"
  zone               = "ru-central1-a" 
  instance_labels    = { project = "marketing", team = "infrastructure" } 
  cloud_init_content = local.rendered_cloud_init_marketing
  subnet_id          = module.vpc_prod.subnet_ids["ru-central1-a-10.0.2.0/24"] 
}

# 4. Вызов модуля для Analytics VM (в зоне B)
module "analytics_vm" {
  source = "./module/vm_creator"

  vm_name            = "analytics-vm"
  vm_hostname        = "analytics-vm"
  zone               = "ru-central1-b" 
  instance_labels    = { project = "analytics", environment = "dev" }
  cloud_init_content = local.rendered_cloud_init_analytics
  subnet_id          = module.vpc_prod.subnet_ids["ru-central1-b-10.0.3.0/24"] 
}
