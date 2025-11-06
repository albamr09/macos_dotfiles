
"------------------------------------------------------------------------------
" ________  ___       ___  ___  ________  ___  ________   ________      
"|\   __  \|\  \     |\  \|\  \|\   ____\|\  \|\   ___  \|\   ____\     
"\ \  \|\  \ \  \    \ \  \\\  \ \  \___|\ \  \ \  \\ \  \ \  \___|_    
" \ \   ____\ \  \    \ \  \\\  \ \  \  __\ \  \ \  \\ \  \ \_____  \   
"  \ \  \___|\ \  \____\ \  \\\  \ \  \|\  \ \  \ \  \\ \  \|____|\  \  
"   \ \__\    \ \_______\ \_______\ \_______\ \__\ \__\\ \__\____\_\  \ 
"    \|__|     \|_______|\|_______|\|_______|\|__|\|__| \|__|\_________\
"                                                           \|_________|
"
"------------------------------------------------------------------------------


call plug#begin('~/.vim/plugged')

" Icons
Plug 'kyazdani42/nvim-web-devicons'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'windwp/nvim-autopairs'


" Custom formatting
Plug 'nvimtools/none-ls.nvim'
Plug 'nvimtools/none-ls-extras.nvim'

" Theme
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" File explorer
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'

" Syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Bottom status bar
Plug 'nvim-lualine/lualine.nvim'

" Indentation indicators
Plug 'Yggdroot/indentLine'

" Github
Plug 'airblade/vim-gitgutter'
Plug 'kdheepak/lazygit.nvim'
Plug 'f-person/git-blame.nvim'

" Tab navigation
Plug 'Xuyuanp/nerdtree-git-plugin'

" Scroll
Plug 'karb94/neoscroll.nvim'

" File search
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Smooth scrolling
Plug 'karb94/neoscroll.nvim'

" Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }

" Latex
Plug 'lervag/vimtex'

" Floating term
Plug 'voldikss/vim-floaterm'

" Tmux
Plug 'christoomey/vim-tmux-navigator'
call plug#end()
