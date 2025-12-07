data "infisical_secrets" "app" {
  workspace_id = var.infisical_project_id
  env_slug     = var.infisical_environment
  folder_path  = "/terraform"
}

module "proxmox_debian_trixie" {
  source = "../../../modules/debian-trixie-template"

  for_each               = local.vms
  config                 = each.value
  ca_keycloak_realm      = local.secret.ca_keycloak_realm.value
  ca_keycloak_server_url = local.secret.ca_keycloak_server_url.value
  ca_keycloak_token_url  = local.secret.ca_keycloak_token_url.value
  ca_user_public_key     = local.secret.ca_user_public_key.value
}

output "vm_ipv4_address" {
  value = {
    for k, m in module.proxmox_debian_trixie :
    k => m.vm_ipv4_address
  }
}
