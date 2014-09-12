#!/bin/sh

yum install -y httpd mysql mysql-server php php-mysql
rpm -ivh http://repo.zabbix.com/zabbix/2.2/rhel/6/x86_64/zabbix-release-2.2-1.el6.noarch.rpm
yum install -y zabbix-server-mysql zabbix-web-mysql
yum install -y zabbix-agent


cat << EOF > /etc/my.cnf
[mysqld]
datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock
user=mysql
# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0
default-character-set=utf8

[mysqld_safe]
log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid

EOF


service mysqld restart

mysql -e "CREATE DATABASE zabbix"
mysql -e "GRANT ALL PRIVILEGES ON zabbix.* TO zabbix@localhost IDENTIFIED BY 'zabbix'"
mysql -e "FLUSH PRIVILEGES"

mysql -u zabbix -ppassword zabbix < /usr/share/doc/zabbix-server-mysql-2.2.4/create/schema.sql
mysql -u zabbix -ppassword zabbix < /usr/share/doc/zabbix-server-mysql-2.2.4/create/data.sql
mysql -u zabbix -ppassword zabbix < /usr/share/doc/zabbix-server-mysql-2.2.4/create/images.sql

mysql -u zabbix -ppassword zabbix < /usr/share/doc/zabbix-server-mysql-2.2.4/create/schema.sql
mysql -u zabbix -ppassword zabbix < /usr/share/doc/zabbix-server-mysql-2.2.4/create/data.sql
mysql -u zabbix -ppassword zabbix < /usr/share/doc/zabbix-server-mysql-2.2.4/create/images.sql



#sed -e "s/# DBUser=/DBUser=zabbix/g" /etc/zabbix/zabbix_server.conf > /etc/zabbix/zabbix_server.conf
sed -i".org" -e "s/;date.timezone =/date.timezone = Asia\/Tokyo/g" /etc/php.ini

service zabbix-server restart
service httpd restart 
chkconfig mysqld on
chkconfig httpd on
chkconfig zabbix-server on

#access to <host>/zabbix
