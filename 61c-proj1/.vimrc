set nocompatible

" TODO: this may not be in the correct place. It is intended to allow overriding <Leader>.
" source ~/.vimrc.before if it exists.
if filereadable(expand("~/.vimrc.before"))
  source ~/.vimrc.before
endif

" ================ General Config ===================

set mousemodel=extend
set number                      " Line numbers are good
set ruler
set backspace=indent,eol,start  " Allow backspace in insert mode
set history=1000                " Store lots of :cmdline history
set showcmd                     " Show incomplete cmds down the bottom
set showmode                    " Show current mode down the bottom
set gcr=a:blinkon0              " Disable cursor blink
set visualbell                  " No sounds
set autoread                    " Reload files changed outside vim
set mouse=a
set virtualedit=onemore
set clipboard=unnamed,unnamedplus
set hidden
set timeoutlen=500
set encoding=utf-8
set cursorline
set cursorcolumn
syntax on
" set gdefault                    " global search by default.
au FocusLost * :wa              " saves file on focus change
" set spell for markdown
autocmd BufRead,BufNewFile *.md setlocal spell
" syntax highlight 'less' files
au BufRead,BufNewFile *.less set filetype=css

syntax enable
syn match myTodo "\<\l\{2\}TODO\>"
syn match myTodo2 "\<QUESTION>"
hi def link myTodo Todo
hi def link myTodo2 Todo

" move by screen line
noremap <Down> gj
noremap <Up> gk
" stop arrow keys from typing A B C D
map OA <up>
map OB <Down>
map OD <left>
map OC <right>
noremap h gj
noremap k gk
noremap j h

