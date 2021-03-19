let s:namespace_id = nvim_create_namespace('pmv-virtual-text')

scriptencoding utf-8

let s:popup_window = 0

function! pmv#utils#renderText(version, lnum) abort
  if exists('*nvim_buf_set_virtual_text')
    call nvim_buf_set_virtual_text(
                \   0,
                \   s:namespace_id,
                \   a:lnum - 1,
                \   [['#', 'Comment'],
                \    [' Last version: ' . a:version, 'NonText']],
                \   {}
                \ )
  endif
endfunction

func! pmv#utils#closePopup() abort
  if s:popup_window
    if exists('*nvim_win_close')
      call nvim_win_close(s:popup_window, 1)
    endif
    let s:popup_window = 0
    nvim_buf_clear_namespace(0, s:namespace_id, 0, -1)
  endif
endfunc

function! pmv#utils#fetchApiPackage(uri) abort
  call pmv#utils#closePopup()
  echom 'Retrieving information from: ' . a:uri
  let l:result = system(printf('curl -sS -L -i -X GET -H "Content-Cache: no-cache" "%s"', a:uri))
  let l:pos = stridx(l:result, "\r\n\r\n")
  let l:content = strpart(l:result, l:pos + 4)

  redraw!
  return webapi#json#decode(l:content)
endfunction

function! pmv#utils#renderNewPopup(input, ...) abort
  let max_width = 72
  let max_height = 16
  let width = max(map(copy(a:input), {_, v -> len(v)})) + 1
  let width = (width > max_width) ? max_width : width
  let height = len(a:input)
  let height = (height > max_height) ? max_height : height

  if exists('*nvim_open_win')
    call pmv#utils#closePopup()
    let buf = nvim_create_buf(0, 1)
    call nvim_buf_set_option(buf, 'syntax', 'versioning')
    call nvim_buf_set_lines(buf, 0, -1, 0, a:input)
    let s:popup_window = nvim_open_win(buf, v:false, {
          \ 'relative': 'cursor',
          \ 'row': 0,
          \ 'col': 0,
          \ 'width': width,
          \ 'height': height,
          \ })
    call nvim_win_set_option(s:popup_window, 'cursorline', v:false)
    call nvim_win_set_option(s:popup_window, 'foldenable', v:false)
    call nvim_win_set_option(s:popup_window, 'number', v:false)
    call nvim_win_set_option(s:popup_window, 'relativenumber', v:false)
    call nvim_win_set_option(s:popup_window, 'wrap', v:true)
    autocmd CursorMoved * ++once call pmv#utils#closePopup()
  elseif exists('*popup_create')
    let s:popup_window = popup_create(a:input, {
          \ 'line': 'cursor',
          \ 'col': 'cursor',
          \ 'maxwidth': width,
          \ 'maxheight': height,
          \ 'moved': 'any',
          \ 'zindex': 1000,
          \ })
    call setbufvar(winbufnr(s:popup_window), '&filetype', 'versioning')
  else
    return 0
  endif

  return 1
endfunction

function! pmv#utils#renderLegacyPopup(input, ...) abort
  silent keepalt belowright split markdown
  setlocal nosmartindent noautoindent noswapfile nobuflisted nospell nowrap modifiable
  setlocal buftype=nofile bufhidden=hide
  setlocal wrap
  normal! ggdG
  call setline(1, a:input)
  exec 'resize 10'
  setlocal nomodifiable filetype=versioning
  nnoremap <silent> <buffer> q :bd<CR>
endfunction

function! pmv#utils#renderPopup(input, ...) abort
  if a:0 > 0
    let info = [a:1] + a:input
  else
    let info = a:input
  endif
  if pmv#utils#renderNewPopup(info)
    return
  else
    call pmv#utils#renderLegacyPopup(info)
  endif
endfunction

function! pmv#utils#packageNotFound(package) abort
  if empty(a:package)
    redraw
    echom '>>> No package found on this line! <<<'
    return 1
  endif
  return 0
endfunction

function! pmv#utils#openUri(uri) abort
  if s:is_macunix
    call system('open ' . shellescape(a:uri))
  elseif s:is_unix
    system('xdg-open ' . shellescape(a:uri))
  endif
endfunction

let s:is_unix = has('unix')
let s:is_macunix = (has('mac') || has('macunix') || has('gui_macvim') || (!executable('xdg-open') && system('uname') =~? '^darwin'))
