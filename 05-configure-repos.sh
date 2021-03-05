#!/bin/bash
ansible -i inventory all -m copy -a 'content="127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4\n::1         localhost localhost.localdomain localhost6 localhost6.localdomain6\n192.168.122.100 controller.example.com controller\n192.168.122.101 node1.example.com node1\n192.168.122.102 node2.example.com node2\n192.168.122.103 node3.example.com node3\n192.168.122.104 node4.example.com node4\n" dest=/etc/hosts'
ansible -i inventory all -m shell -a "command=rm -rf /etc/yum.repos.d/*"
ansible -i inventory all -m yum_repository -a "name=BaseOS description=BaseOS baseurl=ftp://controller.example.com/BaseOS gpgcheck=yes gpgkey=ftp://controller.example.com/RPM-GPG-KEY-redhat-release"
ansible -i inventory all -m yum_repository -a "name=AppStream description=AppStream baseurl=ftp://controller.example.com/AppStream gpgcheck=yes gpgkey=ftp://controller.example.com/RPM-GPG-KEY-redhat-release"
ansible -i inventory all -m dnf -a "name=vim state=present"
