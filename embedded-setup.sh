#!/bin/bash

###################################################################
#Script Name    : Embedded C++ Development Environment Setup      
#Description    : Set up Ubuntu 22.04 for embedded C++ development
#Args           : None                                             
#Author         : Azabell                                          
#Email          : jeewoo19930315@gmail.com                         
###################################################################

# 필요한 패키지를 업데이트하고 설치합니다.
echo "========================================================================="
echo "  Updating package lists and upgrading installed packages"
echo "========================================================================="
sudo apt-get update && sudo apt-get upgrade -y

# 필수 개발 도구 설치
echo "========================================================================="
echo "  Installing essential development tools"
echo "========================================================================="
sudo apt-get install -y build-essential cmake git curl wget vim

# C++ 컴파일러 설치 (GCC 및 Clang)
echo "========================================================================="
echo "  Installing GCC and Clang"
echo "========================================================================="
sudo apt-get install -y gcc g++ clang

# 임베디드 개발 도구 설치 (GNU Arm Embedded Toolchain)
echo "========================================================================="
echo "  Installing GNU Arm Embedded Toolchain"
echo "========================================================================="
sudo apt-get install -y gcc-arm-none-eabi gdb-multiarch

# OpenOCD 설치 (임베디드 디버깅 도구)
echo "========================================================================="
echo "  Installing OpenOCD"
echo "========================================================================="
sudo apt-get install -y openocd

# CMake 설치
echo "========================================================================="
echo "  Installing CMake"
echo "========================================================================="
sudo apt-get install -y cmake

# Visual Studio Code 설치
echo "========================================================================="
echo "  Installing Visual Studio Code"
echo "========================================================================="
sudo snap install --classic code

# VSCode의 필수 확장 프로그램 설치
echo "========================================================================="
echo "  Installing VSCode extensions for C++ development"
echo "========================================================================="
code --install-extension ms-vscode.cpptools
code --install-extension ms-vscode.cmake-tools
code --install-extension marus25.cortex-debug

# JLink 설치 (임베디드 디버거)
echo "========================================================================="
echo "  Installing JLink"
echo "========================================================================="
wget -O /tmp/JLink_Linux_V688a_x86_64.deb https://www.segger.com/downloads/jlink/JLink_Linux_V688a_x86_64.deb
sudo dpkg -i /tmp/JLink_Linux_V688a_x86_64.deb
sudo apt-get install -f

# Minicom 설치 (시리얼 통신 도구)
echo "========================================================================="
echo "  Installing Minicom"
echo "========================================================================="
sudo apt-get install -y minicom

# QEMU 설치 (임베디드 시스템 에뮬레이터)
echo "========================================================================="
echo "  Installing QEMU"
echo "========================================================================="
sudo apt-get install -y qemu-system qemu-user qemu-user-static

# Docker 설치 (컨테이너 기반 개발 환경)
echo "========================================================================="
echo "  Installing Docker"
echo "========================================================================="
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce
sudo usermod -aG docker ${USER}

# STM32CubeMX 설치 (STM32 MCU 설정 도구)
#echo "========================================================================="
#echo "  Installing STM32CubeMX"
#echo "========================================================================="
#wget -O /tmp/stm32cubemx.deb https://www.st.com/content/ccc/resource/technical/software/sw_development_suite/group0/b3/36/43/d0/32/82/43/6e/stm32cubemx_v6-5-0/files/stm32cubemx_6-5-0_amd64.deb/jcr:content/translations/en.stm32cubemx_6-5-0_amd64.deb
#sudo dpkg -i /tmp/stm32cubemx.deb
#sudo apt-get install -f

# Zephyr RTOS 설치 (실시간 운영체제)
echo "========================================================================="
echo "  Installing Zephyr RTOS dependencies"
cho "========================================================================="
sudo apt-get install -y python3-pip python3-venv
pip3 install --user west
echo "export PATH=~/.local/bin:\$PATH" >> ~/.bashrc
source ~/.bashrc

echo "========================================================================="
echo "  Cloning Zephyr RTOS"
echo "========================================================================="
west init ~/zephyrproject
cd ~/zephyrproject
west update
west zephyr-export
pip3 install --user -r zephyr/scripts/requirements.txt

# 기타 유틸리티 설치
echo "========================================================================="
echo "  Installing additional utilities"
echo "========================================================================="
sudo apt-get install -y htop neofetch

# 설정 완료 메시지
echo "========================================================================="
echo "  Setup complete. Your system is now ready for embedded C++ development!"
echo "========================================================================="

