#!/bin/bash

###################################################################
#Script Name   : wamr_zabbix_setup.sh                                                                                
#Description   : WAMR 개발 및 Zabbix 빌드 환경 구축을 위한 필수 패키지 및 도구 설치 스크립트                            
#Args          : 없음                                                                                         
#Author        : Azabell                                        
#Email         : jeewoo19930315@gmail.com                                           
###################################################################

# 설치할 패키지 목록을 변수에 저장
packages=(
    apache2
    mysql-server
    php
    php-mysql
    libapache2-mod-php
    php-cli
    php-curl
    php-zip
    php-gd
    php-mbstring
    php-xml
    php-xmlrpc
    php-soap
    php-intl
    php-bcmath
    php-json
    wordpress
    zabbix-server-mysql
    zabbix-frontend-php
    zabbix-agent
    zabbix-sql-scripts
    build-essential
    cmake
    git
    libssl-dev
    libsnmp-dev
    libcurl4-openssl-dev
    libxml2-dev
    libiksemel-dev
    libevent-dev
    libpcre3-dev
    libmysqlclient-dev
    libssh2-1-dev
    libopenipmi-dev
    libldap2-dev
    curl
    wget
    vim
)

# 시스템 업데이트
echo "========================================================================="
echo "  시스템 패키지 목록을 업데이트 중입니다..."
echo "========================================================================="
sudo apt-get update
echo " "

# 패키지 설치 루프
for pkg in "${packages[@]}"; do
    echo "========================================================================="
    echo "  $pkg 설치 중..."
    echo "========================================================================="
    sudo apt-get install -y $pkg
    echo " "
done

# Apache2 설정
echo "========================================================================="
echo "  Apache2 설치 및 설정 중..."
echo "========================================================================="
sudo ufw app list
sudo ufw allow 'Apache Full'
sudo ufw enable
sudo ufw status >> /home/$USER/Desktop/ApacheUfwStatus.log
echo " "

# MySQL 설정
echo "========================================================================="
echo "  MySQL 서버 설치 및 설정 중..."
echo "========================================================================="
sudo systemctl enable mysql
sudo systemctl start mysql
sudo systemctl status mysql >> /home/$USER/Desktop/mysql_status.log
echo " "

# WordPress 설치 및 설정
echo "========================================================================="
echo "  WordPress 설정 중..."
echo "========================================================================="
sudo cp /usr/share/wordpress/wp-config-sample.php /usr/share/wordpress/wp-config.php
sudo chown -R www-data:www-data /usr/share/wordpress
sudo ln -s /usr/share/wordpress /var/www/html/wordpress
# WordPress 설정 완료 확인 로그
if [ -f /var/www/html/wordpress/wp-config.php ]; then
    echo "WordPress 설정이 완료되었습니다. /var/www/html/wordpress/wp-config.php 파일이 존재합니다." >> /home/$USER/Desktop/wordpress_setup.log
    echo "WordPress 설정이 성공적으로 완료되었습니다."
else
    echo "WordPress 설정에 실패했습니다. wp-config.php 파일을 찾을 수 없습니다." >> /home/$USER/Desktop/wordpress_setup.log
    echo "WordPress 설정에 문제가 발생했습니다."
fi
echo " "

# Zabbix 설치 및 설정
echo "========================================================================="
echo "  Zabbix 서버 설치 및 설정 중..."
echo "========================================================================="
sudo systemctl enable zabbix-server zabbix-agent apache2
sudo systemctl start zabbix-server zabbix-agent apache2
sudo systemctl status zabbix-server zabbix-agent apache2 >> /home/$USER/Desktop/zabbix_status.log
echo " "

# Emscripten 설치 및 설정 (WASM 개발 환경)
echo "========================================================================="
echo "  Emscripten 설치 및 WASM 개발 환경 설정 중..."
echo "========================================================================="
git clone https://github.com/emscripten-core/emsdk.git
cp -r emsdk /home/$USER/Desktop/
cd /home/$USER/Desktop/emsdk
./emsdk install latest
./emsdk activate latest
echo "source /home/$USER/Desktop/emsdk/emsdk_env.sh" >> ~/.bashrc
source ~/.bashrc
echo " "

# 마무리 메시지
echo "========================================================================="
echo "  모든 패키지 설치 및 설정이 완료되었습니다."
echo "========================================================================="
