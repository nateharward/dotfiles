"
" Nathan Harward's Vim RC
"

" TODO
" * checkout this addon: http://valloric.github.io/YouCompleteMe/
" * and anything else from here:
" https://github.com/JohnMorales/dotfiles/blob/master/vimrc

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

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

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

if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

"if &shell =~# 'fish$'
"  set shell=/bin/bash
"endif

set autoread
set fileformats+=mac

if !empty(&viminfo)
  set viminfo^=!
endif
set sessionoptions-=options

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
" logs-sim
" task
"
call plug#begin('~/.vim/plugged')

""" Source control extentions
  " fugitive.vim: a Git wrapper so awesome, it should be illegal
  Plug 'tpope/vim-fugitive'

  " gitk for Vim
  Plug 'gregsexton/gitv', {'on': ['Gitv']}

  " A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks.
  Plug 'airblade/vim-gitgutter'
"""

""" Languages plugins
  " Syntax highlighting for SystemRDL files
  Plug 'vim-scripts/systemrdl.vim'

  " Support for Perl 5 and Perl 6 in Vim
  Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }

  " Go development plugin for Vim
  Plug 'fatih/vim-go'

  " OVM systemverilog plugin
  " NOTE works well, can fall back on this if hacked version below gives trouble
  " Plug '~/.vim/bundle_back/vim_ovm/'

  " OVM and UVM hacked together systemverilog plugin by nateharward
  " TODO put on github
  Plug '~/repos/verilog_systemverilog.vim'

  " A modern vim plugin for editing LaTeX files.
  Plug 'lervag/vimtex'

"""

""" Tags, Searching, showing heiarchy, files

  " A tree explorer plugin for vim. 
  Plug 'scrooloose/nerdtree'

  " A plugin of NERDTree showing git status
  " NOTE dependancy on scrooloose/nerdtree
  " XXX too slow on large models, find a way to speed up 
  " Plug 'Xuyuanp/nerdtree-git-plugin'

  " Vim plugin for the Perl module / CLI script 'ack'
  Plug 'mileszs/ack.vim'

  " Fuzzy file, buffer, mru, tag, etc finder.
  " Plug 'ctrlpvim/ctrlp.vim'

  " 🐉  Dark powered asynchronous unite all interfaces for Neovim/Vim8
  " Plug 'Shougo/denite.nvim'

  " A nice customizable popup menu for vim
  Plug 'skywind3000/quickmenu.vim'

  " Perform all your vim insert mode completions with Tab
  Plug 'ervandew/supertab'

  " Vim plugin that displays tags in a window, ordered by scope
  " Plug 'majutsushi/tagbar'

  " Automated tag file generation and syntax highlighting of tags in Vim http://peterodding.com/code/vim/easytags
  " TODO this might require additional setup to make it scale with large projects: https://github.com/xolox/vim-easytags
  " TODO introduce when ready Plug 'xolox/vim-easytags'

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

  " Vim plugin that allows you to visually select increasingly larger regions of text using the same key combination.
  Plug 'terryma/vim-expand-region'

  " comment lines in a program
  Plug 'vim-scripts/EnhCommentify.vim'
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
"""

""" Appearance, asthetics
  " Base16 for Vim
  Plug 'chriskempson/base16-vim'

  " lean & mean status/tabline for vim that's light as air
  Plug 'vim-airline/vim-airline'

  " A collection of themes for vim-airline
  Plug 'vim-airline/vim-airline-themes'

  " Simple tmux statusline generator with support for powerline symbols and statusline / airline / lightline integration
  Plug 'edkolev/tmuxline.vim'

""" Work specific plugins - to keep specifics info out of my public dotfiles

  Plug '~/repos/vim-intel'

