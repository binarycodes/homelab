terraform {
  required_version = ">= 1.11.2"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.83.1"
    }
    keycloak = {
      source  = "keycloak/keycloak"
      version = "5.4.0"
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

provider "keycloak" {
  realm         = var.keycloak_realm
  client_id     = var.keycloak_client_id
  client_secret = var.keycloak_client_secret
  url           = var.keycloak_url
}
