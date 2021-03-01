#!/bin/bash
ansible -i inventory localhost -m file -a "path=~/.ssh state=directory owner=ansible group=ansible"
ansible -i inventory localhost -m openssh_keypair -a "path=~/.ssh/id_rsa"
ansible -i inventory all -u root -k -m user -a "name=ansible"
ansible -i inventory all -u root -k -m authorized_key -a "user=ansible state=present key='{{ lookup('file', '~/.ssh/id_rsa.pub') }}'"
ansible -i inventory all -u root -k -m copy -a "content='ansible ALL=(ALL) NOPASSWD: ALL' dest=/etc/sudoers.d/ansible"
ansible -i inventory all -m ping
