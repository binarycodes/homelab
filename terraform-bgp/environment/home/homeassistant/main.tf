resource "proxmox_virtual_environment_download_file" "home_assistant_cloud_image" {
  content_type            = "iso"
  datastore_id            = "local"
  file_name               = "haos_ova-15.2.qcow2.xz.img"
  node_name               = each.value
  url                     = "https://github.com/home-assistant/operating-system/releases/download/15.2/haos_ova-15.2.qcow2.xz"
  decompression_algorithm = "zst"
  overwrite               = false # file size will always differ due to decompression

  for_each = local.home_assistant_vm_nodes
}

module "proxmox_home_assitant" {
  source = "../../../modules/home-assistant-template"

  for_each = local.home_assistant_vms
  config   = merge(each.value, { image_id = proxmox_virtual_environment_download_file.home_assistant_cloud_image[each.value.node].id, tags = ["home-assistant"] })
}
