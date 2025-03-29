locals {
  debian_bookworm = {
    pve1 = {
      1101 = {
        name   = "vmpve1deb1101"
        dhcp   = true
        bridge = "vmbr0"
      }
      1102 = {
        name   = "vmpve1deb1102"
        dhcp   = true
        bridge = "LabNet"
      }
    }
    pve2 = {
      2201 = {
        name   = "vmpve2deb2201"
        dhcp   = true
        bridge = "IoTNet"
      }
      2202 = {
        name   = "vmpve2deb2202"
        dhcp   = true
        bridge = "LabNet"
      }
    }
    pve3 = {
      3302 = {
        name   = "vmpve3deb3302"
        dhcp   = true
        bridge = "LabNet"
      }
      3303 = {
        name   = "vmpve3deb3302"
        dhcp   = true
        bridge = "LabNet"
      }
    }
  }
}
