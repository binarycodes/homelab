data "local_file" "ssh_public_key" {
  filename = "./id_homelab.pub"
}

resource "proxmox_virtual_environment_download_file" "home_assistant_cloud_image" {
  content_type            = "iso"
  datastore_id            = "local"
  file_name               = "haos_ova-15.2.qcow2.xz.img"
  node_name               = var.config.node
  url                     = "https://github.com/home-assistant/operating-system/releases/download/15.2/haos_ova-15.2.qcow2.xz"
  decompression_algorithm = "zst"
  overwrite               = false # file size will always differ due to decompression
}

resource "proxmox_virtual_environment_file" "user_data_cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.config.node

  source_raw {
    data      = templatefile("${path.module}/cloud-init-config.yml", { config = var.config, ssh_keys = trimspace(data.local_file.ssh_public_key.content) })
    file_name = "user-data-cloud-config-${var.config.vmid}.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "home_assistant_clone" {
  depends_on = [proxmox_virtual_environment_download_file.home_assistant_cloud_image]

  node_name = var.config.node

  vm_id       = var.config.vmid
  name        = var.config.name
  description = var.config.description

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
    file_id      = proxmox_virtual_environment_download_file.home_assistant_cloud_image.id
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

    user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id
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
