data "local_file" "ssh_public_key" {
  filename = "./id_homelab.pub"
}

resource "proxmox_virtual_environment_download_file" "bookworm_cloud_image" {
  content_type = "iso"
  datastore_id = "local"
  file_name    = "debian-12-generic-amd64.qcow2.img"
  node_name    = var.node
  url          = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2"
}

resource "proxmox_virtual_environment_file" "user_data_cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.node

  source_raw {
    data      = templatefile("${path.module}/cloud-init-config.yml", { node = var.node, config = var.config, ssh_keys = trimspace(data.local_file.ssh_public_key.content) })
    file_name = "user-data-cloud-config-${var.config.vmid}.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "bookworm_clone" {
  node_name = var.node

  vm_id       = var.config.vmid
  name        = var.config.name
  description = try(var.config.description, "")

  bios = try(var.config.bios, "seabios")

  agent {
    enabled = true
  }

  keyboard_layout = "en-us"
  on_boot         = true

  operating_system {
    type = "l26"
  }

  cpu {
    cores = try(var.config.cores, 1)
    type  = try(var.config.cpu, "host")
  }

  memory {
    dedicated = try(var.config.memory, 2048)
  }

  serial_device {
    device = "socket"
  }

  scsi_hardware = "virtio-scsi-single"

  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_download_file.bookworm_cloud_image.id
    interface    = "scsi0"
    iothread     = true
    discard      = "on"
    size         = try(var.config.disk_size, 10)
  }

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id
  }

  network_device {
    bridge = try(var.config.bridge, "LabNet")
  }

  smbios {
    serial = "ds=nocloud-net;h=${var.config.name}"
  }
}

output "vm_ipv4_address" {
  value = proxmox_virtual_environment_vm.bookworm_clone.ipv4_addresses[1][0]
}
