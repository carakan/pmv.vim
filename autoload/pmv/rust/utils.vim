function! pmv#rust#utils#getPackageName(qarg)
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
  let l:strings = split(l:line, '=')
  if len(l:strings) == 2
    let l:name = tolower(trim(l:strings[0]))
    return l:name
  else
    return
  endif
endfunction

function! pmv#rust#utils#getApiAllReleases(package)
  let l:json = pmv#rust#utils#getApiPackage(a:package)
  if has_key(l:json, 'versions')
    let l:format_version = 'v:val.num . "\t link: " . v:val.dl_path'
    return map(l:json.versions, l:format_version)
  endif
endfunction

function! pmv#rust#utils#openRepoPage(package, section)
  let l:json = pmv#rust#utils#getApiPackage(a:package)
  if has_key(l:json.crate, a:section)
    call pmv#utils#openUri(l:json.crate[a:section])
  else
    redraw
    echo 'No Github link found for ' . a:package . '!'
  endif
endfunction

function! pmv#rust#utils#getApiPackage(package)
  let l:json = pmv#utils#fetchApiPackage('https://crates.io/api/v1/crates/' . a:package)
  return l:json
endfunction
