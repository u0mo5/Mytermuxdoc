repo.md

本文将在五分钟内让你学会git,python,ruby,golang的基础用法，并学会关于各大流行编程语言的简单知识。

 * git基本用法
 
```shell
git clone $repourl $dirname
```

复制repo到本地目录

但中国网络环境出了名的不好，一般github上的大型项目传输中途会断流！

使用shadowsocks成本又高，最好还是用ssh拉取源码。

如果希望使用ssh拉取源码，那么应该注册一个github账号，创建自己的ssh密钥，并将公钥提交到github。

```shell
apt install openssh
ssh-keygen -t rsa -C "youremail@example.com"
cat $HOME/.ssh/id_rsa.pub
#输出的内容就是你的公钥
```

将公钥提交到github需要在浏览器内完成，此处不作演示。

想略为深入的学习git，建议看[廖雪峰的git教程]
 
```shell
cd $dirname
git pull
```
 
更新repo

 
 * python(2或3)
 
python 是目前全世界最流行的编程语言，分为2和3两个版本

使用python2编写的项目不能使用python3解释器来运行，反之亦然。

`python xxx.py`  或 `python2 xxx.py`

 * 运行报错？
 
可能的几种情况
 
 [1]未安装需要的模块。报错信息`no module named xxxx`

 `pip install xxxx`即可
 
 [2]解释器版本问题
 
 [3]脚本自身问题(bug)，这需要自身有一定python基础才能修复
 
 [4]权限问题，某些脚本需要以root权限运行。
 
 若有Android root权限，在Termux内输入`pkg install tsu`,安装完成后输入`tsu`，让Termux应用获取root权限即可。
 
 在输入`tsu`后，可输入`exit`回到普通模式
 
 注：在root用户状态下创建文件不是个好主意，可能带来严重的权限问题。
 
 注：安装软件包和python依赖包也属于创建文件的行为。
 
 * pyc文件

pyc文件是python的虚拟机字节码文件。事实上，py文件先被解释器翻译为pyc字节码文件，然后导入PVM(Python Virtual Machine,python虚拟机)中运行。

 * pip

pip是一个自动化的python依赖包管理器

同理，使用python2编写的模块只能用pip2安装

```shell
pip install $ModuleName
```

若repo目录内包含requirements.txt,直接`pip install -r requirements.txt`即可

-r表示从文件中读取参数(read)。

 * 安装报错？
 
 [1]使用了错误的pip版本。
 
 [2]此模块需连接C共享库。
 
先试着安装`python-dev pkg-config clang`等编译所需工具,如果仍然报错则寻找报错信息中有无`include<xxx.h>`。 若有，则安装对应的dev包和lib包即可。

注：也有人说只要clang装好就没有问题，太扯了…… 

仍无法正确安装，则建议先在github的issues区自行搜索。

`apt install lib*dev`是个好方法。

当没有可用方案时，可以自行创建一个issues，有时实际情况的确难以由用户自行解决。

看看这里也行：https://wiki.termux.com/wiki/Instructions_for_installing_python_packages

搜索引擎永远是我们的好帮手，经统计常见问题大概三分钟出解决方案，下面以pynacl的安装为例。官方的解决方案比较复杂，第三方方案则相当简单。

```shell
apt install clang python python-dev libsodium libsodium-dev
export SODIUM_INSTALL=system
pip install pynacl
```

原解决方案出处:Pypi

原文如下：

```shell
PyNaCl relies on libsodium, a portable C library. A copy is bundled with PyNaCl so to install you can run:
$ pip install pynacl
If you’d prefer to use the version of libsodium provided by your distribution, you can disable the bundled copy during install by running:
$ SODIUM_INSTALL=system pip install pynacl
```
 
 * 为何会这样？
 
 termux尽管基于debian,官方行事却有Arch之风，连保留旧版软件包都不愿意。为python依赖打deb包啥的更是不可能了
 
 * 曲线救国之法
 
 proot/chroot运行一个Linux发行版(建议使用debian一系的发行版),或使用gnurootdebian。然后执行 `apt install python-$ModuleName`

 * ruby
 
 `ruby xxx.rb`可运行此脚本
 
 * gem
 
 gem是ruby的模块管理工具。但我们一般不使用它
 
 * bundler
 
 bundler是一个自动化的ruby模块管理器。
 
 * 安装及使用
 
```shell
gem install bundler
cd $repodir
bundle install
```

 
 * 注意
 
