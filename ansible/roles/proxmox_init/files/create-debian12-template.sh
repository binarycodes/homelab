#!/usr/bin/env bash

image_name="debian-12-genericcloud-amd64.qcow2"
image_url="https://cloud.debian.org/images/cloud/bookworm/latest/$image_name"
template_name="debian12"
template_id=100200
storage_name="local-lvm"

apt update -y
apt install libguestfs-tools -y
wget $image_url

virt-customize -a $image_name --install qemu-guest-agent
virt-customize -a $image_name --run-command "echo -n > /etc/machine-id"
qm create $template_id --name $template_name --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0
qm importdisk $template_id $image_name $storage_name
qm set $template_id --scsihw virtio-scsi-single --scsi0 $storage_name:vm-$template_id-disk-0
qm set $template_id --boot c --bootdisk scsi0
qm set $template_id --ide2 $storage_name:cloudinit
qm set $template_id --agent enabled=1
qm template $template_id

rm $image_name
