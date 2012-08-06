" ============================================================================
" File:         autoload/timestamp.vim
" Author:       mojako <moja.ojj@gmail.com>
" URL:          https://github.com/mojako/vim-timestamp
" Last Change:  2012-06-17
" ============================================================================

let s:cpo_save = &cpo
set cpo&vim

if !exists('g:timestamp_prefix')
  let g:timestamp_prefix =
\   '\%(Changed\?\|Modified\|Updated\?\)\%([ -]*Date\)\?[ :]*'
endif

if !exists('g:timestamp_suffix')
  let g:timestamp_suffix = '\%(\$\|$\)'
endif

let s:V = vital#of('timestamp')
let s:dt = s:V.import('DateTime')

let s:date_formats = [
\   ['%%', '%'],
\   ['%F', '\%(19\|20\)\d\{2}-\%(0\d\|1[0-2]\)-\%([0-2]\d\|3[01]\)'],
\   ['%r', '\%(0\d\|1[0-2]\):[0-5]\d:\([0-5]\d\|60\) [AP]M'],
\   ['%T', '\%([01]\d\|2[0-4]\):[0-5]\d:\([0-5]\d\|60\)'],
\   ['%I:%M %p', '\%(0\d\|1[0-2]\):[0-5]\d [AP]M'],
\   ['%R', '\%([01]\d\|2[0-4]\):[0-5]\d'],
\   ['%z', '%T \zs[+-][01]\d\{3}'],
\   ['%A', '\%(Sun\|Mon\|Tues\|Wednes\|Thurs\|Fri\|Sat\)day'],
\   ['%a', '\%(Sun\|Mon\|Tue\|Wed\|Thu\|Fri\|Sat\)'],
\   ['%b', '\%(Jan\|Feb\|Mar\|Apr\|May\|Jun\|Jul\|Aug\|Sep\|Oct\|Nov\|Dec\)'],
\   ['%Y', '\%(19\|20\)\d\{2}'],
\   ['%d', '\%([0-2]\d\|3[01]\)\ze[ -]%b'],
\   ['%d', '%b[ -]\zs\%([0-2]\d\|3[01]\)'],
\ ]

function! timestamp#replace()
  let pat = s:getopt('prefix') . '\zs.\{-}' . s:getopt('suffix')

  let i = 1
  while i <= 20
    let line = getline(i)
    let m = match(line, pat)
    if m >= 0 && synIDattr(synID(i, m, 0), 'name') =~? 'Comment'
      let str = matchstr(line, pat)
      for fmt in s:date_formats
        let str = substitute(str, fmt[1], fmt[0], 'g')
      endfor

      let newline = substitute(line, pat, s:dt.now().format(str, 'C'), '')
      if line != newline
        call setline(i, newline)
      endif
    endif
    let i += 1
  endwhile
endfunction

function! s:getopt(optname)
  return exists('b:timestamp_{a:optname}') ?
\        b:timestamp_{a:optname} : g:timestamp_{a:optname}
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: set et sts=2 sw=2 wrap:
