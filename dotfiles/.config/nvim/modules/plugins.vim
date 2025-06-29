
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

" Devicons
Plug 'kyazdani42/nvim-web-devicons'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'windwp/nvim-autopairs'

" Linting
Plug 'nvimtools/none-ls.nvim'
Plug 'jay-babu/mason-null-ls.nvim'

" Temas
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" File explorer
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'

" Syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'sheerun/vim-polyglot'

" Linea estado abajo
Plug 'nvim-lualine/lualine.nvim'

" Linea de identacion
Plug 'Yggdroot/indentLine'

" Github
Plug 'airblade/vim-gitgutter'
Plug 'kdheepak/lazygit.nvim'

" Tab navigation
" Plug 'romgrk/barbar.nvim'
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

" CPP Linting
Plug 'vim-syntastic/syntastic'

" CPP Clangd Format
Plug 'rhysd/vim-clang-format'

" Debugger
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'nvim-neotest/nvim-nio'
Plug 'theHamsta/nvim-dap-virtual-text'

" Tmux                                                                                                               │
Plug 'christoomey/vim-tmux-navigator'
call plug#end()
