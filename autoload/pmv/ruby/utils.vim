function! pmv#ruby#utils#getApiPackage(gemName) abort
  let l:uri = 'https://rubygems.org/api/v1/gems/' . a:gemName . '.json'
  let l:content = pmv#utils#fetchApiPackage(l:uri)
  return l:content
endfunction

function! pmv#ruby#utils#getApiPackageVersions(gemName) abort
  let l:uri = 'https://rubygems.org/api/v1/versions/' . a:gemName . '.json'
  let l:content = pmv#utils#fetchApiPackage(l:uri)
  return l:content
endfunction

function! pmv#ruby#utils#openPage(package, entry)
  let l:json = pmv#ruby#utils#getApiPackage(a:package)
  if has_key(l:json, a:entry)
    call pmv#utils#openUri(l:json[a:entry])
  else
    redraw
    echo 'No Github link found for ' . a:package . '!'
  endif
endfunction
