locals {
  keyboard_layout = "en-us"
  iso_file_id     = "local:iso/haos_ova.qcow2.img"
  datastore_id    = "local-lvm"

  tags = toset(
    concat(
      ["home_assistant"],
      tolist(try(var.config.tags, []))
    )
  )

  en_if  = one([for n in proxmox_virtual_environment_vm.this.network_interface_names : n if startswith(n, "en")])
  en_idx = index(proxmox_virtual_environment_vm.this.network_interface_names, local.en_if)
  vm_ip  = flatten(proxmox_virtual_environment_vm.this.ipv4_addresses[local.en_idx])[0]
}


resource "proxmox_virtual_environment_vm" "this" {
  node_name = var.config.node

  vm_id       = var.config.vmid
  name        = var.config.name
  description = var.config.description
  tags        = local.tags

  bios = var.config.bios

  agent {
    enabled = true
  }

  keyboard_layout = local.keyboard_layout
  on_boot         = true

  operating_system {
    type = "l26"
  }

  cpu {
    cores = var.config.cores
    type  = var.config.cpu
  }

  memory {
    dedicated = var.config.memory
  }

  serial_device {
    device = "socket"
  }

  scsi_hardware = "virtio-scsi-single"

  efi_disk {
    datastore_id = local.datastore_id
    file_format  = "raw"
    type         = "4m"
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = local.iso_file_id
    interface    = "scsi0"
    iothread     = true
    discard      = "on"
    size         = var.config.disk_size
  }

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }

  network_device {
    bridge = var.config.bridge
  }

  smbios {
    serial = "ds=nocloud-net;h=${var.config.name}"
  }
}

resource "dns_a_record_set" "this" {
  zone      = "${var.config.searchdomain}."
  name      = var.config.name
  addresses = [local.vm_ip]
  ttl       = 300
}

output "vm_ipv4_address" {
  value = proxmox_virtual_environment_vm.this.ipv4_addresses
}
