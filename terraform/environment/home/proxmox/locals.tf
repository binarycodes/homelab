locals {
  nodes = ["pve1", "pve2", "pve3"]

  packer_debian_metadata_url = "https://s3-api.cloudyhome.net/os-image/debian/metadata_all.json"
  packer_debian_images_json  = jsondecode(data.http.this.response_body)
  packer_debian_images = {
    for img in local.packer_debian_images_json :
    img.IMAGE_NAME => {
      nodes              = local.nodes
      download_url       = "${img.IMAGE_URL}"
      save_file_name     = "${img.IMAGE_NAME}.img"
      checksum           = "${img.SHA512_CHECKSUM}"
      checksum_algorithm = "sha512"
    }
  }

  cloud_images = {
    home_assistant = {
      download_url            = "https://github.com/home-assistant/operating-system/releases/download/18.0/haos_ova-18.0.qcow2.xz"
      save_file_name          = "haos_ova-18.0.qcow2.img"
      checksum                = "ae125c592532a4b64a5c05c6596173eb5edddf15a1e681e082ab28b7d5e5ba6b"
      checksum_algorithm      = "sha256"
      decompression_algorithm = "zst"
      overwrite               = false
    }

    free_bsd = {
      download_url            = "https://download.freebsd.org/releases/VM-IMAGES/15.1-RELEASE/amd64/Latest/FreeBSD-15.1-RELEASE-amd64-BASIC-CLOUDINIT-ufs.qcow2.xz"
      save_file_name          = "FreeBSD-15.1-RELEASE-amd64-BASIC-CLOUDINIT-ufs.qcow2.img"
      checksum                = "bea82b91a983a20eb7ecdc6f11c1006d394ebbc5668b7f0ecdecf5a54fc5f9ea3a8384fc9f74a6611a9b08c183fa953327147ebfaa0de199fd015e67dd1e608a"
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
