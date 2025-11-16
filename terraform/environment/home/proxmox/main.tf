locals {
  secret = data.infisical_secrets.app.secrets
}

data "infisical_secrets" "app" {
  workspace_id = var.infisical_project_id
  env_slug     = var.infisical_environment
  folder_path  = "/terraform"
}

module "proxmox_os_image" {
  source = "../../../modules/proxmox-os-image"

  for_each = local.images
  config   = each.value
}

resource "proxmox_virtual_environment_sdn_zone_vlan" "this" {
  for_each = local.sdn

  id     = each.key
  bridge = each.value.bridge
  ipam   = "pve"
}

resource "proxmox_virtual_environment_sdn_vnet" "this" {
  for_each = local.vnets_map

  id         = each.value.name
  zone       = proxmox_virtual_environment_sdn_zone_vlan.this[each.value.zone].id
  vlan_aware = true
  tag        = each.value.tag
}

resource "proxmox_virtual_environment_time" "this" {
  for_each  = toset(local.nodes)
  node_name = each.value
  time_zone = local.secret.vm_timezone.value
}
