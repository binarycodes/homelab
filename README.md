# Homelab

This repository attemps to collect all required scripts, playbooks, etc to setup my homelab. This is forever work in progress.


## Setup Proxmox VMs

> For the first execution, the password is required for ssh\
> So run the playbook with additional argument -k. Thereafter the ssh authorized keys are set and password will not be required.

```
cd proxmox/ansible
ansible-playbook proxmox.yml
```

### Run terraform to provision VMs

```
cd proxmox/terraform
terraform init --upgrade
terraform plan
terraform apply --auto-approve
```

### Run ansible to setup VMs

```
cd proxmox/ansible
ansible-playbook vm.yml
```

## Usefull commands

Random tidbits that I need to run frequently enough that these are useful but not so frequently that I will remember these.

### Generate basic auth password

```sh
echo $(htpasswd -nb "<USER>" "<PASSWORD>") | sed -e s/\\$/\\$\\$/g
```

### SSH

#### Remove known hosts entry when recreating VMs
```sh
ssh-keygen -R <IP>
```

#### Copy the ssh to the server

```sh
# Run in windows command prompt / powershell
# Alternative to doing the same thing in ansible
ssh <user@hostname> "mkdir -p .ssh"
type $env:USERPROFILE\.ssh\id_rsa.pub | ssh <user@hostname> "cat >> .ssh/authorized_keys"
```

### Ansible

#### Check if ansible is able to reach the servers

```sh
# if everything is set up
ansible all -m ping

# if ansible.cfg is not set up
ansible all --key-file ~/.ssh/ansible -i inventory -m ping
```

### WSL

#### Ansible does not like world writable directory in WSL. Enable chmod and then remove write persmission from others.

```sh
sudo umount /mnt/c
sudo mount -t drvfs C: /mnt/c -o metadata
sudo chmod o-w <ANSIBLE_DIRECTORY>
```

### Proxmox

#### Stop and remove VMs
```
qm stop <VM_ID>
qm destroy <VM_ID>
```

### Terraform

#### Destroy all resources

```
terraform destroy
```

### Git

#### Rebase and squash entire branch
```
git checkout --orphan new-master master
git commit -m "Enter commit message for your new initial commit"

# Overwrite the old master branch reference with the new one
git branch -M new-master master
```