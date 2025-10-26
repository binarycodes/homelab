module "proxmox_home_assitant" {
  source = "../../../modules/home-assistant-template"

  for_each = local.home_assistant_vms
  config   = each.value
}
