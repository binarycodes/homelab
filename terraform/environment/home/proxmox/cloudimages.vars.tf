variable "homeassistant_image" {
  type = object({
    download_url            = string
    save_file_name          = string
    checksum                = string
    checksum_algorithm      = string
    decompression_algorithm = string
  })
}

variable "freebsd_image" {
  type = object({
    download_url            = string
    save_file_name          = string
    checksum                = string
    checksum_algorithm      = string
    decompression_algorithm = string
  })
}
