locals {
  nodes = ["pve1", "pve2", "pve3"]

  debian_bookworm = {
    url            = "https://cloud.debian.org/images/cloud/bookworm/20250814-2204/debian-12-generic-amd64-20250814-2204.qcow2"
    checksum       = "736ed2e24e106defd95549b0471e15552b19580c504202269955c3587722777506269655ebd7fa5cce919044dccdd9084c4fb3efbe408843c63cefa9d79daea3"
    save_file_name = "debian-12-generic-amd64-20250814-2204.qcow2.img"
  }

  debian_trixie = {
    url            = "https://cloud.debian.org/images/cloud/trixie/20250814-2204/debian-13-generic-amd64-20250814-2204.qcow2"
    checksum       = "8f5c54d654b53951430b404efc3043b425cf2214467d5bf33d6c5157fa47c8fe4a1a2abf603050dafc7e54f57e9685f0d59a6c0d09d0cb2b7fcec75561c0df6f"
    save_file_name = "debian-13-generic-amd64-20250814-2204.qcow2.img"
  }

  home_assistant = {
    url                     = "https://github.com/home-assistant/operating-system/releases/download/16.1/haos_generic-x86-64-16.1.img.xz"
    decompression_algorithm = "zst"
    save_file_name          = "haos_generic-x86-64-16.1.img"
  }
}
