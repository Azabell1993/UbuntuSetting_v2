
# 한글 입력기 설치 및 설정
sudo apt install -y ibus-hangul
ibus restart
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('ibus', 'hangul')]"
gsettings set org.freedesktop.ibus.general.hotkey triggers "['<Control>space']"
