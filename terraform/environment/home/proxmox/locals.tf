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
      download_url            = var.homeassistant_image.download_url
      save_file_name          = var.homeassistant_image.save_file_name
      checksum                = var.homeassistant_image.checksum
      checksum_algorithm      = var.homeassistant_image.checksum_algorithm
      decompression_algorithm = var.homeassistant_image.decompression_algorithm
      overwrite               = false
    }

    free_bsd = {
      download_url            = var.freebsd_image.download_url
      save_file_name          = var.freebsd_image.save_file_name
      checksum                = var.freebsd_image.checksum
      checksum_algorithm      = var.freebsd_image.checksum_algorithm
      decompression_algorithm = var.freebsd_image.decompression_algorithm
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
