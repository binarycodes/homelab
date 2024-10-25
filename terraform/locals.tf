locals {
  debian12_template_name = "bookworm"
  pve1_vms = {
    1001 = {
	  name         = "sundarban"
      description  = "network tools"
      cpu          = "host"
      cores        = 1
      memory       = 2048
      disk_size    = "20"
      dhcp         = true
	  vlan_id      = -1
      username     = var.vm_username
      password     = var.vm_password
      ssh_keys     = var.vm_ssh_keys
    }
    1002 = {
	  name         = "gorumara"
      description  = "authentication"
      cpu          = "host"
      cores        = 1
      memory       = 2048
      disk_size    = "20"
      dhcp         = true
	  vlan_id      = 10
      username     = var.vm_username
      password     = var.vm_password
      ssh_keys     = var.vm_ssh_keys
    }
  }
  pve2_vms = {
    2001 = {
	  name         = "simlipal"
      description  = "unknown"
      cpu          = "host"
      cores        = 1
      memory       = 2048
      disk_size    = "20"
      dhcp         = true
	  vlan_id      = 10
      username     = var.vm_username
      password     = var.vm_password
      ssh_keys     = var.vm_ssh_keys
    }
    2002 = {
	  name         = "kuldiha"
      description  = "unknown"
      cpu          = "host"
      cores        = 1
      memory       = 2048
      disk_size    = "20"
      dhcp         = true
	  vlan_id      = 10
      username     = var.vm_username
      password     = var.vm_password
      ssh_keys     = var.vm_ssh_keys
    }
  }
  pve3_vms = {
    3001 = {
	  name         = "kanha"
      description  = "unknown"
      cpu          = "host"
      cores        = 1
      memory       = 2048
      disk_size    = "20"
      dhcp         = true
	  vlan_id      = 10
      username     = var.vm_username
      password     = var.vm_password
      ssh_keys     = var.vm_ssh_keys
    }
    3002 = {
	  name         = "pench"
      description  = "unknown"
      cpu          = "host"
      cores        = 1
      memory       = 2048
      disk_size    = "20"
      dhcp         = true
	  vlan_id      = 10
      username     = var.vm_username
      password     = var.vm_password
      ssh_keys     = var.vm_ssh_keys
    }
    3003 = {
	  name         = "bandhavgarh"
      description  = "unknown"
      cpu          = "host"
      cores        = 1
      memory       = 2048
      disk_size    = "20"
      dhcp         = true
	  vlan_id      = 10
      username     = var.vm_username
      password     = var.vm_password
      ssh_keys     = var.vm_ssh_keys
    }
  }
}
