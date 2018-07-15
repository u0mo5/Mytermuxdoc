termux不完全指南

1.选择shell

termux的默认shell是bash，启动文件为$PREFIX/etc/bash.bashrc

默认只定义了bash提示符为'$',不包括当前路径，未免不太方便

本人修改bash提示符为['当前路径']，这已经够我用了。

修改方法：nano $PREFIX/etc/bash.bashrc，然后修改提示符变量PS1为

PS1='[\w]'

\w意为当前路径，必须处于单引号包裹中。

当然我们有更好的选择，zsh和fish是很受新手欢迎的两个shell

 * zsh有什么优点？
 
 [1]显示git仓库的状态(生产力加成)
 
 [2]大量的主题，字体与配色
 
 [3]强大的命令、路径补全能力
 
 * 如何安装？
 
 zsh的配置相当麻烦，所以一般使用oh-my-zsh这个一键脚本进行配置
 
 termux有一键安装oh-my-zsh的脚本，github自寻
 
 安装后默认主题是agnoster，可以通过编辑$HOME/.zshrc中的ZSH_THEME来更换主题
 
2.目录

termux根目录为/data/data/com.termux/files

内有home和usr两个目录

如果觉得这样的目录结构不习惯，可以执行

pkg install proot -y

termux-chroot

但这对性能有一定损伤。

3.软件包

termux的官方源软件包齐全，但没有打包好的python和ruby依赖包。

像paramiko这类包含c库依赖的模块一般无法正常安装。

同时官方源不保留旧版本软件包。

某些源包含openjdk这类官方源中不包含的软件包(Extra源)

在$PREFIX/etc/apt/source.list加入一行 'deb https://termux.xeffyr.ml/ extra main x11'

gpg error这种东西不要关心！

据说通过更换第三方源可以安装metasploit，但我没找到。印象里在官方wiki见过一次。

https://github.com/termux/termux-root-packages这个仓库内有编译libusb,aircrack-ng,tcpdump的脚本

同时termux官方给出了一个python脚本，帮助用户构建自己的deb包。

4.帮助生活

百度网盘不限速下载，斗鱼挂机，构建基于websocket的科学上网环境……

没错，都可以做到!

但这样的功能一般依靠
 