variable "config" {
  type = object({
    node        = string
    vmid        = number
    name        = string
    description = optional(string, "")
    dhcp        = bool
    bridge      = optional(string, "IoTNet")
    bios        = optional(string, "ovmf")
    cores       = optional(number, 1)
    cpu         = optional(string, "host")
    memory      = optional(number, 2048)
    disk_size   = optional(number, 32)
    timezone    = string
    username    = string
  })
}
