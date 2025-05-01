resource "proxmox_virtual_environment_download_file" "bookworm_cloud_image" {
  content_type       = "iso"
  datastore_id       = "local"
  file_name          = "debian-12-genericcloud-amd64-20250416-2084.qcow2.img"
  node_name          = each.value
  url                = "https://cloud.debian.org/images/cloud/bookworm/20250416-2084/debian-12-genericcloud-amd64-20250416-2084.qcow2"
  checksum           = "72ef23f399ceff56f7e0c213db796d655aaaea833bc18838210a1ab40e531e6acf9b21adc1954b902db8c9b2255bff7a08aed816250e6afc2821550533df457d"
  checksum_algorithm = "sha512"

  for_each = local.bookworm_vm_nodes
}

module "proxmox_bookworm" {
  source = "./debian-bookworm-template"

  for_each = local.bookworm_vms
  config   = merge(each.value, { image_id = proxmox_virtual_environment_download_file.bookworm_cloud_image[each.value.node].id })
}

# module "proxmox_home_assitant" {
#   source = "./home-assistant-template"

#   for_each = local.home_assistant_vms
#   config   = each.value
# }
