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

function! pmv#utils#openUri(uri)
  if s:is_macunix
    call system('open ' . shellescape(a:uri))
  elseif s:is_unix
    system('xdg-open ' . shellescape(a:uri))
  endif
endfunction

let s:is_unix = has('unix')
let s:is_macunix = (has('mac') || has('macunix') || has('gui_macvim') || (!executable('xdg-open') && system('uname') =~? '^darwin'))

