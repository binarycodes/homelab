variable "config" {
  type = object({
    node         = string
    vmid         = optional(number, null)
    name         = string
    description  = optional(string, "")
    dhcp         = bool
    searchdomain = optional(string, "localdomain")
    bridge       = optional(string, "LabNet")
    bios         = optional(string, "seabios")
    cores        = optional(number, 1)
    cpu          = optional(string, "x86-64-v2-AES")
    memory       = optional(number, 2048)
    disk_size    = optional(number, 10)
    timezone     = string
    username     = string
    user_id      = number
    tags         = optional(set(string), [])
  })
}

variable "ssh_authorized_key" {
  type      = string
  sensitive = true
}

variable "user_cloud_init_file" {
  description = "Optional path to user cloud-init template file"
  type        = string
  default     = null

  validation {
    condition = (
      var.user_cloud_init_file == null ||
      can(
        fileexists(var.user_cloud_init_file)
        && (
          endswith(var.user_cloud_init_file, ".yml")
          || endswith(var.user_cloud_init_file, ".yaml")
        )
      )
    )
    error_message = "user_cloug_init_file must be a .yml or .yaml file and must exist if provided."
  }
}

variable "network_cloud_init_file" {
  description = "Optional path to user cloud-init template file"
  type        = string
  default     = null

  validation {
    condition = (
      var.network_cloud_init_file == null ||
      can(
        fileexists(var.network_cloud_init_file)
        && (
          endswith(var.network_cloud_init_file, ".yml")
          || endswith(var.network_cloud_init_file, ".yaml")
        )
      )
    )
    error_message = "user_cloug_init_file must be a .yml or .yaml file and must exist if provided."
  }
}
