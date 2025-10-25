locals {
  debian_bookworm = {
    url            = "https://cloud.debian.org/images/cloud/bookworm/20251006-2257/debian-12-generic-amd64-20251006-2257.qcow2"
    checksum       = "be06e506319a7f0e3ee5ec2328595bc4c2205b91b4354ccbb2e6d88b047cf7288137bfa17a143ea611cb588adb9417847c0a5aec0addbbf2835f9f31e2e76547"
    save_file_name = "debian-12-generic-amd64.qcow2.img"
  }

  debian_trixie = {
    url            = "https://cloud.debian.org/images/cloud/trixie/20251006-2257/debian-13-generic-amd64-20251006-2257.qcow2"
    checksum       = "0449ce335d0780af6290dd0b1c11c1e5231a73a3a1fc3e49ba8172853d26f5002e02830352d91ab9894442d29c8d352b21cb6c1c29f3b0f995d968ae4b573452"
    save_file_name = "debian-13-generic-amd64.qcow2.img"
  }

  home_assistant = {
    url                     = "https://github.com/home-assistant/operating-system/releases/download/16.2/haos_generic-x86-64-16.2.img.xz"
    decompression_algorithm = "zst"
    save_file_name          = "haos_generic-x86-64.img"
  }

  free_bsd = {
    url                     = "https://download.freebsd.org/ftp/snapshots/VM-IMAGES/15.0-STABLE/amd64/20251022/FreeBSD-15.0-STABLE-amd64-BASIC-CLOUDINIT-20251022-2427ae41b7cf-280773-zfs.qcow2.xz"
    decompression_algorithm = "zst"
    save_file_name          = "FreeBSD-15.0-STABLE-amd64-BASIC-CLOUDINIT-zfs.qcow2.img"
    checksum                = "e08247d1b7c519f8eaacddc14ffc14ec20be4f2a4fcbc7c62967fd8a7699a60bffc127351ba24711ada8e06804305a2e3390dec5aeafc8345100ea661a9b0547"
  }
}

resource "proxmox_virtual_environment_download_file" "debian_bookworm_cloud_image" {
  node_name          = var.node_name
  content_type       = "iso"
  datastore_id       = "local"
  file_name          = local.debian_bookworm.save_file_name
  url                = local.debian_bookworm.url
  checksum           = local.debian_bookworm.checksum
  checksum_algorithm = "sha512"
}

resource "proxmox_virtual_environment_download_file" "debian_trixie_cloud_image" {
  node_name          = var.node_name
  content_type       = "iso"
  datastore_id       = "local"
  file_name          = local.debian_trixie.save_file_name
  url                = local.debian_trixie.url
  checksum           = local.debian_trixie.checksum
  checksum_algorithm = "sha512"
}

resource "proxmox_virtual_environment_download_file" "home_assistant_cloud_image" {
  node_name               = var.node_name
  content_type            = "iso"
  datastore_id            = "local"
  file_name               = local.home_assistant.save_file_name
  url                     = local.home_assistant.url
  decompression_algorithm = local.home_assistant.decompression_algorithm
  overwrite               = false # file size will always differ due to decompression
}

resource "proxmox_virtual_environment_download_file" "free_bsd_cloud_image" {
  node_name               = var.node_name
  content_type            = "iso"
  datastore_id            = "local"
  file_name               = local.free_bsd.save_file_name
  url                     = local.free_bsd.url
  decompression_algorithm = local.free_bsd.decompression_algorithm
  overwrite               = false # file size will always differ due to decompression
  checksum                = local.free_bsd.checksum
  checksum_algorithm      = "sha512"
}
