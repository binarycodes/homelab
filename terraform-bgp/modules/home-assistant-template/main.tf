resource "proxmox_virtual_environment_vm" "home_assistant_clone" {
  node_name = var.config.node

  vm_id       = var.config.vmid
  name        = var.config.name
  description = var.config.description
  tags        = var.config.tags

  bios = var.config.bios

  agent {
    enabled = true
  }

  keyboard_layout = "en-us"
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

  disk {
    datastore_id = "local-lvm"
    file_id      = var.config.image_id
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

output "vm_ipv4_address" {
  value = proxmox_virtual_environment_vm.home_assistant_clone.ipv4_addresses
}
