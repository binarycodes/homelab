terraform {
  required_version = ">= 1.11.2"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.85.1"
    }
    dns = {
      source  = "hashicorp/dns"
      version = "3.4.3"
    }
  }

  cloud {
    organization = "binarycodes"

    workspaces {
      name = "HomeAssistant"
    }
  }

}

provider "proxmox" {
  endpoint  = var.proxmox_endpoint
  api_token = var.proxmox_api_token

  insecure = true

  ssh {
    agent       = false
    private_key = file("~/.ssh/id_homelab")
    username    = "root"
  }
}

provider "dns" {
  update {
    server        = var.dns_server
    key_name      = var.dns_key_name
    key_algorithm = "hmac-sha256"
    key_secret    = var.dns_key_secret
  }
}
