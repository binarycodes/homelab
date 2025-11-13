data "infisical_secrets" "app" {
  workspace_id = var.infisical_project_id
  env_slug     = var.infisical_environment
  folder_path  = "/terraform"
}

resource "proxmox_virtual_environment_role" "this" {
  role_id = "terraform-privileges"

  privileges = [
    "Datastore.Allocate",
    "Datastore.AllocateSpace",
    "Datastore.AllocateTemplate",
    "Datastore.Audit",
    "Pool.Allocate",
    "SDN.Allocate",
    "SDN.Use",
    "Sys.Audit",
    "Sys.Console",
    "Sys.Modify",
    "VM.Allocate",
    "VM.Audit",
    "VM.Clone",
    "VM.Config.CDROM",
    "VM.Config.CPU",
    "VM.Config.Cloudinit",
    "VM.Config.Disk",
    "VM.Config.HWType",
    "VM.Config.Memory",
    "VM.Config.Network",
    "VM.Config.Options",
    "VM.GuestAgent.Audit",
    "VM.Migrate",
    "VM.PowerMgmt",
  ]
}

resource "proxmox_virtual_environment_user" "this" {
  user_id         = local.terraform_user
  comment         = "to be used by terraform"
  expiration_date = local.token_expiration
  enabled         = true

  acl {
    path      = "/"
    propagate = true
    role_id   = proxmox_virtual_environment_role.this.role_id
  }
}

resource "proxmox_virtual_environment_user_token" "this" {
  comment               = "to be used by terraform"
  expiration_date       = local.token_expiration
  token_name            = local.token_name
  user_id               = proxmox_virtual_environment_user.this.user_id
  privileges_separation = false
}

output "user_token" {
  value     = proxmox_virtual_environment_user_token.this.value
  sensitive = true
}
