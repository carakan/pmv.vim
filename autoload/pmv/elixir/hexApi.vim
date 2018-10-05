function! pmv#elixir#hexApi#getPackageInfo(package)
  echom 'Retrieving information from hex.pm ...'
  let l:info = system('mix hex.info ' . shellescape(a:package))
  redraw!

  if match(l:info, 'No package with name') != 0
    return split(l:info, '\n')
  else
    call s:packageNotFound(a:package)
  endif
endfunction

function! pmv#elixir#hexApi#getAllReleases(package)
  let l:json = pmv#utils#fetchApiPackage('https://hex.pm/api/packages/' . a:package)
  if has_key(l:json, 'releases')
    let l:format_version = 'v:val.version . "\t url: " . v:val.url'
    return map(l:json.releases, l:format_version)
  endif
endfunction

function! pmv#elixir#hexApi#getLatestRelease(package)
  let l:json = pmv#utils#fetchApiPackage('https://hex.pm/api/packages/' . a:package)
  if has_key(l:json, 'releases')
    return l:json.releases[0].version
  endif
endfunction

function! s:extractDate(str)
  let l:date = matchstr(a:str, '[0-9-]\+')
  return l:date
endfunction

function! s:packageNotFound(package)
  echom 'No package with name ' . a:package
endfunction
