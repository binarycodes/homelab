resource "proxmox_virtual_environment_download_file" "debian_bookworm_cloud_image" {
  content_type       = "iso"
  datastore_id       = "local"
  node_name          = each.value
  file_name          = local.debian_bookworm.save_file_name
  url                = local.debian_bookworm.url
  checksum           = local.debian_bookworm.checksum
  checksum_algorithm = "sha512"

  for_each = toset(local.nodes)
}

resource "proxmox_virtual_environment_download_file" "debian_trixie_cloud_image" {
  content_type       = "iso"
  datastore_id       = "local"
  node_name          = each.value
  file_name          = local.debian_trixie.save_file_name
  url                = local.debian_trixie.url
  checksum           = local.debian_trixie.checksum
  checksum_algorithm = "sha512"

  for_each = toset(local.nodes)
}

resource "proxmox_virtual_environment_download_file" "home_assistant_cloud_image" {
  content_type            = "iso"
  datastore_id            = "local"
  file_name               = local.home_assistant.save_file_name
  node_name               = each.value
  url                     = local.home_assistant.url
  decompression_algorithm = local.home_assistant.decompression_algorithm
  overwrite               = false # file size will always differ due to decompression

  for_each = toset(local.nodes)
}

resource "proxmox_virtual_environment_download_file" "free_bsd_cloud_image" {
  content_type            = "iso"
  datastore_id            = "local"
  file_name               = local.free_bsd.save_file_name
  node_name               = each.value
  url                     = local.free_bsd.url
  decompression_algorithm = local.free_bsd.decompression_algorithm
  overwrite               = false # file size will always differ due to decompression
  checksum                = local.free_bsd.checksum
  checksum_algorithm      = "sha512"

  for_each = toset(local.nodes)
}
