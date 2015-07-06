set nocompatible                                           "  [Must be the 1st uncommented line!] Use vim settings rather than vi settings (to avoid emulating vi's bugs & limitations)
" *** USE :help [options]   <-- to get list of available SET options, etc.
" *** USE :tab help         <-- to get help in a separate tab.

" *** Here's the 'MAP' TEMPLATE to use:
"noremap  g                    doesthisandthat             "  g        <-- does-this-and-that

inoremap  jj                   <ESC>                       "  jj       <-- ESC
" * Auto-correct:
abbr teh the
" * Print:
"set printfont=:h7
set printfont=:h9
set printoptions=number:y,paper:letter,portrait:n,left:15pt,right:20pt,top:25pt,bottom:25pt

" Strip trailing whitespace on Save:
autocmd BufWritePre * :%s/\s\+$//e

" Windows-like functionality for Copy, i.e., CTRL-c [cannot set Paste b/c CTRL-v is already set to invoke Visual Mode]:
noremap   <C-c>                "+y

set viminfo^=!
set modelines=0                                            "  Avoid the security exploit involving modelines in edited files
set ttyfast                                                "  Smoother changes
" For gvim -d/vim -d (& g/vimdiff) options:
set diffopt+=iwhite                                        "  Ignore whitespace (except leading whitespace)
"set diffopt+=icase                                         "  Ignore case
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" Do not timeout on MAP key-sequences:
set notimeout
set ttimeout
" * Replace ^M at all EOLs:
noremap   <LEADER>m            mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm
                                                           "  \m
set guioptions=merb                                        "  Display gvim's menu bar, tab bar, vertical scroll bar, and horizontal scroll bar, respectively
"set guioptions+=T                                           "  Display gvim's tool bar
""set showtabline=2                                           " Commented-out because it causes editor to refresh screen several times at onset! " --> Tab bar is always displayed
set guitablabel=(%N)%m\ \ %t                               "  Number the tabs in the tabs bar, also displays [+] to indicate 'modified'; and display filename's tail-end only
tab all                                                    "  Open all files in vim's arg-list in separate tabs
""set helpheight=15                                           " Use ':tab help' instead. " 15 lines of Help is enough
set ignorecase
set smartcase                                              "  Ignore 'ignorecase' for uppercase letters in patterns
set infercase                                              "  Infer case for ignorecase keyword completion
set magic                                                  "  Set magic on, for regular expressions
set showmatch                                              "  Cursor briefly jumps to the matching closing/opening brace/parenthesis/bracket
set matchtime=3                                            "  Matching 'item' blinks for x-tenths of a second
set incsearch                                              "  Do incremental searching - make sure to hit ENTER to accept a match!
noremap   ;;                   :%s:::g<LEFT><LEFT><LEFT>
                                                           "  ;;       <-- template for SEARCH
noremap   ;'                   :%s:\v::g<LEFT><LEFT><LEFT>
                                                           "  ;'       <-- template for SEARCH _without_ having to escape the occasional Regex-SEARCH-symbol
set hls                                                    "  Hilite search matches; use ':set noh' to turn off [OR see next line!]
nnoremap  <silent> <SPACE>     :noh<BAR>echo<CR>           "  \S-bar   <-- clear SEARCH-highlighting & STATUS msgs

set cursorline                                             "  Show current line with a different background
nmap      <C-a>sc              :set cursorline<CR>         "  C-a + sc <-- :set cursorline
set showmode                                               "  Show current input mode in statusbar
set showcmd                                                "  Show current command being typed in statusbar
"set shortmess=aOstT                                         "  Shortens msgs to avoid 'press a key' prompt
set ruler                                                  "  Enable ruler [statusbar]
set laststatus=2                                           "  Always show statusbar [statusline]
set statusline=\ %F%m%r%h%w\ \ \ \ \ \ Line:\ %l/%L:%c\ \ \ \ \ \ \ Format:%{&ff}%y
"                | | | | |                    |  |  |                      |     |
"                | | | | |                    |  |  |                      |     +-- current syntax in []s
"                | | | | |                    |  |  |                      +-- current fileformat
"                | | | | |                    |  |  +-- current column
"                | | | | |                    |  +-- total number of lines
"                | | | | |                    +-- current line
"                | | | | +-- preview flag in []s
"                | | | +-- help flag in []s
"                | | +-- readonly flag in []s
"                | +-- modified flag in []s
"                +-- full path to file in buffer

