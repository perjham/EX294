#!/bin/bash
ansible -i inventory localhost -m file -a "path=~/.ssh mode='0700' state=directory"
ansible -i inventory localhost -m openssh_keypair -a "path=~/.ssh/id_rsa"
# if the user ansible from controller already have ssh powerless access into root user's nodes
# use this way, otherwise you have to add '-k' option for prompt the password in each execution of 
# the next lines.
ansible -i inventory all -u root -m user -a "name=ansible"
ansible -i inventory all -u root -m copy -a "dest=/etc/sudoers.d/ansible content='ansible ALL=(ALL) NOPASSWD: ALL'"
ansible -i inventory all -u root -m authorized_key -a "user=ansible manage_dir=True key='{{ lookup('file', '~/.ssh/id_rsa.pub') }}'"
