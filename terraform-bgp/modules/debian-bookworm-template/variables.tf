variable "config" {
  type = object({
    image_id    = string
    node        = string
    vmid        = number
    name        = string
    description = optional(string, "")
    dhcp        = bool
    bridge      = optional(string, "LabNet")
    bios        = optional(string, "seabios")
    cores       = optional(number, 1)
    cpu         = optional(string, "x86-64-v2-AES")
    memory      = optional(number, 2048)
    disk_size   = optional(number, 10)
    timezone    = string
    username    = string
    user_id     = number
    tags        = optional(set(string), [])
  })
}

variable "ssh_authorized_key" {
  type      = string
  sensitive = true
}
