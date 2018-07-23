termux不完全指南

[+]初始化

1.选择shell

termux的默认shell是bash，启动文件为`$PREFIX/etc/bash.bashrc`

默认只定义了bash提示符为`$`,不包括当前路径，未免不太方便

本人修改bash提示符为['当前路径']，这已经够我用了。

修改方法：`nano $PREFIX/etc/bash.bashrc`，然后修改提示符变量PS1为

```shell
PS1='[\w]'
```

`\w`意为当前路径，必须处于单引号包裹中。

关于bash提示符与bashrc的详细设置不多叙述，详情见任意linux学习书籍。

当然我们有更好的选择，zsh和fish是很受新手欢迎的两个shell

 * zsh有什么优点？
 
 [1]显示git仓库的状态(生产力加成)
 
 [2]大量的主题，字体与配色
 
 [3]强大的命令、路径补全能力
 
 * 如何安装？
 
 zsh的配置相当麻烦，所以一般使用oh-my-zsh这个一键脚本进行配置
 
 termux有一键安装oh-my-zsh的脚本，github自寻
 
 安装后默认主题是agnoster，可以通过编辑`$HOME/.zshrc`中的`ZSH_THEME`来更换主题
 
 注：可通过输入`exit 0`来关闭一个shell会话
 
 注：长按屏幕左边滑出的'keyboard'可打开一些特殊键
 
2.选择文本编辑器

Linux上最流行的编辑器是Vim和Emacs，nano则适用于新手。

但termux上的nano对中文的显示支持有问题，中文字符串会随机缩短。zile更水，居然不支持中文输入……

没奈何，Vim与Emacs取其一。

注：google中文输入法无法在termux内输入中文。

注：使用Vim或Emacs时按手机返回键，点按呼出键盘将不会生效，需点按屏幕左边滑出的'keyboard'按钮。

尽管vim老手从不用上下左右键，但我等新手还是少不了它的。

酷安某用户修改了termux的特殊键，增加了上下左右键，修改版apk我放在仓库里了，有需要自己下。

3.选择软件源

termux的官方源软件包齐全，但没有打包好的python和ruby依赖包。

像pynacl这类包含c库依赖的模块一般无法正常安装。

同时官方源不保留旧版本软件包。想安旧版可以试试`Tuna`，这是由中国某大学维护的软件源，支持Termux。

某些源包含openjdk这类官方源中不包含的软件包(Extra源)

在`$PREFIX/etc/apt/source.list`加入一行`deb https://termux.xeffyr.ml/ extra main x11`

简单操作一下：

```shell
echo 'deb https://termux.xeffyr.ml/ extra main x11' >> $PREFIX/etc/apt/source.list
```

gpg error这种东西不要关心！

 * 注：extra源的编译脚本与补丁由github某用户提供

据说通过更换第三方源可以安装metasploit，但我没找到。印象里在官方wiki见过一次。

https://github.com/termux/termux-root-packages 这个仓库内有编译libusb,aircrack-ng,tcpdump的脚本

同时termux官方给出了一个python脚本，帮助用户构建自己的deb包。

 * termux特色package

包括termux-tools,termux-exec,tsu等

经检查，除termux-exec，termux-elf-cleaner使用C语言编写，其他大部分为bashscript，不得不让人感叹Linux的高度可定制性！

下面给出列表。

termux-tools:bashscript工具集，包含`termux-fix-shebang termux-info termux-open termux-open-url termux-reload-settings termux-setup-storage termux-wake-lock termux-wake-unlock`

termux-api:与Android交互需要使用的工具集。

termux-apt-repo:

termux-create-package:字面意思

termux-am:一个apk文件，未知作用，在`$PREFIX/libexec/termux-am`目录下。

termux-elf-cleaner：

termux-exec：下面介绍

4.软件包管理

termux自带apt，基于apt封装了一个pkg命令

`apt install $package` 或 `pkg install $package` 是一样的。

但我建议使用apt，这样做可以让你在将来快速适应deb系的发行版。

###########

[+]目录结构

