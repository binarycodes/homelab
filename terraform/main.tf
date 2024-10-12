module "proxmox_pve1_vm" {
  providers = { proxmox = proxmox.pve1 }
  source    = "./debian_vm"

  node          = "pve1"
  template_name = local.debian12_template_name

  for_each = {
    for key, value in local.pve1_vms :
    key => merge(value, { vmid = key })
  }
  config = each.value
}

module "proxmox_pve2_vm" {
  providers = { proxmox = proxmox.pve2 }
  source    = "./debian_vm"

  node          = "pve2"
  template_name = local.debian12_template_name

  for_each = {
    for key, value in local.pve2_vms :
    key => merge(value, { vmid = key })
  }
  config = each.value
}

module "proxmox_pve3_vm" {
  providers = { proxmox = proxmox.pve3 }
  source    = "./debian_vm"

  node          = "pve3"
  template_name = local.debian12_template_name

  for_each = {
    for key, value in local.pve3_vms :
    key => merge(value, { vmid = key })
  }
  config = each.value
}
