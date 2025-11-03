

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
