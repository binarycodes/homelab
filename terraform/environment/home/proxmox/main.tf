locals {
  secret = data.infisical_secrets.app.secrets
}

data "infisical_secrets" "app" {
  workspace_id = var.infisical_project_id
  env_slug     = var.infisical_environment
  folder_path  = "/terraform"
}


resource "proxmox_virtual_environment_storage_directory" "this" {
  id   = "local"
  path = "/var/lib/vz"

  content = ["backup", "iso", "snippets", "vztmpl"]
  shared  = false
  disable = false
}

resource "proxmox_virtual_environment_storage_lvmthin" "this" {
  id           = "local-lvm"
  thin_pool    = "data"
  volume_group = "pve"

  content = ["rootdir", "images"]
  disable = false
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
