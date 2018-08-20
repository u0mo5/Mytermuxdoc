#!/data/data/com.termux/files/usr/bin/bash
apt install clang python2 python2-dev libevent libcrypt-dev libcrypt
pip2 install msgpack gevent&&echo 'module installed'
cd $PREFIX/share
git clone https://gitee.com/wenqiangchina/ZeroNet
mv ZeroNet zeronet
cd $PREFIX/bin
ln -s $PREFIX/share/zeronet/zeronet.py zeronet
termux-fix-shebang zeronet
echo 'zeronet installed'
echo 输入'zeronet'即可启动。
exit
