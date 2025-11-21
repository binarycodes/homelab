terraform {
  required_version = ">= 1.11.2"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.87.0"
    }
    keycloak = {
      source  = "keycloak/keycloak"
      version = "5.4.0"
    }
    dns = {
      source  = "hashicorp/dns"
      version = "3.4.3"
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
      name = "Kubernetes"
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

provider "keycloak" {
  realm         = local.secret.keycloak_realm.value
  client_id     = local.secret.keycloak_client_id.value
  client_secret = local.secret.keycloak_client_secret.value
  url           = local.secret.keycloak_url.value
}

provider "dns" {
  update {
    server        = local.secret.dns_server.value
    key_name      = local.secret.dns_key_name.value
    key_algorithm = local.secret.dns_key_algorithm.value
    key_secret    = local.secret.dns_key_secret.value
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
