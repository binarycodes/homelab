data "infisical_secrets" "app" {
  workspace_id = var.infisical_project_id
  env_slug     = var.infisical_environment
  folder_path  = "/terraform"
}

resource "dns_a_record_set" "this" {
  for_each = local.a_records_flat

  zone      = each.value.zone
  name      = each.value.name
  addresses = each.value.addresses
  ttl       = 300
}
