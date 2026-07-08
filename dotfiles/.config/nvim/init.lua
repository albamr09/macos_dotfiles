---@diagnostic disable: undefined-global avoid vim definition warnings

-----------------------------------
-- General Settings
-----------------------------------
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.g.mapleader = ","
vim.opt.completeopt = { "menu", "menuone", "fuzzy", "noinsert" }

-----------------------------------
-- Plugins
-----------------------------------
vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter' }
vim.pack.add { 'https://github.com/neovim/nvim-lspconfig' }
vim.pack.add { 'https://github.com/mason-org/mason.nvim' }
vim.pack.add { 'https://github.com/mason-org/mason-lspconfig.nvim' }
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
-----------------------------------
vim.o.termguicolors = true
require("catppuccin").setup({
    flavour = "latte"
})
vim.cmd.colorscheme "catppuccin-nvim"

-----------------------------------
-- File Explorer
-----------------------------------
require("oil").setup({
    -- Set to true to watch the filesystem for changes and reload oil
    watch_for_changes = true,
    view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
    }
})

-----------------------------------
-- Treesitter
-----------------------------------
require('nvim-treesitter').install { 'c', 'javascript', 'jsx', 'tsx', 'typescript', 'python', 'json', 'java', 'xml', 'html', 'lua', 'bash', 'dockerfile', 'cpp' }

-- Only highlight with tree-sitter
vim.cmd("syntax off")

-- Enable tree-sitter parser
vim.api.nvim_create_autocmd('FileType', {
    callback = function() pcall(vim.treesitter.start) end,
})

-----------------------------------
-- Autopairs
-----------------------------------
require("nvim-autopairs").setup()

-----------------------------------
-- Terminal (toggleterm.nvim)
-----------------------------------
require("toggleterm").setup {
    open_mapping = [[<leader>at]],
    direction = 'float',
    float_opts = {
        border = 'curved'
    }
}

-----------------------------------
-- Git
-----------------------------------
vim.g.gitgutter_enabled = 1
vim.o.updatetime = 100

-----------------------------------
-- LSP
-----------------------------------

-- Servers
local servers = {
    "ts_ls",
    "biome",
    "oxlint",
    "clangd",
    "pyright",
    "lua_ls",
}

-- Mason (server manager)
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = servers,
})

-- Server set up
vim.lsp.config('biome', {
    root_markers = { 'biome.json' },
})
vim.lsp.config('oxlint', {
    root_markers = { '.oxlintrc.json' },
})
vim.lsp.enable(servers)


-- LSP callback helpers
local function global_code_action()
    vim.lsp.buf.code_action({ context = { only = { "source", "source.fixAll", "source.organizeImports" } }, range = nil })
end

local function lsp_format(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()

    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    local client_names = vim.tbl_map(function(c)
        return c.name
    end, clients)

    vim.lsp.buf.format({
        bufnr = bufnr,
        filter = function(client)
            if client.name == "biome" then
                return true
            end

            -- Prioritize biome over ts
            if client.name == "ts_ls" then
                return not vim.tbl_contains(client_names, "biome")
            end

            -- Allow every other formatter (clangd, lua_ls, etc.)
            return true
        end,
    })
end

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

            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end

        -- Auto-format on save
        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
                buffer = ev.buf,
                callback = function()
                    lsp_format(ev.buf)
                end,
            })
        end
    end,
})

-----------------------------------
-- Search (telescope.nvim)
-----------------------------------
require("telescope").setup({
    defaults = {
        file_ignore_patterns = { 'node_modules' }
    }
})

-- Integrate with LSP code actions
require("telescope").load_extension("ui-select")

-----------------------------------
-- Remaps
-----------------------------------
local builtin = require('telescope.builtin')

-- Search
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })

-- Git
vim.keymap.set('n', '<leader>gg', "<cmd>LazyGit<CR>", { desc = "Lazygit" })

-- LSP
vim.keymap.set('n', '<leader>f', lsp_format, { desc = 'Format' })
vim.keymap.set('n', 'grA', global_code_action, { desc = 'Global code action' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })

-- LSP + Telescope
vim.keymap.set('n', 'grr', builtin.lsp_references, { desc = 'Go to references' })
vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { desc = 'List document symbols in the current buffer' })

-- Oil
vim.keymap.set("n", "<C-B>", "<cmd>Oil<CR>", { desc = "Open parent directory" })
