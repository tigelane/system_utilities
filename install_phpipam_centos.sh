#!/bin/bash

echo LC_ALL=en_US.utf-8 >> /etc/environment
echo LANG=en_US.utf-8 >> /etc/environment

sudo yum -y install httpd mariadb-server php php-cli php-gd php-common php-ldap php-pdo php-pear php-snmp php-xml php-mysql php-mbstring git

cat >> /etc/httpd/conf/httpd.conf <<_EOF_
<Directory "/var/www/html">
    Options FollowSymLinks
    AllowOverride all
    Order allow,deny
    Allow from all
</Directory>
ServerName locahost:80
_EOF_

sed -i '/;date.timezone =/ c\date.timezone = America\/Los_Angeles' /etc/php.ini

sudo service httpd start
sudo chkconfig httpd on

sudo firewall-cmd --permanent --add-port=80/tcp
sudo firewall-cmd --permanent --add-port=443/tcp
sudo firewall-cmd --reload

sudo service mariadb start
sudo chkconfig mariadb on

# sudo mysql_secure_installation
mysql -u root <<-EOF
UPDATE mysql.user SET Password=PASSWORD('ignw!098') WHERE User='root';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';
FLUSH PRIVILEGES;
EOF

cd /var/www/html/
git clone https://github.com/phpipam/phpipam.git .
git checkout 1.3

sudo chown apache:apache -R /var/www/html/
sudo chcon -t httpd_sys_content_t /var/www/html/ -R

find . -type f -exec chmod 0644 {} \;
find . -type d -exec chmod 0755 {} \;

sudo chcon -t httpd_sys_rw_content_t app/admin/import-export/upload/ -R
sudo chcon -t httpd_sys_rw_content_t app/subnets/import-subnet/upload/ -R
sudo chcon -t httpd_sys_rw_content_t css/1.3/images/logo/ -R

cp config.dist.php config.php
