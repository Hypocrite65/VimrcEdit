#!/bin/bash

# 定义文件路径
current_autoload_dir="$PWD/autoload"
current_plug_file="$current_autoload_dir/plug.vim"
target_autoload_dir="$HOME/.vim/autoload"
target_plug_file="$target_autoload_dir/plug.vim"
current_vimrc_file="$PWD/.vimrc"
target_vimrc_file="$HOME/.vimrc"
current_plugged_dir="$PWD/plugged"
target_plugged_dir="$HOME/.vim/plugged"
gruvbox_repo="https://github.com/morhetz/gruvbox.git"
gruvbox_dir="$current_plugged_dir/gruvbox"
target_gruvbox_dir="$target_plugged_dir/gruvbox"

# 下载 plug.vim 到当前目录的 autoload/ 下
if [ ! -f "$current_plug_file" ]; then
    echo "plug.vim not found in current directory, downloading..."
    mkdir -p "$current_autoload_dir"  # 创建当前目录的 autoload 目录
    curl -fLo "$current_plug_file" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "Download complete."
else
    echo "plug.vim already exists in current directory."
fi

# 将 plug.vim 复制到目标目录的 autoload/ 下
if [ ! -f "$target_plug_file" ]; then
    echo "plug.vim not found in target directory, copying..."
    mkdir -p "$target_autoload_dir"  # 创建目标目录的 autoload 目录
    cp "$current_plug_file" "$target_plug_file"  # 复制 plug.vim 文件
    echo "Copy complete."
else
    echo "plug.vim already exists in target directory."
fi

# 替换 $HOME/.vimrc 文件
if [ -f "$current_vimrc_file" ]; then
    echo "Replacing $HOME/.vimrc with current directory's .vimrc..."
    cp "$current_vimrc_file" "$target_vimrc_file"
    echo "Replacement complete."
else
    echo ".vimrc not found in the current directory."
    exit 1
fi

# 下载 gruvbox 主题到当前目录的 plugged/ 文件夹
if [ ! -d "$gruvbox_dir" ]; then
    echo "Downloading gruvbox theme..."
    mkdir -p "$current_plugged_dir"  # 创建当前目录的 plugged 目录
    git clone "$gruvbox_repo" "$gruvbox_dir"
    echo "Download complete."
else
    echo "gruvbox theme already exists in current directory."
fi

# 将 gruvbox 复制到目标目录的 plugged/ 下
if [ ! -d "$target_gruvbox_dir" ]; then
    echo "gruvbox theme not found in target directory, copying..."
    mkdir -p "$target_plugged_dir"  # 创建目标目录的 plugged 目录
    cp -r "$gruvbox_dir" "$target_plugged_dir"
    echo "Copy complete."
else
    echo "gruvbox theme already exists in target directory."
fi

# 确保 .vimrc 文件中包含安装 gruvbox 插件的配置
if ! grep -q "^Plug 'morhetz/gruvbox'" "$target_vimrc_file"; then
    echo "Adding gruvbox plugin configuration to .vimrc..."
    echo -e "\n\" Add gruvbox theme\nPlug 'morhetz/gruvbox'" >> "$target_vimrc_file"
    echo "Configuration added."
else
    echo "gruvbox plugin already configured in .vimrc."
fi

# 打开 Vim 并运行 PlugInstall
echo "Opening Vim and installing plugins..."
vim +PlugInstall +qall
echo "Plugin installation complete."
