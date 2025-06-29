
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
    mappings = {'<C-u>', '<C-d>', '<C-f>',
                '<C-y>', '<C-e>', 'zt', 'zz', 'zb'}
}
EOF

" -------------- ] Telescope: fuzzy search [ ----------------

lua <<EOF
require'telescope'.setup{
  defaults = {
    file_ignore_patterns = { 'node_modules' }
  }
}
EOF

" -------------- ] Markdown Preview [ ----------------

" Echo the url when the command is executed
let g:mkdp_echo_preview_url = 1

" -------------- ] Latex Preview [ ----------------
 
let g:vimtex_view_general_viewer = 'zathura'

" -------------- ] LSP [ ----------------

lua << EOF
local servers = {
	pyright = {},
	eslint = {
		codeAction = {
			disableRuleComment = {
				enable = true,
				location = "separateLine",
			},
			showDocumentation = {
				enable = true,
			},
		},
		codeActionOnSave = {
			enable = false,
			mode = "all",
		},
		format = false,
		nodePath = "",
		onIgnoredFiles = "off",
		packageManager = "npm",
		quiet = false,
		rulesCustomizations = {},
		run = "onType",
		useESLintClass = false,
		validate = "on",
		workingDirectory = {
			mode = "location",
		},
	},
	bashls = {},
	cssls = {},
	html = {},
	jsonls = {},
  ts_ls = {},
  clangd = {},
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

	-- Theme, colors and gui
	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	-- See `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

	-- Lesser used LSP functionality
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })
end

-- Use a loop to conveniently install and call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
require('mason').setup()
local mason_lspconfig = require('mason-lspconfig');
mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

local lspconfig = require("lspconfig")
for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
  lspconfig[server_name].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = servers[server_name],
  })
end
EOF

" -------------- ] Autocompletion [ ----------------

lua << EOF
-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
}
EOF

lua << EOF
require("nvim-autopairs").setup {}
EOF

" -------------- ] Linting [ ----------------

lua << EOF
local null_ls = require("null-ls");
-- LSP formatting filter
local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- Ignore formatting from these LSPs
			local lsp_formatting_denylist = {
				eslint = true,
			}
			if lsp_formatting_denylist[client.name] then
				return false
			end
			return true
		end,
		bufnr = bufnr,
	})
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
	-- you can reuse a shared lspconfig on_attach callback here
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end
	end,
	sources = {
		null_ls.builtins.formatting.prettier.with({
			extra_filetypes = { "xml", "md" },
		}),
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.djlint,
		null_ls.builtins.formatting.isort,
		null_ls.builtins.diagnostics.djlint,
		null_ls.builtins.diagnostics.pylint,
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

" -------------- ] CPP Linting [ ----------------

let g:syntastic_cpp_checkers = ['cpplint']
let g:syntastic_c_checkers = ['cpplint']
let g:syntastic_cpp_cpplint_exec = 'cpplint'
" The following two lines are optional. Configure it to your liking!
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" --------------- ] Debugger [  --------------- 

lua << EOF
require('telescope').load_extension('dap')
-- CPP/C/Rust config
local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode', -- install lldb an locate lldb-vscode, it might not be the same
  name = 'lldb'
}

local dap = require('dap')
dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- Python
local dap = require('dap')
dap.adapters.python = {
  type = 'executable';
  command = '/home/alba/.virtualenvs/debugpy/bin/python';
  args = { '-m', 'debugpy.adapter' };
}
local dap = require('dap')
dap.configurations.python = {
  {
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";
    program = "${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/bin/python'
      end
    end;
  },
}

-- Highlight colors
vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg=0, fg='#292d3e', bg='#dd92b8' })
vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg=0, fg='#292d3e', bg='#939ede' })
vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg=0, fg='#292d3e', bg='#d5dd92' })

-- Cutomize breakpoints
vim.fn.sign_define('DapBreakpoint', {text='🚩', texthl='', linehl='DapBreakpoint', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', {text='❔', texthl='DapBreakpoint', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='✖️', texthl='DapBreakpoint', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint', { text='📜', texthl='', linehl='DapLogPoint', numhl= '' })
vim.fn.sign_define('DapStopped', { text='👁️', txthl='', linehl='DapStopped', numhl='' })
EOF

" --------------- ] Debugger UI [  --------------- 

" TODO: restore this, for some reasong importing dapui gives an error
" lua << EOF
" require("dapui").setup({
"   icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
"   expand_lines = vim.fn.has("nvim-0.7"),
"   layouts = {
"     {
"       elements = {
"         "breakpoints",
"         "stacks",
"       },
"       size = 40, -- 40 columns
"       position = "left",
"     },
"     {
"       elements = {
"         "scopes",
"         "console",
"       },
"       size = 0.25, -- 25% of total lines
"       position = "bottom",
"     },
"   },
"   floating = {
"     max_height = nil, -- These can be integers or a float between 0 and 1.
"     max_width = nil, -- Floats will be treated as percentage of your screen.
"     border = "single", -- Border style. Can be "single", "double" or "rounded"
"     mappings = {
"       close = { "q", "<Esc>" },
"     },
"   },
"   windows = { indent = 1 },
"   render = {
"     max_type_length = nil, -- Can be integer or nil.
"     max_value_lines = 100, -- Can be integer or nil.
"   }
" })
" EOF

" --------------- ] Debugger Virtual Text [  --------------- 

" lua << EOF
" require("nvim-dap-virtual-text").setup {
"     enabled = true,                        -- enable this plugin (the default)
"     enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
"     highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
"     highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
"     show_stop_reason = true,               -- show stop reason when stopped for exceptions
"     commented = false,                     -- prefix virtual text with comment string
"     only_first_definition = true,          -- only show virtual text at first definition (if there are multiple)
"     all_references = false,                -- show virtual text on all all references of the variable (not only definitions)
"     filter_references_pattern = '<module', -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
"     -- experimental features:
"     virt_text_pos = 'eol',                 -- position of virtual text, see `:h nvim_buf_set_extmark()`
"     all_frames = false,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
"     virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
"     virt_text_win_col = nil                -- position the virtual text at a fixed window column (starting from the first text column) ,
"                                            -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
" }
" EOF

" --------------- ] Formatter [  --------------- 

lua << EOF
require("mason-null-ls").setup({
  ensure_installed = { "prettier" },
  automatic_installation = true,
})

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier, -- Enable Prettier
  },
  -- Format on save
  on_attach = function(current_client, bufnr)
    if current_client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            filter = function(client)
              -- only use null-ls for formatting instead of lsp server
              return client.name == "null-ls"
            end,
            bufnr = bufnr,
          })
        end,
      })
    end
  end,
})
EOF
