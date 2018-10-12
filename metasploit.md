![banner](https://github.com/myfreess/Mytermuxdoc/blob/master/pic/msfbanner.jpg)

metasploit.md

[+]安装metasploit

Termux上安装metasploit有三种方式：从源安装/脚本安装/手动安装

从源安装与脚本安装没什么不同(利用deb包内置的postinstall脚本)，但因为termux官方将postgresql-contrib合并到postgresql中，所以无法正确安装。(删掉aptcache和deb包control中的postgresql-contrib之后没有依赖问题了，但postinstall脚本仍然报错)

以下为metasploit在Termux上的手动安装指南。

1.组织意念，冷静思考

你连使用都不会，装Metasploit干吗？

2.下载源码、软件包以及bundler。

```shell
#install deb package
apt update
apt install -y autoconf bison clang coreutils curl findutils git apr apr-util libffi-dev libgmp-dev libpcap-dev postgresql-dev readline-dev libsqlite-dev openssl-dev libtool libxml2-dev libxslt-dev ncurses-dev pkg-config wget make ruby-dev libgrpc-dev termux-tools ncurses-utils ncurses unzip zip tar postgresql termux-elf-cleaner
#
#Get the metasploit-framework repository
curl -L https://github.com/rapid7/metasploit-framework/archive/4.16.2.tar.gz | tar xz
cd metasploit-framework-4.16.2
#remove bad script/移除坏的脚本
rm modules/auxiliary/gather/http_pdf_authors.rb
#fix shebang/修改shebang
termux-fix-shbang msf*
#install bundler
gem install bundler
```

3.安装nokogiri

注：此步需在metasploit的源码根目录内进行。

```shell
sed 's|nokogiri (*|nokogiri (1.8.0)|g' -i Gemfile.lock  
gem install nokogiri -v'1.8.0' -- --use-system-libraries
```
如报错，自己用nano把Gemfile.lock中的nokogiri版本换成1.8.0

为何单独安装nokogiri？

共享库惹的祸。

4.安装Gem模块

注：此步需在metasploit的源码根目录内进行。

```shell
bundle install -j5
```

5.建立数据库

注：此步需在metasploit的源码根目录内进行。

```shell
cd config
curl -LO https://Auxilus.github.io/database.yml
mkdir -p $PREFIX/var/lib/postgresql
initdb $PREFIX/var/lib/postgresql
pg_ctl -D $PREFIX/var/lib/postgresql start
createuser msf
createdb msf_database
#接着启动metasploit。
ruby msfconsole
#可能有`warning linker`字符出现，无视即可。
#启动成功后运行
msf> db_rebuild_cache
#等待五分钟。
#退出
msf> exit
#以上的msf>并非需要输入的内容！
```


[+]使用

我不会，请前往freebuf.com查看使用方法。
