module "proxmox_os_image" {
  source = "../../../modules/proxmox-os-image"

  for_each  = toset(local.nodes)
  node_name = each.value
}

resource "proxmox_virtual_environment_sdn_zone_vlan" "this" {
  for_each = local.sdn

  id     = each.key
  bridge = each.value.bridge
  nodes  = local.nodes
  ipam   = "pve"
}
