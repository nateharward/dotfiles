"
"  Nate Harward's Vim RC
"

" This must be first, because it changes other options as side effect
set nocompatible

" set term=rxvt-unicode

set complete-=i
set smarttab

set nrformats-=octal

set ttimeout
set ttimeoutlen=100

" Change my whitespace symbols (tabstops and EOLs)
"set listchars=tab:▸\ ,eol:¬ " Textmate
"set listchars=tab:▸\ ,eol:¶ " Eclipse DVT
"       testing tab     char

set laststatus=2 " Always show the status line
set ruler " Show where I am in the cmd area
set showcmd " count highlighted
set wildmenu

if !&scrolloff
   set scrolloff=1
endif
if !&sidescrolloff
   set sidescrolloff=5
endif
set display+=lastline

"if &encoding ==# 'latin1' && has('gui_running')
"  set encoding=utf-8
"endif
set encoding=utf-8 " Show utf-8 chars

if &listchars ==# 'eol:$'
   set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if v:version > 703 || v:version == 703 && has("patch541")
   set formatoptions+=j " Delete comment character when joining commented lines
endif

"if &shell =~# 'fish$'
"  set shell=/bin/bash
"endif

set autoread
set fileformats+=mac

" If it gets laggy when ssh'd in, set this option
" same as -X option. Also his will stop the "No protocol specified" error when running a GUI enabled instance of vim under root.
" set clipboard=exclude:.*

" if !empty(&viminfo)
"    set viminfo^=!
" endif
" set sessionoptions-=options

if v:version > 702

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
   set t_Co=16
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
   runtime! macros/matchit.vim
endif

inoremap <C-U> <C-G>u<C-U>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""
"""" Run Pathogen
"""" Allows us to simply unzip a plugin distribution into .vim/bundle/'myplugin'
"""execute pathogen#infect()
"""" Run a second phase that has to load after the first one
"""execute pathogen#infect('bundle_2/{}')
"""
" TODO gui-buttons
" task

" Download plugin manager if not already downloaded
if empty(glob('~/.vim/autoload/plug.vim'))
   silent execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
   autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

""" Source control extentions
" fugitive.vim: a Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" gitk for Vim
Plug 'gregsexton/gitv', {'on': ['Gitv']}

" A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks.
if v:version >= 740
   Plug 'airblade/vim-gitgutter'
endif

" A git commit browser in Vim
" - `:GV` to open commit browser
" - `:GV!` will only list commits that affected the current file
" - `]]` and `[[` to move between commits
Plug 'junegunn/gv.vim'

" Ease your git workflow within Vim
" - `:Magit`  Open magit buffer with [:Magit](#magitshow_magit) command.
" - `<C-n>`   Jump to next hunk with `<C-n>`, or move the cursor as you like. The cursor is on a hunk.
" - `S`       While the cursor is on an unstaged hunk, press `S` in Normal mode: the hunk is now staged, and appears in "Staged changes" section (you can also unstage a hunk from "Staged section" with `S`).
" - `CC`      Once you have stage all the required changes, press `CC`.
Plug 'jreybert/vimagit'

" Git branch management for Vim
Plug 'sodapopcan/vim-twiggy'

" TODO look at this async git plugin
" Plug 'lambdalisue/gina.vim'

" TODO look at this plugin that helps with merging
" Plug 'sjl/threesome.vim'

"""

""" Languages plugins and linters
" Asynchronous Lint Engine
Plug 'w0rp/ale'

" Syntax highlighting for SystemRDL files
Plug 'vim-scripts/systemrdl.vim'

" Additional Vim syntax highlighting for C++ (including C++11/14)
Plug 'octol/vim-cpp-enhanced-highlight'

" Support for Perl 5 and Perl 6 in Vim
Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }

" Reason language
if v:version > 800
   Plug 'reasonml-editor/vim-reason-plus'
else
   Plug 'reasonml-editor/vim-reason-legacy'
endif

" Edit Bash scripts in Vim/gVim. Insert code snippets, run, check, and debug the code and look up help
if v:version >= 740
   Plug 'WolfgangMehner/bash-support'
endif

" Go development plugin for Vim
if v:version > 740
   Plug 'fatih/vim-go'
endif

" OVM systemverilog plugin
" NOTE works well, can fall back on this if hacked version below gives trouble
" Plug '~/.vim/bundle_back/vim_ovm/'

" OVM and UVM hacked together systemverilog plugin by nateharward
" TODO put on github
" Plug '~/repos/verilog_systemverilog.vim'
Plug 'vhda/verilog_systemverilog.vim'
let g:verilog_efm_level = "lint"

" Fast and Highly Extensible Vim script Language Lint implemented by Python
Plug 'Kuniwak/vint'

" A modern vim plugin for editing LaTeX files.
Plug 'lervag/vimtex'

" Log file highlighting
" TODO merge into vim-intel repo
Plug '~/repos/logssim'

"""

