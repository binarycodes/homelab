resource "proxmox_vm_qemu" "debian" {
  target_node = var.node
  clone       = var.template_name

  vmid    = var.config.vmid
  name    = var.config.name
  desc    = var.config.description
  agent   = 1
  onboot  = true
  os_type = "cloud-init"
  qemu_os = "l26"
  cpu     = var.config.cpu
  cores   = var.config.cores
  sockets = 1
  memory  = var.config.memory

  scsihw    = "virtio-scsi-single"
  bootdisk  = "scsi0"

  network {
    bridge   = "vmbr0"
    model    = "virtio"
	tag 	 = var.config.vlan_id
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
	ide {
	  ide3 {
	  	cloudinit {
		  storage   = "local-lvm"
		}
	  }
	}
  }

  smbios {
    serial = "ds=nocloud-net;h=${var.config.name}"
  }

  ipconfig0    = var.config.dhcp ? "ip=dhcp" : "ip=${var.config.ip_v4},gw=${var.config.gateway}"
  nameserver   = var.config.dhcp ? null : var.config.nameserver
  searchdomain = var.config.dhcp ? null : var.config.searchdomain

  ciuser     = var.config.username
  cipassword = var.config.password
  sshkeys    = var.config.ssh_keys


  provisioner "local-exec" {
    command = "ssh-keygen -R ${lower(self.name)}"
  }

}
