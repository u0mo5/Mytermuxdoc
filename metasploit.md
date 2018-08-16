Termux上安装metasploit有三种方式：从源安装/脚本安装/手动安装

从源安装与脚本安装没什么不同(利用deb包内置的postinstall脚本)，但因为termux官方将postgresql-contrib合并到postgresql中，所以无法正确安装。(删掉aptcache和deb包control中的postgresql-contrib之后没有依赖问题了，但postinstall脚本仍然报错)

以下为metasploit在Termux上的手动安装指南。

1.降级ruby

```shell
apt remove ruby ruby-dev
apt install gnupg-curl dirmngr
apt-key adv --keyserver pool.sks-keyservers.net --recv 9D6D488416B493F0
echo 'deb https://termux.xeffyr.ml/ stable main' >> $PREFIX/etc/apt/sources.list
apt update
apt install ruby=2.4.5 ruby-dev=2.4.5
```
这一步并非必需。

2.下载源码。