locals {
  secret = data.infisical_secrets.app.secrets

  vm_config = {
    pve1 = [
      {
        name   = "kubecontrol01"
        dhcp   = true
        bridge = "LabNet"
        type   = "control-plane"
      },
      {
        name   = "kubeworker01"
        dhcp   = true
        bridge = "LabNet"
        type   = "worker"
      }
    ]
    pve2 = [
      {
        name   = "kubecontrol02"
        dhcp   = true
        bridge = "LabNet"
        type   = "control-plane"
      },
      {
        name   = "kubeworker02"
        dhcp   = true
        bridge = "LabNet"
        type   = "worker"
      }
    ]
    pve3 = [
      {
        name   = "kubecontrol03"
        dhcp   = true
        bridge = "LabNet"
        type   = "control-plane"
      },
      {
        name   = "kubeworker03"
        dhcp   = true
        bridge = "LabNet"
        type   = "worker"
      }
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
        searchdomain = local.secret.dns_zone.value
      }) }
  ]...)
}
