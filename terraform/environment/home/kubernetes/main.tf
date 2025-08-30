data "local_file" "ssh_public_key" {
  filename = "../../../files/id_homelab.pub"
}

module "proxmox_debian_trixie_kubernetes" {
  source = "../../../modules/debian-trixie-kubernetes-node/"

  for_each = local.vms
  config   = each.value

  ssh_authorized_key = trimspace(data.local_file.ssh_public_key.content)
}

output "vm_ipv4_address" {
  value = {
    for k, m in module.proxmox_debian_trixie_kubernetes :
    k => m.vm_ipv4_address
  }
}
