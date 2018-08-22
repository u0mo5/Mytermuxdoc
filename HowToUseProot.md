proot.md

本文将指导用户完成自己的第一个proot启动脚本。

全过程大概需时30分钟。

1.unset LD_PRELOAD

```shell
unset LD_PRELOAD
#为当前shell消除LD_PRELOAD这个变量
```


如果你安装了`termux-exec`，则这一步是必须的，如果不进行这一步则proot必报错。

2.[-r]

指定proot虚拟机的根目录，参数为目录名。

例子:我使用Alpine这个轻量级发行版，根目录为

```shell
~/TermuxAlpine
```

所以我的proot启动脚本中有这样一行

```shell
-r /data/data/com.termux/files/home/TermuxAlpine/
```

3.[-b]

将真实系统中的目录映射到虚拟机中。

```shell
#将Android内核产生的数个特殊目录映射到虚拟机中
-b /dev/ -b /sys/ -b /proc/
#另一种方法
-b /dev:/dev
```
其余目录可自行选择，常有人将Termux的Home目录映射到虚拟机中，以便于在Termux与虚拟机间共享dot文件。

4.[--link2symlink]

用符号链接替换硬链接。

5.[-0]

使当前用户显示为“root”并伪造其权限。

编译必备。

6.[-w]

设定初始工作目录。

7.[-k]

虚拟内核版本号。

8.[-i]

用`-i uid:gid`来指定自己启动proot时的登录用户。

[$]设定shell变量与登录shell

注:这一步没有在proot的帮助中出现，但的确需要完成。

```shell
/usr/bin/env
#不明白
-i
#不明白，但非常重要。
HOME=/home
#设定Home目录
TERM="xterm-256color"
#设定终端样式
LANG=zh_CN.UTF-8
#语言与文本编码
PATH=/bin:/usr/bin:/sbin:/usr/sbin
#指定可执行文件所在目录
/bin/sh --login
#启动登录shell
```

[+]集成到脚本中

```shell
unset LD_PRELOAD
exec proot --link2symlink -0 -r /data/data/com.termux/files/home/TermuxAlpine/ -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b /data/data/com.termux/files/home -w /data/data/com.termux/files/home /usr/bin/env -i HOME=/home TERM="xterm-256color" LANG=zh_CN.UTF-8 PATH=/bin:/usr/bin:/sbin:/usr/sbin /bin/sh --login
#实际的脚本中最好使用exec而非直接启动proot
#原因与shell工作机制有关
```
问题1:当proot启动脚本中的shell与/etc/passwd相冲突时，听谁的?

proot是老大，听他的。

问2：proot会启动linux发行版的init吗？

不会。

问3：systemd在Android上可用吗？

由于Android的内核魔改过，所以不行。

问4：我很懒……

https://github.com/myfreess/Termux-writer

专为懒人设计，Termux上的proot脚本模板生成器。


