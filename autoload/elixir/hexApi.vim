function! elixir#hexApi#getPackageInfo(package)
  echom 'Retrieving information from hex.pm ...'
  let l:info = system('mix hex.info ' . shellescape(a:package))
  redraw!

  if match(l:info, 'No package with name') != 0
    return split(l:info, '\n')
  else
    call s:packageNotFound(a:package)
  endif
endfunction

function! elixir#hexApi#getAllReleases(package)
  let l:json = elixir#hexApi#fetchPackage(a:package)
  if has_key(l:json, 'releases')
    let l:format_version = 'v:val.version . "\t url: " . v:val:url'
    return map(l:json.releases, l:format_version)
  endif
endfunction

function! elixir#hexApi#getLatestRelease(package)
  let l:json = elixir#hexApi#fetchPackage(a:package)
  if has_key(l:json, 'releases')
    return l:json.releases[0].version
  endif
endfunction

function! elixir#hexApi#fetchPackage(package)
  echom 'Retrieving information from hex.pm ...'
  let l:uri = 'https://hex.pm/api/packages/' . a:package
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
