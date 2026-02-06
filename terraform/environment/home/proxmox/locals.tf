locals {
  nodes = ["pve1", "pve2", "pve3"]

  cloud_images = {
    custom_debian_trixie = {
      download_url       = "http://moria.ip.cloudyhome.net:9000/os-image/debian/debian-trixie-packer-20260206-0336.qcow2"
      save_file_name     = "debian-trixie-packer-20260206-0336.qcow2.img"
      checksum           = "921570361b07581fde85f467cecc570b7c9da45a4aaad9647ee6293d073fb7f18611cc5e630c2263042078d9de03f4d209f3380957fe7eb64f07fc56d9e62d07"
      checksum_algorithm = "sha512"
    }

    debian_trixie = {
      download_url       = "https://cloud.debian.org/images/cloud/trixie/20251117-2299/debian-13-genericcloud-amd64-20251117-2299.qcow2"
      save_file_name     = "debian-13-genericcloud-amd64.qcow2.img"
      checksum           = "e5563c7bb388eebf7df385e99ee36c83cd16ba8fad4bd07f4c3fd725a6f1cf1cb9f54c6673d4274a856974327a5007a69ff24d44f9b21f7f920e1938a19edf7e"
      checksum_algorithm = "sha512"
    }

    home_assistant = {
      download_url            = "https://github.com/home-assistant/operating-system/releases/download/16.3/haos_ova-16.3.qcow2.xz"
      save_file_name          = "haos_ova.qcow2.img"
      checksum                = "f3f56cae72cdc1732c35b1b2a7547a11397eaaac8c4de2ff63bb10f45721c8ce"
      checksum_algorithm      = "sha256"
      decompression_algorithm = "zst"
      overwrite               = false
    }

    free_bsd = {
      download_url            = "https://download.freebsd.org/releases/VM-IMAGES/15.0-RELEASE/amd64/Latest/FreeBSD-15.0-RELEASE-amd64-BASIC-CLOUDINIT-ufs.qcow2.xz"
      save_file_name          = "FreeBSD-15.0-RELEASE-amd64-BASIC-CLOUDINIT-ufs.qcow2.img"
      checksum                = "ef2835411accb622f42dad145e5cdd91b703dfa972d33cce4d4b71c88b25f5892eb52e11826e78629dd42835b57111f1849d993ed08c6fd578b1070e4ed62379"
      checksum_algorithm      = "sha512"
      decompression_algorithm = "zst"
      overwrite               = false
    }
  }

  images = { for key, img in local.cloud_images :
    key => merge(img, {
      nodes                   = local.nodes,
      decompression_algorithm = try(img.decompression_algorithm, null)
    })
  }

  sdn = {
    Lab = {
      bridge = "vmbr0"
      vnets = {
        IoTNet = {
          tag = 15
        },
        LabNet = {
          tag = 16
        }
      }
    },
    VPN = {
      bridge = "vmbr0"
      vnets = {
        IndiaNet = {
          tag = 200
        }
      }
    },
    Mgmt = {
      bridge = "vmbr0"
      vnets = {
        MgmtNet = {
          tag = 1
        }
      }
    },
    Prod = {
      bridge = "vmbr0"
      vnets = {
        ProdNet = {
          tag = 99
        }
      }
    }
  }

  vnets = flatten([
    for zone_name, zone in local.sdn : [
      for vnet_name, vnet in zone.vnets : {
        name = vnet_name
        tag  = vnet.tag
        zone = zone_name
      }
    ]
  ])

  vnets_map = {
    for v in local.vnets :
    "${v.zone}-${v.name}" => v
  }
}
