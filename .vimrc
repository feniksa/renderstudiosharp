nnoremap <F8> :make<CR>
set makeprg=ninja\ -C\ build

nnoremap <F9> :Termdebug -cd=build/src --args ./main --n 5<CR>
set path+=src
set path+=tests

