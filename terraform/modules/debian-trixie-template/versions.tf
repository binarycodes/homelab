terraform {
  required_version = ">= 1.11.2"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.84.0"
    }
    keycloak = {
      source  = "keycloak/keycloak"
      version = "5.4.0"
    }
  }
}
