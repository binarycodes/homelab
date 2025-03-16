resource "proxmox_vm_qemu" "clone_template" {
  target_node = var.node

  clone   = var.config.template
  vmid    = var.config.vmid
  name    = var.config.name
  desc    = try(var.config.description,"")
  agent   = 1
  onboot  = true
  os_type = "cloud-init"
  qemu_os = "l26"
  bios    = try(var.config.bios, "seabios")
  cpu     = try(var.config.cpu, "host")
  cores   = try(var.config.cores, 1)
  sockets = 1
  memory  = try(var.config.memory, 2048)

  scsihw   = "virtio-scsi-single"
  bootdisk = "scsi0"

  network {
    id       = 0
    bridge   = try(var.config.bridge, "vmbr0")
    model    = "virtio"
    firewall = true
  }

  disks {
    scsi {
      scsi0 {
        disk {
		  storage  = "local-lvm"
		  size     = try(var.config.disk_size, "20G")
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
  nameserver   = var.config.dhcp ? null : try(var.config.nameserver, var.config.gateway)
  searchdomain = var.config.dhcp ? null : try(var.config.searchdomain, "localdomain")

  cicustom  = "user=local:snippets/debian-bookworm.yaml"

  provisioner "local-exec" {
    command = "ssh-keygen -R ${lower(self.name)}"
  }

}
