locals {
  debian12_template_name = "debian12"
  pve1_vms = {
    1001 = {
      description  = "reverse proxy"
      cpu          = "host"
      cores        = 1
      memory       = 2048
      disk_size    = "20"
      dhcp         = false
      ip_v4        = "10.88.1.3/16"
      gateway      = "10.88.0.1"
      nameserver   = "10.88.0.1"
      searchdomain = "localdomain"
      username     = var.vm_username
      password     = var.vm_password
      ssh_keys     = var.vm_ssh_keys
    }
    1002 = {
      description  = "site-2-site vpn"
      cpu          = "host"
      cores        = 1
      memory       = 2048
      disk_size    = "20"
      dhcp         = true
      searchdomain = "localdomain"
      username     = var.vm_username
      password     = var.vm_password
      ssh_keys     = var.vm_ssh_keys
    }
    1003 = {
      description  = "oauth authentication"
      cpu          = "host"
      cores        = 2
      memory       = 2048
      disk_size    = "20"
      dhcp         = true
      searchdomain = "localdomain"
      username     = var.vm_username
      password     = var.vm_password
      ssh_keys     = var.vm_ssh_keys
    }
  }
  pve2_vms = {
    2001 = {
      description  = "debian-1-description"
      cpu          = "host"
      cores        = 1
      memory       = 2048
      disk_size    = "20"
      dhcp         = true
      searchdomain = "localdomain"
      username     = var.vm_username
      password     = var.vm_password
      ssh_keys     = var.vm_ssh_keys
    }
    2002 = {
      description  = "debian-1-description"
      cpu          = "host"
      cores        = 1
      memory       = 2048
      disk_size    = "20"
      dhcp         = true
      searchdomain = "localdomain"
      username     = var.vm_username
      password     = var.vm_password
      ssh_keys     = var.vm_ssh_keys
    }
  }
}
