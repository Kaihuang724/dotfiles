"=================================================================================
"general
"=================================================================================

syntax on
set ma
set autoindent
set mouse=a
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoread
set nobackup
set nowritebackup
set noswapfile
set nu
set foldlevelstart=99
set scrolloff=8
set path+=**
set hidden
set splitbelow
set splitright

"==================================================================================
"keymaps
"==================================================================================

let mapleader = "\<space>"

" leader + Q will delete all files in current buffer
nmap <leader>Q :bufdo bdelete<cr>

" Allow gf to open non-existent files
map gf: edit <cfile><cr>

" Quicker switching between windows
nmap <silent> <C-h> <C-w>h
nmap <silent> <C-j> <C-w>j
nmap <silent> <C-k> <C-w>k
nmap <silent> <C-l> <C-w>l

" Reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv

" Copy from buffer
map <Leader>y "*y
map <Leader>p "*p

"==================================================================================
"plugins
"==================================================================================

" Automatically install vim-plug if it doesn't exist
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/')

"Colour scheme
Plug 'kyoz/purify', { 'rtp': 'vim' }

"Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}

"Autocomplete plugin
"Also do :CocInstall coc-clangd coc-tsserver coc-eslint coc-json coc-prettier coc-css coc-python coc-java
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'

"Buffer navigation
Plug 'vim-airline/vim-airline'

" Autobrackets
Plug 'jiangmiao/auto-pairs'

"Telescope Requirements
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

"Telescope
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'fannheyward/telescope-coc.nvim'

"git diff
Plug 'sindrets/diffview.nvim'

"todo comments
Plug 'folke/todo-comments.nvim'

"rainbow brackets
Plug 'frazrepo/vim-rainbow'

"fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"fullstack dev
Plug 'pangloss/vim-javascript' "JS support
Plug 'leafgarland/typescript-vim' "TS support
Plug 'peitalin/vim-jsx-typescript'
Plug 'maxmellon/vim-jsx-pretty' "JS and JSX syntax
Plug 'jparise/vim-graphql' "GraphQL syntax

" markdown pages
" tabular plugin is used to format tables
Plug 'godlygeek/tabular'
" JSON front matter highlight plugin
Plug 'elzr/vim-json'
Plug 'plasticboy/vim-markdown'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

" rust support
Plug 'rust-lang/rust.vim'

" solidity support
Plug 'tomlion/vim-solidity'

" Svelte support
Plug 'othree/html5.vim'
Plug 'evanleck/vim-svelte', {'branch': 'main'}

call plug#end()

"==============================================================================
" plugin configs
"==============================================================================
" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"  " use <Tab> to trigger autocompletion
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
nmap <C-P> :FZF<CR>

" Focus and redistribute split windows
noremap ff :resize 100 <CR> <BAR> :vertical resize 220<CR>
noremap fm <C-w>=

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Buffer navigation
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'

" Rainbow brackets
let g:rainbow_active = 1

" Coc
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-css', ]

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

" Fzf
" Customize the Files command to use ripgrep which respects .gitignore files
command! -bang -nargs=? -complete=dir Files
  \ call fzf#run(fzf#wrap('files', fzf#vim#with_preview({ 'dir': <q-args>, 'sink': 'e', 'source': 'rg --files --hidden' }), <bang>0))

" Add an AllFiles variation that ignores .gitignore files
command! -bang -nargs=? -complete=dir AllFiles
  \ call fzf#run(fzf#wrap('allfiles', fzf#vim#with_preview({ 'dir': <q-args>, 'sink': 'e', 'source': 'rg --files --hidden --no-ignore' }), <bang>0))

nmap <leader>f :Files<cr>
nmap <leader>F :AllFiles<cr>
nmap <leader>h :History<cr>
nmap <leader>b :Buffers<cr>

" Go to definitions
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Vertically split screen
nnoremap <silent><leader>\ :vs<CR>

" Buffer switching
nnoremap <F5> :buffers<CR>:buffer<Space>
nmap <leader>w :bd<cr>

" Ag: Start ag in the specified directory e.g. :Ag ~/foo
function! s:ag_in(bang, ...)
    if !isdirectory(a:1)
        throw 'not a valid directory: ' .. a:1
    endif
    " Press `?' to enable preview window.
    call fzf#vim#ag(join(a:000[1:], ' '),
                \ fzf#vim#with_preview({'dir': a:1}, 'right:50%', '?'), a:bang)
endfunction

" Ag call a modified version of Ag where first arg is directory to search
command! -bang -nargs=+ -complete=dir Ag call s:ag_in(<bang>0, <f-args>)

" Svelte preprocessor
let g:svelte_preprocessors = ['typescript']

"=================================================================================
" theming
"=================================================================================
if (has("termguicolors"))
set termguicolors
endif
syntax on
colorscheme purify

"Airline theme
let g:airline_theme='purify'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#buffer_nr_show = 1
