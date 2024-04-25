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
  alias               = "n1"
  pm_api_url          = var.proxmox_api_url["n1"]
  pm_api_token_id     = var.proxmox_api_token_id["n1"]
  pm_api_token_secret = var.proxmox_api_token_secret["n1"]

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
  alias               = "n2"
  pm_api_url          = var.proxmox_api_url["n2"]
  pm_api_token_id     = var.proxmox_api_token_id["n2"]
  pm_api_token_secret = var.proxmox_api_token_secret["n2"]

  pm_tls_insecure = true

  pm_log_enable = true
  pm_log_file   = "terraform-plugin-proxmox.log"
  pm_debug      = true
  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }
}
