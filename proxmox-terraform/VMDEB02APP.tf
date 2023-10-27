resource "proxmox_vm_qemu" "VMDEB02APP" {
    name = "VMDEB02APP"
    desc = "Debian VM"
    target_node = "homelab"
    clone = "vm-debian-template"

    agent = 1
    onboot = true
    qemu_os = "l26"
    cpu = "host"
    cores = 1
    sockets = 1
    memory = 1024
    scsihw = "virtio-scsi-single"

    network {
        bridge = "vmbr0"
        model = "virtio"
        mtu = 0
        firewall = true
    } 

    disk {
        storage = "local-lvm"
        type = "scsi"
        size = "20G"
        discard = "on"
        iothread = 1
    }

    os_type = "cloud-init"
    ipconfig0 = "ip=192.168.1.12/16,gw=192.168.1.1"
    nameserver = "192.168.1.1"
    ciuser = var.default_username
    cipassword = var.default_userpassword
}