""" Tags, Searching, showing heiarchy, files

" A tree explorer plugin for vim.
Plug 'scrooloose/nerdtree'
" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTree')
         \ && b:NERDTree.isTabTree()) | q | endif
nnoremap <leader>n :NERDTreeToggle<CR>

" A plugin of NERDTree showing git status
" NOTE dependancy on scrooloose/nerdtree
" XXX too slow on large models, find a way to speed up
" Plug 'Xuyuanp/nerdtree-git-plugin'

" A class outline viewer for Vim using tags, ordered by scope
Plug 'majutsushi/tagbar'
" Map Tagbar to <leader> tb
nnoremap <silent> <leader>tb :TagbarToggle<CR>

" Vim plugin for the Perl module / CLI script 'ack'
Plug 'mileszs/ack.vim'

" platinum searcher
Plug 'nazo/pt.vim'

" Fuzzy file, buffer, mru, tag, etc finder.
Plug 'ctrlpvim/ctrlp.vim'

" 🐉  Dark powered asynchronous unite all interfaces for Neovim/Vim8
Plug 'Shougo/denite.nvim'

" dispatch.vim: Asynchronous build and test dispatcher
Plug 'tpope/vim-dispatch'

" A nice customizable popup menu for vim
Plug 'skywind3000/quickmenu.vim'

" Perform all your vim insert mode completions with Tab
Plug 'ervandew/supertab'

" Make tag jumping in vim behave more like other IDE
" XXX Trying this out temporarily
" Use Ctrl-] to jump to tag and Ctrl-t to jump back
Plug 'ipod825/TagJump'

" Automated tag file generation and syntax highlighting of tags in Vim http://peterodding.com/code/vim/easytags
" TODO this might require additional setup to make it scale with large projects: https://github.com/xolox/vim-easytags
" TODO introduce when ready Plug 'xolox/vim-easytags'

" To place, toggle, display and navigate marks
" Keymap:
" mx        Toggle mark 'x' where x is a-zA-Z
" dmx       Remove mark 'x' where x is a-zA-Z
" m,        Place the next available mark
" m.        If no mark on line, place the next available mark
" m-        Delete all marks from the current line
" m/        Open location list and display marks
" m<Space>  Delete all marks from the current buffer
" m[0-9]    Toggle the corresponding marker !@#$%^&*()
" m<S-[0-9]>Remove all markers of the same type
" m?        Open location list and display markers
" m<BS>     Remove all markers
" ]`        Jump to next mark
" [`        Jump to prev mark
" ]'        Jump to start of next line containg a mark
" ['        Jump to start of prev line containg a mark
" Highlight signs of marks dynamically based upon state
" indicated by vim-signify
Plug 'kshenoy/vim-signature'
let g:SignatureMarkTextHLDynamic=1

" Mark : Highlight several words in different colors simultaneously
" <Leader> m : mark stuff like star command
" <Leader> n : clear mark " HACK DISABLED
" <Leader> * : jump forward on current mark
" <Leader> / : jump backwards on current mark " HACK DISABLED
Plug 'inkarkat/vim-ingo-library' " Required by vim-mark
Plug 'inkarkat/vim-mark'

" Eclipse like task list
Plug 'vim-scripts/TaskList.vim'
" Map TaskList to <leader> tl
nnoremap <silent> <leader>tl :TaskList<CR>

" NERDTree and tabs together in Vim
"  Plug 'jistr/vim-nerdtree-tabs', { 'on': 'NERDTreeTabsToggle' }
"Plug 'jistr/vim-nerdtree-tabs'
" Map NERDTreeToggle to \n
"nnoremap <leader>n :NERDTreeTabsToggle<CR>

" Vim plugin to list, select and switch between buffers.
" <leader>b to use, <ctrl>T to open in new tab
" gb (or <M-b>) and gB (or <M-S-b>) to flip through the MRU buffer stack
Plug 'jeetsukumaran/vim-buffergator'
"""

""" Tmux Related
" vim plugin to interact with tmux
Plug 'benmills/vimux'

" Seamless navigation between tmux panes and vim splits
" Plug 'christoomey/vim-tmux-navigator'

"vim plugin for tmux.conf
Plug 'tmux-plugins/vim-tmux'
"""

""" Usability
" unimpaired.vim: pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

" ansi escape sequences concealed, but highlighted as specified (conceal)
Plug 'vim-scripts/AnsiEsc.vim'

" Vim plugin that provides additional text objects
" CHEATSHEET https://raw.githubusercontent.com/wellle/targets.vim/master/cheatsheet.md
Plug 'wellle/targets.vim'

" copy rtf for pasting into emails with color syntax etc
" FIXME look at closely and make it work for linux
" Plug 'zerowidth/vim-copy-as-rtf'

" Vim plugin that allows you to visually select increasingly larger regions of text using the same key combination.
Plug 'terryma/vim-expand-region'

" comment lines in a program
" XXX commented out while I try other plugin
"Plug 'vim-scripts/EnhCommentify.vim'
"function EnhCommentifyCallback(ft)
"   if a:ft == 'verilog_systemverilog'
"      let b:ECcommentOpen = '//'
"      let b:ECcommentClose = ''
"      let b:ECcommentMiddle = ''
"   endif
"endfunction
"let g:EnhCommentifyCallbackExists = 'Yes'

" Comment functions so powerful—no comment necessary.
" Plug 'scrooloose/nerdcommenter'
" let g:NERDSpaceDelims = 1
"Uncomments the selected line(s).
"  [count]<leader>cu
"Comment out the current line or text selected in visual mode.
"  [count]<leader>cc
"Toggles the comment state of the selected line(s). If the topmost selected line is commented, all selected lines are uncommented and vice versa.
"  [count]<leader>c<space>

" commentary.vim: comment stuff out
" Use gcc to comment out a line (takes a count),
" gc to comment out the target of a motion (for example, gcap to comment out a paragraph),
" gc in visual mode to comment out the selection, and
" gc in operator pending mode to target a comment.
Plug 'tpope/vim-commentary'

" Vim script for text filtering and alignment
" * :Tab /:     lines up colon
" * :Tab/|      lines up pipe-delimited tables
" * :Tab /:\zs  lines up stuff after colon
Plug 'godlygeek/tabular'

" Vim motions on speed!
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_smartcase = 1
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Space>l <Plug>(easymotion-lineforward)
map <Space>j <Plug>(easymotion-j)
map <Space>k <Plug>(easymotion-k)
map <Space>h <Plug>(easymotion-linebackward)
" nmap s <Plug>(easymotion-overwin-f

"""

