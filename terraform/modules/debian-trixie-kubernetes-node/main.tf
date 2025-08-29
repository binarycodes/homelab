locals {
  kubernetes_tags = toset(
    concat(
      ["kubernetes"],
      tolist(try(var.config.tags, []))
    )
  )
}

module "kubernetes-node" {
  source = "../debian-trixie-template/"
  config = merge(var.config, {
    tags = local.kubernetes_tags
  })
  ssh_authorized_key   = var.ssh_authorized_key
  user_cloud_init_file = "${path.module}/k8s-user-cloud-init-config.yml"
}
