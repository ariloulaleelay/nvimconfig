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
Plugin 'airblade/vim-gitgutter'


" --- Python ---
Plugin 'klen/python-mode'         " Python mode (docs, refactor, lints, highlighting, run and ipdb and more)
Plugin 'davidhalter/jedi-vim'     " Jedi-vim autocomplete plugin
Plugin 'nvie/vim-flake8' " PEP8 checks

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
let g:pymode_options_max_line_length = 1000
let g:pymode_options_colorcolumn = 0
let g:pymode_folding = 0
let g:pymode_lint_options_mccabe = { 'complexity': 120 }
" rope hang workaround https://github.com/klen/python-mode/issues/209
let g:pymode_rope_lookup_project = 0
" https://github.com/klen/python-mode/issues/525
let g:pymode_rope_autoimport = 0

" Yggdroot/indentLine configuration
let g:indentLine_enabled = 1
let g:indentLine_char = '⏐'

" insert new line by <C-J>
nnoremap <C-J> i<CR><Esc>

" Shortcut for jj 
inoremap jj <Esc>l

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
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

" call AutoHighlightToggle()
nnoremap <localleader>z :call AutoHighlightToggle()<CR>

" Airline
let g:airline_powerline_fonts = 1
" let g:airline_theme='solarized'

" jedi-vim
let g:jedi#show_call_signatures = "0"

" Let plugins show effects after 500ms, not 4s
set updatetime=100
set number
