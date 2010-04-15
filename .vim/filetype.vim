augroup filetypedetect
    autocmd BufRead,BufNewFile *.wiki setfiletype Wikipedia
    autocmd BufRead,BufNewFile *.wikipedia.org* setfiletype Wikipedia
augroup END
