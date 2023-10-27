# Homelab

This repository attemps to collect all required scripts, playbooks, etc to setup my homelab. This is work in progress.

## Usefull commands

Random tidbits that I need to run frequently enough that these are useful but not so frequently that I will remember these.

### SSH

###### Copy the ssh to the server
```sh
# Run in windows command prompt / powershell
# Not required if using ansible
ssh <user@hostname> "mkdir -p .ssh"
type $env:USERPROFILE\.ssh\id_rsa.pub | ssh <user@hostname> "cat >> .ssh/authorized_keys"
```

### Ansible

###### For the first time, need to run as root to create the user and setup ssh keys
```sh
ansible-playbook site.yml -k --ask-become-pass
```

###### Check if ansible is able to reach the servers

```sh
# if everything is set up
ansible all -m ping

# if ansible.cfg is not set up
ansible all --key-file ~/.ssh/ansible -i inventory -m ping
```


### WSL

###### Ansible does not like world writable directory in WSL. Enable chmod and then remove write persmission from others.

```sh
sudo umount /mnt/c
sudo mount -t drvfs C: /mnt/c -o metadata
sudo chmod o-w <ANSIBLE_DIRECTORY>
```

###### Run terraform

```sh
terraform init --upgrade
terraform plan
terraform apply
```
