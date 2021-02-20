#!/bin/bash
ansible -i inventory localhost -u root -m file -a "path=~/.ssh state=directory mode=0700"
ansible -i inventory localhost -u root -m openssh_keypair -a "path=~/.ssh/id_rsa"
ansible -i inventory all -u root -m user -a "name=ansible"
ansible -i inventory all -u root -m copy -a "content='ansible ALL=(ALL) NOPASSWD: ALL' dest=/etc/sudoers.d/ansible"
ansible -i inventory all -u root -m authorized_key -a "user=ansible state=present key='{{ lookup('file', '/home/ansible/.ssh/id_rsa.pub') }}'"
