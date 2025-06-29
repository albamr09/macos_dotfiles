" --------------------------------------------------------------------------------------------------
"
" ________  ________  _____ ______   _____ ______   ________  ________   ________  ________      
"|\   ____\|\   __  \|\   _ \  _   \|\   _ \  _   \|\   __  \|\   ___  \|\   ___ \|\   ____\     
"\ \  \___|\ \  \|\  \ \  \\\__\ \  \ \  \\\__\ \  \ \  \|\  \ \  \\ \  \ \  \_|\ \ \  \___|_    
" \ \  \    \ \  \\\  \ \  \\|__| \  \ \  \\|__| \  \ \   __  \ \  \\ \  \ \  \ \\ \ \_____  \   
"  \ \  \____\ \  \\\  \ \  \    \ \  \ \  \    \ \  \ \  \ \  \ \  \\ \  \ \  \_\\ \|____|\  \  
"   \ \_______\ \_______\ \__\    \ \__\ \__\    \ \__\ \__\ \__\ \__\\ \__\ \_______\____\_\  \ 
"    \|_______|\|_______|\|__|     \|__|\|__|     \|__|\|__|\|__|\|__| \|__|\|_______|\_________\
"                                                                                    \|_________|
"
" --------------------------------------------------------------------------------------------------
"
" --------------- ] Commands [  --------------- 

" Explanation
" 
" - autocmd: command that Vim will execute automatically on {event} 
"             (here: if you open a python file)
" - [i]map: creates a keyboard shortcut to <F9> in insert/normal mode
" - <buffer>: If multiple buffers/files are open: just use the active one
" - <esc>: leaving insert mode
" - :w<CR>: saves your file
" - !: runs the following command in your shell (try :!ls)
" - %: is replaced by the filename of your active buffer. But since it can 
"       contain things like whitespace and other "bad" stuff it is better practise 
"       not to write :python %, but use:
" - shellescape: escape the special characters. The 1 means with a backslash
"
" The first line will work in normal mode and once you press <F9> 
" it first saves your file and then run the file with python. The 
" second does the same thing, but leaves insert mode first


" Execute racket
autocmd FileType scheme,racket map <buffer> <F9> :w<CR>:exec '!racket' shellescape(@%, 1)<CR>
autocmd FileType scheme,racket imap <buffer> <F9> <esc>:w<CR>:exec '!racket' shellescape(@%, 1)<CR>

" Execute bash
autocmd FileType sh map <buffer> <F9> :w<CR>:exec '!bash' shellescape(@%, 1)<CR>
autocmd FileType sh imap <buffer> <F9> <esc>:w<CR>:exec '!bash' shellescape(@%, 1)<CR>
