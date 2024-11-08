module "proxmox_pve1_vm" {
  providers = { proxmox = proxmox.pve }
  source    = "./template_vm"

  node          = "pve1"

  for_each = {
    for key, value in local.pve1_vms :
    key => merge(value, { vmid = key })
  }
  config = each.value
}

module "proxmox_pve2_vm" {
  providers = { proxmox = proxmox.pve }
  source    = "./template_vm"

  node          = "pve2"

  for_each = {
    for key, value in local.pve2_vms :
    key => merge(value, { vmid = key })
  }
  config = each.value
}

module "proxmox_pve3_vm" {
  providers = { proxmox = proxmox.pve }
  source    = "./template_vm"

  node          = "pve3"

  for_each = {
    for key, value in local.pve3_vms :
    key => merge(value, { vmid = key })
  }
  config = each.value
}
