terraform {
  required_version = ">= 1.11.2"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.85.1"
    }
  }

  cloud {
    organization = "binarycodes"

    workspaces {
      name = "ProxmoxInit"
    }
  }
}

provider "proxmox" {
  endpoint = var.proxmox_endpoint
  username = var.proxmox_username
  password = var.proxmox_password

  insecure = true

  ssh {
    agent       = false
    private_key = file("~/.ssh/id_homelab")
    username    = "root"
  }
}
