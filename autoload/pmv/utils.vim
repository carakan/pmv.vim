let s:window = 0

func! pmv#utils#closePopup()
    if s:window
        let id = win_id2win(s:window)
        if id > 0
            execute id . 'close!'
        endif
        let s:window = 0
    endif
endfunc

function! pmv#utils#fetchApiPackage(uri)
  call pmv#utils#closePopup()
  echom 'Retrieving information from: ' . a:uri
  let l:result = system(printf('curl -sS -L -i -X GET -H "Content-Cache: no-cache" "%s"', a:uri))
  let l:pos = stridx(l:result, "\r\n\r\n")
  let l:content = strpart(l:result, l:pos + 4)

  redraw!
  return webapi#json#decode(l:content)
endfunction

function! pmv#utils#renderPopup(input, ...)
  call pmv#utils#closePopup()
  let s:buf = nvim_create_buf(0, 1)
  call nvim_buf_set_lines(s:buf, 0, -1, 0, a:input)
  let s:window = call('nvim_open_win', [s:buf, v:false, {
          \ 'relative': 'cursor',
          \ 'row': 0,
          \ 'col': 0,
          \   'width': 80,
          \   'height': 20,
          \ }])
endfunction

function! pmv#utils#packageNotFound(package)
  if empty(a:package)
    redraw
    echom '>>> No package found on this line! <<<'
    return 1
  endif
  return 0
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
