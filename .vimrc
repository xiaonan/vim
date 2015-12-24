set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/vundle.git/
call vundle#rc()

Bundle 'https://github.com/scrooloose/nerdtree.git'
Bundle 'junegunn/vim-easy-align'
Bundle 'vim-scripts/DoxygenToolkit.vim'
Bundle 'vim-scripts/VOoM'
Bundle 'majutsushi/tagbar'

filetype plugin indent on     " required!
let mapleader = ','
set nobackup

"设置编码
set encoding=utf-8

set bg=dark
colorscheme desert

set nocompatible "不要vim模仿vi模式，建议设置，否则会有很多不兼容的问题
syntax on"打开高亮
if has("autocmd")
    filetype plugin indent on "根据文件进行缩进
    augroup vimrcEx
        au!
        autocmd FileType text setlocal textwidth=78
        autocmd BufReadPost *
                    \ if line("'\"") > 1 && line("'\"") <= line("$") |
                    \ exe "normal! g`\"" |
                    \ endif
    augroup END
else
    "智能缩进，相应的有cindent，官方说autoindent可以支持各种文件的缩进，但是效果会比只支持C/C++的cindent效果会差一点，但笔者并没有看出来
    set autoindent " always set autoindenting on 
endif " has("autocmd")

"让一个tab等于4个空格
set tabstop=4
set softtabstop=4

"设置默认缩进宽度为4
set shiftwidth=4

"输入的tab自动转化为4个空格
set expandtab

"强制已有的tab转化为4个空格
retab!
"去掉vim错误时的发声
"set vb t_vb=

"set nowrap "不自动换行
set hlsearch "高亮显示结果
set incsearch "在输入要搜索的文字时，vim会实时匹配
set backspace=indent,eol,start whichwrap+=<,>,[,] "允许退格键的使用


"代码折叠
set foldmethod=indent "折叠方式
set foldnestmax=10 "最大折叠层级 
set nofoldenable "默认不折叠 
set foldlevel=1
"highlight Folded guibg=grey guifg=blue
"highlight FoldColumn guibg=darkgrey guifg=white



"代码自动补全
filetype plugin indent on
set completeopt=longest,menu

"php函数自动补全
au FileType php call AddPHPFuncList()
function AddPHPFuncList()
		set dictionary-=~/.vim/doc/php_funclist.txt dictionary+=~/.vim/doc/php_funclist.txt
		set complete-=k complete+=k
endfunction

" 不让vim发出讨厌的滴滴声 
set noerrorbells 

" 在被分割的窗口间显示空白，便于阅读 
" 在搜索的时候忽略大小写 
set ignorecase 

"Doxygen风格注释
let g:DoxygenToolkit_dateTag="@date "
let g:DoxygenToolkit_briefTag_pre="@desc " 
let g:DoxygenToolkit_paramTag_pre="@param " 
let g:DoxygenToolkit_authorTag="@author "
let g:DoxygenToolkit_authorName="陈肖楠 (chenxiaonan01@baidu.com)" 
let g:DoxygenToolkit_returnTag="@return   " 

"indent guides 函数对齐线
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3 
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4 
"python语法检查
if has("gui_running") 
    highlight SpellBad term=underline gui=undercurl guisp=Green
endif 

"align 配置
"set nocp 
"filetype plugin on 

"---------------------------------------------------------------
" csupport
"---------------------------------------------------------------
let g:C_GlobalTemplateFile=$HOME."/.vim/c-support/templates/Templates"
let g:C_LocalTemplateFile=$HOME."/.vim/c-support/templates/Templates"
let g:C_CodeSnippets=$HOME."/.vim/c-support/codesnippets"
"let g:C_Styles = {'*.c,*.h' : 'default', '*.cc,*.cpp,*.hh' : 'CPP'}
let g:C_Styles = { '.c,.h' : 'C', '.cc,.cpp,.c++,.C,.hh,.h++,*.H' : 'CPP'  }

"ctrlp.vim cofig
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
"let g:ctrlp_custom_ignore = { 'dir':  '\v[\/]\.(git|hg|svn)$','file': '\v\.(exe|so|dll)$', 'link': 'some_bad_symbolic_links' }
"let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux

"powerline
let g:Powerline_symbols = 'fancy'
set nocompatible
set laststatus=2   " Always show the statusline"
set t_Co=256
let g:Powerline_symbols_override = {
            \ 'BRANCH': [0x2213],
            \ 'LINE': 'L',
            \ }
let g:Powerline_mode_n = 'NORMAL'
let g:Powerline_stl_path_style = 'full'
"let g:Powerline_cache_file='~/.vim/bundle/powerline/Powerline.cache'
nnoremap <F5> :w<CR> :silent make<CR>
inoremap <F5> <Esc>:w<CR>:silent make<CR>
vnoremap <F5> :<C-U>:w<CR>:silent make<CR>

let g:vim_markdown_folding_disabled=1
let g:vim_markdown_initial_foldlevel=1

function! ToHtml()
    exec 'w'
    exec "!pandoc -s -S --self-contained -c style.css % -o %<.html "
endfunction

function! ToPdf()
    exec 'w'
    exec "!pandoc  % -o %<.pdf --latex-engine=xelatex --template=pm-template.latex"
endfunction
:nmap <silent> <F5> :call ToHtml()<CR>
:nmap <silent> <F6> :call ToPdf()<CR>


inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

"php 函数补全
filetype plugin on                                             
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

vmap <Leader>a <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
if !exists('g:easy_align_delimiters')
    let g:easy_align_delimiters = {}
endif
let g:easy_align_delimiters['#'] = { 'pattern': '#', 'ignore_groups': ['String'] }

"tagbar
nmap tb :TagbarToggle<CR>

"nerdtree
nmap ne :NERDTreeToggle<CR>
