function! pmv#nodejs#utils#getPackageName(qarg)
  if empty(a:qarg)
    let l:package = s:scanForPackage()
    if pmv#utils#packageNotFound(l:package)
      return
    endif
    return l:package
  endif
  return a:qarg
endfunction

function! s:scanForPackage()
  let l:line = getline('.')
  let l:strings = split(l:line, '"')
  if len(l:strings) > 3
    let l:npm_name = tolower(l:strings[1])
    return l:npm_name
  else
    return
  endif
endfunction


function! pmv#nodejs#utils#getApiAllReleases(package)
  let l:json = pmv#nodejs#utils#getApiPackage(a:package)
  if has_key(l:json, 'versions')
    let l:format_version = 'v:val.version . "\t name: " . v:val.name'
    return reverse(sort(values(map(l:json.versions, l:format_version))))
  endif
endfunction

function! pmv#nodejs#utils#openRepoPage(package)
  let l:json = pmv#nodejs#utils#getApiPackage(a:package)
  if has_key(l:json, 'homepage')
    call pmv#utils#openUri(l:json.homepage)
  else
    redraw
    echo 'No Github link found for ' . a:package . '!'
  endif
endfunction

function! pmv#nodejs#utils#getApiPackage(package)
  let l:json = pmv#utils#fetchApiPackage('https://registry.npmjs.org/' . a:package)
  return l:json
endfunction
