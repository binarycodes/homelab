locals {
  secret     = data.infisical_secrets.app.secrets
  image_name = "debian-container-20260220-1225.qcow2.img"

  vm_config = {
    pve2 = [
      {
        name      = "media"
        dhcp      = true
        bridge    = "LabNet"
        tags      = ["media"]
        disk_size = 32
        memory    = 8192
        cores     = 4
      },
    ]
  }

  vms = merge(
    [for key, val in local.vm_config : {
      for conf in val :
      conf.name => merge(conf, {
        node         = key,
        username     = local.secret.vm_username.value,
        user_id      = local.secret.vm_user_id.value,
        timezone     = local.secret.vm_timezone.value,
        searchdomain = local.secret.dns_zone.value,
        age_secret   = local.secret.age_secret.value,
      }) }
  ]...)
}
