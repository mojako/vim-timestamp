" ============================================================================
" File:         plugin/timestamp.vim
" Author:       mojako <moja.ojj@gmail.com>
" URL:          https://github.com/mojako/timestamp.vim
" Last Change:  2012-06-16
" ============================================================================

scriptencoding utf-8

" g:loaded_timestamp
if exists('g:loaded_timestamp')
  finish
endif
let g:loaded_timestamp = 1

let s:cpo_save = &cpo
set cpo&vim

augroup Timestamp
  autocmd!
  autocmd BufWritePre * if &modified && changenr() |
                      \ call timestamp#overwrite() | endif
augroup END

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: set et sts=2 sw=2 wrap:
