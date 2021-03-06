set nocompatible                              " Make vim more useful
filetype off                                  " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/vundle'

" My Plugins here:
"
" original repos on github
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'majutsushi/tagbar'
" Plugin 'tpope/vim-abolish'
Plugin 'klen/python-mode'

Plugin 'vim-scripts/hlint'

Plugin 'groenewege/vim-less'
Plugin 'ap/vim-css-color'
Plugin 'jelera/vim-javascript-syntax'

Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'junegunn/seoul256.vim'

Plugin 'bling/vim-airline'

" Plugin 'vim-scripts/promela.vim'

" vim-scripts
Plugin 'L9'
Plugin 'TaskList.vim'
Plugin 'Latex-Text-Formatter'

call vundle#end()

filetype plugin indent on
let base16colorspace=256
colorscheme seoul256
set bg=dark
let g:airline_theme = 'light'

set modeline
set smartindent
set tabstop=2                                 " Tab key results in 2 spaces
set shiftwidth=2                              " The num of spaces for indenting
set backspace=indent,eol,start
set softtabstop=2                             " Tab key results in 2 spaces
set expandtab                                 " Expand tabs to spaces
set clipboard+=unnamed
set clipboard+=unnamedplus
set go+=a
set number                                    " Enable line numbers
set laststatus=2                              " Always show statusline
set foldenable
set foldmethod=syntax                         " Markers are used to specify folds
set foldopen=block,hor,percent,quickfix,tag
set foldlevel=1
set hlsearch                                  " Highlight all search hits
set spell                                     " Enable spell checking
set colorcolumn=101                           " Highlight column 101 for line length indicator

" Backup
set noswapfile
set backupdir=~/.vim/tmp

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,latin1
endif

" Use The Silver Searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Now, make python work with virtualenvs:
if has("python") && !empty($VIRTUAL_ENV)
  python << EOF
import os
import sys
a = os.environ['VIRTUAL_ENV'] + '/bin/activate_this.py'
execfile(a, dict(__file__ = a))
if 'PYTHONPATH' not in os.environ:
    os.environ['PYTHONPATH'] = ''
    os.environ['PYTHONPATH'] += os.getcwd()+":"
    os.environ['PYTHONPATH'] += ":".join(sys.path)
EOF
endif

syntax enable

let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

" Make syntastic work nicer
let g:syntastic_enable_balloons = 1
let g:pymode_lint_ignore = 'E111,E114'
"let g:pymode_lint_ignore = 'C0110,W0702,W0511C0110,W0702,W0511C0110,W0702,W0511C0110,W0702,W0511C0110,W0702,W0511C0110,W0702,W0511C0110,W0702,W0511C0110,W0702,W0511C0110,W0702,W0511,E111,E114,E121,E128'
" pylint gives me the shits.
let g:syntastic_python_checkers = ['flake8', 'pyflakes']
" Don't whinge about c++11, you brat!
let g:syntastic_cpp_compiler_options = '-I${HOME}/openmpi/env/include -std=c++11'
let g:syntastic_auto_loc_list=1

" Map f8 for Tagbar
nmap <F8> :TagbarToggle<CR>

" Fix :s
" Currently doesn't work reliably
"cnoreabbrev <expr> s/ ((getcmdtype() is# ':' && getcmdline() =~# 's/')?('Subvert/'):('s'))

" Remap ctrl+arrows to move between window splits
nmap <silent> <C-Up> :wincmd k<CR>
nmap <silent> <C-Down> :wincmd j<CR>
nmap <silent> <C-Left> :wincmd h<CR>
nmap <silent> <C-Right> :wincmd l<CR>

" Remap space for use with easymotion
map <Space> \\w


map <leader>ss :setlocal spell!<cr>

" Map enter to clear highlighted search hits
nnoremap <CR> :nohlsearch<CR><CR>

" QuickFix close function; :q should close a window *and* the accompanying
" quickfix
aug QFClose
  au!
  " if |q| doesn't work use |cclose| ?
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

" Javascript folding that doesn't suck
let javaScript_fold=1
au FileType javascript call JavaScriptFold()

" Conceal
set conceallevel=2
hi Conceal ctermfg=231 ctermbg=233

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
" Filetype dependant tabs because tabstops are better
autocmd FileType txt setlocal shiftwidth=2 tabstop=2 noexpandtab spell!
