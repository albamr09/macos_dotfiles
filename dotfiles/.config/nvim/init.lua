-----------------------------------
-- General config
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.g.mapleader = ","

-----------------------------------
-- Plugins
vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter' }
vim.pack.add { 'https://github.com/neovim/nvim-lspconfig' }
vim.pack.add { 'https://github.com/catppuccin/nvim' }
vim.pack.add { 'https://github.com/nvim-lua/plenary.nvim' }  
vim.pack.add { 'https://github.com/nvim-telescope/telescope.nvim' }
vim.pack.add { 'https://github.com/nvim-telescope/telescope-ui-select.nvim' }
vim.pack.add { 'https://github.com/kdheepak/lazygit.nvim' }
vim.pack.add { 'https://github.com/airblade/vim-gitgutter' }
vim.pack.add { 'https://github.com/windwp/nvim-autopairs' }
vim.pack.add { 'https://github.com/stevearc/oil.nvim' }
vim.pack.add { 'https://github.com/akinsho/toggleterm.nvim' }
vim.pack.add { 'https://github.com/christoomey/vim-tmux-navigator' }

-----------------------------------
-- Theme

vim.o.termguicolors = true
require("catppuccin").setup({
    flavour = "latte"
})
vim.cmd.colorscheme "catppuccin-nvim"

-----------------------------------
-- File explorer

require("oil").setup()

-----------------------------------
-- Treesitter
require('nvim-treesitter').install { 'c', 'javascript', 'jsx', 'tsx', 'typescript', 'python', 'json', 'java' }

-- Only highlight with tree-sitter
vim.cmd("syntax off")

-- Enable tree-sitter parser
vim.api.nvim_create_autocmd('FileType', {
    callback = function() pcall(vim.treesitter.start) end,
})

-----------------------------------
-- Autopairs
require("nvim-autopairs").setup()

-----------------------------------
-- Terminal

require("toggleterm").setup {
    open_mapping = [[<leader>at]],
    direction = 'float',
    float_opts = {
        border = 'curved'
    }
}

-----------------------------------
-- Git
vim.g.gitgutter_enabled = 1
vim.o.updatetime = 100

-----------------------------------
-- LSP

-- Servers
vim.lsp.enable("biome")
vim.lsp.enable("ts_ls")
vim.lsp.enable("clangd")
vim.lsp.enable("pyright")

-- Auto-complete configuration
vim.opt.completeopt = { "menu", "menuone", "fuzzy", "noinsert" }

-- Enable auto-completion and auto-formatting (see :help lsp-attach example)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

    -- Enable auto-completion for LSP client
    if client:supports_method('textDocument/completion') then
      -- Optional: trigger autocompletion on EVERY keypress. May be slow!
      local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
      client.server_capabilities.completionProvider.triggerCharacters = chars

      vim.lsp.completion.enable(true, client.id, ev.buf, {autotrigger = true})
    end

    -- Auto-format on save
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', {clear=false}),
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})

-----------------------------------
-- Search
require("telescope").setup({
  defaults = {
    file_ignore_patterns = { 'node_modules' }
  }
})

-- Integrate with LSP code actions
require("telescope").load_extension("ui-select")

-----------------------------------
-- Remaps
local builtin = require('telescope.builtin')

-- Search
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })

-- Git
vim.keymap.set('n', '<leader>gg', "<cmd>LazyGit<CR>", { desc = "Lazygit" })

-- LSP + Telescope
vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = 'Go to references' })
vim.keymap.set('n', 'gd', builtin.lsp_definitions, { desc = 'Go to definition' })
vim.keymap.set('n', 'gi', builtin.lsp_implementations, { desc = 'Go to implementation' })

-- Oil
vim.keymap.set("n", "<C-B>", "<cmd>Oil<CR>", { desc = "Open parent directory" })
