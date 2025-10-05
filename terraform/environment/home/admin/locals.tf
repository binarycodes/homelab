locals {
  vm_config = {
    pve3 = [
      {
        name   = "administrator"
        dhcp   = true
        bridge = "LabNet"
        tags   = ["admin"]
      },
    ]
  }

  vms = merge(
    [for key, val in local.vm_config : {
      for conf in val :
      conf.name => merge(conf, {
        node         = key,
        username     = var.vm_username,
        user_id      = var.vm_user_id,
        timezone     = var.vm_timezone,
        searchdomain = var.dns_zone
      }) }
  ]...)
}
