terraform {
  required_version = ">= 1.5.7"

  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }
}

provider "proxmox" {
  alias               = "pve1"
  pm_api_url          = var.proxmox_api_url["pve1"]
  pm_api_token_id     = var.proxmox_api_token_id["pve1"]
  pm_api_token_secret = var.proxmox_api_token_secret["pve1"]

  pm_tls_insecure = true

  pm_log_enable = true
  pm_log_file   = "terraform-plugin-proxmox.log"
  pm_debug      = true
  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }
}

provider "proxmox" {
  alias               = "pve2"
  pm_api_url          = var.proxmox_api_url["pve2"]
  pm_api_token_id     = var.proxmox_api_token_id["pve2"]
  pm_api_token_secret = var.proxmox_api_token_secret["pve2"]

  pm_tls_insecure = true

  pm_log_enable = true
  pm_log_file   = "terraform-plugin-proxmox.log"
  pm_debug      = true
  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }
}
