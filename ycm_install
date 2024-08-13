#!/bin/bash
# 이 스크립트는 Vim의 YouCompleteMe(YCM) 플러그인을 설치하고 컴파일하는 과정을 자동화합니다.
# YCM은 코드 자동 완성 기능을 제공하는 플러그인으로, C++, Python, JavaScript 등의 다양한 언어를 지원합니다.
# YCM의 핵심 라이브러리는 C++로 작성되어 있어 사용 전에 반드시 컴파일해야 합니다.
# 이 스크립트는 이 과정을 자동화하여 사용자가 쉽게 YCM을 설치하고 설정할 수 있도록 도와줍니다.

# 1. 필요한 의존성 패키지 설치
# YCM을 컴파일하려면 다양한 도구와 라이브러리가 필요합니다. 여기에는 C++ 컴파일러, Python 개발 패키지, 
# 그리고 CMake와 같은 빌드 도구가 포함됩니다. 이 단계에서는 시스템에 따라 적절한 패키지를 설치합니다.

echo "필요한 의존성 패키지를 설치 중입니다..."

if [ -f /etc/debian_version ]; then
    # Debian 계열 (Ubuntu 포함)
    sudo apt-get update
    sudo apt-get install -y build-essential cmake vim-nox python3-dev mono-complete golang nodejs default-jdk npm 
elif [ -f /etc/fedora-release ]; then
    # Fedora 계열
    sudo dnf install -y cmake gcc-c++ make python3-devel
elif [ -f /etc/arch-release ]; then
    # Arch Linux
    sudo pacman -S --noconfirm base-devel cmake python
else
    echo "지원되지 않는 운영 체제입니다. 수동으로 의존성 패키지를 설치하세요."
    exit 1
fi

# 2. YouCompleteMe 디렉토리로 이동
# YouCompleteMe 플러그인이 설치된 디렉토리로 이동합니다. 이 디렉토리는 Vim의 플러그인 디렉토리인 
# `~/.vim/bundle/YouCompleteMe`에 위치해야 합니다. 디렉토리가 없을 경우 설치가 필요합니다.

YCM_DIR=~/.vim/bundle/YouCompleteMe

if [ ! -d "$YCM_DIR" ]; then
    echo "YouCompleteMe가 설치되지 않았습니다. Vundle을 사용하여 YCM을 설치하세요."
    exit 1
fi

cd "$YCM_DIR"

# 3. YouCompleteMe 컴파일
# YCM은 다양한 언어에 대한 자동 완성 기능을 제공하기 위해 여러 컴파일러 옵션을 제공합니다.
# 사용자는 필요에 따라 기본 설치, C-family 지원, JavaScript/TypeScript 지원 등 다양한 옵션을 선택할 수 있습니다.

echo "YouCompleteMe를 컴파일 중입니다..."
read -p "C-family 언어 지원을 추가하시겠습니까? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    python3 install.py --clangd-completer
else
    python3 install.py
fi

read -p "JavaScript/TypeScript 지원을 추가하시겠습니까? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    python3 install.py --clangd-completer --ts-completer
fi

read -p "모든 언어 지원을 추가하시겠습니까? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    python3 install.py --all
fi

# 4. Vim 재시작 안내
# YCM이 정상적으로 컴파일된 후 Vim을 재시작하여 변경 사항이 반영되도록 안내합니다.
echo "YouCompleteMe가 성공적으로 설치되었습니다. Vim을 재시작하십시오."

# 5. 설치 확인
# YCM이 제대로 설치되었는지 확인하는 방법을 안내합니다. Vim에서 `:YcmDebugInfo` 명령어를 사용하여
# YCM 서버 상태와 활성화된 기능을 확인할 수 있습니다.

echo "설치 확인을 위해 Vim에서 ':YcmDebugInfo' 명령어를 실행해 보십시오."

# 6. 문제 해결 안내
# 설치 과정에서 문제가 발생할 경우 해결 방법을 안내합니다. 주로 의존성 문제, Python 버전 문제, 
# 또는 Vim 설정 파일 문제로 인해 발생할 수 있습니다.

echo "설치 과정에서 문제가 발생했다면, 의존성 패키지가 제대로 설치되었는지 확인하고,"
echo "Python 버전이 호환되는지 확인하십시오. 또한, Vim 설정 파일을 다시 확인하세요."
#!/bin/bash
# ---------------------------------------------------
# Script Name:    __file
# Description:    <Brief description of what this script does>
# Author:         $USER
# Created:        __time
# ---------------------------------------------------
