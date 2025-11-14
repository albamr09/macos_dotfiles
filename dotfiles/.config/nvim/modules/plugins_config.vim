
"---------------------------------------------------------------
" ________  ________  ________   ________ ___  ________     
"|\   ____\|\   __  \|\   ___  \|\  _____\\  \|\   ____\    
"\ \  \___|\ \  \|\  \ \  \\ \  \ \  \__/\ \  \ \  \___|    
" \ \  \    \ \  \\\  \ \  \\ \  \ \   __\\ \  \ \  \  ___  
"  \ \  \____\ \  \\\  \ \  \\ \  \ \  \_| \ \  \ \  \|\  \ 
"   \ \_______\ \_______\ \__\\ \__\ \__\   \ \__\ \_______\
"    \|_______|\|_______|\|__| \|__|\|__|    \|__|\|_______|
"
"---------------------------------------------------------------

" --------------- ] File Explorer [  --------------- 

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Git status
let g:NERDTreeGitStatusUseNerdFonts = 1

" ------------------ ] Tree Sitter [ --------------------

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    "javascript",
    "json",
    "html",
    "scss",
    "cpp",
    "python",
    "java",
    "c",
    "rust",
    "bash",
    "latex",
    "make",
    "dockerfile",
    "cmake",
    "r",
    "typescript",
    "tsx",
    "ruby",
    "kotlin",
    "c_sharp",
    "markdown",
    "markdown_inline"
  },
}
EOF

" -------------- ] Integrated Terminal [ ----------------

" open new split panes to right and below
set splitright
set splitbelow

" -------------- ] Lualine [ -----------------
 
lua << EOF
require'lualine'.setup{
  options = { theme  = "catppuccin" },
}
EOF

" -------------- ] Linea identacion [ ----------------

" No mostrar en ciertos tipos de buffers y archivos
" Avoid conceallevel problem (e.g. not showing links)
let g:indentLine_fileTypeExclude = ['text', 'sh', 'help', 'terminal', 'json', 'vimwiki', 'markdown', 'tex']
let g:indentLine_bufNameExclude = ['NERD_tree.*', 'term:.*']

" -------------- ] Git update time [ ----------------

set updatetime=100

" -------------- ] Smooth Scroll [ ----------------

lua <<EOF
require'neoscroll'.setup {
    mappings = {'<C-u>', '<C-d>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb'}
}
EOF

" -------------- ] Telescope: fuzzy search [ ----------------

lua <<EOF
require'telescope'.setup{
  defaults = {
    file_ignore_patterns = { 'node_modules' }
  }
}

-- Integrate lsp code-actions
require"telescope".load_extension("ui-select")
EOF

" -------------- ] Markdown Preview [ ----------------

" Echo the url when the command is executed
let g:mkdp_echo_preview_url = 1

" -------------- ] Latex Preview [ ----------------
 
let g:vimtex_view_general_viewer = 'zathura'

" -------------- ] LSP [ ----------------

lua << EOF

local mason_lspconfig = require('mason-lspconfig');
local lspconfig = require("lspconfig")

