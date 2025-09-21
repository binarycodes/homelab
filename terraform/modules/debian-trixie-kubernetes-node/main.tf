locals {
  kubernetes_tags = toset(
    concat(
      ["kubernetes", var.config.type],
      tolist(try(var.config.tags, []))
    )
  )
  extra_runcmd = yamldecode(
    templatefile("${path.module}/extra-runcmd.yml", {
      type = var.config.type
    })
  )
}

module "kubernetes-node" {
  source = "../debian-trixie-template/"
  config = merge(var.config, {
    tags = local.kubernetes_tags
  })

  ca_keycloak_realm      = var.ca_keycloak_realm
  ca_keycloak_server_url = var.ca_keycloak_server_url
  ca_keycloak_token_url  = var.ca_keycloak_token_url
  ca_user_public_key     = var.ca_user_public_key

  extra_runcmd = local.extra_runcmd
}

output "vm_ipv4_address" {
  value = module.kubernetes-node.vm_ipv4_address
}
