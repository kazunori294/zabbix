#!/bin/sh

rpm -ivh http://repo.zabbix.com/zabbix/2.2/rhel/6/x86_64/zabbix-release-2.2-1.el6.noarch.rpm
yum install -y zabbix-agent

sed -i".org" -e "s/ServerActive=127.0.0.1/ServerActive=zabbix01.kazutan.info/g" /etc/zabbix/zabbix_agentd.conf
sed -i -e "s/Server=127.0.0.1/Server=zabbix01.kazutan.info/g" /etc/zabbix/zabbix_agentd.conf
sed -i -e "s/# HostnameItem=system.hostname/HostnameItem=system.hostname/g" /etc/zabbix/zabbix_agentd.conf
sed -i -e "s/Hostname=Zabbix server/# Hostname=Zabbix server/g" /etc/zabbix/zabbix_agentd.conf

service zabbix-agent start
chkconfig zabbix-agent on
