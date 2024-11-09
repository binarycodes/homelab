locals {
  pve1_vms = {
    1001 = {
      template     = "bookworm"
	  name         = "sundarban"
      dhcp         = true
    }
    1002 = {
      template     = "bookworm"
	  name         = "gorumara"
      dhcp         = true
	  bridge       = "LabNet"
    }
  }
  pve2_vms = {
    2001 = {
      template     = "bookworm"
	  name         = "simlipal"
      dhcp         = true
	  bridge       = "LabNet"
    }
    2002 = {
      template     = "bookworm"
	  name         = "kuldiha"
      dhcp         = true
	  bridge       = "LabNet"
    }
  }
  pve3_vms = {
    3001 = {
      template     = "home-assistant"
	  name         = "kanha"
      description  = "home assistant"
      bios         = "ovmf"
      disk_size    = "32"
      dhcp         = true
	  bridge       = "IoTNet"
    }
    3002 = {
      template     = "bookworm"
	  name         = "pench"
      dhcp         = true
	  bridge       = "LabNet"
    }
    3003 = {
      template     = "bookworm"
	  name         = "bandhavgarh"
      dhcp         = true
	  bridge       = "LabNet"
    }
  }
}
