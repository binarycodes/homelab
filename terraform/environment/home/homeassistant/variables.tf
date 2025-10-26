variable "proxmox_endpoint" {
  type      = string
  sensitive = true
}

variable "proxmox_api_token" {
  type      = string
  sensitive = true
}

variable "dns_server" {
  type      = string
  sensitive = true
}

variable "dns_key_name" {
  type      = string
  sensitive = true
}

variable "dns_key_secret" {
  type      = string
  sensitive = true
}

variable "dns_zone" {
  type      = string
  sensitive = true
}
