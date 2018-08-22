#!/data/data/com.termux/files/usr/bin/bash
#增加第三方源
#metasploit
apt install curl
curl -O https://Auxilus.github.io/auxilus.key
apt-key add auxilus.key
echo "deb [arch=all] https://Auxilus.github.io/ termux extras" >> $PREFIX/etc/apt/sources.list
#fix missing
#暂时无法修复
curl -O https://its-pointless.github.io/setup-pointless-repo.sh
bash setup-pointless-repo.sh
#mirror&&extra
apt install gnupg-curl dirmngr
apt-key adv --keyserver pool.sks-keyservers.net --recv 9D6D488416B493F0
echo 'deb https://termux.xeffyr.ml/ stable main' >> $PREFIX/etc/apt/sources.list
apt-key adv --keyserver pool.sks-keyservers.net --recv 9D6D488416B493F0
echo 'deb https://termux.xeffyr.ml/ extra main x11' >> $PREFIX/etc/apt/sources.list
#root
apt-key adv --keyserver pgp.mit.edu --recv A46BE53C
mkdir -p $PREFIX/etc/apt/sources.list.d
echo "deb https://grimler.se root stable" > $PREFIX/etc/apt/sources.list.d/termux-root.list
#update
apt update