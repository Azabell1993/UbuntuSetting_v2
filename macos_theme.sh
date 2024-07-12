#!/bin/bash

###################################################################
#Script Name    : Ubuntu macOS Style Setup
#Description    : Set up Ubuntu to resemble macOS in appearance and behavior
#Args           : None
#Author         : Azabell
#Email          : jeewoo19930315@gmail.com
###################################################################

# 필수 패키지 업데이트 및 설치
sudo apt update && sudo apt upgrade -y
sudo apt install -y gnome-tweaks git wget unzip dconf-cli

# Gnome Shell Extensions 설치
sudo apt install -y gnome-shell-extensions chrome-gnome-shell

# 필요한 디렉토리 생성
THEME_DIR="$HOME/.themes"
ICON_DIR="$HOME/.icons"
CURSOR_DIR="$HOME/.icons"
EXTENSIONS_DIR="$HOME/.local/share/gnome-shell/extensions"

mkdir -p $THEME_DIR
mkdir -p $ICON_DIR
mkdir -p $CURSOR_DIR
mkdir -p $EXTENSIONS_DIR

# WhiteSur GTK 테마 설치
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
cd WhiteSur-gtk-theme
./install.sh -d $THEME_DIR
cd ..
rm -rf WhiteSur-gtk-theme

# WhiteSur 아이콘 테마 설치
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
cd WhiteSur-icon-theme
./install.sh -d $ICON_DIR
cd ..
rm -rf WhiteSur-icon-theme

# McMojave 커서 테마 설치
git clone https://github.com/vinceliuice/McMojave-cursors.git
cd McMojave-cursors
./install.sh -d $CURSOR_DIR
cd ..
rm -rf McMojave-cursors

# Gnome Shell 테마 적용
gsettings set org.gnome.shell.extensions.user-theme name "WhiteSur-Dark"
gsettings set org.gnome.desktop.interface gtk-theme "WhiteSur-Dark"
gsettings set org.gnome.desktop.interface icon-theme "WhiteSur"
gsettings set org.gnome.desktop.interface cursor-theme "McMojave-cursors"
gsettings set org.gnome.desktop.wm.preferences theme "WhiteSur-Dark"

# Dash to Dock 확장 설치 및 설정
gnome-extensions install dash-to-dock@micxgx.gmail.com
gnome-extensions enable dash-to-dock@micxgx.gmail.com
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
gsettings set org.gnome.shell.extensions.dash-to-dock intellihide true
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'DYNAMIC'
gsettings set org.gnome.shell.extensions.dash-to-dock custom-background-color true
gsettings set org.gnome.shell.extensions.dash-to-dock background-color '#2E3440' # Dark background for dock

# 터미널 배경색 설정 (기본값 유지)
TERMINAL_PROFILE=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d \')
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$TERMINAL_PROFILE/ background-color 'rgb(0,0,0)'

# macOS 배경화면 다운로드 및 설정
wget -O ~/macos-wallpaper.jpg https://images.unsplash.com/photo-1522199710521-72d69614c702?fit=crop&w=1920&h=1080&q=80
gsettings set org.gnome.desktop.background picture-uri "file://$HOME/macos-wallpaper.jpg"

# Mac 스타일로 Hot Corners 설정
gsettings set org.gnome.desktop.interface enable-hot-corners true

# 설치 완료 메시지
echo "macOS 테마 설치가 완료되었습니다. 변경 사항을 적용하려면 로그아웃 후 다시 로그인해주세요."

