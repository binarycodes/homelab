terraform {
  required_version = ">= 1.10.6"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.85.1"
    }
    keycloak = {
      source  = "keycloak/keycloak"
      version = "5.4.0"
    }
    dns = {
      source  = "hashicorp/dns"
      version = "3.4.3"
    }
  }
}
