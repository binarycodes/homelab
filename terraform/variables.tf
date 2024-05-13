variable "proxmox_api_url" {
  type = map(string)
}

variable "proxmox_api_token_id" {
  type      = map(string)
  sensitive = true
}

variable "proxmox_api_token_secret" {
  type      = map(string)
  sensitive = true
}

variable "vm_username" {
  type      = string
  sensitive = true
}

variable "vm_password" {
  type      = string
  sensitive = true
}

variable "vm_ssh_keys" {
  type      = string
  sensitive = true
}
