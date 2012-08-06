" ============================================================================
" File:         plugin/timestamp.vim
" Author:       mojako <moja.ojj@gmail.com>
" URL:          https://github.com/mojako/vim-timestamp
" Last Change:  2012-06-16
" ============================================================================

" g:loaded_timestamp
if exists('g:loaded_timestamp')
  finish
endif
let g:loaded_timestamp = 1

let s:cpo_save = &cpo
set cpo&vim

if !exists('g:timestamp_auto_update')
  let g:timestamp_auto_update = 1
endif

augroup Timestamp
  autocmd!
  autocmd BufWritePre * call s:timestamp_auto_update()
augroup END

function! s:timestamp_auto_update()
  if (exists('b:timestamp_auto_update') ? b:timestamp_auto_update :
\   g:timestamp_auto_update) && &modified && changenr()
    call timestamp#replace()
  endif
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: set et sts=2 sw=2 wrap:
