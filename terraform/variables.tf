variable "proxmox" {
  type = map(string)
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
