locals {
  nodes = ["pve1", "pve2", "pve3"]

  cloud_images = {
    custom_debian_trixie = {
      download_url       = "http://moria.ip.cloudyhome.net:9000/os-image/debian/debian-trixie-packer-20260206-1345.qcow2"
      save_file_name     = "debian-trixie-packer-20260206-1345.qcow2.img"
      checksum           = "7a61c8780aaf9a3afcbf5818cacd1e72517cfc678873cc938d334835912ab626e54afb25cba7cf4756d274f1c6bd32b935451c1e1c44f70150a87456659df648"
      checksum_algorithm = "sha512"
    }

    debian_trixie = {
      download_url       = "https://cloud.debian.org/images/cloud/trixie/20260129-2372/debian-13-genericcloud-amd64-20260129-2372.qcow2"
      save_file_name     = "debian-13-genericcloud-amd64.qcow2.img"
      checksum           = "a70acbedb0dc691ab77c57f3f775de435afe1d3b063dfafbdf194661a8d65543ebaa32128f4362a9a2c7be065bd9e48944f83dd3583e9765d3ab1ee06965552e"
      checksum_algorithm = "sha512"
    }

    home_assistant = {
      download_url            = "https://github.com/home-assistant/operating-system/releases/download/17.0/haos_ova-17.0.qcow2.xz"
      save_file_name          = "haos_ova.qcow2.img"
      checksum                = "5080f10959785dfc60bfa614fe0ef267b40ec33afcdf920040070e7afc1a43b2"
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