""" Etc/Misc
" Automatically save changes to disk in Vim
"   disabled by default, search for g:auto_save to see for what I turn it on
Plug '907th/vim-auto-save'

" 📑 Automated Vim session management and file auto-save
Plug 'thaerkh/vim-workspace'

" A lightweight implementation of emacs's kill-ring for vim
Plug 'maxbrunsfeld/vim-yankstack'

" Provide easy code formatting in Vim by integrating existing code formatters.
Plug 'Chiel92/vim-autoformat'

" Miscellaneous auto-load Vim scripts http://peterodding.com/code/vim/misc/
Plug 'xolox/vim-misc'

" repeat.vim: enable repeating supported plugin maps with '.'
" to make it work with my map functions add silent! call repeat#set("\<Plug>MyWonderfulMap", v:count) at the end
Plug 'tpope/vim-repeat'

" Improved integration between Vim and its environment (fullscreen, open URL, background command execution) http://peterodding.com/code/vim/shell/
" Plug 'xolox/vim-shell'

" Interactive command execution in Vim.
Plug 'Shougo/vimproc.vim', {'do' : 'make'}

" Gray out the colors for unused areas of code (ifdef etc)
Plug 'mphe/grayout.vim'

" Text outlining and task management for Vim based on Emacs' Org-Mode
Plug 'jceb/vim-orgmode'

"""

""" Appearance, asthetics
" Base16 for Vim
if !empty(glob('~/repos/base16-builder-go/templates/vim/'))
  Plug '~/repos/base16-builder-go/templates/vim/'
else
  Plug 'chriskempson/base16-vim'
endif

if !has('gui_running')
   if !empty(glob('~/repos/base16-builder-go/templates/shell/scripts/'))
     let g:base16_shell_path='~/repos/base16-builder-go/templates/shell/scripts'
   elseif !empty(glob('$DOTFILES/base16-shell/scripts/'))
     let g:base16_shell_path='$DOTFILES/base16-shell/scripts/'
   else
      echo 'No base16 shell scripts found'
   endif
endif

" lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 1

" A collection of themes for vim-airline
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='base16_flat'
" set this when git performance is slow
"    let g:airline#extensions#branch#enabled = 0

" Simple tmux statusline generator with support for powerline symbols and statusline / airline / lightline integration
Plug 'edkolev/tmuxline.vim'

""" Work specific plugins - to keep specifics info out of my public dotfiles
Plug '~/repos/vim-intel'
Plug '~/repos/vim-hdk/'


