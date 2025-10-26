locals {
  home_assistant = {
    pve3 = [
      {
        name        = "homeassistant"
        description = "home-assistant"
        dhcp        = true
      }
    ]
  }
  home_assistant_vms = merge(
    [for key, val in local.home_assistant : {
      for conf in val :
      conf.name => merge(conf, {
        node         = key,
        searchdomain = var.dns_zone
      }) }
  ]...)
}
