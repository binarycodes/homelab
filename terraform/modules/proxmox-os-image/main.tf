locals {
  debian_bookworm = {
    url            = "https://cloud.debian.org/images/cloud/bookworm/20250814-2204/debian-12-generic-amd64-20250814-2204.qcow2"
    checksum       = "736ed2e24e106defd95549b0471e15552b19580c504202269955c3587722777506269655ebd7fa5cce919044dccdd9084c4fb3efbe408843c63cefa9d79daea3"
    save_file_name = "debian-12-generic-amd64.qcow2.img"
  }

  debian_trixie = {
    url            = "https://cloud.debian.org/images/cloud/trixie/20250911-2232/debian-13-generic-amd64-20250911-2232.qcow2"
    checksum       = "2d63144148d3e1c1cec456c201965c1f3345daeecf8ca708e6aeaadbae352a1aa20ca5e3de600aac514bb9b98c940ea0c770cada58c3e7ebcf4e2bf85c57ec65"
    save_file_name = "debian-13-generic-amd64.qcow2.img"
  }

  home_assistant = {
    url                     = "https://github.com/home-assistant/operating-system/releases/download/16.1/haos_generic-x86-64-16.1.img.xz"
    decompression_algorithm = "zst"
    save_file_name          = "haos_generic-x86-64-16.1.img"
  }

  free_bsd = {
    url                     = "https://download.freebsd.org/ftp/snapshots/VM-IMAGES/14.3-STABLE/amd64/20250918/FreeBSD-14.3-STABLE-amd64-BASIC-CLOUDINIT-20250918-cbd62452bff6-272439-zfs.qcow2.xz"
    decompression_algorithm = "zst"
    save_file_name          = "FreeBSD-14.3-STABLE-amd64-BASIC-CLOUDINIT-zfs.qcow2.img"
    checksum                = "30af6bf2d4a0e618759d1223654b74e53ee297c4fb273682217393f1f9997aa190c956986b21b72b8c95828524a409762adcc2ad4ce8758555c8e6616b8e8b9c"
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