termux根目录为`/data/data/com.termux/files`

内有home和usr两个目录

如果觉得这样的目录结构不习惯，可以执行

```shell
pkg install proot -y
termux-chroot
```

但这对性能有一定损伤。

[+]获得并使用源码

百度网盘不限速下载，无限制下载各网站视频，构建基于websocket的科学上网环境……

没错，Termux都可以做到!

但这样的功能一般依靠github上其他人创建的repo才能做到，要学会git,python,ruby,golang的基础用法。

 * git基本用法
 
```shell
git clone $repourl $dirname
```

复制repo到本地目录

但中国网络环境出了名的不好，一般大型项目传输中途会断流！

使用shadowsocks成本又高，最好还是用ssh拉取源码。
 
```shell
cd $dirname&&git pull
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
 
 [2]此模块需连接C库。
 
 这种情况糟糕至极。修复没有固定步骤，但这些事是必须做的。
 
 [1]使用`pip download $ModuleName` 下载tar.gz文件
 
 注:可能还会有些whl文件，不管它。那是可以直接用于安装的python模块文件
 
 [2]解压，前往此模块中包含C依赖库的目录(一般以lib为前三个字母)
 
 [3]检查Makefile.in,Makefile.ac等自动化编译所需的文件
 
 [4]编写补丁
 
 [5]打包为whl文件
 
 * 为何会这样？
 
 termux尽管基于debootstrap,官方行事却有Arch之风，连保留旧版软件包都不愿意。为python依赖打deb包啥的更是不可能了
 
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
cd $repodir&&bundle install
```

 
 * 注意
 
有时repo的启动脚本没有.rb这个后缀，可在`$PREFIX/bin`中建立它的软链接方便使用。
 
以metasploit为例，启动脚本为msfconsole,安装结束并建立软链接后可在任意目录用msfconsole来启动它。
 
这时你应预先修改msfconsole的shebang。
 
 * 常见问题
 
版本错误，如使用ruby2.5的gem安装使用ruby2.4编写的模块，必出问题。
 
C库依赖……仍用运行发行版后`apt install ruby-$module`解决。官方有rbnacl-libsodium的补丁，可以自行patch后安装(但要在之前自行编译ruby2.4并安装)。
 
bundler对tmp目录无写权限。chmod 777是不可行的，要用root权限来运行bundler(并非好方案)。
 
 * nodejs
 
```shell
node xxx.js 
cd $repodir&&npm install
```
 
 * 何为shebang?
 
shebang是脚本的首行，一般会定义脚本解释器的位置。
 
termux-exec可以使termux适应Linux风格的shebang。
 
或用'termux-fix-shebang $script' 修改脚本shebang。
 
 * go
 
go是跨平台的编译型语言
 
```shell
apt install golang
go get $repourl
```

注意去掉$repourl的`https://`前缀。
 
完成后在$HOME建立go工作目录，在其中的bin子目录有编译完成的elf可执行文件。src目录则包含其源码，当bin目录为空时，进入源码目录使用`go run xxx.go`来运行项目。
 
或者`cd $repodir&&go build`
 
 * 一些工具

[Baidupcsgo](https://github.com/iikira/BaiduPCS-Go)百度网盘不限速下载 
 
you-get 强大的视频下载器，支持全球大多数视频网站，`pip install you-get`即可安装。
 


[附录一]获得读写sdcard权限

`termux-setup-storage`获得sdcard读写权限。

`ln -s target linkname`建立软链方便管理。

[附录二]proot运行Linux发行版

termux打包了proot，github上的termux用户们则热心地编写了一系列用于运行发行版的bashscript。

目前有Fedora,kali,Arch,debian可以选择，当然……失败率挺高的。

[附录三]改造termux
 
注：需要提前学习一些Linux知识，可以先用proot运行的发行版练练手。

前面提到了termux上一些特色package其实是bashscript，那么，可以通过自己编写脚本来实现一些自定义功能

例如，为bash上把锁。


 
 
 
 
 
 
 
 
 
 
 
 
 