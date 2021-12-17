"=================================================================================
"general
"=================================================================================

syntax on
set ma
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
set scrolloff=7

"==================================================================================
"plugins
"==================================================================================

call plug#begin('~/.config/nvim/autoload/')

"Colour scheme
" My fave colour schemes:
" dracula/dracula-theme, rakr/vim-one, gosukiwi/vim-atom-dark,
" phanviet/vim-monokai-pro rhysd/vim-color-spring-night arzg/vim-colors-xcode
" Plug 'jonathanfilip/vim-lucius'
" Plug 'sonph/onehalf', { 'rtp': 'vim' }
" Plug 'dracula/vim',{'name':'dracula'}
" Plug 'tyrannicaltoucan/vim-quantum'
" Plug 'dikiaap/minimalist'
" Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'kyoz/purify', { 'rtp': 'vim' }

"Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}

"Autocomplete plugin
"Also do :CocInstall coc-clangd coc-tsserver coc-eslint coc-json coc-prettier coc-css coc-python coc-java 
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"Language packs
" Plug 'sheerun/vim-polyglot'

"Nvim motions
Plug 'phaazon/hop.nvim'

"Buffer navigation
Plug 'vim-airline/vim-airline'

"Grammar checking because I can't english
Plug 'rhysd/vim-grammarous'

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

"magit
Plug 'TimUntersberger/neogit'

"todo comments
Plug 'folke/todo-comments.nvim'

"devicons
Plug 'kyazdani42/nvim-web-devicons'

"rainbow brackets
Plug 'frazrepo/vim-rainbow'

"fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"fullstack dev
Plug 'pangloss/vim-javascript' "JS support
Plug 'leafgarland/typescript-vim' "TS support
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'maxmellon/vim-jsx-pretty' "JS and JSX syntax
Plug 'jparise/vim-graphql' "GraphQL syntax
Plug 'mattn/emmet-vim'

call plug#end()

"==============================================================================
" plugin configs
"==============================================================================

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
  \ 'coc-tsserver'
  \ ]

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

" Fzf
nnoremap <expr> <C-p> (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"

" Buffer switching
nnoremap <F5> :buffers<CR>:buffer<Space>

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
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
