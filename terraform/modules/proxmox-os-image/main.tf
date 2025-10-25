resource "proxmox_virtual_environment_download_file" "os_image" {
  for_each                = local.images
  node_name               = var.node_name
  content_type            = "iso"
  datastore_id            = "local"
  file_name               = each.value.save_file_name
  url                     = each.value.url
  checksum                = each.value.checksum
  checksum_algorithm      = each.value.checksum_algorithm
  decompression_algorithm = try(each.value.decompression_algorithm, null)
}

output "image_filename_to_checksum" {
  description = "filename -> checksum"
  value       = local.filename_to_checksum
}
