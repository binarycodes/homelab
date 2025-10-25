locals {
  images = {
    debian_bookworm = {
      url                = "https://cloud.debian.org/images/cloud/bookworm/20251006-2257/debian-12-generic-amd64-20251006-2257.qcow2"
      save_file_name     = "debian-12-generic-amd64.qcow2.img"
      checksum           = "be06e506319a7f0e3ee5ec2328595bc4c2205b91b4354ccbb2e6d88b047cf7288137bfa17a143ea611cb588adb9417847c0a5aec0addbbf2835f9f31e2e76547"
      checksum_algorithm = "sha512"
    }

    debian_trixie = {
      url                = "https://cloud.debian.org/images/cloud/trixie/20251006-2257/debian-13-generic-amd64-20251006-2257.qcow2"
      save_file_name     = "debian-13-generic-amd64.qcow2.img"
      checksum           = "0449ce335d0780af6290dd0b1c11c1e5231a73a3a1fc3e49ba8172853d26f5002e02830352d91ab9894442d29c8d352b21cb6c1c29f3b0f995d968ae4b573452"
      checksum_algorithm = "sha512"
    }

    home_assistant = {
      url                     = "https://github.com/home-assistant/operating-system/releases/download/16.2/haos_generic-x86-64-16.2.img.xz"
      save_file_name          = "haos_generic-x86-64.img"
      checksum                = "00d1b7da66edacb3f6bdde4e39bdbacf8eb1685ba44ddc827771157c83cf4144"
      decompression_algorithm = "zst"
      checksum_algorithm      = "sha256"
    }

    free_bsd = {
      url                     = "https://download.freebsd.org/ftp/snapshots/VM-IMAGES/15.0-STABLE/amd64/20251022/FreeBSD-15.0-STABLE-amd64-BASIC-CLOUDINIT-20251022-2427ae41b7cf-280773-zfs.qcow2.xz"
      save_file_name          = "FreeBSD-15.0-STABLE-amd64-BASIC-CLOUDINIT-zfs.qcow2.img"
      checksum                = "e08247d1b7c519f8eaacddc14ffc14ec20be4f2a4fcbc7c62967fd8a7699a60bffc127351ba24711ada8e06804305a2e3390dec5aeafc8345100ea661a9b0547"
      decompression_algorithm = "zst"
      checksum_algorithm      = "sha512"
    }
  }

  filename_to_checksum = {
    for k, v in local.images :
    k => {
      file_id   = resource.proxmox_virtual_environment_download_file.os_image[k].id
      file_name = resource.proxmox_virtual_environment_download_file.os_image[k].file_name
      checksum  = resource.proxmox_virtual_environment_download_file.os_image[k].checksum
    }
    if v.checksum != null
  }
}
