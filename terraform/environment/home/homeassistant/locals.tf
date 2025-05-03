locals {
  home_assistant = {
    pve3 = {
      3401 = {
        name        = "vmpve3deb3401"
        description = "home-assistant"
        dhcp        = true
      }
    }
  }
  home_assistant_vms      = merge([for key, val in local.home_assistant : { for id, conf in val : id => merge(conf, { vmid = id, node = key }) }]...)
  home_assistant_vm_nodes = toset([for key, val in local.home_assistant_vms : val.node])
}