local servers = {
  -- Python
	pyright = {},
  -- TS/JS
  -- We keep it here to ensure it is installed
  ts_ls = {},
  biome = {
    -- Attach only to biome configuration (if this does not exist LSP does not start)
    root_dir = function(fname)
      return lspconfig.util.root_pattern("biome.json")(fname)
    end,
    -- Allows biome to act as proxy for LSP functionality and fallback onto ts_ls (so it is important to keep ts_ls as a server)
    -- If you do not include this lspconfig will fail when calling setup
    cmd = { "biome", "lsp-proxy" },
  },
  eslint = {
    -- Attach only to eslint configuration (if this does not exist LSP does not start)
    root_dir = function(fname)
      return lspconfig.util.root_pattern(".eslintrc.js", ".eslintrc.json", ".eslintrc.cjs", "eslint.config.js")(fname)
    end,
	},
  -- Bash
	bashls = {},
  -- CSS
	cssls = {},
  -- HTML
	html = {},
  -- JSON
	jsonls = {},
  -- C/C++
  clangd = {},
  -- Markdown
  marksman = {},
  -- Latex
  ltex = {},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

  -- Formatting function
  local function lsp_format()
    vim.lsp.buf.format({
      filter = function(client)
        -- Get all clients attached to current buffer
        local clients = vim.lsp.get_clients({bufnr = bufnr})
        local client_names = vim.tbl_map(function(c) return c.name end, clients)
        
        -- Prioritize biome/eslint over ts_ls
        return client.name == "biome"
            or client.name == "eslint"
            or (client.name == "ts_ls" 
                and not vim.tbl_contains(client_names, "biome") 
                and not vim.tbl_contains(client_names, "eslint"))
      end,
      bufnr = bufnr,
    })
  end

  -- Wrapper to include source-level code actions
  local function code_actions_with_source_whole_file()
    vim.lsp.buf.code_action({
      context = {
        -- Include source actions
        only = {
          "source",               
          "source.fixAll",       
          "source.organizeImports",
        }
      },
      -- Apply to whole file
      range = nil
    })
  end

  ------------------------
  -- ACTIONS
  ------------------------
	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
  nmap("<leader>cA", code_actions_with_source_whole_file, "[C]ode [A]ction (whole file)")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")
  nmap("<leader>f", lsp_format, "[F]ormat buffer with LSP")

  ------------------------
  -- MOTIONS
  ------------------------
	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

  ------------------------
  -- Diagnostics
  ------------------------
  nmap('<leader>do', vim.diagnostic.open_float, "[D]iagnostic [O]pen")
  nmap('<leader>dp', vim.diagnostic.goto_prev, "[D]iagnostic [P]revious")
  nmap('<leader>dn', vim.diagnostic.goto_next, "[D]iagnostic [N]ext")

  ------------------------
  -- DOC
  ------------------------
	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

  ------------------------
  -- Automatic actions
  ------------------------
  -- Autoformat on save
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("LspFormat", { clear = true }),
    buffer = bufnr,
    callback = lsp_format,
  })

  -- Biome fixAll on save
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("BiomeFixAll", { clear = true }),
    buffer = bufnr,
    callback = function()
      local clients = vim.lsp.get_clients({ name = "biome", buf = bufnr })
      if #clients == 0 then return end
      vim.lsp.buf.code_action({ 
        -- Execute fixAll code action
        context = { only = { "source.fixAll.biome" } },  
        -- Apply without user query
        apply = true
      })
    end,
  })
end

require('mason').setup()
mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})

-- Attach servers
for server_name, server_opts in pairs(servers) do
  if server_name == "ts_ls" then
    -- For typescript-language-server, avoid duplicate servers attaches
    -- We do not attach the server manually, as it somehow auto-attaches by itself
    goto continue
  end
  lspconfig[server_name].setup(vim.tbl_deep_extend("force", {
    on_attach = on_attach,
    capabilities = capabilities,
  }, server_opts))
  ::continue::
end


EOF

" -------------- ] Autocompletion [ ----------------

lua << EOF
local cmp = require 'cmp'

cmp.setup {
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
    },
}
EOF

" -------------- ] Autopairs [ ----------------

lua << EOF
require("nvim-autopairs").setup {}
EOF

" -------------- ] Formatting [ ----------------
"
"  Define formatting using servers/sources not provided by lsp 
"  (e.g. prettier) by creating a "dummy" lsp server
"

lua << EOF
local null_ls = require("null-ls");

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
          vim.lsp.buf.format()
				end,
			})
		end
	end,
	sources = {
    -- Prettier
    null_ls.builtins.formatting.prettier.with({
			filetypes = { "markdown", "xml", "yaml" },
      prefer_local = "node_modules/.bin",
		}),
    null_ls.builtins.formatting.black
	},
})
EOF

" -------------- ] Floating Term [ ----------------

let g:floaterm_title=''
let g:floaterm_autoinsert=1
let g:floaterm_width=0.7
let g:floaterm_height=0.7
let g:floaterm_wintitle=0
let g:floaterm_autoclose=2
let g:floaterm_borderchars = "─│─│╭╮╯╰"

" Set floaterm window's background to black
" hi Floaterm guibg=black
" Set floating window border line color to cyan, and background to orange
hi FloatermBorder guifg=white
