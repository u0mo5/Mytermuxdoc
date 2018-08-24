termux不完全指南

命令行的艺术：https://github.com/jlevy/the-art-of-command-line/blob/master/README-zh.md

[+]初始化

1.选择shell

termux的默认shell是bash(但Termux还默认安装了dash)，启动文件为`$PREFIX/etc/bash.bashrc`

注：这只是一种简单的说法，bash启动文件的详细情况见下文。

默认只定义了bash提示符为`$`,不包括当前路径，未免不太方便

本人修改bash提示符为['当前路径']，这已经够我用了。

修改方法：`nano $PREFIX/etc/bash.bashrc`，然后修改提示符变量PS1为

```shell
PS1='[\w]'
```

`\w`意为当前路径，必须处于单引号包裹中。

 * bash-completion
 
bash不会很漂亮，但补全还是有的。 

#关于bash提示符与bashrc的详细设置不多叙述，详情见任意linux学习书籍。

#关于bash的内置命令(exec alias …)也不多说

#Linux基本操作推荐这个：[RE:0从零开始的Termux](https://github.com/breathiness/learn-termux)

#还有[How Linux Works(2nd Edition) [美 Brian Ward]和刘忆智的Linux从入门到精通，看看gentoo与Arch论坛也不错。

#当然缺不了Termux官方wiki:https:wiki.termux.com/wiki/Main_Page

当然我们有更好的选择，zsh和fish是很受新手欢迎的两个shell

 * zsh安装及配置
 
安装:`apt install zsh`

zsh设计思想相当Linux,不写配置还不如用bash
 
但是zsh的配置相当麻烦，所以一般使用oh-my-zsh这个一键脚本进行配置
 
termux有一键安装oh-my-zsh的脚本，可自行安装:https://github.com/Cabbagec/termux-ohmyzsh ，甚至可以更换终端配色与字体！

安装后默认主题是agnoster，可以通过编辑`$HOME/.zshrc`中的`ZSH_THEME`来更换主题
 
插件自行选择吧！
 
效果图上一张：
 
