locals {
  nodes = ["pve1", "pve2", "pve3"]

  sdn = {
    Lab = {
      bridge = "vmbr0"
    },
    Mgmt = {
      bridge = "vmbr0"
    },
    Prod = {
      bridge = "vmbr0"
    }
  }
}
