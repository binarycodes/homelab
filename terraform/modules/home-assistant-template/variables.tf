variable "config" {
  type = object({
    image_id    = string
    node        = string
    vmid        = number
    name        = string
    description = optional(string, "")
    dhcp        = bool
    bridge      = optional(string, "IoTNet")
    bios        = optional(string, "ovmf")
    cores       = optional(number, 1)
    cpu         = optional(string, "x86-64-v2-AES")
    memory      = optional(number, 2048)
    disk_size   = optional(number, 32)
    tags        = optional(set(string), [])
  })
}