![zsh](https://github.com/myfreess/Mytermuxdoc/blob/master/pictures/zsh.gif) 

 * 语法高亮
 
https://github.com/zsh-users/zsh-syntax-highlighting 

 * plugin&theme manager

[antigen](https://github.com/zsh-users/antigen)是一个轻量的zsh主题/插件管理器。

可为zsh安装语法高亮等有用的工具


* fish的安装与使用
 
安装:`apt install fish`

fish是开箱即用型shell,UI风格对用户非常友好,但如果希望拥有一个更加强大的shell,可以用oh-my-fish和fisherman来安装主题和插件。

自写oh-my-fish安装脚本:`curl -O https://raw.githubusercontent.com/myfreess/Mytermuxdoc/master/setup/fishsetup.sh`

 * 冷水
 
1.ohmyzsh可能因为某些因素卡死你的终端！ 

2.fish的补全不区分大小写！

3.ohmyzsh有机率触发exec()error，一经触发无法修复(别问我为什么这么清楚，这是我换用bash的真正原因)。

[Termux Shell列表]

 * bash
 
 * zsh
 
 * fish
 
 * dash
 
 * tcsh
 
 * Xonsh 
 
更多信息可见[Termux wiki:Shells](https://wiki.termux.com/wiki/Shells) 

注：可通过输入`exit 0`来关闭一个shell会话，Ctrl-d也可。
 
注：长按屏幕左边滑出的'keyboard'可打开一些特殊键
 
 * Termux启动的是登录Shell吗？
 
从'echo $0'的输出来看，bash以非登录shell的模式启动。

但从bash的真正启动文件'$PREFIX/etc/profile'来看，bash以登录模式启动。并且Termux打开时启动的第一个程序是'login'(通过内核调用'exec()'启动)。

注：Termux的bash启动文件'profile'中source了'$PREFIX/etc/bash.bashrc'和'$HOME/.bashrc'，etc目录内的'bash.bashrc'先于home目录内的'.bashrc'被读取。
 
 * Termux上的chsh是什么？
 
Linux上的chsh通过修改`/etc/passwd`文件来改变用户的启动Shell，那Termux这个单用户机制的应用呢？

答案是通过修改`~/.termux/shell`文件，这个文件不存在时Termux就去启动bash，存在时则将其作为启动Shell。

chsh不过一bashscript而己，它会从`$PREFIX/bin`中寻找用户需要的shell，并在`~/.termux`目录中建立名为shell的符号链接指向它。

2.选择文本编辑器

Linux上最流行的编辑器是Vim和Emacs，nano则适用于新手。

但termux上的nano对中文的显示支持有问题，中文字符串会随机缩短。zile更水，居然不支持中文输入……

没奈何，Vim与Emacs取其一。

Vim高效快速，Emacs功能强大且自带帮助手册，自行选择。Neovim比vim更美观，也作为选择之一。

Termux官方列出了所有Termux上可用的文本编辑器，详情见wiki。

 * 论Emacs的全能性

Emacs在设计之初的目标就是：提供一个完整的系统工具集所应有的功能(从浏览器到游戏)，又因为Emacs Lisp的出现，它可以让用户简单地对它进行扩展。

例如Emacs其实可以煮咖啡(coffee.el)，不是玩笑话，详情可搜索词条"Emacs煮咖啡"。

 * 退出Vim

按下'ESC'键，进入命令模式，输入':wq'将保存文件并退出Vim。 

注：google中文输入法无法在termux内输入中文。

注：使用Vim或Emacs时按手机返回键，点按呼出键盘将不会生效，需点按屏幕左边滑出的'keyboard'按钮。

尽管vim老手从不用上下左右键，但我等新手还是少不了它的。

酷安某用户修改了termux的特殊键，增加了上下左右键，修改版apk我放在仓库里了，有需要自己下。

 * 横屏编辑
 
除非使用平板，否则很难兼顾特殊键与中文。 

3.选择软件源

termux的官方源软件包齐全，但没有打包好的python和ruby依赖包。

像pynacl这类包含c库依赖的模块一般无法正常安装。

同时官方源不保留旧版本软件包。想安旧版可以试试`Tuna`，这是由中国某大学维护的软件源，支持Termux。一还有由xeffyr维护的Termux Mirror。

某些源包含openjdk这类官方源中不包含的软件包(Extra源)

在`$PREFIX/etc/apt/source.list`加入一行`deb https://termux.xeffyr.ml/ extra main x11`

简单操作一下：

```shell
apt-key adv --keyserver pool.sks-keyservers.net --recv 9D6D488416B493F0
echo 'deb https://termux.xeffyr.ml/ extra main x11' >> $PREFIX/etc/apt/source.list
```

 * 注：extra源的编译脚本与补丁由github用户xeffyr提供。

通过更换第三方源甚至可以安装metasploit，在官方wiki可见。

https://github.com/termux/termux-root-packages 这个仓库内有编译libusb,aircrack-ng,tcpdump的脚本。

同时termux官方给出了一个python脚本，帮助用户构建自己的deb包。

一键配置所有第三方源:`curl -O https://raw.githubusercontent.com/myfreess/Mytermuxdoc/master/setup/sources.sh`


 * Termux第三方源列表

[1]Tuna镜像源

[2]由xeffyr维护的旧版本源

[3]由xeffyr维护的Extra源

[4]由Auxilus维护的metasploit源

[5]由Grimler91维护的rootpackage源

[6]its-pointless

 * 后缀为dev的deb包是什么？

pkg-config文件与include文件。

 * termux特色package

包括termux-tools,termux-exec,tsu等

经检查，除termux-exec，termux-elf-cleaner使用C语言编写，其他大部分为bashscript，不得不让人感叹Linux的高度可定制性！

下面给出列表。

termux-tools:bashscript工具集，包含`termux-fix-shebang termux-info termux-open termux-open-url termux-reload-settings termux-setup-storage termux-wake-lock termux-wake-unlock`

termux-api:与Android交互需要使用的工具集，powered by bashscript。

termux-apt-repo:

termux-create-package:字面意思

termux-am:apk文件，在`$PREFIX/libexec/termux-am`目录下。是am命令的Android8.0特别版。

termux-elf-cleaner：

termux-exec：下面介绍

 * 手动安装deb包
 
dpkg -i ./xxx.deb 


4.软件包管理

termux自带apt，基于apt封装了一个pkg命令

`apt install $package` 或 `pkg install $package` 是一样的。

但我建议使用apt，这样做可以让你在将来快速适应deb系的发行版。

 * apt update
 
更新deb包索引信息，当初次打开无法安装软件包时可运行此命令。

 * apt下载的deb包在哪儿？
 
`$PREFIX/var/cache/apt/archives`

 * apt的本质
 
基于dpkg封装的自动化包管理器。

 * 为什么不能兼容debian系发行版的deb包(那怕架构相同)？
 
因为软件的安装目录是在deb包中被预制定好的，并且以绝对路径形式制定。

 
###########

[+]proot

https://github.com/myfreess/Mytermuxdoc/blob/master/HowToUseProot.md


[+]拉取并使用源码文件

https://github.com/myfreess/Mytermuxdoc/blob/master/repo.md


[+]目录结构

termux根目录为`/data/data/com.termux/files`

内有home和usr两个目录，对应的变量是`$HOME`和`$PREFIX`。

如果觉得这样的目录结构不习惯，可以执行

```shell
apt install proot -y
termux-chroot
```

但这对性能有一定损伤。


[+]获得读写sdcard权限

`termux-setup-storage`获得sdcard读写权限。

`ln -s target linkname`建立软链方便管理。


[+]启动效果

一般打开Termux时会显示`$PREFIX/etc/motd`中的文字，可自行更改。

也有很多人在bashrc中使用figlet等工具制作启动时的艺术字效果。

[+]配色方案和字体

将字体文件复制到$HOME/.termux内，重命名为font.ttf，重启生效。

配色方案如法炮制，复制后重命名为colors.properties。

[+]More

Termux中长按屏幕，点按'More'出现更多选项。

[+]在Android中调用Termux编辑器

```shell
cd ~
ln -s /sdcard/documents downloads
mkdir ~/bin
cd ~/bin
ln -s $PREFIX/bin/nano termux-file-editor
```

我用nano，vim用户与Emacs用户可如法炮制。

完成后在Termux的home目录内生成downloads目录，编辑完成后文件将保存在这个目录。

[+]url钩子

建立文件`~/bin/termux-url-opener`，然后可以在Android中用Termux打开链接。

可以在此处链接you-get或lynx，自已写一个处理url的脚本也可以。

[+]文件传输

1.同子网内,文件流向:Termux~>client

```shell
cd $dir
python -m SimpleHTTPServer
```
python将监听8000端口，并开启一个简单的http服务器，根目录为$dir，这相当方便易用，风险也小(拒绝使用登录式ftp)

当然了，如果你要的只是快，这样的确很好。但这样不方便整个目录的复制，如果你经常传输文件，可以考虑一下pure-ftpd

pure-ftpd的使用此处不作介绍，以下是一些ftpserver的注意事项。

1.不要为ftp用户开启可写权限

2.只使用匿名登录

如果需要修改、上传文件，那还是用sftp吧。

[+]Remoteshell

Termux的sshd默认端口为8022，不支持密码登录，必须将你自己的ssh公钥输出到`~/.ssh/authorized_keys`这个文件内。

这对你可以使用的ssh客户端产生了一定限制，connectbot这种过于简单的客户端是无法使用了。如果你在自己可以信任的网络中进行工作，你可以使用jupyter或netcat。

如要在外部网络访问可以使用frp和ngrok将你的Server端口映射到公网上，如梯子钱充够了也可按官方教程使用tor进行端口映射。

[附录]proot运行Linux发行版

termux打包了proot，github上的termux用户们则热心地编写了一系列用于运行发行版的bashscript。

目前有Fedora,kali,Arch,debian可以选择，当然……失败率挺高的。

连接图形环境用VNC或Xserver皆可，Xserver更快，VNC更方便。

[附录]改造termux
 
注：需要提前学习一些Linux知识，可以先用proot运行的发行版练练手。

前面提到了termux上一些特色package其实是bashscript，那么，可以通过自己编写脚本来实现一些自定义功能

例如，为bash上一把密码锁。

现成的实现在此https://github.com/myfreess/termux-bashlock

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

[附录]与Android交互

这可能是Termux最强大的功能，需要以下支持:

 * [Termux:API]Termux扩展包。
 
 * [termux-api]用bashscript编写的，方便用户使用的工具集。
 
其实Android应用一直以来都支持命令行交互，你可以不用默认工具集，自己重新编写脚本来实现短信发送一类的功能。但这样做并不方便，最好还是在用户脚本内调用这些工具集完成所需功能。

目前已经有人实现了基于短信的交互式shell，异常强大！

注:用了修改版Termux就用不了这个扩展包了，因为Apk签名不统一。

[附录]Neoterm

Termux分支，特点是兼容Google中文输入法，自带oh-my-zsh安装脚本，Adb与Fastboot,以及强到爆炸的……

Xorg及图形环境。

目前测试版已经有图形会话选项了，但尚不稳定。

[附录]am命令

am全称activity manager，你能使用am去模拟各种系统的行为，例如去启动一个activity，强制停止进程，发送广播进程，修改设备屏幕属性等等。

就是Android上的应用调试器，给开发者用的。
 
[附录]图形界面

见extra源，xorg还有openbox啥的。




友链:http://www.freebuf.com/geek/170510.html



 
 
 
 
 
 
 
 
 
 
 
 
 