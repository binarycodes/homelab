variable "config" {
  type = object({
    nodes                   = set(string)
    content_type            = optional(string, "iso")
    datastore_id            = optional(string, "local")
    save_file_name          = string
    download_url            = string
    checksum                = string
    checksum_algorithm      = string
    decompression_algorithm = optional(string, null)
    overwrite               = optional(bool, true)
  })
}
