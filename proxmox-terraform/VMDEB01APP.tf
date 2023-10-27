resource "proxmox_vm_qemu" "VMDEB01APP" {
    name = "VMDEB01APP"
    vmid = 100
    desc = "Debian VM"
    target_node = "homelab"

    agent = 1
    onboot = true

    clone = "vm-debian-template"
    cores = 1
    sockets = 1
    memory = 1024

    network {
        bridge = "vmbr0"
        model = "virtio"
        mtu = 0
        firewall = true
    }

    scsihw = "virtio-scsi-single"

    disk {
        storage = "local-lvm"
        type = "scsi"
        size = "20G"
        discard = "on"
        iothread = 1
    }

    os_type = "cloud-init"
    ipconfig0 = "ip=192.168.1.11/16,gw=192.168.1.1"
    nameserver = "192.168.1.1"
    ciuser = var.default_username
    cipassword = var.default_userpassword
}