# vimrc
自用 vim 配置, 主要用于 Erlang 开发

## 使用
本 vim 配置, 使用 [Vundle](https://github.com/VundleVim/Vundle.Vim) 进行插件管理

1. 安装 vim-plug
```shell
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

2. 配置 vimrc 文件
```shell
curl -L -o ~/.vimrc https://raw.githubusercontent.com/HJianBo/vimrc/master/vimrc
```

3. 安装已配置的插件
```shell
# 在 vim 命令行中输入
:PlugIntall
```

