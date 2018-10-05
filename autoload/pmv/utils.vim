function! pmv#utils#fetchApiPackage(uri)
  echom 'Retrieving information from: ' . a:uri
  let l:result = system(printf('curl -sS -L -i -X GET -H "Content-Cache: no-cache" "%s"', a:uri))
  let l:pos = stridx(l:result, "\r\n\r\n")
  let l:content = strpart(l:result, l:pos + 4)

  redraw!
  return webapi#json#decode(l:content)
endfunction

function! pmv#utils#render(input)
  silent keepalt belowright split markdown
  setlocal nosmartindent noautoindent noswapfile nobuflisted nospell nowrap modifiable
  setlocal buftype=nofile bufhidden=hide

  normal! ggdG
  call setline(1, a:input)

  exec 'resize 10'
  setlocal nomodifiable filetype=versioning
  nnoremap <silent> <buffer> q :bd<CR>
endfunction
