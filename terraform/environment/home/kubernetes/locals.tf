locals {
  vm_config = {
    pve1 = [
      {
        name   = "kubecontrol01"
        dhcp   = true
        bridge = "LabNet"
        tags   = ["control-plane"]
      },
      {
        name   = "kubeworker01"
        dhcp   = true
        bridge = "LabNet"
        tags   = ["worker"]
      }
    ]
    pve2 = [
      {
        name   = "kubecontrol02"
        dhcp   = true
        bridge = "LabNet"
        tags   = ["control-plane"]
      },
      {
        name   = "kubeworker02"
        dhcp   = true
        bridge = "LabNet"
        tags   = ["worker"]
      }
    ]
    pve3 = [
      {
        name   = "kubecontrol03"
        dhcp   = true
        bridge = "LabNet"
        tags   = ["control-plane"]
      },
      {
        name   = "kubeworker03"
        dhcp   = true
        bridge = "LabNet"
        tags   = ["worker"]
      }
    ]
  }

  vms = merge(
    [for key, val in local.vm_config : {
      for conf in val :
      conf.name => merge(conf, {
        node     = key,
        username = var.vm_username,
        user_id  = var.vm_user_id,
        timezone = var.vm_timezone,
      }) }
  ]...)
}
