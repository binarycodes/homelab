data "local_file" "ssh_public_key" {
  filename = "./id_homelab.pub"
}

resource "proxmox_virtual_environment_download_file" "bookworm_cloud_image" {
  content_type       = "iso"
  datastore_id       = "local"
  file_name          = "debian-12-genericcloud-amd64-20250416-2084.qcow2.img"
  node_name          = var.config.node
  url                = "https://cloud.debian.org/images/cloud/bookworm/20250416-2084/debian-12-genericcloud-amd64-20250416-2084.qcow2"
  checksum           = "72ef23f399ceff56f7e0c213db796d655aaaea833bc18838210a1ab40e531e6acf9b21adc1954b902db8c9b2255bff7a08aed816250e6afc2821550533df457d"
  checksum_algorithm = "sha512"
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

resource "proxmox_virtual_environment_vm" "bookworm_clone" {
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
    file_id      = proxmox_virtual_environment_download_file.bookworm_cloud_image.id
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
  value = proxmox_virtual_environment_vm.bookworm_clone.ipv4_addresses[1][0]
}
