locals {
  secret     = data.infisical_secrets.app.secrets
  image_name = "debian-trixie-packer-20260213-0619.qcow2.img"

  vm_config = {
    pve1 = [
      {
        name             = "ns1"
        dhcp             = false
        ip4_address_cidr = "10.88.16.11/24"
        gateway          = "10.88.16.1"
        dns_addresses    = ["10.88.16.1"]
        bridge           = "LabNet"
        tags             = ["dns-primary"]
      },
    ],
    pve2 = [
      {
        name             = "ns2"
        dhcp             = false
        ip4_address_cidr = "10.88.16.12/24"
        gateway          = "10.88.16.1"
        dns_addresses    = ["10.88.16.1"]
        bridge           = "LabNet"
        tags             = ["dns-secondary"]
      },
    ]
  }

  vms = merge(
    [for key, val in local.vm_config : {
      for conf in val :
      conf.name => merge(conf, {
        node              = key,
        username          = local.secret.vm_username.value,
        user_id           = local.secret.vm_user_id.value,
        timezone          = local.secret.vm_timezone.value,
        searchdomain      = local.secret.dns_zone.value,
        age_secret        = local.secret.age_secret.value,
        create_dns_record = false,
      }) }
  ]...)
}
