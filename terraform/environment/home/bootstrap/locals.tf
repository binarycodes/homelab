locals {
  secret     = data.infisical_secrets.app.secrets
  image_name = "debian-container-20260223-1050.qcow2.img"

  vm_config = {
    pve3 = [
      {
        name             = "bootstrap"
        dhcp             = false
        ip4_address_cidr = "10.88.0.11/24"
        gateway          = "10.88.0.1"
        dns_addresses    = ["10.88.0.1"]
        bridge           = "vmbr0"
        tags             = ["bootstrap"]
        disk_size        = 32
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
