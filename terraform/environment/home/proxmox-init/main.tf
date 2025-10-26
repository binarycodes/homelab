resource "proxmox_virtual_environment_role" "this" {
  role_id = "terraform-privileges"

  privileges = [
    "VM.GuestAgent.Audit",
    "Datastore.Allocate",
    "Datastore.AllocateSpace",
    "Datastore.Audit",
    "Pool.Allocate",
    "Sys.Audit",
    "Sys.Console",
    "Sys.Modify",
    "VM.Allocate",
    "VM.Audit",
    "VM.Clone",
    "VM.Config.CDROM",
    "VM.Config.Cloudinit",
    "VM.Config.CPU",
    "VM.Config.Disk",
    "VM.Config.HWType",
    "VM.Config.Memory",
    "VM.Config.Network",
    "VM.Config.Options",
    "VM.Migrate",
    "VM.PowerMgmt",
    "SDN.Use",
    "SDN.Allocate"
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
