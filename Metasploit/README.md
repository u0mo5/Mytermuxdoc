metasploit一键安装包by KnifeFire@tieba.baidu.com

原版由Auxilus@github.com制作。

```shell
apt update
apt install -y autoconf bison clang coreutils curl findutils git apr apr-util libffi-dev libgmp-dev libpcap-dev postgresql-dev readline-dev libsqlite-dev openssl-dev libtool libxml2-dev libxslt-dev ncurses-dev pkg-config wget make ruby-dev libgrpc-dev termux-tools ncurses-utils ncurses unzip zip tar postgresql termux-elf-cleaner
curl -O https://raw.githubusercontent.com/myfreess/Mytermuxdoc/master/Metasploit/msf.deb
dpkg -i ./msf.deb
```

数据库无法连接很正常，目前无解决方案。

似乎不能在wifi下连数据库?

