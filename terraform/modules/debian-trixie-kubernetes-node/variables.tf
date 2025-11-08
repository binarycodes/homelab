variable "config" {
  type = object({
    node             = string
    vmid             = optional(number, null)
    name             = string
    description      = optional(string, "")
    dhcp             = bool
    searchdomain     = optional(string, "localdomain")
    bridge           = optional(string, "LabNet")
    ip4_address_cidr = optional(string)
    dns_addresses    = optional(set(string), [])
    gateway          = optional(string)
    bios             = optional(string, "seabios")
    cores            = optional(number, 2)
    cpu              = optional(string, "x86-64-v2-AES")
    memory           = optional(number, 2048)
    disk_size        = optional(number, 10)
    timezone         = string
    username         = string
    user_id          = number
    tags             = optional(set(string), [])
    type             = string
    packages         = optional(list(string), [])
    runcmds          = optional(list(string), [])
    write_files = optional(list(object({
      path        = string
      content     = string
      owner       = optional(string, "")
      permissions = optional(string, "")
      encoding    = optional(string, "")
    })), [])
  })

  validation {
    condition     = (var.config.cores >= 2)
    error_message = "kubernetes nodes requires atleast 2 cpu cores"
  }

  validation {
    condition     = contains(["control-plane", "worker"], var.config.type)
    error_message = "type must be either 'control-plane' or 'worker'."
  }
}

variable "cloud_init_template_file" {
  description = "Optional path to cloud-init template file"
  type        = string
  default     = null

  validation {
    condition = (
      var.cloud_init_template_file == null ||
      can(
        fileexists(var.cloud_init_template_file)
        && (
          endswith(var.cloud_init_template_file, ".yml")
          || endswith(var.cloud_init_template_file, ".yaml")
        )
      )
    )
    error_message = "cloud_init_template_file must be a .yml or .yaml file and must exist if provided."
  }
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
