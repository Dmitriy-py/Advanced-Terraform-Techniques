variable "cloud_id" { type = string }
variable "folder_id" { type = string }
variable "zone" { default = "ru-central1-a" }
variable "public_key_path" { default = "/home/user/.ssh/id_rsa.pub" }
variable "sa_key_path" { default = "authorized_key.json" }
