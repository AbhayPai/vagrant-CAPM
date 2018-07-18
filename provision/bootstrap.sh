#!/usr/bin/env bash

installUpdate() {
  echo ">> updating packages <<"
    sudo  yum -y update >/dev/null
}

installApache() {
  echo ">> downloading apache <<"
    sudo yum -y install httpd >/dev/null

  echo ">> enabling apache <<"
    sudo systemctl enable httpd.service >/dev/null

  echo ">> restarting apache <<"
    sudo systemctl restart httpd.service >/dev/null

  echo ">> apache version <<"
    httpd -v
}

installEPEL() {
  echo ">> downloading and installing EPEL <<"
    sudo yum -y install epel-release >/dev/null
}

installRPM() {
  echo ">> dowloading rpm <<"
    rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm >/dev/null
}

installPHP7() {
  installEPEL;

  installRPM;

  echo ">> download and installing php <<"
    yum install -y php72w-fpm php72w-cli php72w-common php72w-dba php72w-devel php72w-embedded  php72w-enchant php72w-gd  php72w-imap  php72w-interbase php72w-intl php72w-ldap php72w-mbstring php72w-mysql  php72w-odbc php72w-opcache php72w-pdo php72w-pdo_dblib php72w-pear php72w-pecl-apcu php72w-pecl-imagick php72w-pecl-mongodb php72w-pgsql php72w-phpdbg php72w-process php72w-pspell php72w-recode php72w-snmp php72w-soap php72w-sodium php72w-tidy php72w-xml php72w-xmlrpc mod_php72w >/dev/null

  echo ">> restarting apache <<"
    sudo systemctl restart httpd.service >/dev/null

  echo ">> php version <<"
    php -v
}

installMariaDB() {
  echo ">> download and installing mariabdb <<"
    sudo yum -y install mariadb-server mariadb >/dev/null

  echo ">> starting mariabdb <<"
    sudo systemctl start mariadb >/dev/null

  echo ">> configuring mariadb on startup <<"
    sudo systemctl enable mariadb >/dev/null

  echo ">> configuring mariadb on startup <<"
    sudo mysql --version
}

installNodeNPM() {
  echo ">> dowloading and installing NPM for nodejs <<"
    sudo yum install -y npm

  echo ">> NPM version <<"
    npm --version
}

installNodeJS() {
  installEPEL;

  echo ">> downloading and installing nodejs <<"
    sudo yum install -y nodejs >/dev/null

  echo ">> nodejs version <<"
    node --version

  installNodeNPM;
}

configureStack() {
  echo ">> configuring stack project <<"
    sudo cp /var/www/html/projects/configuration/guestconfig/* /etc/httpd/conf.d

  echo ">> setting SELinux to permissive <<"
    sudo setenforce 0

  echo ">> restarting apache <<"
    sudo systemctl restart httpd.service >/dev/null
}

configureWebpackStack() {
  echo ">> creating node modules directroy in ~ <<"
    mkdir /home/vagrant/node_modules

  echo ">> creating symbolic link for ~/node_modules with /var/www/html/projects/webpack-app1/frontend"
    ln -sf /home/vagrant/node_modules/ /var/www/html/projects/webpack-app1/frontend
}

installUpdate;

installApache;

installPHP7;

installMariaDB;

installNodeJS;

configureStack;

configureWebpackStack;
