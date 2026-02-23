locals {
  secret     = data.infisical_secrets.app.secrets
  image_name = "debian-container-20260223-2225.qcow2.img"

  vm_config = {
    pve3 = [
      {
        name   = "runner"
        dhcp   = true
        bridge = "LabNet"
        tags   = ["runner"]
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
