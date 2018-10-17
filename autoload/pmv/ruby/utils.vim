function! pmv#ruby#utils#getPackageName(qarg)
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
  let l:gemName = s:extract_gem_name(getline('.'))
  return l:gemName
endfunction

function! s:is_gem_definition(str_arr)
  let l:gem_def_prefixes = [
        \ 'gem',
        \ 'spec.add_development_dependency',
        \ 'spec.add_runtime_dependency'
        \ ]

  return index(l:gem_def_prefixes, a:str_arr[0]) >= 0
endfunction

function! s:extract_gem_name(str)
  let str = split(a:str, ' ')
  if len(str) > 1 && s:is_gem_definition(str)
    let gem_name = tolower(str[1])
    let gem_name = matchstr(gem_name, '[0-9A-z-_]\+')
    return gem_name
  else
    return
  endif
endfunction

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
