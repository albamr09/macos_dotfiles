
"---------------------------------------------------------------------------------------
" _____ ______   ________  ________  ________  ___  ________   ________  ________      
"|\   _ \  _   \|\   __  \|\   __  \|\   __  \|\  \|\   ___  \|\   ____\|\   ____\     
"\ \  \\\__\ \  \ \  \|\  \ \  \|\  \ \  \|\  \ \  \ \  \\ \  \ \  \___|\ \  \___|_    
" \ \  \\|__| \  \ \   __  \ \   ____\ \   ____\ \  \ \  \\ \  \ \  \  __\ \_____  \   
"  \ \  \    \ \  \ \  \ \  \ \  \___|\ \  \___|\ \  \ \  \\ \  \ \  \|\  \|____|\  \  
"   \ \__\    \ \__\ \__\ \__\ \__\    \ \__\    \ \__\ \__\\ \__\ \_______\____\_\  \ 
"    \|__|     \|__|\|__|\|__|\|__|     \|__|     \|__|\|__| \|__|\|_______|\_________\
"                                                                          \|_________|
"---------------------------------------------------------------------------------------

" Map leader to ,
let mapleader=','


" --------------- ] File Explorer [  --------------- 

" Toggle
nnoremap <silent> <C-b> :call NERDTreeToggleAndRefresh()<CR>

" Toggle and refresh
function NERDTreeToggleAndRefresh()
  :NERDTreeToggle
  if g:NERDTree.IsOpen()
    :NERDTreeRefreshRoot
  endif
endfunction

" -------------- ] Integrated Terminal [ ----------------

" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://bash
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

" -------------- ] Switching between panels [ ----------------

" use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" -------------- ] Cambiar tamaño splits [ ----------------

nnoremap <Left> :vertical resize +5 <CR>
nnoremap <Right> :vertical resize -5 <CR>
nnoremap <Down> :resize +5 <CR>
nnoremap <Up> :resize -5 <CR>

" -------------- ] File search [ ----------------

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fs <cmd>Telescope live_grep<cr>
nnoremap <leader>fg <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Integration with dap
nnoremap <leader>fdc <cmd>Telescope dap commands<cr>
nnoremap <leader>fdb <cmd>Telescope dap list_breakpoints<cr>
nnoremap <leader>fdv <cmd>Telescope dap variables<cr>
nnoremap <leader>fdf <cmd>Telescope dap frames<cr>

" -------------- ] Markdown Preview [ ----------------

" Open preview
nmap <C-s> <Plug>MarkdownPreview        

" -------------- ] Toggle spell check [ ----------------

nnoremap <silent> <F11> :set spell!<cr>
inoremap <silent> <F11> <C-O>:set spell!<cr>

" -------------- ] Floating Term [ ----------------

nnoremap <Leader>at :FloatermToggle<CR>

" -------------- ] CPP Clangd Format [ ----------------

nnoremap <Leader>f :<C-u>ClangFormat<CR>

" -------------- ] Debugger [ ----------------
" To start debugging
nnoremap <silent> <Leader>ds <Cmd>lua require'dap'.continue()<CR>
" To stop debugging
nnoremap <silent> <Leader>dc <Cmd>lua require'dap'.close()<CR>
" To debug
nnoremap <silent> <Leader>do <Cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <Leader>di <Cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <Leader>dso <Cmd>lua require'dap'.step_out()<CR>
nnoremap <silent> <Leader>db <Cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <Leader>dB <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <Leader>dlp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>

" -------------- ] Debugger UI [ ----------------

nnoremap <silent> <Leader>dut <Cmd>lua require'dapui'.toggle()<CR>

" -------------- ] Lazygit [ ----------------

nnoremap <silent> <leader>gg :LazyGit<CR>
