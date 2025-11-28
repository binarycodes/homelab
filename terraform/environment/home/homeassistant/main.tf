data "infisical_secrets" "app" {
  workspace_id = var.infisical_project_id
  env_slug     = var.infisical_environment
  folder_path  = "/terraform"
}

module "proxmox_home_assitant" {
  source = "../../../modules/home-assistant-template"

  for_each = local.home_assistant_vms
  config   = each.value
}
