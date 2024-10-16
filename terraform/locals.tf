locals {
  debian12_template_name = "debian12"
  pve1_vms = {
    1001 = {
      description  = "reverse proxy"
      cpu          = "host"
      cores        = 1
      memory       = 2048
      disk_size    = "20"
      dhcp         = true
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
      username     = var.vm_username
      password     = var.vm_password
      ssh_keys     = var.vm_ssh_keys
    }
  }
  pve3_vms = {
    3001 = {
      description  = "debian-1-description"
      cpu          = "host"
      cores        = 1
      memory       = 2048
      disk_size    = "20"
      dhcp         = true
      username     = var.vm_username
      password     = var.vm_password
      ssh_keys     = var.vm_ssh_keys
    }
    3002 = {
      description  = "debian-1-description"
      cpu          = "host"
      cores        = 1
      memory       = 2048
      disk_size    = "20"
      dhcp         = true
      username     = var.vm_username
      password     = var.vm_password
      ssh_keys     = var.vm_ssh_keys
    }
    3003 = {
      description  = "debian-1-description"
      cpu          = "host"
      cores        = 1
      memory       = 2048
      disk_size    = "20"
      dhcp         = true
      username     = var.vm_username
      password     = var.vm_password
      ssh_keys     = var.vm_ssh_keys
    }
  }
}