" To jump around tags defs easier.
nnoremap <c-[> <c-t>

" sets a line to find your cursor position
" augroup cline
    " au!
    " au WinLeave,InsertEnter * set nocursorline
    " au WinEnter,InsertLeave * set cursorline
" augroup END

" marks 80th column
if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif

" The mapleader has to be set before vundle starts loading all
" the plugins.

let mapleader="\<Space>"
let maplocalleader = "-"

" TODO don't forget about backslash as a third leader

" ================ Startify ===================
"
let g:startify_bookmarks = ['~/.vimrc', '~/.zshrc', '/Users/alokbeniwal/.yadr/zsh/aliases.zsh', '/Users/alokbeniwal/Library/Application Support/Karabiner/private.xml' ]

" =============== Vundle Initialization ===============

" This loads all the plugins specified in ~/.vim/vundles.vim
" Use Vundle plugin to manage all other plugins
 set rtp+=~/.vim/bundle/vundle/Vundle.vim
 set rtp+=~/.fzf
if filereadable(expand("~/.vim/vundles.vim"))
  source ~/.vim/vundles.vim
endif

" ================ Turn Off Swap Files =============
"
 set noswapfile
 set nobackup
 set nowb

" ================ Modules ==========================

set rtp+=/usr/local/Cellar/fzf/0.9.4-1

" ================ Change Cursor Shape ==========================

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x10"

" ================ Persistent Undo ==================

" Keep undo history across sessions, by storing in file.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·


set nowrap       " Don't wrap lines
set linebreak    " Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent " fold based on indent
set foldnestmax=30    " deepest fold is 30 levels
set nofoldenable      " don't fold by default
set foldlevelstart=99 " start with folds open

" more stuff that's fine
" ================ Completion =======================

set wildmode=list:longest
set wildmenu                " enable ctrl-n and ctrl-p to scroll through matches
set wildignore=*.o,*.obj,*~ " stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Scrolling ========================

set scrolloff=8         " Start scrolling when we're 8 lines away from margins
set sidescrolloff=4
set sidescroll=1



" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" ================ Custom Mappings===========================
" ================ Plugins ===========================

" see what C functions depend on each other
Plugin 'hari-rangarajan/CCTree'
Plugin 'hari-rangarajan/ccglue'

" TODO: add more commands for parens

" add semicolon for C-like languages
nnoremap <leader>: $a;<esc>^

" fast commenting
nnoremap <M-c> gcc

" change working directory to current file's directory
nnoremap <leader>cd :cd %:p:h<CR>

" Open a Quickfix window for the last search.
nnoremap <silent> <leader>q :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Ag for the last search.
nnoremap <silent> <Leader>qa :execute "Ag! '" . substitute(substitute(substitute(@/, "\\\\<", "\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "", "") . "'"<CR>

" open tagbar
nnoremap <silent> <Leader>t :TagbarToggle<CR>

let gundo_map_move_older = "n"
let gundo_map_move_newer = "e"

" saves effort of going to beginning of word
nnoremap yw yiw
nnoremap cw "_ciw
nnoremap dw "_diw

" close linter window fast
nnoremap <Leader>l :lclose<CR>

" add newline in normal mode
nnoremap <c-b> o<Esc>k
nnoremap <M-o> o<Esc>k

" toggle wrap modes
nnoremap <leader>sr :set wrap!<CR>

" SplitJoin plugin
nmap Ej :SplitjoinSplit<cr>
nmap Ek :SplitjoinJoin<cr>

" Get the current highlight group. Useful for then remapping the color
map <leader>hI :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>

" toggle highlighting by variable names
nnoremap <Leader>hi :SemanticHighlightToggle<CR>

map <M-e> <Plug>(easymotion-bd-e)
map <M-w> <Plug>(easymotion-bd-w)
map <BS>w <Plug>(easymotion-bd-w)
map <BS>e <Plug>(easymotion-bd-e)

" Create window splits easier. The default
" way is Ctrl-w,v and Ctrl-w,s. I remap
" this to vv and ss
nnoremap <silent> -- <C-w>v
nnoremap -v <C-w>s

" close window and or buffer
nnoremap <silent> Q :call CloseWindowOrKillBuffer()<CR>

" launch Startify
nnoremap <Leader>e :Startify<CR>


" easy folding
nnoremap zz zf
"
" make searching easier
nnoremap <LocalLeader>s :%s,
" noremap <CR> /
nnoremap <CR> /\v
vnoremap <CR> /\v

" for the quickfix window
nnoremap / <CR>
vnoremap / <CR>

" Make go to file create the file, if not existent
nnoremap <leader>gf :e<cfile><CR>
nnoremap <C-w>f :sp +e<cfile><CR>
nnoremap <C-w>gf :tabe<cfile><CR>

" Zoom in
map <silent> <leader>gz <C-w>o

" Create window splits easier.
nnoremap <silent> -- <C-w>v
nnoremap <silent> -c <C-w>s

" TODO: figure out what this does
nnoremap zO zCzO

" switch buffers fast
nnoremap <S-Left>  :bp<cr>
nnoremap <S-Right> :bp<cr>


" jump to linter error marks
nnoremap <D-M-Up>    :lpre<cr>zvzz
nnoremap <D-M-Down>  :lnext<cr>zvzz


" TODO: figure out what this does
inoremap <c-j> <c-x><c-f>
inoremap <c-k> <c-x><c-]>

nnoremap <c-a> ^
vnoremap <c-a> ^


" Unimpaired configuration
" Bubble single lines
nmap <M-Up> [e
nmap <M-Down> ]e

" Bubble multiple lines
vmap <M-Up> [egv
vmap <M-Down> ]egv

" end of line
nnoremap <c-e> $
vnoremap <c-e> g_

" make cut a motion
"replace X as delete letter so `exchange` plugin can work.
noremap <c-x> "_x

nmap x <Plug>MoveMotionPlug
xmap x <Plug>MoveMotionXPlug
nmap xx <Plug>MoveMotionLinePlug

" CtrlP mappings
let g:ctrlp_map = '<LocalLeader>t'
nnoremap <silent> <LocalLeader>t :CtrlP<CR>
nnoremap <silent> <LocalLeader>= :CtrlPBuffer<cr>

"Cmd-Shift-(M)ethod - jump to a method (tag in current file)
"Ctrl-m is not good - it overrides behavior of Enter
nnoremap <silent> <D-M> :CtrlPBufTag<CR>


" Create snippets quickly
map -u :UltiSnipsEdit<CR>

" don't undo when i want to yank
vnoremap u y
vnoremap gu u


" emacs insert bindings
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A

" pasting and show yankring
noremap <Leader>P :pu<CR>
" nnoremap <Leader>yr :YRShow<CR>

" TODO: make tab work for angle brackets
nnoremap <tab> %
onoremap <tab> %
vnoremap <tab> %

nmap <silent> S <plug>SubstituteOverMotionMap
nmap SS <plug>SubstituteLine
xmap S <plug>XEasyClipPaste

" use this more to go to older changes

cnoremap <D-P> <plug>EasyClipCommandModePaste
inoremap <D-P> <plug>EasyClipInsertModePaste

" nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" use dash more
nnoremap <silent> <leader>d <Plug>DashSearch
vnoremap <silent> <leader>d <Plug>DashSearch

" toggle paste formatting
nnoremap <LocalLeader>p <plug>EasyClipToggleFormattedPaste

" make sql stop messing with my arrow keys in insert mode
let g:ftplugin_sql_omni_key_right = '<C-Right>'
let g:ftplugin_sql_omni_key_left  = '<C-Left>'


" ================ Insert Mode Mappings For Specific Filetypes ===========================


autocmd Filetype *.hs  inoremap <buffer> ; :
autocmd Filetype *.py* inoremap <buffer> ; :

" ================ Plugin Settings ===========================

" Jedi settings
let g:jedi#documentation_command = "<leader>K"
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#use_splits_not_buffers = "right"

" NERDTree
let NERDTreeIgnore = ['\.DS_Store$']

" faster bookmarking in NERDTree
autocmd Filetype nerdtree nnoremap <buffer> <leader>B :Bookmark<space>
autocmd Filetype nerdtree nnoremap <buffer> <leader>b :Bookmark<space><CR>

" easier navigation of filesystem
let NERDTreeMapChangeRoot = 'u'
let NERDTreeMapUpdir = 'U'
let NERDTreeMapUpdirKeepOpen = 'c'
let g:NERDTreeShowHidden = 1
let g:NERDTreeShowBookmarks = 1

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
    exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
    exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('hs', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('rkt', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('py', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('scala', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('py3', 'Magenta', 'none', '#ff00ff', '#151515')

" Rainbow
let g:rainbow_active = 1

" EasyMotion
let g:EasyMotion_smartcase = 1

" Neocomplete
let g:neocomplete#auto_completion_start_length = 2

autocmd FileType python setlocal omnifunc=jedi#completions
	let g:jedi#completions_enabled = 0
	let g:jedi#auto_vim_configuration = 0
	" let g:neocomplete#force_omni_input_patterns.python =
	" \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
	" alternative pattern: '\h\w*\|[^. \t]\.\w*'

" Sneak
" let g:sneak#streak = 1
" let g:sneak#s_next = 1
let g:sneak#use_ic_scs = 1

" CtrlP
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:ctrlp_show_hidden = 1
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'


" Airline
let g:airline#extensions#tabline#enabled = 1
set statusline =%1*\ %n\ %*
set statusline +=%2*/%L%*
" set statusline +=%{tagbar#currenttag('[%s] ','')}

" Easyclip
let g:EasyClipShareYanks = 1
let g:EasyClipUseCutDefaults = 0
let g:EasyClipAutoFormat = 1
let g:EasyClipPreserveCursorPositionAfterYank = 1

" HASKELL

" Haddock
let g:haddock_browser = "open"
let g:haddock_browser_callformat = "%s %s"


" Neco ghc
let g:necoghc_enable_detailed_browse = 1

" make slime work
let g:slime_target = "tmux"
let g:slime_python_ipython = 1
let g:slime_default_config = {"socket_name": "default", "target_pane": ":"}
let g:slime_paste_file = "$HOME/.slime_paste"

" UltiSnips
let g:UltiSnipsEditSplit="vertical"

" tagbar
let g:tagbar_left = 1
let g:tagbar_autofocus = 1
let g:tagbar_show_linenumbers = -1

" tag generation
" tags += tagfile
let g:easytags_async = 1

let g:tagbar_type_haskell = {
            \ 'ctagsbin'  : 'hasktags',
            \ 'ctagsargs' : '-x -c -o-',
            \ 'kinds'     : [
            \  'm:modules:0:1',
            \  'd:data: 0:1',
            \  'd_gadt: data gadt:0:1',
            \  't:type names:0:1',
            \  'nt:new types:0:1',
            \  'c:classes:0:1',
            \  'cons:constructors:1:1',
            \  'c_gadt:constructor gadt:1:1',
            \  'c_a:constructor accessors:1:1',
            \  'ft:function types:1:1',
            \  'fi:function implementations:0:1',
            \  'o:others:0:1'
            \ ],
            \ 'sro'        : '.',
            \ 'kind2scope' : {
            \ 'm' : 'module',
            \ 'c' : 'class',
            \ 'd' : 'data',
            \ 't' : 'type'
            \ },
            \ 'scope2kind' : {
            \ 'module' : 'm',
            \ 'class'  : 'c',
            \ 'data'   : 'd',
            \ 'type'   : 't'
            \ }
            \ }
" Syntastic
" make it use Python3
let g:syntastic_python_python_exec = '/usr/local/bin/python3'

" cmd2
  function! s:CustomFuzzySearch(string)
    let pattern = ""
    let ignore_case = g:Cmd2__complete_ignorecase ? '\c' : ''
    let char = matchstr(a:string, ".", byteidx(a:string, 0))
    let pattern = '\V' . ignore_case
    let pattern .= '\<\%(\[agls]\:\)\?'
    let pattern .= '\%(\%(\k\*\[_\-#]\)\?' . char
    let pattern .= '\|\k\*\%(' . char . '\&\L\)\)'
    if g:Cmd2__complete_fuzzy
      let result = ''
      let i = 1
      while i < len(a:string)
        let char = matchstr(a:string, ".", byteidx(a:string, i))
        let result .= '\%(' . '\%(\k\*\[_\-#]\)\?' . char . '\|'
        let result .= '\k\*\%(' . char . '\&\L\)' . '\)'
        let i += len(char)
      endwhile
      let pattern .= result
    else
      let pattern .= a:string
    endif
    let pattern .= g:Cmd2__complete_end_pattern
    return pattern
  endfunction

    let g:Cmd2_options = {
          \ '_complete_ignorecase': 1,
          \ '_complete_uniq_ignorecase': 0,
          \ '_complete_pattern_func':
                \ function('s:CustomFuzzySearch'),
          \ '_complete_start_pattern':
                \ '\<\(\[agls]\:\)\?\(\k\*\[_\-#]\)\?',
          \ '_complete_fuzzy': 1,
          \ '_complete_string_pattern': '\v\k(\k|\.)*$',
          \ '_complete_loading_text': '...',
          \ }

    let g:Cmd2_cmd_mappings = {
      \ 'iw': {'command': 'iw', 'type': 'text', 'flags': 'Cpv'},
      \ 'ap': {'command': 'ap', 'type': 'line', 'flags': 'pv'},
      \ '^': {'command': '^', 'type': 'normal!', 'flags': 'r'},
      \ "CF": {'command': function('Cmd2#ext#complete#Main'),
          \ 'type': 'function'},
      \ "CB": {'command': function('Cmd2#ext#complete#Main'),
          \ 'type': 'function'},
      \ 'w': {'command': 'Cmd2#functions#Cword',
          \ 'type': 'function', 'flags': 'Cr'},
      \ }

" Python syntax highlighting improved
let python_highlight_all = 1

    cmap <C-S> <Plug>Cmd2
    cmap <expr> <Tab> Cmd2#ext#complete#InContext() ? "\<Plug>Cmd2CF" : "\<Tab>"
    cmap <expr> <S-Tab> Cmd2#ext#complete#InContext() ? "\<Plug>Cmd2CB" : "\<S-Tab>"

    set wildcharm=<Tab>

let CoVim_default_name = "Alok Singh"
let CoVim_default_port = "192.168.1.6"

" ================ Return to last edit ===========================

" Return to last edit position when opening files (You want this!)
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" ================ Misc ===========================

" read epub files in vim
au BufReadCmd *.epub call zip#Browse(expand("<amatch>"))

" Remember info about open buffers on close
set viminfo^=%

" ================ Custom Settings ========================
so ~/.yadr/vim/settings.vim
