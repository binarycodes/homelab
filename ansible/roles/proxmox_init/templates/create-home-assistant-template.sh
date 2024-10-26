#!/usr/bin/env bash

image_name="haos_ova-13.2.qcow2"
download_name="${image_name}.xz"
image_url="https://github.com/home-assistant/operating-system/releases/download/13.2/$download_name"
template_name="home-assistant"
template_id={{ home_assistant_template_id }}
storage_name="local-lvm"

apt-get -qq update -y
apt-get -qq install libguestfs-tools -y

if [[ ! -f $image_name ]]; then
	wget -q $image_url
	unxz $download_name
fi

qm create $template_id --name $template_name --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0
qm importdisk $template_id $image_name $storage_name
qm set $template_id --scsihw virtio-scsi-single --scsi0 $storage_name:vm-$template_id-disk-0
qm set $template_id --boot c --bootdisk scsi0
qm set $template_id --ide2 $storage_name:cloudinit
qm template $template_id

if [[ -f $image_name ]]; then
	rm $image_name
fi

if [[ -f $download_name ]]; then
	rm $download_name
fi