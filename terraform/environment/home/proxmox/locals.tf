locals {
  nodes = ["pve1", "pve2", "pve3"]

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
    url                     = "https://download.freebsd.org/ftp/snapshots/VM-IMAGES/14.3-STABLE/amd64/Latest/FreeBSD-14.3-STABLE-amd64-BASIC-CLOUDINIT-zfs.qcow2.xz"
    decompression_algorithm = "zst"
    save_file_name          = "FreeBSD-14.3-STABLE-amd64-BASIC-CLOUDINIT-zfs.qcow2.img"
    checksum                = "6659fcd0b445af31f450e3c1f5a7e27cc9ff028e75b6d95b723b2272edbcee932acaad32e4b39178cae484fd991e8c8ebc15302f81b2f384615988fec02a83bc"
  }
}
