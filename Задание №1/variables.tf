variable "cloud_id" {type                = string}
variable "folder_id" {type               = string}
variable "zone" {type                     = string
  default = "ru-central1-a"
}
variable "public_key_path" {type          = string
  default = "~/.ssh/id_rsa.pub" 
}
variable "service_account_key_file" {type = string
  default = "authorized_key.json"
}
