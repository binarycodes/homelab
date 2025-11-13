locals {
  secret = data.infisical_secrets.app.secrets

  terraform_user   = "terraform-user@pve"
  token_name       = "terraform"
  token_expiration = timeadd(timestamp(), "${30 * 24}h")
}
