variable "env_name" { type = string }
variable "network_id" { type = string }
variable "subnets" { 
  type = list(object({ zone = string, cidr = string }))
}
