module "proxmox_bookworm" {
  source = "./debian-bookworm-template"

  for_each = local.bookworm_vms
  config   = each.value
  node     = each.value.node
}

module "proxmox_home_assitant" {
  source = "./home-assistant-template"

  for_each = local.home_assistant_vms
  config   = each.value
  node     = each.value.node
}
