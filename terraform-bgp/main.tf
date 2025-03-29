module "proxmox_pve1_vms" {
  source = "./debian-bookworm-template"
  node   = "pve1"

  for_each = {
    for key, value in local.debian_bookworm.pve1 :
    key => merge(value, { vmid = key })
  }
  config = merge(each.value, { username = var.vm_username, timezone = var.vm_timezone })
}

module "proxmox_pve2_vms" {
  source = "./debian-bookworm-template"
  node   = "pve2"

  for_each = {
    for key, value in local.debian_bookworm.pve2 :
    key => merge(value, { vmid = key })
  }

  config = merge(each.value, { username = var.vm_username, timezone = var.vm_timezone })
}

module "proxmox_pve3_vms" {
  source = "./debian-bookworm-template"
  node   = "pve3"

  for_each = {
    for key, value in local.debian_bookworm.pve3 :
    key => merge(value, { vmid = key })
  }
  config = merge(each.value, { username = var.vm_username, timezone = var.vm_timezone })
}
