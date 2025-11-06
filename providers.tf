# providers.tf
# (Начало файла)
terraform {
  
  required_version = ">= 1.13.0" 
  
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
    }
  }
  
  backend "s3" {
    bucket  = "ter-hw04-final-bucket-999" # <-- Проверьте имя
    key     = "terraform.tfstate" 
    region  = "ru-central1" 
    use_lockfile = true 
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true 
  }
} 
# ^ Эта скобка закрывает terraform {}
# Если вы видите ее красной, значит, скобка выше была лишней.

# Блок провайдера Yandex (ВНЕ блока terraform {})
provider "yandex" {
  service_account_key_file = "~/ter_hw04_task1/authorized_key.json"
  cloud_id                 = "b1g77q1uj2nvo40nk61r"
  folder_id                = "b1gakqg2opjsih3min3i"
  zone                     = "ru-central1-a" 
}
# (Конец файла)