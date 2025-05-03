locals {
  user_cloud_init_path = (
    var.user_cloud_init_file != null ?
    var.user_cloud_init_file : "${path.module}/user-cloud-init-config.yml"
  )

  network_cloud_init_path = (
    var.network_cloud_init_file != null ?
    var.network_cloud_init_file : "${path.module}/network-cloud-init-config.yml"
  )
}

resource "proxmox_virtual_environment_file" "user_data_cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.config.node

  source_raw {
    data = templatefile(local.user_cloud_init_path, {
      config   = var.config,
      ssh_keys = trimspace(var.ssh_authorized_key)
    })
    file_name = "${var.config.vmid}-user-data-cloud-config.yaml"
  }
}

resource "proxmox_virtual_environment_file" "network_cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.config.node

  source_raw {
    data = templatefile(local.network_cloud_init_path, {
      config   = var.config,
      ssh_keys = trimspace(var.ssh_authorized_key)
    })
    file_name = "${var.config.vmid}-network-data-cloud-config.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "this" {
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
    user_data_file_id    = proxmox_virtual_environment_file.user_data_cloud_config.id
    network_data_file_id = proxmox_virtual_environment_file.network_cloud_config.id
  }

  network_device {
    bridge = var.config.bridge
  }

  smbios {
    serial = "ds=nocloud-net;h=${var.config.name}"
  }
}

output "vm_ipv4_address" {
  value = proxmox_virtual_environment_vm.this.ipv4_addresses
}
