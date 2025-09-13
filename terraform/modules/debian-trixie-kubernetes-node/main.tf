locals {
  kubernetes_tags = toset(
    concat(
      ["kubernetes"],
      tolist(try(var.config.tags, []))
    )
  )
  extra_runcmd = yamldecode(file("${path.module}/extra-runcmd.yml"))
}

module "kubernetes-node" {
  source = "../debian-trixie-template/"
  config = merge(var.config, {
    tags = local.kubernetes_tags
  })

  ca_server_url        = var.ca_server_url
  ca_sso_client_id     = var.ca_sso_client_id
  ca_sso_client_secret = var.ca_sso_client_secret
  ca_sso_token_url     = var.ca_sso_token_url
  ca_user_public_key   = var.ca_user_public_key

  extra_runcmd = local.extra_runcmd
}

output "vm_ipv4_address" {
  value = module.kubernetes-node.vm_ipv4_address
}
