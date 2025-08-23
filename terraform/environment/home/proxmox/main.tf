resource "proxmox_virtual_environment_download_file" "trixie_cloud_image" {
  content_type       = "iso"
  datastore_id       = "local"
  file_name          = "debian-13-generic-amd64-20250814-2204.qcow2.img"
  node_name          = each.value
  url                = "https://cloud.debian.org/images/cloud/trixie/20250814-2204/debian-13-generic-amd64-20250814-2204.qcow2"
  checksum           = "8f5c54d654b53951430b404efc3043b425cf2214467d5bf33d6c5157fa47c8fe4a1a2abf603050dafc7e54f57e9685f0d59a6c0d09d0cb2b7fcec75561c0df6f"
  checksum_algorithm = "sha512"

  for_each = toset(local.nodes)
}
