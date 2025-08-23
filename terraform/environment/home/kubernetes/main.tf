data "local_file" "ssh_public_key" {
  filename = "../../../files/id_homelab.pub"
}

module "proxmox_debian_kubernetes" {
  source = "../../../modules/debian-trixie-kubernetes-node/"

  for_each = local.bookworm_vms
  config   = each.value

  ssh_authorized_key = trimspace(data.local_file.ssh_public_key.content)
}
