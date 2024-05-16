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

  ipconfig0    = var.config.dhcp ? "ip=dhcp" : "ip=${var.config.ip_v4},gw=${var.config.gateway}"
  nameserver   = var.config.dhcp ? null : var.config.nameserver
  searchdomain = var.config.searchdomain

  ciuser     = var.config.username
  cipassword = var.config.password
  sshkeys    = var.config.ssh_keys


  provisioner "remote-exec" {
    inline = [
      "sudo dhclient -r",
      "sudo ip -4 addr flush dev eth0",
      "sudo dhclient",
    ]

    connection {
      type        = "ssh"
      user        = var.config.username
      private_key = file("~/.ssh/ansible")
      host        = self.ssh_host
    }
  }

  provisioner "local-exec" {
    command = "ssh-keygen -R ${lower(self.name)}"
  }

}
