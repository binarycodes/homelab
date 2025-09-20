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