""" Run after everything else

  " 🔣 Adds file type glyphs/icons to popular Vim plugins: NERDTree, vim-airline, Powerline, Unite, vim-startify and more
  "   XXX Run last (or at least after the plugins that is modifies
  "   XXX Requires a patched nerd font https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts
  Plug 'ryanoasis/vim-devicons'

call plug#end()


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
set smartindent           " Be smarter about indenting dummy
set formatoptions=cotqr  " I like smart comments

set nobackup
set nowritebackup
set noswapfile

" force 256
"if has('unix')
"   set t_Co=256
"endif

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
     set guifont=Inconsolata-g\ Medium\ 11
     "set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 11
     "set gfn=Inconsolata-g\ for\ Powerline\ Medium\ 11
     "set gfn=InconsolataForPowerline\ Nerd\ Font\ Medium\ 12
  elseif has("gui_photon")
    "set guifont=Inconsolata-g\ Medium:11
    "set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h11
  elseif has("gui_kde")
    set guifont=Inconsolata-g/11/-1/5/50/0/0/0/1/0
  elseif has("x11")
    set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
  else
    set guifont=Inconsolata-g\:h11:cDEFAULT
  endif
  "colorscheme slate

  map  <silent>  <S-Insert>  "+gP
  imap <silent>  <S-Insert>  <Esc>"+pa
  map  <silent>  <C-S-Insert>  "+gP
  imap <silent>  <C-S-Insert>  <Esc>"+pa
else

" NON GUI ONLY SETTINGS

  " set background=dark
   "set background=light
   "let g:solarized_termcolors=256
   "colorscheme solarized

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
 set ttymouse=xterm2

endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" tweaking gitgitter to improve performance
"let g:gitgutter_enabled = 0 " Disables gitgutter
let g:gitgutter_realtime = 0 "
let g:gitgutter_eager = 0

" thaerkh/vim-workspace
" By default, all trailing spaces are trimmed before a buffer is autosaved. If
" you don't prefer this behaviour, add this line
let g:workspace_autosave_untrailspaces = 0

let g:airline_powerline_fonts = 1
" let g:airline_theme='base16_eighties'
let g:airline_theme='base16_flat'

" use ag instead of ack for :Ack command
if executable('pt')
"  let g:ackprg = 'pt --vimgrep' " will report every match on the line
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
   autocmd FileType todo let g:auto_save = 1
   autocmd BufRead,BufNewFile notes let g:auto_save = 1
   "autocmd FileType notes set g:auto_save
   "autocmd FileType todo set g:auto_save
augroup END

"
" Filetypes
"
autocmd BufRead,BufNewFile *.rdl set filetype=systemrdl
autocmd BufRead,BufNewFile *.tc set filetype=perl
" autocmd BufRead,BufNewFile *.vs set filetype=systemverilog
autocmd BufRead,BufNewFile *.vs set filetype=verilog_systemverilog
autocmd BufRead,BufNewFile .bindings-tcsh set filetype=tcsh

"
" Special settings for filetypes
"
autocmd FileType make setlocal noexpandtab

" Replace grep with pt
if executable('pt')
  " Use ag over grep
  set grepprg=pt\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'pt %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" ----------------------------------------------------------------------------
" Key Mappings
" ----------------------------------------------------------------------------

" Function Key Summary !!!!
" F1  : OUTSIDE (VNC Menu)
" F2  :
" F3  :
" F4  :
" F5  :
" F6  :
" F7  :
" F8  : Buffers to Tabs
" F9  : Toggle Code Folding
" F10 : Toggle case invariant searching
" F11 : OUTSIDE - terminal full screen
" F12 : something weird (TODO look up)

" SPACE - map to colin
nnoremap <space> :

" F8 - Have all buffers turn into tabs
let notabs = 0
nnoremap <silent> <F8> :let notabs=!notabs<Bar>:if notabs<Bar>:tabo<Bar>:else<Bar>:tab ball<Bar>:tabn<Bar>:endif<CR>

" F9 - Toggle Code Folding
" http://vim.wikia.com/wiki/Folding?useskin=monobook
" With the following in your vimrc, you can toggle folds open/closed by pressing F9.
" In addition, if you have :set foldmethod=manual, you can visually select some lines,
" then press F9 to create a fold.
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

" F10 - Toggle Smartcase
nnoremap <F10> :set smartcase!<CR>
inoremap <F10> <C-O>:set smartcase!<CR>

" F12 - Quickmenu popup
noremap <silent><F12> :call quickmenu#toggle(0)<cr>


" Set My leader key
":let mapleader =

" Use jj for escape ----------------------------------------------------------
:imap jj <Esc>

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

" Ctrl-left/right change tabs, Alt-left/right move tabs ----------------------
"nnoremap <C-Left> :tabprevious<CR>
"nnoremap <C-Right> :tabnext<CR>
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>


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

" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

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

" Shift + Direction to Change Tabs ---------------------------------------------
" Who has time to type gt and gT? Not me. Using shift and a direction to change
" tabs is a great alternative.
noremap <S-l> gt
noremap <S-h> gT

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

" Toggle save workspace with Leader + w
" Dependant on plugin thaerkh/vim-workspace
nnoremap <leader>w :ToggleWorkspace<CR>

" Open Nerd Tree
" Dependant on plugin scrooloose/nerdtree
map <leader>t :NERDTreeToggle<CR>

" Save File with Leader + s ----------------------------------------------------
" If you're like me and you like to constantly save files, this one is nice.
" Just hit <leader>s. The second line makes this work in insert mode too, saving
" you even more effort.
nnoremap <leader>s :w<cr>
inoremap <leader>s <C-c>:w<cr>

" Be able to move lines up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

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
  nmap <leader>f :let @*=expand("%:p")<CR>
endif

" copy all - everything in the file
nnoremap <leader>ca :%y+<CR>

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
nnoremap <CR> G
nnoremap <BS> gg


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
