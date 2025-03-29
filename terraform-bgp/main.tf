data "local_file" "ssh_public_key" {
  filename = "./id_homelab.pub"
}

resource "proxmox_virtual_environment_download_file" "bookworm_cloud_image" {
  content_type = "iso"
  datastore_id = "local"
  file_name    = "debian-12-generic-amd64.qcow2.img"
  node_name    = "pve1"
  url          = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2"
}

resource "proxmox_virtual_environment_file" "user_data_cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "pve1"

  source_raw {
    data = <<-EOF
    #cloud-config
    timezone: Europe/Helsinki
    users:
      - name: ${var.vm_username}
        groups:
          - sudo
        shell: /bin/bash
        ssh_authorized_keys:
          - ${trimspace(data.local_file.ssh_public_key.content)}
        sudo: ALL=(ALL) NOPASSWD:ALL
    package_update: true
    packages:
      - qemu-guest-agent
      - net-tools
      - curl
    ssh_deletekeys: true
    ssh_genkeytypes: [ed25519]
    runcmd:
      - systemctl enable qemu-guest-agent
      - systemctl start qemu-guest-agent
      - echo "done" > /tmp/cloud-config.done
    runcmd:
      - systemctl enable --now qemu-guest-agent
      - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = "user-data-cloud-config.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "bookworm_clone" {
  name      = "bookworm-clone"
  node_name = "pve1"

  bios = "seabios"

  agent {
    enabled = true
  }

  keyboard_layout = "en-us"
  on_boot         = true

  operating_system {
    type = "l26"
  }

  cpu {
    cores = 1
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = 2048
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
    size         = 10
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
    bridge = "LabNet"
  }

  smbios {
    serial = "ds=nocloud-net;h=bookworm-clone"
  }
}

output "vm_ipv4_address" {
  value = proxmox_virtual_environment_vm.bookworm_clone.ipv4_addresses[1][0]
}
