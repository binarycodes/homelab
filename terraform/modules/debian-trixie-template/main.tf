locals {
  keyboard_layout = "en-us"
  iso_file_id     = "local:iso/debian-13-generic-amd64.qcow2.img"

  user_cloud_init_path = (
    var.user_cloud_init_file != null ? var.user_cloud_init_file : "${path.module}/user-cloud-init-config.yml"
  )

  network_cloud_init_path = (
    var.network_cloud_init_file != null ? var.network_cloud_init_file :
    (
      var.config.dhcp ?
      "${path.module}/network-dhcp-cloud-init-config.yml" :
      "${path.module}/network-static-cloud-init-config.yml"
    )
  )

  tags = toset(
    concat(
      ["trixie"],
      tolist(try(var.config.tags, []))
    )
  )
}

resource "proxmox_virtual_environment_file" "user_data_cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.config.node

  source_raw {
    data = templatefile(local.user_cloud_init_path, {
      config               = var.config,
      ssh_keys             = trimspace(var.ssh_authorized_key)
      ca_server_url        = var.ca_server_url
      ca_sso_client_id     = var.ca_sso_client_id
      ca_sso_client_secret = var.ca_sso_client_secret
      ca_sso_token_url     = var.ca_sso_token_url
      ca_user_public_key   = var.ca_user_public_key
    })
    file_name = "${var.config.name}-user-data-cloud-config.yaml"
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
    file_name = "${var.config.name}-network-data-cloud-config.yaml"
  }
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

  disk {
    datastore_id = "local-lvm"
    file_id      = local.iso_file_id
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
  value = {
    for idx, name in proxmox_virtual_environment_vm.this.network_interface_names :
    name => flatten(proxmox_virtual_environment_vm.this.ipv4_addresses[idx])
  }
}
