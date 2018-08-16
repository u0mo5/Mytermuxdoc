#!/data/data/com.termux/files/usr/bin/bash
mkdir ~/bin
cd ~/bin
echo 'What editor are you use?emacs or vim?(e/v)
echo '你使用emacs还是vim?(e/v)'
read editor
case $editor in
   e)
   ln -s $PREFIX/bin/emacs termux-file-editor
   ;;
   v)
   ln -s $PREFIX/bin/vim termux-file-editor
esac   
   