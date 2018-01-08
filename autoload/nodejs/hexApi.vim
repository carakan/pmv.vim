function! nodejs#npmApi#getPackageInfo(package)
  echom 'Retrieving information from npm.pm ...'
  let l:info = system('mix npm.info ' . shellescape(a:package))
  redraw!

  if match(l:info, 'No package with name') != 0
    return split(l:info, '\n')
  else
    call s:packageNotFound(a:package)
  endif
endfunction

function! nodejs#npmApi#getAllReleases(package)
  let l:json = nodejs#npmApi#fetchPackage(a:package)
  if has_key(l:json, 'releases')
    let l:format_version = 'v:val.version . " (released on " . s:extractDate(v:val.inserted_at) . ")"'
    return map(l:json.releases, l:format_version)
  endif
endfunction

function! nodejs#npmApi#getLatestRelease(package)
  let l:json = nodejs#npmApi#fetchPackage(a:package)
  if has_key(l:json, 'releases')
    return l:json.releases[0].version
  endif
endfunction

function! nodejs#npmApi#fetchPackage(package)
  echom 'Retrieving information from npm.pm ...'
  let l:uri = 'https://npm.pm/api/packages/' . a:package
  let l:result = system(printf('curl -sS -L -i -X GET -H "Content-Cache: no-cache" "%s"', l:uri))
  let l:pos = stridx(l:result, "\r\n\r\n")
  let l:content = strpart(l:result, l:pos + 4)

  redraw!
  return webapi#json#decode(l:content)
endfunction

function! s:extractDate(str)
  let l:date = matchstr(a:str, '[0-9-]\+')
  return l:date
endfunction

function! s:packageNotFound(package)
  echom 'No package with name ' . a:package
endfunction
