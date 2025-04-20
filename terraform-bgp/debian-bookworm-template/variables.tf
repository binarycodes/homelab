variable "config" {
  type = object({
    node        = string
    vmid        = number
    name        = string
    description = optional(string, "")
    dhcp        = bool
    bridge      = optional(string, "LabNet")
    bios        = optional(string, "seabios")
    cores       = optional(number, 1)
    cpu         = optional(string, "host")
    memory      = optional(number, 2048)
    disk_size   = optional(number, 10)
    timezone    = string
    username    = string
  })
}
