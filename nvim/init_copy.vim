call plug#begin('~/.vim/plugged')
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'TaDaa/vimade'
Plug 'mcchrish/nnn.vim'
Plug 'skywind3000/asyncrun.vim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'scrooloose/nerdtree'
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
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'embear/vim-localvimrc'
Plug 'lifepillar/vim-solarized8'
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
call plug#end()

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
" let g:solarized_termtrans=1
colorscheme solarized8
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

" vim-bufferline
 let g:bufferline_echo = 0
 let g:bufferline_show_bufnr = 0

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
set nowritebackup

set fileformats=unix,dos,mac

" IndentLine
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 0
let g:indentLine_char = '┆'
let g:indentLine_faster = 1

" Indent
set tabstop=2
set softtabstop=0
set shiftwidth=2
set expandtab

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
nnoremap <leader>d :NERDTreeFind<CR>
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

" Airline
" let g:airline_theme='minimalist'
let g:airline_section_x=''
let g:airline_section_y=''
" let g:airline_section_warning=''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#ignore_bufadd_pat =
  \ 'gundo|undotree|vimfiler|tagbar|nerd_tree|startify|!'
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
set noshowmode

lua require'colorizer'.setup()

" Coc		
"		
set cmdheight=2
let g:coc_global_extensions = ['coc-snippets', 'coc-yank', 'coc-flow', 'coc-eslint', 'coc-word'		
      \, 'coc-sh']		

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" You will have bad experience for diagnostic messages when it's default 4000.		
set updatetime=300		
" don't give |ins-completion-menu| messages.		
set shortmess+=c		

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent><leader> [g <Plug>(coc-diagnostic-prev)
nmap <silent><leader> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)		
nmap <silent> gy <Plug>(coc-type-definition)		
nmap <silent> gi <Plug>(coc-implementation)		
nmap <silent> gr <Plug>(coc-references)		

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>		
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}		

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

hi illuminatedWord cterm=bold ctermfg=121 gui=bold guifg=#2aa198
imap <C-l> <Plug>(coc-snippets-expand)		

" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

" End Coc

" Switch ; and :
nnoremap ; :
nnoremap : ;

"better split movements
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

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
