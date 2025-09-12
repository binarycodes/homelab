data "local_file" "ssh_public_key" {
  filename = "../../../files/id_homelab.pub"
}

module "proxmox_debian_trixie_kubernetes" {
  source = "../../../modules/debian-trixie-kubernetes-node/"

  for_each             = local.vms
  config               = each.value
  ca_server_url        = var.ca_server_url
  ca_sso_client_id     = var.ca_sso_client_id
  ca_sso_client_secret = var.ca_sso_client_secret
  ca_sso_token_url     = var.ca_sso_token_url
  ca_user_public_key   = var.ca_user_public_key

  ssh_authorized_key = trimspace(data.local_file.ssh_public_key.content)
}

output "vm_ipv4_address" {
  value = {
    for k, m in module.proxmox_debian_trixie_kubernetes :
    k => m.vm_ipv4_address
  }
}
