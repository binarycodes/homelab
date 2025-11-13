locals {
  nodes = ["pve1", "pve2", "pve3"]

  cloud_images = {
    debian_bookworm = {
      download_url       = "https://cloud.debian.org/images/cloud/bookworm/20251112-2294/debian-12-generic-amd64-20251112-2294.qcow2"
      save_file_name     = "debian-12-generic-amd64.qcow2.img"
      checksum           = "5da221d8f7434ee86145e78a2c60ca45eb4ef8296535e04f6f333193225792aa8ceee3df6aea2b4ee72d6793f7312308a8b0c6a1c7ed4c7c730fa7bda1bc665f"
      checksum_algorithm = "sha512"
    }

    debian_trixie = {
      download_url       = "https://cloud.debian.org/images/cloud/trixie/20251006-2257/debian-13-generic-amd64-20251006-2257.qcow2"
      save_file_name     = "debian-13-generic-amd64.qcow2.img"
      checksum           = "0449ce335d0780af6290dd0b1c11c1e5231a73a3a1fc3e49ba8172853d26f5002e02830352d91ab9894442d29c8d352b21cb6c1c29f3b0f995d968ae4b573452"
      checksum_algorithm = "sha512"
    }

    home_assistant = {
      download_url            = "https://github.com/home-assistant/operating-system/releases/download/16.3/haos_ova-16.3.qcow2.xz"
      save_file_name          = "haos_ova.qcow2.img"
      checksum                = "f3f56cae72cdc1732c35b1b2a7547a11397eaaac8c4de2ff63bb10f45721c8ce"
      checksum_algorithm      = "sha256"
      decompression_algorithm = "zst"
    }

    free_bsd = {
      download_url            = "https://download.freebsd.org/ftp/snapshots/VM-IMAGES/15.0-STABLE/amd64/20251106/FreeBSD-15.0-STABLE-amd64-BASIC-CLOUDINIT-20251106-71bd17b879a7-281079-ufs.qcow2.xz"
      save_file_name          = "FreeBSD-15.0-STABLE-amd64-BASIC-CLOUDINIT-ufs.qcow2.img"
      checksum                = "65d04adf64745f089c5b8ca615a9e03e0ac87ea29e8eebe865bf014471aa868b0e2e4b6eaf0a8cb523208be92a9f5b56a3174cb342db21e25218a9a5984985f1"
      checksum_algorithm      = "sha512"
      decompression_algorithm = "zst"
    }
  }

  images = { for key, img in local.cloud_images :
    key => merge(img, {
      nodes                   = local.nodes,
      decompression_algorithm = try(img.decompression_algorithm, null)
    })
  }
}