""" Run after everything else

" 🔣 Adds file type glyphs/icons to popular Vim plugins: NERDTree, vim-airline, Powerline, Unite, vim-startify and more
"   XXX Run last (or at least after the plugins that is modifies
"   XXX Requires a patched nerd font https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts
Plug 'ryanoasis/vim-devicons'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vimballs - currently download and install of these is not automated
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" I find these on http://www.drchip.org/astronaut/vim/index.html

" The 'gotta have it' vimball I used is visincr
" http://www.drchip.org/astronaut/vim/vbafiles/visincr.vba.gz
" open with vim, then run ':so %' to install
" Usage: Put cursor on topmost zero, select column with Ctrl-v, then enter :I
" Tags: increment, iterate, package, tar

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" My Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
if has('autocmd')
   filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
   syntax enable
endif
set backspace=2 " Backspace over indent, eol, and insert
set backspace=indent,eol,start

" Tags
set tags=./tags,tags;
if has('path_extra')
   setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

"{{{indent
set expandtab " Expand tabs to spaces
set shiftwidth=3
set softtabstop=3
set cindent
"}}}

set tw=0 " stop automatic wrapping, unset textwidth

" set modelines=0 " Don't read first/last lines of file for settings
" set hidden                " Stash unwritten files in buffer
set vb                    " Don't beep at me
set cursorline            " Highlight current line
" set cursorcolumn          " Highlight current column
set scrolloff=3           " Start scrolling when I'm 3 lines from top/bottom
set mousehide             " Hide the mouse pointer while typing
if &history < 1000
   set history=1000 " Remember commands and search history
endif
if &tabpagemax < 50
   set tabpagemax=50
endif
set number                " Show linenumbers
"set nowrap                " Turn off linewrap
"set list                  " Show invisible chars
set hlsearch              " highlight my search
set incsearch             " incremental search
set wrapscan              " Set the search scan to wrap around the file
set ignorecase            " when searching
set smartcase             " …unless I use an uppercase character
syntax sync minlines=256  " Makes big files slow
set synmaxcol=2048        " Also long lines are slow
set autoindent            " try your darndest to keep my indentation
" set smartindent           " Be smarter about indenting dummy
set formatoptions=cotqr  " I like smart comments

if !isdirectory($HOME.'/.vim/files') && exists('*mkdir')
  call mkdir($HOME.'/.vim/files')
endif

" backup files
set nobackup
set nowritebackup
" set backup
" set backupdir   =$HOME/.vim/files/backup/
" set backupext   =-vimbackup
" set backupskip  =

" swap files
set noswapfile
" set directory   =$HOME/.vim/files/swap//
" set updatecount =100

" undo files
set undofile
set undodir  =$HOME/.vim/files/undo/

" viminfo files
set viminfo     ='100,n$HOME/.vim/files/info/viminfo

" force 256
"if has('unix')
"   set t_Co=256
"endif

" If diffing
if &diff
    map ] ]c
    map [ [c
endif

" If GUI
if has('gui_running')
   "set guioptions-=T  " no toolbar
   "colorscheme desert
   "set background=dark
   "colorscheme solarized
   "if exists('g:base16-vim')
   " colorscheme base16-eighties
   colorscheme base16-flat
   "endif
   if has("gui_gtk2")
      set gfn=DejaVuSansMono\ Nerd\ Font\ Mono\ 11
      set gfw=DejaVuSansMono\ Nerd\ Font\ 11
      "     set gfn=MesloLGSDZ\ Nerd\ Font\ 11
      "     set gfw=MesloLGSDZ\ Nerd\ Font\ 11
      "     set guifont=Inconsolata-g\ Medium\ 11
      "set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 11
      "set gfn=Inconsolata-g\ for\ Powerline\ Medium\ 11
      "set gfn=InconsolataForPowerline\ Nerd\ Font\ Medium\ 12
   elseif has("gui_photon")
      "set guifont=Inconsolata-g\ Medium:11
      "set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h11
   elseif has("gui_kde")
      "    set guifont=Inconsolata-g/11/-1/5/50/0/0/0/1/0
   elseif has("x11")
      "    set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
   else
      "    set guifont=Inconsolata-g\:h11:cDEFAULT
   endif
   "colorscheme slate

   map  <silent>  <S-Insert>  "+gP
   imap <silent>  <S-Insert>  <Esc>"+pa
   map  <silent>  <C-S-Insert>  "+gP
   imap <silent>  <C-S-Insert>  <Esc>"+pa
else

   " NON GUI ONLY SETTINGS

   colorscheme default

   if $TERM !~# 'putty-256color'
      "   "if &basenotwork=~'true'
      "if exists('g:base16-vim')
      if filereadable(expand("~/.vimrc_background"))
         let base16colorspace=256
         source ~/.vimrc_background
      endif
      "endif
   else " if in PUTTY
      " TODO find a good putty scheme
      " let g:solarized_termcolors=256
      " set background=dark
      " colorscheme solarized
      colorscheme default
   endif

   " Send more characters for redraws
   set ttyfast
   "
   " " Enable mouse use in all modes
   set mouse=a
   "
   " " Set this to the name of your terminal that supports mouse codes.
   " " Must be one of: xterm, xterm2, netterm, dec, jsbterm, pterm
   " set ttymouse=xterm2 : xterm < 277 (ec default is 238)
   if v:version >= 740
      set ttymouse=sgr " allows for selecting columns past 223
   endif

endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" tabularize shortcuts
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
endif

" vim-easytags
let g:easytags_async = 1

"let g:NERDTreeIndicatorMapCustom = {
"    \ "Modified"  : "✹",
"    \ "Staged"    : "✚",
"    \ "Untracked" : "✭",
"    \ "Renamed"   : "➜",
"    \ "Unmerged"  : "═",
"    \ "Deleted"   : "✖",
"    \ "Dirty"     : "✗",
"    \ "Clean"     : "✔︎",
"    \ 'Ignored'   : '☒',
"    \ "Unknown"   : "?"
"    \ }

let g:tagbar_type_systemverilog = {
    \ 'ctagstype': 'systemverilog',
    \ 'kinds' : [
         \'A:assertions',
         \'C:classes',
         \'E:enumerators',
         \'I:interfaces',
         \'K:packages',
         \'M:modports',
         \'P:programs',
         \'Q:prototypes',
         \'R:properties',
         \'S:structs and unions',
         \'T:type declarations',
         \'V:covergroups',
         \'b:blocks',
         \'c:constants',
         \'e:events',
         \'f:functions',
         \'m:modules',
         \'n:net data types',
         \'p:ports',
         \'r:register data types',
         \'t:tasks',
     \],
     \ 'sro': '.',
     \ 'kind2scope' : {
        \ 'K' : 'package',
        \ 'C' : 'class',
        \ 'm' : 'module',
        \ 'P' : 'program',
        \ 'I' : 'interface',
        \ 'M' : 'modport',
        \ 'f' : 'function',
        \ 't' : 'task',
     \},
     \ 'scope2kind' : {
        \ 'package'   : 'K',
        \ 'class'     : 'C',
        \ 'module'    : 'm',
        \ 'program'   : 'P',
        \ 'interface' : 'I',
        \ 'modport'   : 'M',
        \ 'function'  : 'f',
        \ 'task'      : 't',
     \ },
     \}

" tweaking gitgitter to improve performance
" let g:gitgutter_enabled = 0 " Disables gitgutter
" let g:gitgutter_realtime = 0 "
" let g:gitgutter_eager = 0

" thaerkh/vim-workspace
" By default, all trailing spaces are trimmed before a buffer is autosaved. If
" you don't prefer this behaviour, add this line
let g:workspace_autosave_untrailspaces = 0

" Use TMUX window name in the workspace session save to isolate sessions
if empty($tmux)
   let g:workspace_session_name = 'session.vim'
else
   let g:tmux_window_name = systemlist( "tmux display-message -p '#w'")[0]
   let g:workspace_session_name = g:tmux_window_name . '-session.vim'
endif

" Replace grep with pt
if executable('pt')
   " Use pt over grep
   set grepprg=pt\ --nogroup\ --nocolor
   " Use pt in CtrlP for listing files. Lightning fast and respects .gitignore
   let g:ctrlp_user_command = 'pt %s -l --nocolor -g ""'
endif

" use ag instead of ack for :Ack command
if executable('ag')
   let g:ackprg = 'ag --vimgrep' " will report every match on the line
endif

" unnless we have pt, use that instead of ag or ack
if executable('pt')
   let g:ackprg = 'pt --nogroup --nocolor --column'
endif

" Quick Menu -----------------------------------------
if exists('g:quickmenu_max_width')
   " enable cursorline (L) and cmdline help (H)
   let g:quickmenu_options = "LH"
   " clear all the items
   call g:quickmenu#reset()

   " new section: empty action with text starts with "#" represent a new section
   call quickmenu#append("# Debug", '')
   " script between %{ and } will be evaluated before menu open
   call quickmenu#append("Run %{expand('%:t')}", '!./%', "Run current file")

   " new section
   call quickmenu#append("# Git", '')
   " use fugitive to show diff
   call quickmenu#append("Gvdiff", 'Gvdiff', "use fugitive's Gvdiff on current document")
   call quickmenu#append("Gstatus", 'Gstatus', "use fugitive's Gstatus on current document")
   call quickmenu#append("Glog", 'Glog', "loads all previous revisions of a file into the quickfix list so you can iterate over them and watch the file evolve!")
   call quickmenu#append("Gread", 'Gread', "a variant of git checkout -- filename that operates on the buffer rather than the filename. This means you can use u to undo it and you never get any warnings about the file changing outside Vim")
   call quickmenu#append("Gwrite", 'Gwrite', "writes to both the work tree and index versions of a file, making it like git add when called from a work tree file and like git checkout when called from the index or a blob in history.")

   " new section
   call quickmenu#append("# Misc", '')
   call quickmenu#append("Turn paste %{&paste? 'off':'on'}", "set paste!", "enable/disable paste mode (:set paste!)")
   call quickmenu#append("Turn spell %{&spell? 'off':'on'}", "set spell!", "enable/disable spell check (:set spell!)")
   call quickmenu#append("Function List", "TagbarToggle", "Switch Tagbar on/off")

   call quickmenu#append("Ignore Whitespace", "set diffopt+=iwhite", "Ignore Whitespace when diffing")

   " section 1, text starting with "#" represents a section (see the screen capture below)
   call g:quickmenu#append('# Develop', '')

   call g:quickmenu#append('item 1.1', 'echo "1.1 is selected"', 'select item 1.1')
   call g:quickmenu#append('item 1.2', 'echo "1.2 is selected"', 'select item 1.2')
   call g:quickmenu#append('item 1.3', 'echo "1.3 is selected"', 'select item 1.3')

   " section 2
   call g:quickmenu#append('# Misc', '')

   call g:quickmenu#append('item 2.1', 'echo "2.1 is selected"', 'select item 2.1')
   call g:quickmenu#append('item 2.2', 'echo "2.2 is selected"', 'select item 2.2')
   call g:quickmenu#append('item 2.3', 'echo "2.3 is selected"', 'select item 2.3')
   call g:quickmenu#append('item 2.4', 'echo "2.4 is selected"', 'select item 2.4')
   " -----------------------------------
endif

"
" Deal with artifacts
"
au BufWritePost * :silent! :syntax sync fromstart<cr>:redraw!<cr>
au CursorHold * :silent! :syntax sync fromstart<cr>:redraw!<cr>
au CursorMoved * :silent! :syntax sync fromstart<cr>:redraw!<cr>
au CursorMovedI * :silent! :syntax sync fromstart<cr>:redraw!<cr>

" Specific File Names
"

" have vim autosave these filenames when focus leaves the term
augroup mynotes
   "clears previous times this group was sourced
   autocmd!
   "   autocmd FileType todo let g:auto_save = 1
   autocmd BufRead,BufNewFile todo let g:auto_save = 1
   autocmd BufRead,BufNewFile todo set filetype=markdown
   autocmd BufRead,BufNewFile notes let g:auto_save = 1
   autocmd BufRead,BufNewFile notes set filetype=markdown
   autocmd BufRead,BufNewFile notes.md let g:auto_save = 1
   "autocmd FileType notes set g:auto_save
   "autocmd FileType todo set g:auto_save
augroup END

"
" Filetypes
"
if has("autocmd")
   " Extentions
   autocmd BufRead,BufNewFile *.rdl set filetype=systemrdl
   autocmd BufRead,BufNewFile *.tc set filetype=perl
   autocmd BufRead,BufNewFile *.hdl set filetype=perl
   autocmd BufRead,BufNewFile *.udf set filetype=perl
   " autocmd BufRead,BufNewFile *.vs set filetype=systemverilog
   autocmd BufRead,BufNewFile *.vs set filetype=verilog_systemverilog
   autocmd BufRead,BufNewFile .bindings-tcsh set filetype=tcsh
   autocmd BufRead,BufNewFile workspace_spawn.conf set filetype=tmux

   " Additional FileType settings
   " autocmd FileType verilog_systemverilog compiler vcs
   autocmd FileType make setlocal noexpandtab
endif


" ----------------------------------------------------------------------------
" Key Mappings
" ----------------------------------------------------------------------------

" Function Key Summary !!!!
" F1  : OUTSIDE (VNC Menu)
" F2  :
" F3  : Calculator 22
" F4  :
" F5  : Hdk Compile
" F6  : Re-parse a simbuild log
" F7  : Toggle Code Folding
" F8  : Buffers to Tabs
" F9  : Hdk Clean Compile
" F10 : Toggle case invariant searching
" F11 : OUTSIDE - terminal full screen
" F12 : something weird (TODO look up)

" SPACE - map to colin
nnoremap <space> :

" F3 - Calulator
" while editing, hit F3 in the insert mode and type expression to calulate
imap <silent> <F3> <C-R>=string(eval(input("Calculate: ")))<CR>

" F5 - Hdk Compile
nnoremap <silent><F5> :HdkCompile<CR>

" F6 - Re-parse a simbuild log stored at g:hdk#logname
nnoremap <silent><F6> :HdkReload<CR>

" F7 - Toggle Code Folding
" http://vim.wikia.com/wiki/Folding?useskin=monobook
" With the following in your vimrc, you can toggle folds open/closed by pressing F9.
" In addition, if you have :set foldmethod=manual, you can visually select some lines,
" then press F7 to create a fold.
inoremap <F7> <C-O>za
nnoremap <F7> za
onoremap <F7> <C-C>za
vnoremap <F7> zf

" F8 - Have all buffers turn into tabs
let notabs = 0
nnoremap <silent> <F8> :let notabs=!notabs<Bar>:if notabs<Bar>:tabo<Bar>:else<Bar>:tab ball<Bar>:tabn<Bar>:endif<CR>

" F9 - Hdk Clean Compile
nnoremap <silent> <F9> :HdkCleanCompile<CR>

" F10 - Toggle Smartcase
nnoremap <F10> :set smartcase!<CR>
inoremap <F10> <C-O>:set smartcase!<CR>

" F12 - Quickmenu popup
noremap <silent><F12> :call quickmenu#toggle(0)<cr>

" Use jj for escape ----------------------------------------------------------
:imap jj <Esc>

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Make * or # work with visually selected text in addition to its normal function
" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
         \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
         \gvy/<C-R><C-R>=substitute(
         \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
         \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
         \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
         \gvy?<C-R><C-R>=substitute(
         \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
         \gV:call setreg('"', old_reg, old_regtype)<CR>

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" use pt with unite ----------------------------------------------------------
nnoremap <silent> ,g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
if executable('pt')
   let g:unite_source_grep_command = 'pt'
   let g:unite_source_grep_default_opts = '--nogroup --nocolor'
   let g:unite_source_grep_recursive_opt = ''
   let g:unite_source_grep_encoding = 'utf-8'
endif

" Set \[ and \] to yank stack mappings
nmap <leader>[ <Plug>yankstack_substitute_older_paste
nmap <leader>] <Plug>yankstack_substitute_newer_paste

" Shortcut to rapidly toggle `set list` --------------------------------------
nmap <leader>l :set list!<CR>

" Shortcut to return to the dafault colorscheme ------------------------------
" (like when using tmux in putty)
nmap <leader>d :colorscheme default<CR>

" Shortcut to auto-format. Requires vim-autoformat plugin
nmap <leader>af :Autoformat<CR>

" Map to function to switch to header file by the same name
nmap <silent> <leader>sh :call ToggleHeader()<CR>

" Shift + Direction to Move Tabs ----------------------
nnoremap <silent> <S-h> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <S-l> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

" Ctrl + Direction to Change Tabs ---------------------------------------------
" Who has time to type gt and gT? Not me. Using shift and a direction to change
" tabs is a great alternative.
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>

" Control + n, p for next and prev -------------------------------------------
noremap <C-n> :next<CR>
noremap <C-p> :prev<CR>

" System paste ---------------------------------------------------------------
noremap <leader>p "+gP
" System copy
"noremap <leader>c "+y

" Quickly open vimrc ---------------------------------------------------------
nnoremap <leader>ev :split $MYVIMRC<CR>

" Quickly reload vimrc -------------------------------------------------------
nnoremap <leader>sv :source $MYVIMRC<CR>

" load my base-16 color scheme (handy when reattaching tmuxs in different terminals)
nnoremap <leader>sb :source ~/.vimrc_background<CR>

" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

" Filter to search result LEADER + /
" :redir @a         redirect output to register a
" :g//              repeat last global command
" :redir END        end redirection
" :new              create new window
" :put! a           paste register a into new window
nnoremap <silent> <leader>/ :redir @a<CR>:g//<CR>:redir END<CR>:tabnew<CR>:put! a<CR>

" Clone Paragraph with cp ------------------------------------------------------
" This will copy the paragraph your cursor is on then paste a copy of it just
" below. This is great when you're about to create a block of code that will be
" similar, but not different enough to abstract (e.g. it blocks in rspec).
noremap cp yap<S-}>p

" Align Current Paragraph with Leader + a --------------------------------------
" Quickly align your current paragraph with this command. Sometimes this can
" help you see where you're missing an end or a bracket.
noremap <leader>a =ip

" Toggle Paste Mode ------------------------------------------------------------
"Avoid typing :set paste and :set nopaste by setting a paste toggle command.
set pastetoggle=<leader>z

" Apply Macros with Q ----------------------------------------------------------
" This mapping makes macros even easier to remember: hit qq to record, q to stop
" recording, and Q to apply. This mapping also allows you to play macros across
" a visual selection with Q.
nnoremap Q @q
vnoremap Q :norm @q<cr>

" Control + Direction to Change Panes ------------------------------------------
" Same thing goes for changing panes, but these use control . Skip that pesky w
" and get straight to the good stuff.
"noremap <C-l> <C-w>l
"noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k

" map these to window movements for now
noremap <Up> <C-w>k
noremap <Down> <C-w>j
noremap <Left> <C-w>h
noremap <Right> <C-w>l

" Quit Files with Leader + q ---------------------------------------------------
" Quickly close a file with <leader>q.
noremap <leader>q :q<cr>

" Yank / copy inner word to external clipboard with leader + space ---------------------------------------------------
noremap <leader><space> viw"*y
noremap <return> yiw
"noremap <leader><return> viw"*p doesn't quite work

" Toggle save workspace with Leader + w
" Dependant on plugin thaerkh/vim-workspace
nnoremap <leader>w :ToggleWorkspace<CR>

" Save File with Leader + s ----------------------------------------------------
" If you're like me and you like to constantly save files, this one is nice.
" Just hit <leader>s. The second line makes this work in insert mode too, saving
" you even more effort.
nnoremap <leader>s :w<cr>
inoremap <leader>s <C-c>:w<cr>

" Bubbling - Move lines up and down
" Requires vim-impared mappings since I'm mapping to mappings
" Bubble single lines
execute "set <M-k>=\ed"
execute "set <M-j>=\ed"
nmap <M-k> [e
nmap <M-j> ]e
" Bubble multiple lines
vmap <M-k> [egv
vmap <M-j> ]egv

" have gf open a new tab -------------------------------------------------------
" [OVERRIDES DEFAULT BEHAVIOUR]
nnoremap gf <C-W>gf
vnoremap gf <C-W>gf

" Ctrl-WF go to file in a vertical split -------------------------------------
" [note] Ctrl-W+f still will do the same with a horizontl split
nnoremap <C-W><C-F> <C-W>vgf

" get the file path Leader + f ------------------------------------------------
" <leader>f. Get the path. Next step, figure out how to save it in
" you even more effort.
" Convert slashes to backslashes for Windows.
if has('win32')
   nmap <leader>f :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>
else
   nmap <leader>f :let @*=expand("%:p")<CR>:let @+=expand("%:p")<CR>
endif

" copy all - everything in the file
" TODO find a mapping other than leader-ca so that it doesn't slow down leader-c
nnoremap <leader>caa :%y+<CRa >

" Text search object
" It allows me to use the following search-and-replace flow:
" * I search things usual way using /something
" * I hit cs, replace first match, and hit <Esc>
" * I hit n.n.n.n.n. reviewing and replacing all matches
" http://vim.wikia.com/wiki/Copy_or_change_search_hit?useskin=monobook
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
         \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>

" Automatically jump to end of text you pasted:
" I can paste multiple lines multiple times with simple ppppp.
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Paste the timestamp
nnoremap <leader>tt "=strftime("%y%b%d %H:%M:%S")<CR>P
inoremap <leader>tt <C-R>=strftime("%y%b%d %H:%M:%S")<CR>
"
" Prevent replacing paste buffer on paste:
" I can select some text and paste over it without worrying if my paste buffer was replaced by the just removed text (place it close to end of ~/vimrc).
" vp doesn't replace paste buffer
function! RestoreRegister()
   let @" = s:restore_reg
   return ''
endfunction
function! s:Repl()
   let s:restore_reg = @"
   return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

" Type 12<Enter> to go to line 12 (12G breaks my wrist)
" Hit Enter to go to end of file.
" Hit Backspace to go to beginning of file. FIXME on linux
" XXX not a huge fan of these bindings but I like the concept of mapping
" normal mode BS and CR to something
" nnoremap <CR> G
" nnoremap <BS> gg

" Something is making normal mode backspace change tabs. This drives me nuts.
" Remapping it to move left
nnoremap <BS> h

" Merge shortcuts for vim when merging git repos
" +----------------------------+
" | LOCAL  |   BASE   | REMOTE |
" +----------------------------+
" |           MERGED           |
" +----------------------------+
if &diff
   " get from REMOTE into MERGED
   nnoremap d1 :diffg RE<CR>
   " get from BASE into MERGED
   nnoremap d2 :diffg BA<CR>
   " get from LOCAL into MERGED
   nnoremap d3 :diffg LO<CR>
endif

"----------------------------------------------------------------------------
" Repo Specific Settings
"----------------------------------------------------------------
if empty($LOCAL_MODEL_ROOT)
   let g:ctrlp_cache_dir = '/tmp/naharwar/.flow/ctrlp'
else
   let g:model_root_vim_settings = $LOCAL_MODEL_ROOT . '/.flow/model_vim_settings'
   if filereadable(expand(g:model_root_vim_settings))
      execute 'source '.fnameescape(g:model_root_vim_settings)
   endif
   " model_vim_settings expected to contain
   " set tags=$LOCAL_MODEL_ROOT/tags
   " let g:ctrlp_cache_dir = $LOCAL_MODEL_ROOT . '/.flow/ctrlp'
endif

"----------------------------------------------------------------------------
" AUTO RELOAD
"----------------------------------------------------------------

" Auto update vim when saving .vimrc
augroup myvimrc
   au!
   au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" Highlight trailing whitespace in some color for certail code files (don't want this in logs)
autocmd BufRead,BufNewFile *.rdl,*.sv,*.vs,*.svh,*.vh,*.c,*.cpp,*.perl,*.pl,*.h,*.hpp,.vimrc call HighlightTrailingWhitespace()

" FIXME
" let g:LargeFile=100 " Large files are > 100M
" " Files become read only
" if !exists("my_auto_commands_loaded")
"   let my_auto_commands_loaded = 1
"   let g:LargeFile = 1024 * 1024 * 10
"   augroup LargeFile
"   autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | els
"   augroup END
" endif

"------------------------------------------------------------------------------
" Terminal Scrolling FIXME find a better solution
" -----------------------------------------------------------------------------
function! ExitNormalMode()
    unmap <buffer> <silent> <RightMouse>
    call feedkeys("a")
endfunction

function! EnterNormalMode()
    if &buftype == 'terminal' && mode('') == 't'
        call feedkeys("\<c-w>N")
        call feedkeys("\<c-y>")
        map <buffer> <silent> <RightMouse> :call ExitNormalMode()<CR>
    endif
endfunction

if v:version >= 800
   tmap <silent> <ScrollWheelUp> <c-w>:call EnterNormalMode()<CR>
endif

"------------------------------------------------------------------------------
" My functions
" -----------------------------------------------------------------------------

" HighlightTrailingWhitespace
function! HighlightTrailingWhitespace()
   highlight ExtraWhitespace ctermbg=green guibg=green
   match ExtraWhitespace /\s\+$/
   autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
   autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
   autocmd InsertLeave * match ExtraWhitespace /\s\+$/
   autocmd BufWinLeave * call clearmatches()
endfunction

" AddSpaceBeforeEqualInWholeBuffer
function! AddSpaceBeforeEqualInWholeBuffer()
   let l = 1
   for line in getline(1,"$")
      call setline(l, substitute(line, '\([^= ]\)=', '\1 =', "g"))
      let l = l + 1
   endfor
endfunction

" BangOpen ------------------------------------------------------------ {{{
" example :BangOpen which script_I_wrote_thats_in_my_path_but_I_forget_where
function! BangOpen(arg)
   execute 'tabe ' . system(a:arg)
endfunction

command! -nargs=1 BangOpen :call BangOpen(<f-args>)
" }}}

function! SetSpaces(arg)
   echo "settings spaces to: " . a:arg
   execute 'set tabstop=' . a:arg
   execute 'set shiftwidth=' . a:arg
   execute 'set softtabstop=' . a:arg
endfunction

command! -nargs=1 SetSpaces :call SetSpaces(<f-args>)

" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
   let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
   if l:tabstop > 0
      let &l:sts = l:tabstop
      let &l:ts = l:tabstop
      let &l:sw = l:tabstop
   endif
   call SummarizeTabs()
endfunction

function! SummarizeTabs()
   try
      echohl ModeMsg
      echon 'tabstop='.&l:ts
      echon ' shiftwidth='.&l:sw
      echon ' softtabstop='.&l:sts
      if &l:et
         echon ' expandtab'
      else
         echon ' noexpandtab'
      endif
   finally
      echohl None
   endtry
endfunction

command! -nargs=* FileTime echo FileTime()
function! FileTime()
  let ext=tolower(expand("%:e"))
  let fname=tolower(expand('%<'))
  let filename=fname . '.' . ext
  let msg=""
  let msg=msg." ".strftime("(Modified %b,%d %y %H:%M:%S)",getftime(filename))
  return msg
endfunction

command! -nargs=* CurTime echo CurTime()
function! CurTime()
  let ftime=""
  let ftime=ftime." ".strftime("%b,%d %y %H:%M:%S")
  return ftime
endfunction

" Switch between header and source if they have the same name
" TODO make it open tabs and switch between them
function! ToggleHeader()
    let extension = expand('%:e')
    let root = expand('%:r')
    if extension == 'cpp'
        execute(':e '.root.'.h')
    elseif extension == 'h'
        execute(':e '.root.'.cpp')
    elseif extension == 'sv'
        execute(':e '.root.'.svh')
    elseif extension == 'svh'
        execute(':e '.root.'.sv')
    endif
endfunc

" FIXME wrap this in a "isDispatchPluginAvailable" sort of if statment
command! -nargs=0 Tig :Start -dir=%:p:h -title=tig -wait=always tig

" https://vim.fandom.com/wiki/Display_output_of_shell_commands_in_new_window
function! s:ExecuteInShell(command)
  let command = join(map(split(a:command), 'expand(v:val)'))
  let winnr = bufwinnr('^' . command . '$')
  silent! execute  winnr < 0 ? 'botright vnew ' . fnameescape(command) : winnr . 'wincmd w'
  setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
  echo 'Execute ' . command . '...'
  silent! execute 'silent %!'. command
  silent! execute 'resize '
  silent! redraw
  silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
  silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
  echo 'Shell command ' . command . ' executed.'
endfunction
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)

endif