有时repo的启动脚本没有.rb这个后缀，可在`$PREFIX/bin`中建立它的软链接方便使用。
 
以metasploit为例，启动脚本为msfconsole,安装结束并建立软链接后可在任意目录用msfconsole来启动它。
 
这时你应预先修改msfconsole的shebang。
 
 * 常见问题
 
C库依赖……仍用运行发行版后`apt install ruby-$module`解决，如果想折腾，自己认真看看报错即可，仍然建议多看Termux的issues。

注：google翻译是个好东西。
 
bundler对tmp目录无写权限。chmod 777是不可行的，要用root权限来运行bundler(并非好方案)。
 
 * nodejs
 
```shell
node xxx.js 
cd $repodir
npm install
```

 * npm安装任意包都报错？
 
解决方案:https://github.com/rvagg/node-worker-farm/commit/0b2349c6c7ed5c51e234e418fad226875313e773

手动解决

```shell
vim $PREFIX/lib/node_modules/npm/node_modules/worker-farm/lib/farm.js
#将'maxConcurrentWorkers        : (require('os').cpus() || { length: 1 }).length'内的1改动一下，改成一个小于cpu核心数的数字。

```
 
 * 何为shebang?
 
shebang是脚本的首行，一般会定义脚本解释器的位置。
 
termux-exec可以使termux适应Linux风格的shebang。
 
或用'termux-fix-shebang $script' 修改脚本shebang。
 
 * go
 
go是跨平台的编译型语言。

以csploit项目的核心编译为例：
 
```shell
apt install golang
go get github/cSploit/daemon
#go get将自动下载项目及其依赖，有时也会自动编译
#golang一般无法完成这一步
#请自行挂梯子
cd $GOPATH/src/github/cSploit/daemon
go build -i
```
golang会在$HOME建立go工作目录，在其中的bin子目录有编译完成的elf可执行文件。src目录则包含项目源码，当bin目录为空时，进入源码目录使用`go build`来编译项目。

注：编译时耗电量较大，占用运存也很多

`go run xxx.go`则可以测试而不编译此项目。

总之，编译前多看README是不会有错的。

有一篇好文可以读一读:https://splice.com/blog/contributing-open-source-git-repositories-go/

注：golang编译时不使用共享库。

 * 使用make完成构建

```shell
git clone $repourl
cd $repodir
make
make install
#要求项目作者写了Makefile
```


 
 * 一些工具

[Baidupcsgo](https://github.com/iikira/BaiduPCS-Go)百度网盘不限速下载 
 
[you-get] 强大的视频下载器，支持全球大多数视频网站，`pip install you-get`即可安装。
 
[caddy](https://github.com/mholt/caddy)WebUI的文件管理器。

[jupyter]方便好用的Web终端，但它还可以更强大！

[mapscii]基于cli的终端地图，Nodejs编写。npm install mapscii -s即可安装。

[hexo]轻量的个人博客框架by nodejs

[webui-aria2](https://github.com/ziahamza/webui-aria2)快速，强大，易用的多线程下载器。

[zeronet]去中心化的web网络，Termux安装脚本:bash < $(curl https://raw.githubusercontent.com/myfreess/Mytermuxdoc/master/installer/zeronet.sh)

[sqlmap]sql远程管理工具，好用！(认真)



[附录]编译C源码文件

README告诉我，`autoconf&&./configure&&make&&make install`四步走，就能把软件装好！

事实上大多数时候没这么好的事。

言归正传，Termux上的c编译器是`clang`，比gcc更轻量。

当然Linux一贯的特点是兼容并蓄，所以安装后它会建立名为`cc`的符号键接指向自身，以适应使用gcc的一些应用。

当然，一般我们不会直接使用clang进行编译，GNU/Linux上的传统编译管理器是make。

注：GNU/Linux是Linux的正式名称(但不是官方名称)

一般来说大型的C程序都需要先将源码文件编译为对象文件，再从对象文件生成Elf可执行文件(Linux上是这样做的)。

当编译时需要加入一些特殊的选项时，手动编译就不太合适了。

于是开发者会编写一个Makefile，你解开源码包并进入源码目录，运行make完成编译，然后`make install`，安装就完成了。

然而仅靠一个Makefile还是适应不了各平台的差别，于是有了Autoconf这类移植工具。

注：这里说的各平台只包括Unix系的操作系统，windows没那么好解决。

注：现代的gcc支持多种语言的编译，而现代的make甚至可以自动化完成Docker容器的创建(这个说法可能不对)和运行。




