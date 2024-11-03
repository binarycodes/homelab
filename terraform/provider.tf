terraform {
  required_version = ">= 1.5.7"

  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc4"
    }
  }
}

provider "proxmox" {
  alias               = "pve"
  pm_api_url          = var.proxmox["api_url"]
  pm_api_token_id     = var.proxmox["token_id"]
  pm_api_token_secret = var.proxmox["token_secret"]

  pm_tls_insecure = true

  pm_log_enable = true
  pm_log_file   = "terraform-plugin-proxmox.log"
  pm_debug      = true
  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }
}
