#!/bin/sh

yum install -y httpd mysql mysql-server php php-mysql
rpm -ivh http://repo.zabbix.com/zabbix/2.2/rhel/6/x86_64/zabbix-release-2.2-1.el6.noarch.rpm
yum install -y zabbix-server-mysql zabbix-web-mysql
yum install -y zabbix-agent
