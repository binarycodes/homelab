resource "proxmox_vm_qemu" "debian" {
  target_node = var.node
  clone       = var.template_name

  vmid    = var.config.vmid
  name    = upper("vm${var.node}debian${var.config.vmid}")
  desc    = var.config.description
  agent   = 1
  onboot  = true
  os_type = "cloud-init"
  qemu_os = "l26"
  cpu     = var.config.cpu
  cores   = var.config.cores
  sockets = 1
  memory  = var.config.memory

  cloudinit_cdrom_storage = "local-lvm"
  scsihw                  = "virtio-scsi-single"
  bootdisk                = "scsi0"

  network {
    bridge   = "vmbr0"
    model    = "virtio"
    mtu      = 0
    firewall = true
  }

  disks {
    scsi {
      scsi0 {
        disk {
          storage  = "local-lvm"
          size     = var.config.disk_size
          discard  = true
          iothread = true
        }
      }
    }
  }

  ipconfig0  = "ip=${var.config.ip_v4}/24,gw=${var.config.gateway}"
  nameserver = var.config.nameserver
  ciuser     = var.config.username
  cipassword = var.config.password
  sshkeys    = var.config.ssh_keys
}
