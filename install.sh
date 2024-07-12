#!/bin/bash

###################################################################
#Script Name    : Basic Install Develop Package                                                                                             
#Description    : Set up Ubuntu about Basic Setting                                                                                 
#Args           : None                                                                                          
#Author         : Azabell                                        
#Email          : jeewoo19930315@gmail.com                                           
###################################################################

PACKAGES=(
    "curl"
    "wget"
    "neofetch"
    "git"
    "cmake"
    "make"
    "vim"
    "ninja-build"
    "openjdk-11-jdk"
    "ibus"
    "openssh-server"
    "clang"
    "terminator"
    "code"
    "build-essential"
    "net-tools"
    "snap"
    "libmysqlclient-dev"
    "ibus-hangul"
    "apache2"
    "microsoft-edge-dev"
    "brightness-controller"
    "mysql-server"
)

echo "========================================================================="
echo "  sudo apt-get update and install packages"
echo "========================================================================="
cd /home/$USER
sudo apt-get update
sudo apt-get install -y "${PACKAGES[@]}"

echo " "
echo " "
echo "========================================================================="
echo "    sudo snap install dbeaver-ce"
echo "========================================================================="  
sudo snap install dbeaver-ce

echo " "
echo " "
echo "========================================================================="
echo "    nodejs ver.14 download"
echo "========================================================================="
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
sudo apt-get install -y nodejs

echo " "
echo " "
echo "========================================================================"
echo "    sudo snap install clion --classic"
echo "========================================================================"
sudo snap install clion --classic

echo " "
echo " "
echo "========================================================================="
echo "    emcc wasm development setting"
echo "========================================================================="
git clone https://github.com/emscripten-core/emsdk.git
cp -r emsdk /home/$USER/Desktop/
cd /home/$USER/Desktop/emsdk
./emsdk install latest
./emsdk activate latest
echo "source /home/$USER/Desktop/emsdk/emsdk_env.sh" >> ~/.bashrc
source ~/.bashrc

echo " "
echo " "
echo "========================================================================="
echo "    Vundle download"
echo "========================================================================="
cd /home/$USER
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo " "
echo " "
echo "========================================================================="
echo "    sudo ufw app list and allow Apache Full"
echo "========================================================================="
sudo ufw app list
sudo ufw allow 'Apache Full'
sudo ufw status >> /home/$USER/Desktop/ApacheUfwStatus.log

echo " "
echo " "
echo "========================================================================="
echo "    Setting up MySQL"
echo "========================================================================="
sudo systemctl enable mysql
sudo chmod 777 /etc/mysql/my.cnf
echo -e "\n\n[client]\ndefault-character-set=utf8\n[mysql]\ndefault-character-set=utf8\n[mysqld]\ncollation-server=utf8_unicode_ci\ninit-connect='SET NAMES utf8'\ncharacter-set-server=utf8" | sudo tee -a /etc/mysql/my.cnf
sudo systemctl start mysql
sudo systemctl status mysql  >> /home/$USER/Desktop/firstMysqlStatus.log
mysql_config --cflags >>  /home/$USER/Desktop/mysqlClientPostion.log

echo " "
echo " "
echo "========================================================================="
echo "    GitHub setting"
echo "========================================================================="
git config --global user.name "Azabell1993"
git config --global user.email "Azabell1993"

echo " "
echo " "
echo "========================================================================="
echo "    npm install and create-react-app"
echo "========================================================================="
sudo npm install -g create-react-app
create-react-app --version >> /home/$USER/Desktop/react_app_version.log
npm --version

echo " "
echo " "
echo "========================================================================="
echo "    Screen light and touch"
echo "========================================================================="
sudo add-apt-repository -y ppa:apandada1/brightness-controller
sudo apt update
sudo apt install -y brightness-controller
echo "Run the -> brightness-controller"

echo " "
echo " "
echo "========================================================================="
echo "    ibus setup"
echo "========================================================================="
echo "First, run the following commands manually:"
echo "$ ibus-setup"
echo "Input Method -> Add -> 'Korean-Hangul'"
echo "Ubuntu Setting -> Keyboard -> Input Sources -> '+' button -> Add 'Korean(Hangul)'"
echo "$ reboot"

echo " "
echo "========================================================================="
echo "    Completed"
echo "========================================================================="

