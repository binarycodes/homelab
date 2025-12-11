terraform {
  required_version = ">= 1.10.6"

  required_providers {
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
      name = "Static-DNS"
    }
  }
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
