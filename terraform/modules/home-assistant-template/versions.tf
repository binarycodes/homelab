terraform {
  required_version = ">= 1.11.2"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.93.0"
    }
    dns = {
      source  = "hashicorp/dns"
      version = "3.4.3"
    }
  }
}
