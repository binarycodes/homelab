locals {
  debian12_template_name = "debian12"
  n1_vms = {
    1001 = {
      description = "debian-1-description"
      cpu         = "host"
      cores       = 1
      memory      = 2048
      disk_size   = "20"
      ip_v4       = "192.168.1.51"
      gateway     = "192.168.1.1"
      nameserver  = "192.168.1.1"
      username    = var.vm_username
      password    = var.vm_password
      ssh_keys    = var.vm_ssh_keys
    }
    1002 = {
      description = "debian-1-description"
      cpu         = "host"
      cores       = 1
      memory      = 2048
      disk_size   = "20"
      ip_v4       = "192.168.1.52"
      gateway     = "192.168.1.1"
      nameserver  = "192.168.1.1"
      username    = var.vm_username
      password    = var.vm_password
      ssh_keys    = var.vm_ssh_keys
    }
    1003 = {
      description = "debian-1-description"
      cpu         = "host"
      cores       = 2
      memory      = 2048
      disk_size   = "20"
      ip_v4       = "192.168.1.53"
      gateway     = "192.168.1.1"
      nameserver  = "192.168.1.1"
      username    = var.vm_username
      password    = var.vm_password
      ssh_keys    = var.vm_ssh_keys
    }
  }
  n2_vms = {
    2001 = {
      description = "debian-1-description"
      cpu         = "host"
      cores       = 1
      memory      = 2048
      disk_size   = "20"
      ip_v4       = "192.168.1.61"
      gateway     = "192.168.1.1"
      nameserver  = "192.168.1.1"
      username    = var.vm_username
      password    = var.vm_password
      ssh_keys    = var.vm_ssh_keys
    }
    2002 = {
      description = "debian-1-description"
      cpu         = "host"
      cores       = 1
      memory      = 2048
      disk_size   = "20"
      ip_v4       = "192.168.1.62"
      gateway     = "192.168.1.1"
      nameserver  = "192.168.1.1"
      username    = var.vm_username
      password    = var.vm_password
      ssh_keys    = var.vm_ssh_keys
    }
  }
}
