call plug#begin('~/.vim/plugged')
Plug 'folke/which-key.nvim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'TaDaa/vimade'
Plug 'mcchrish/nnn.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'junegunn/fzf', { 'do': './install --all' } | Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/indentLine'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'edkolev/tmuxline.vim'
Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'tomasr/molokai'
Plug 'iberianpig/tig-explorer.vim'
Plug 'ledger/vim-ledger'
Plug 'machakann/vim-highlightedyank'
Plug 'junegunn/vim-peekaboo'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'amiorin/ctrlp-z'
Plug 'tpope/vim-surround'
Plug 'thaerkh/vim-workspace'
Plug 'tpope/vim-repeat'
Plug 'simnalamburt/vim-mundo'
Plug 'haya14busa/vim-keeppad'
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'embear/vim-localvimrc'
Plug 'lifepillar/vim-solarized8'
Plug 'danilo-augusto/vim-afterglow'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'leafgarland/typescript-vim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'lambdalisue/suda.vim'
Plug 'chrisbra/SudoEdit.vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'jparise/vim-graphql'
Plug 'yardnsm/vim-import-cost', { 'do': 'npm install' }
Plug 'mvpopuk/inspired-github.vim'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }
Plug 'phaazon/hop.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'tpope/vim-commentary'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
call plug#end()

set shell=/usr/bin/zsh

lua require'hop'.setup()
lua << EOF
	vim.keymap.set("n", "zl", "<cmd>HopLineStart<cr>", { noremap = true, silent = true })
	vim.keymap.set("n", "zw", "<cmd>HopWord<cr>", { noremap = true, silent = true })

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "lua", "javascript", "typescript", "tsx" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = {},

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = {},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require'nvim-treesitter.configs'.setup {
  context_commentstring = {
    enable = true
  }
}
EOF

" CtrlpZ, fasd intergration
let g:ctrlp_map = ''
let g:ctrlp_extensions = ['Z']

let g:localvimrc_enable=1

" vim-workspace
let g:workspace_session_name = '.session.vim'
let g:workspace_autosave = 0

nnoremap <leader>n :NnnPicker %:p:h<CR>

command! -nargs=* Z :call Z(<f-args>)
function! Z(...)
  let cmd = 'fasd -d -e printf'
  for arg in a:000
    let cmd = cmd . ' ' . arg
  endfor
  let path = system(cmd)
  if isdirectory(path)
    echo path
    exec 'cd' fnameescape(path)
  endif
endfunction

" Colors
set number relativenumber
syntax enable
set background=dark
set termguicolors
set cursorline
if exists('g:GuiLoaded')
  Guifont! Iosevka:h13
endif

augroup TerminalStuff
    au!
    autocmd TermOpen * nnoremap <buffer> <A-q> <Esc>:bdelete!<CR>
    autocmd BufWinEnter,WinEnter * if &buftype == 'terminal' | silent! normal i | endif
    autocmd TermOpen * setlocal nonumber norelativenumber noshowcmd noruler nospell
    autocmd TermOpen * echo ""
augroup END


" Other
filetype plugin indent on
set autowrite
set spell

if has('nvim')
  let $VISUAL = 'nvr -cc split --remote-wait'
endif

" Cd to current file directory
command CDC cd %:p:h


set termguicolors
lua << EOF
	require("bufferline").setup{}
EOF

" Color terminal curser
" :hi! TermCursorNC ctermfg=15 guifg=#fdf6e3 ctermbg=14 guibg=#93a1a1 cterm=NONE gui=NONE

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Directories for swp files
set nobackup
set noswapfile

set fileformats=unix,dos,mac

" IndentLine
" is used for code indented with spaces
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 0
let g:indentLine_char = '▏'
let g:indentLine_faster = 1
" is used for code indented with tabs
set list
set list listchars=tab:❘⠀,extends:»,precedes:«,nbsp:×

" Indent
set autoindent
set tabstop=4
set softtabstop=0
set shiftwidth=4
" use spaces instead of tabs
" set expandtab
" use tabs instead of spaces
set noexpandtab

" Mouse integration
set mousemodel=popup
set mouse=a

" Maps
let mapleader = " "
nmap <S-w> :w<CR>
nmap <S-q> :w<CR>:bd<CR>
nmap <leader>1 :on<CR>
inoremap jj <Esc>

" fzf
cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <silent> <leader>b :Buffers<CR>
nmap <leader>o ;History<CR>
nmap <leader>p ;GFiles<CR>
nmap <C-p> ;GFiles<CR>
nmap <leader>/ ;Rg<CR>
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
nmap <leader><leader> :Commands<CR>
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__

" Hide statusline in fzf
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" File manager
" nnoremap <leader>d :Ranger<CR>
nnoremap <leader>d :NvimTreeFindFile<CR>
" let g:ranger_replace_netrw = 1

" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

" vim-javascript
let g:jsx_ext_required = 0
" let g:javascript_plugin_flow = 1

