set nocompatible
filetype off

set rtp+=~/.config/nvim/bundle/Vundle.vim

call vundle#begin('~/.config/nvim/bundle')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Syntax highliters
Plugin 'derekwyatt/vim-scala'
Plugin 'GEverding/vim-hocon'
Plugin 'aklt/plantuml-syntax'
Plugin 'kalafut/vim-taskjuggler'
Plugin 'mitsuhiko/vim-jinja'
Bundle 'altercation/vim-colors-solarized.git'

" Tab detection
Plugin 'tpope/vim-sleuth.git'
Bundle 'Yggdroot/indentLine'

" Golden ratio multiwindow
Bundle 'roman/golden-ratio'

" Status line decorations
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Git
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'

" --- Python ---
Plugin 'klen/python-mode'         " Python mode (docs, refactor, lints, highlighting, run and ipdb and more)
Plugin 'davidhalter/jedi-vim'     " Jedi-vim autocomplete plugin

" JSON
Plugin 'elzr/vim-json'

" OpenSCAD
Plugin 'sirtaj/vim-openscad'

" Some exotics
Plugin 'edkolev/tmuxline.vim'

call vundle#end()

filetype plugin on

" Always show statusbar
set laststatus=2

" Disable mouse click to go to position
set mouse-=a

" Don't let autocomplete affect usual typing habits
set completeopt=menuone,preview,noinsert

" Let vim-gitgutter do its thing on large files
let g:gitgutter_max_signs=10000

" Tabs configuration
set tabstop=4 shiftwidth=4 expandtab smarttab autoindent

set nowrap " попросим Vim НЕ переносить длинные строки
set ai " включим автоотступы для новых строк
set cin " включим отступы в стиле Си

" Search highlighting
set showmatch hlsearch incsearch smartcase

" Показываем табы в начале строки точками
set listchars=tab:··
set list

" Порядок применения кодировок и формата файлов
set ffs=unix,dos,mac
set fencs=utf-8,cp1251,koi8-r,ucs-2,cp866

" Solarized configuration
set t_Co=256
set background=dark
colorscheme solarized

" trailing whitespaces highlight
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
autocmd Syntax * syn match ExtraWhitespace /\s\+$/
autocmd FileType c,cpp,java,php,py,pl,sh,h,hpp,js,javascript,html,css,scala autocmd BufWritePre <buffer> :%s/\s\+$//e

" klen/python-mode configuration
let g:pymode = 1
let g:pymode_options = 1
let g:pymode_options_colorcolumn = 0
let g:pymode_folding = 0
let g:pymode_indent = 1
let g:pymode_doc = 1
let g:pymode_virtualenv = 1

" let g:pymode_debug = 0
let g:pymode_lint = 1
let g:pymode_lint_checkers = ['pylint', 'pep8', 'pyflakes']
let g:pymode_lint_on_write = 1
let g:pymode_lint_on_fly = 0
let g:pymode_lint_message = 1
let g:pymode_lint_ignore = 'W0702,R0914,E265,E501,E0611,W0201,line-too-long,missing-docstring,abstract-method,invalid-name,no-self-use,fixme,too-many-arguments,no-member,too-few-public-methods,star-args'
let g:pymode_lint_cwindow = 1 
let g:pymode_lint_signs = 1
let g:pymode_lint_options_pylint = { 'max-branches': 20 }

let g:pymode_rope = 0 
let g:pymode_rope_lookup_project = 1
let g:pymode_rope_regenerate_on_write = 0
let g:pymode_rope_autoimport = 0
let g:pymode_rope_completion = 1
let g:pymode_rope_complete_on_dot = 1
let g:pymode_rope_goto_definition_cmd = 'vnew'
let g:pymode_rope_organize_imports_bind = '<localleader>ro'

let g:pymode_syntax = 1
let g:pymode_syntax_slow_sync = 1
let g:pymode_syntax_all = 1

" Yggdroot/indentLine configuration
let g:indentLine_enabled = 1
let g:indentLine_char = '⏐'

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled = 1

" jedi-vim
let g:jedi#show_call_signatures = 0

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    "echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    "echo 'Highlight current word: ON'
    return 1
  endif
endfunction

" Let plugins show effects after 500ms, not 4s
set updatetime=100
set number

nnoremap <localleader>l :PymodeLint<CR>
nnoremap <localleader>z :set hls<CR>call AutoHighlightToggle()<CR>

nnoremap <C-J> i<CR><Esc>
inoremap jj <Esc>l

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
