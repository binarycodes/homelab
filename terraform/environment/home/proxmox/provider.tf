terraform {
  required_version = ">= 1.11.2"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.89.1"
    }
    infisical = {
      source  = "Infisical/infisical"
      version = "0.15.44"
    }
  }

  cloud {
    organization = "binarycodes"
    hostname     = "app.terraform.io"

    workspaces {
      name = "Proxmox-Setup"
    }
  }
}



provider "proxmox" {
  endpoint  = local.secret.proxmox_endpoint.value
  api_token = local.secret.proxmox_api_token.value

  insecure = true
  ssh {
    agent       = false
    private_key = local.secret.proxmox_ssh_private_key.value
    username    = "root"
  }
}


provider "infisical" {
  host = "https://eu.infisical.com"
  auth = {
    universal = {
      client_id     = var.infisical_client_id
      client_secret = var.infisical_client_secret
    }
  }
}