" Navigation
nnoremap <A-j> <C-w>h
nnoremap <A-k> <C-w>l
" nnoremap <A-j> <C-w>j
" nnoremap <A-k> <C-w>k
inoremap <A-q> <Esc>:bdelete<CR>
nnoremap <A-q> <Esc>:bdelete<CR>
nnoremap <leader><tab> :b#<cr>
nnoremap <A-l> :bnext<CR>
nnoremap <A-h> :bprev<CR>

" Tig
if has('nvim')
  nnoremap <leader>gs :Tig<cr>
else
  nmap <leader>gs :!tig status<cr>
endif

" Nvim specific
if has('nvim')
  set inccommand=nosplit
endif

" Teminal mode, make it like tmux
if has('nvim')
  nnoremap <A-n> :terminal<CR>i
  inoremap <A-h> <C-\><C-N><C-w>h
  inoremap <A-j> <C-\><C-N><C-w>j
  inoremap <A-k> <C-\><C-N><C-w>k
  inoremap <A-l> <C-\><C-N><C-w>l
  tnoremap <Esc><Esc> <C-\><C-n>
  " tnoremap <M-[> <Esc>
  " tnoremap <C-v><Esc> <Esc>
  tnoremap <A-h> <C-\><C-N><C-w>h
  tnoremap <A-j> <C-\><C-N><C-w>j
  tnoremap <A-k> <C-\><C-N><C-w>k
  tnoremap <A-l> <C-\><C-N><C-w>l
  tnoremap <A-l> <C-\><C-n>:bnext<CR>
  tnoremap <A-h> <C-\><C-n>:bprev<CR>
  tnoremap <A-q> <C-\><C-n>:bdelete!<CR>
  tnoremap <A-n> <C-\><C-n>:terminal<CR>i
endif


" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev z Z
cnoreabbrev j Z
cnoreabbrev Qall qall

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

" Clipboard
noremap <C-c> "+y<CR>
inoremap <C-v> <Esc>l"+gPa

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" " Airline
" " let g:airline_theme='minimalist'
" let g:airline_section_x=''
" let g:airline_section_y=''
" " let g:airline_section_warning=''
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#ignore_bufadd_pat =
"   \ 'gundo|undotree|vimfiler|tagbar|nerd_tree|startify|!'
" let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
" let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
set noshowmode

lua require'colorizer'.setup()
" lualine config
lua require('bubbles')
lua require('nvim-tree-config')

	" coc		
"		
let g:coc_global_extensions = ['coc-snippets', 'coc-yank', 'coc-eslint'
      \, 'coc-sh', 'coc-tsserver', 'coc-tabnine']		
" Use tab for trigger completion with characters ahead and navigate.		
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.		
inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

" use <c-space>for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
function! s:check_back_space() abort		
  let col = col('.') - 1		
  return !col || getline('.')[col - 1]  =~# '\s'		
endfunction		
" You will have bad experience for diagnostic messages when it's default 4000.		
set updatetime=300		
" don't give |ins-completion-menu| messages.		
set shortmess+=c		
" always show signcolumns		
set signcolumn=yes		
function! s:show_documentation()		
  if &filetype == 'vim'		
    execute 'h '.expand('<cword>')		
  else		
    call CocActionAsync('doHover')		
  endif		
endfunction		
nnoremap <silent> K :call <SID>show_documentation()<CR>		

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

nmap <silent> gd <Plug>(coc-definition)		
nmap <silent> gy <Plug>(coc-type-definition)		
nmap <silent> gi <Plug>(coc-implementation)		
nmap <silent> gr <Plug>(coc-references)		
imap <C-l> <Plug>(coc-snippets-expand)		
nmap <silent> <leader>ep <Plug>(coc-diagnostic-prev)		
nmap <silent> <leader>en <Plug>(coc-diagnostic-next)		
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}		
hi illuminatedWord cterm=bold ctermfg=121 gui=bold guifg=#2aa198

" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a ;<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a ;<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

" vmap <leader>a ;CocCommad actions.open<CR>
" nmap <leader>a ;CocCommand actions.open<CR>

" End Coc

" Switch ; and :
nnoremap ; :
nnoremap : ;

"better split movements
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"resize splits
:nnoremap <leader><C-J> :resize -10<CR>
:nnoremap <leader><C-K> :resize +10<CR>
:nnoremap <leader><C-L> :vertical resize +10<CR>
:nnoremap <leader><C-H> :vertical resize -10<CR>

" move lines up or down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

"move vertically by visual line
nnoremap j gj
nnoremap k gk

augroup import_cost_auto_run
  autocmd!
  autocmd InsertLeave *.js,*.jsx,*.ts,*.tsx ImportCost
  autocmd BufEnter *.js,*.jsx,*.ts,*.tsx ImportCost
  autocmd CursorHold *.js,*.jsx,*.ts,*.tsx ImportCost
augroup END


" ledger shortcuts
autocmd FileType ledger inoremap <leader>ld <C-O>:call ledger#transaction_date_set(line('.'), 'primary')<Cr><END>

" apply LedgerAlignBuffer on save ledger file
autocmd BufWritePost *.ledger :LedgerAlignBuffer

" replace spaces with tabs for config files
" autocmd BufWritePost *.json,*rc silent! %s/\(^\s*\)\@<=    /\t/g

set timeoutlen=300

lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF
