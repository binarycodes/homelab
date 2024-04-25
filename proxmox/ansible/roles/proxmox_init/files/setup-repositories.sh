#!/usr/bin/env bash

sed -i '/^#/!s/\(..*\)/# \1/' /etc/apt/sources.list.d/pve-enterprise.list
sed -i '/^#/!s/\(..*\)/# \1/' /etc/apt/sources.list.d/ceph.list

if ! grep -q "pve-no-subscription" /etc/apt/sources.list; then
    echo "adding pve-no-subscription repository ..."

    tee -a /etc/apt/sources.list <<END

# Proxmox VE pve-no-subscription repository provided by proxmox.com,
# NOT recommended for production use
deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription
deb http://download.proxmox.com/debian/ceph-reef bookworm no-subscription
END
fi
