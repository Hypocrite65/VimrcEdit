"=========================================================================
"
"" 本文件会在执行sh脚本后，覆盖本地用户配置。
"
""=========================================================================

" 使用 vim-plug 插件管理器
call plug#begin('~/.vim/plugged')

" 安装 gruvbox 配色方案
Plug 'morhetz/gruvbox'

call plug#end()

" 使用 gruvbox 配色方案
colorscheme gruvbox

" 设置背景模式（深色或浅色）
set background=dark

" 自定义语法高亮
" 设置变量的颜色
highlight Identifier ctermfg=Blue guifg=Blue

" 设置函数名的颜色
highlight Function ctermfg=Green guifg=Green

" 其他自定义设置
syntax on
set number

" 定义自定义命令 FoldBlocks 用于折叠所有的语句块 {}
command! FoldBlocks call FoldAllBlocks()

" 定义函数 FoldAllBlocks 执行实际的折叠操作
function! FoldAllBlocks()
    " 启用折叠方式
    set foldmethod=syntax
    " 关闭所有折叠
    normal! zM
    " 打开所有折叠
    normal! zR
    " 重新折叠所有的语句块
    :normal! gg=G
    " 打开折叠方式
    normal! zM
endfunction
