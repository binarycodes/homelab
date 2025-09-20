module "proxmox_debian_trixie_kubernetes" {
  source = "../../../modules/debian-trixie-kubernetes-node/"

  for_each               = local.vms
  config                 = each.value
  ca_keycloak_realm      = var.ca_keycloak_realm
  ca_keycloak_server_url = var.ca_keycloak_server_url
  ca_keycloak_token_url  = var.ca_keycloak_token_url
  ca_user_public_key     = var.ca_user_public_key
}

output "vm_ipv4_address" {
  value = {
    for k, m in module.proxmox_debian_trixie_kubernetes :
    k => m.vm_ipv4_address
  }
}
