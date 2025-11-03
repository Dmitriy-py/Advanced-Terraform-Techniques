# ... (terraform, provider, locals blocks) ...

# Поиск существующей сети для переиспользования
data "yandex_vpc_network" "existing_network" {
  # !!! ЗАМЕНИТЕ "develop-network" НА ИМЯ ВАШЕЙ АКТУАЛЬНОЙ СЕТИ !!!
  name      = "develop-network" 
  folder_id = var.folder_id     
}



module "vpc_dev" {
  source   = "./vpc"
  env_name = "develop"
  network_id = data.yandex_vpc_network.existing_network.id 
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" }, 
  ]
}

module "vpc_prod" {
  source   = "./vpc"
  env_name = "production"
  network_id = data.yandex_vpc_network.existing_network.id 
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.2.0/24" }, 
    { zone = "ru-central1-b", cidr = "10.0.3.0/24" },
    { zone = "ru-central1-d", cidr = "10.0.4.0/24" }, # Корректная зона D
  ]
}

# ВМ привязываются к подсетям PROD
module "marketing_vm" {
  source = "./module/vm_creator"
  vm_name = "marketing-vm"
  vm_hostname = "marketing-vm"
  zone = "ru-central1-a"
  instance_labels = { project = "marketing", team = "infra" }
  cloud_init_content = local.cloud_init_content
  subnet_id = module.vpc_prod.subnet_ids["ru-central1-a-10.0.2.0/24"] 
}

module "analytics_vm" {
  source = "./module/vm_creator"
  vm_name = "analytics-vm"
  vm_hostname = "analytics-vm"
  zone = "ru-central1-b"
  instance_labels = { project = "analytics", env = "dev" }
  cloud_init_content = local.cloud_init_content
  subnet_id = module.vpc_prod.subnet_ids["ru-central1-b-10.0.3.0/24"] 
}
