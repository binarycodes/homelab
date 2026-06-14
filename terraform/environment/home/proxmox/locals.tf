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
      download_url            = "https://github.com/home-assistant/operating-system/releases/download/17.3/haos_ova-17.3.qcow2.xz"
      save_file_name          = "haos_ova-17.3.qcow2.img"
      checksum                = "d42fadf806c0690792a4460ff3a72c2846c4e16e2033aefad0835662e7a9696f"
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
