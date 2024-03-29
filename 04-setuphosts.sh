#!/bin/bash
ansible localhost -m file -a "path=$HOME/.ssh state=directory owner=ansible group=ansible"
ansible localhost -m openssh_keypair -a "path=$HOME/.ssh/id_rsa owner=ansible group=ansible"
ansible -i inventory all -m user -a "name=ansible" -u root -k
ansible -i inventory all -m authorized_key -a "user=ansible state=present key='{{ lookup('file', '/home/ansible/.ssh/id_rsa.pub') }}'" -u root -k
ansible -i inventory all -m copy -a "content='ansible ALL=(ALL) NOPASSWD: ALL' dest=/etc/sudoers.d/ansible mode=0600" -u root -k
ansible -i inventory all -m ping
