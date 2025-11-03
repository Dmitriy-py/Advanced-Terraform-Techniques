variable "vm_name" { type = string }
variable "vm_hostname" { type = string }
variable "instance_labels" { type = map(string) }
variable "zone" { type = string }
variable "cloud_init_content" { type = string }
variable "subnet_id" { type = string }
