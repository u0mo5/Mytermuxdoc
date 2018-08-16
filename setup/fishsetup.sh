#!/data/data/com.termux/files/usr/bin/bash
apt install fish curl
curl -L https://get.oh-my.fish > install
fish install --path=~/.local/share/omf --config=~/.config/omf
exec fish
omf install agnoster
chsh -s fish
exit