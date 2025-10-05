variable "proxmox_endpoint" {
  type      = string
  sensitive = true
}

variable "proxmox_api_token" {
  type      = string
  sensitive = true
}

variable "keycloak_realm" {
  type      = string
  sensitive = true
}

variable "keycloak_client_id" {
  type      = string
  sensitive = true
}

variable "keycloak_client_secret" {
  type      = string
  sensitive = true
}

variable "keycloak_url" {
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

variable "ca_keycloak_realm" {
  type      = string
  sensitive = true
}

variable "ca_keycloak_server_url" {
  type      = string
  sensitive = true
}

variable "ca_keycloak_token_url" {
  type      = string
  sensitive = true
}

variable "ca_user_public_key" {
  type      = string
  sensitive = true
}
