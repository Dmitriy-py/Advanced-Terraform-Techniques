module "mysql_cluster_example" {
  source       = "./module/db_cluster"
  cluster_name = "example-single-host" 
  network_id   = data.yandex_vpc_network.existing_network.id
  zone         = "ru-central1-a"
  
  # Сценарий А: false, Сценарий Б: true
  ha           = false 
  
  # Подсети для хостов
  subnet_id    = module.vpc_dev.subnet_ids["ru-central1-a-10.0.1.0/24"]
  subnet_id_ha = module.vpc_prod.subnet_ids["ru-central1-b-10.0.3.0/24"] 
}

module "mysql_components" {
  source          = "./module/db_component"
  cluster_id      = module.mysql_cluster_example.cluster_id
  db_name         = "test"
  user_name       = "app"
  user_password   = "SuperSecure123" 
}
