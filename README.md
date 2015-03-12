vim
===

把vim打造成强大的IDE工具，使linux下开发变得快速，专业！！！

使用方法：
>
1. git clone git地址 vim 
2. 建立home目录软链接到vim目录 .vimrc-> ..vim/.vimrc, .vim->..vim/.vim
3. 进入vim目录。运行git submodule init命令
4. 运行git submodule update命令
5. 打开vi,运行BundleInstall命令，安装插件
6. 尽情享受vim带来的快乐吧~


>ps:使用过程中有可能git配置的关系，导致git协议或者http协议只能有一个是work的
git协议work ,直接按照上面步骤来
http协议work,但是git协议不work
1. git clone 地址应该为 https://...
2. 再运行上面的步骤3.之前应该修改vim目录下`.gitmodules`把`git@github.com:oohcoder/vundle.git`改为`https://github.com/oohcoder/vundle.git`
3. 然后继续前面的步骤3
