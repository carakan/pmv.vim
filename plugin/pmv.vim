command! -nargs=0 PmvAppendRelease call pmv#appendRelease()
nnoremap <plug>(pmv-append-release) :<c-u>PmvAppendRelease<cr>

command! -nargs=0 PmvLastRelease call pmv#lastRelease()
nnoremap <plug>(pmv-last-release) :<c-u>PmvLastRelease<cr>

command! -nargs=? PmvAllReleases call pmv#allReleases(<q-args>)
nnoremap <plug>(pmv-all-releases) :<c-u>PmvAllReleases<cr>

command! -nargs=? PmvPackageInfo call pmv#packageInfo(<q-args>)
nnoremap <plug>(pmv-package-info) :<c-u>PmvPackageInfo<cr>

command! -nargs=? PmvOpenDocs call pmv#openDocs(<q-args>)
nnoremap <plug>(pmv-open-docs) :<c-u>PmvOpenDocs<cr>

command! -nargs=? PmvOpenRepoPage call pmv#openRepoPage(<q-args>)
nnoremap <plug>(pmv-open-repo-page) :<c-u>PmvOpenRepoPage<cr>

command! -nargs=? PmvPackageSearch call pmv#packageSearch(<q-args>)
nnoremap <plug>(pmv-package-seach) :<c-u>PmvPackageSearch<cr>

function! s:register_mapping(command, shortcut, has_count)
  if a:has_count
    execute 'nnoremap <silent> <Plug>'. a:command . ' :<C-u>'. a:command . ' v:count<CR>'
  else
    execute 'nnoremap <silent> <Plug>' . a:command . ' :' . a:command . '<CR>'
  endif
  if !hasmapto('<Plug>' . a:command)
        \ && !get(g:, 'pmv_no_default_key_mappings', 0)
        \ && maparg(a:shortcut, 'n') ==# ''
    execute 'nmap ' . a:shortcut . ' <Plug>' . a:command
  endif
endfunction

call s:register_mapping('PmvLastRelease','<Leader>pm', 0)
call s:register_mapping('PmvAllReleases','<Leader>pa', 0)
call s:register_mapping('PmvAppendRelease','<Leader>pp', 0)
call s:register_mapping('PmvPackageInfo','<Leader>pi', 0)
call s:register_mapping('PmvOpenRepoPage','<Leader>po', 0)
call s:register_mapping('PmvOpenDocs','<Leader>pd', 0)
call s:register_mapping('PmvPackageSearch','<Leader>ps', 0)
