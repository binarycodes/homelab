locals {
  bookworm = {
    pve1 = [
      {
        vmid   = 1101
        name   = "vmpve1deb1101"
        dhcp   = true
        bridge = "LabNet"
        tags   = ["control-plane"]
      },
      {
        vmid   = 1102
        name   = "vmpve1deb1102"
        dhcp   = true
        bridge = "LabNet"
        tags   = ["worker"]
      }
    ]
    pve2 = [
      {
        vmid   = 2201
        name   = "vmpve2deb2201"
        dhcp   = true
        bridge = "LabNet"
        tags   = ["control-plane"]
      },
      {
        vmid   = 2202
        name   = "vmpve2deb2202"
        dhcp   = true
        bridge = "LabNet"
        tags   = ["worker"]
      }
    ]
    pve3 = [
      {
        vmid   = 3301
        name   = "vmpve3deb3301"
        dhcp   = true
        bridge = "LabNet"
        tags   = ["control-plane"]
      },
      {
        vmid   = 3302
        name   = "vmpve3deb3302"
        dhcp   = true
        bridge = "LabNet"
        tags   = ["worker"]
      }
    ]
  }

  bookworm_vms = merge(
    [for key, val in local.bookworm : {
      for conf in val :
      conf.vmid => merge(conf, {
        node     = key,
        username = var.vm_username,
        user_id  = var.vm_user_id,
        timezone = var.vm_timezone,
      }) }
  ]...)
}
