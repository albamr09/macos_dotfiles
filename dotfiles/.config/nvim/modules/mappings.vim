
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

" -------------- ] Markdown Preview [ ----------------

" Open preview
nmap <C-s> <Plug>MarkdownPreview        

" -------------- ] Toggle spell check [ ----------------

nnoremap <silent> <F11> :set spell!<cr>
inoremap <silent> <F11> <C-O>:set spell!<cr>

" -------------- ] Floating Term [ ----------------

nnoremap <Leader>at :FloatermToggle<CR>

" -------------- ] Lazygit [ ----------------

nnoremap <silent> <leader>gg :LazyGit<CR>
