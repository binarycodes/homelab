module "proxmox_n1_vm" {
  providers = { proxmox = proxmox.n1 }
  source    = "./debian_vm"

  node          = "n1"
  template_name = local.debian12_template_name

  for_each = {
    for key, value in local.n1_vms :
    key => merge(value, { vmid = key })
  }
  config = each.value
}

module "proxmox_n2_vm" {
  providers = { proxmox = proxmox.n2 }
  source    = "./debian_vm"

  node          = "n2"
  template_name = local.debian12_template_name

  for_each = {
    for key, value in local.n2_vms :
    key => merge(value, { vmid = key })
  }
  config = each.value
}