set scrolloff=3                                            "  Keep 3 lines above and below cursor when scrolling
set history=70
set wildmenu                                               "  When using tab to complete commands, show candidates above

set fileencodings=utf-8
set encoding=utf-8
set columns=190
set lines=53
"winpos 480 28
set t_Co=256                                               "  256-color support
"   colorscheme sahara
colorscheme peachpuff
"colorscheme solarized
"set guifont=Droid\ Sans\ Mono\ 10
set guifont=Monospace\ 10

set expandtab                                              "  Generate spaces (instead of tabs) in insert-mode
set shiftwidth=2                                           "  Governs # of spaces for a Tab, when re-indenting (that is, when using <<|>>), & for auto-C-style indentation
set softtabstop=2                                          "  # of spaces on hitting Tab in insert-mode
set tabstop=2                                              "  Defines # of spaces representing one tab
""set autoindent                                             "  Simply repeats the indentation on the previous line!
"set paste                                                  " Do NOT use; interferes with 'autoindent' (resets it!)
"set smartindent                                            "  Automatically inserts one more level of indentation in certain scenarios, for C-like files.
                                                             "  However, setting 'smartindent' may interfere with file-type-based indentation. So,
                                                             "  SET THIS ONLY IF NECESSARY AND, IF SO, SET IT MANUALLY.
" Syntax declarations:
"autocmd FileType html       setlocal shiftwidth=2 tabstop=2
"autocmd FileType python     setlocal expandtab shiftwidth=4 softtabstop=4
"autocmd BufNewFile,BufRead *.{cs,vb}html set syntax=html
"autocmd BufNewFile,BufRead *.{cs,vb}html_{,v}[0-9] set syntax=html

set nobackup                                               "  No backup files
set nowb                                                   "  No write backup
set noswapfile
set report=0

"
" For pathogen:
"
filetype off                                               "  Prior to the Pathogen calls; reinstated afterwards
execute pathogen#infect()
"
" Post-pathogen:
"
syntax on
filetype plugin indent on                                  "  Uses indentation scripts located in the vim installation's indent folder

" [non-Pathogen:]
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap      <C-a>so              :syntax on<CR>              "  C-a + so <-- :syntax on
set nowrap                                                 "  Don't wrap lines
nmap      <C-a>nw              :set nowrap<CR>             "  C-a + nw <-- :set nowrap
set number                                                 "  Turn on line numbers
nmap      <C-a>sn              :set number<CR>             "  C-a + sn <-- :set number
set numberwidth=5                                          "  Format for upto 999 lines
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"
" airline (w/ powerline fonts)
"
let g:airline_powerline_fonts=1
"let g:Powerline_symbols="fancy"
"
" syntastic (w/ airline)
"
let g:airline#extensions#syntastic#enabled=1
let g:airline_theme='solarized'
let g:syntastic_check_on_open=1
"let g:syntastic_auto_loc_list=1
let g:syntastic_always_populate_loc_list=1
let g:syntastic_enable_signs=1
"
" NERDTree
"
nmap      <silent> <C-l>       :NERDTreeToggle<CR>         "  C-l      <-- :NERDTree toggle
let g:NERDTreeDirArrows=0
let g:nerdtree_tabs_open_on_gui_startup=0
"let NERDTreeQuitOnOpen=1
"autocmd vimenter * NERDTree
"
" Undotree
"
nnoremap  <F5>                 :UndotreeToggle<CR>         "  <F5>     <-- :Undotree toggle
if has("persistent_undo")
  set undodir =        " $HOME/.undodir/"
  set undofile
endif
"
" ctrlp
"
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_show_hidden=1                                "  Include hidden files in search
let g:ctrlp_working_path_mode=0                          "  Do not try to intelligently work out the current working directory--to search within
let g:ctrlp_max_height=30                                "  Do not let it take over the screen...
"
" neocomplcache
"
let g:neocomplcache_enable_at_startup=1
"
" tagbar
"
nmap      <F8>                 :TagbarToggle<CR>           "  <F8>     <-- :Tagbar toggle
let g:tabgbar_ctags_bin="ctags"
let g:tagbar_type_ruby = {
    \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 'C:contexts',
        \ 'f:methods',
        \ 'F:singleton methods'
    \ ]
\ }

