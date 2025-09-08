variable "proxmox_endpoint" {
  type      = string
  sensitive = true
}

variable "proxmox_api_token" {
  type      = string
  sensitive = true
}

variable "vm_username" {
  type      = string
  sensitive = true
}

variable "vm_user_id" {
  type      = number
  sensitive = true
}

variable "vm_timezone" {
  type = string
}

variable "ca_server_url" {
  type      = string
  sensitive = true
}

variable "ca_sso_client_id" {
  type      = string
  sensitive = true
}

variable "ca_sso_client_secret" {
  type      = string
  sensitive = true
}

variable "ca_sso_token_url" {
  type      = string
  sensitive = true
}

variable "ca_user_public_key" {
  type      = string
  sensitive = true
}
