locals {
  bookworm = {
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
      3301 = {
        name   = "vmpve3deb3301"
        dhcp   = true
        bridge = "LabNet"
      }
      3302 = {
        name   = "vmpve3deb3302"
        dhcp   = true
        bridge = "LabNet"
      }
    }
  }

  bookworm_vms = merge(
    [for key, val in local.bookworm : {
      for id, conf in val :
      id => merge(conf, {
        vmid     = id,
        node     = key,
        username = var.vm_username,
        user_id  = var.vm_user_id,
        timezone = var.vm_timezone,
        cores    = 2
      }) }
  ]...)
  bookworm_vm_nodes = toset([for key, val in local.bookworm_vms : val.node])
}
