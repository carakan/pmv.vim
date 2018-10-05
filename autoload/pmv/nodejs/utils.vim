function! pmv#nodejs#utils#getPackageName(qarg)
  let l:strings = split(a:qarg, '"')
  echom a:qarg
  if len(l:strings) > 3
    let l:npm_name = tolower(l:strings[1])
    return l:npm_name
  else
    return
  endif
endfunction

function! pmv#nodejs#utils#getApiAllReleases(package)
  let l:json = pmv#utils#fetchApiPackage('https://registry.npmjs.org/' . a:package)
  if has_key(l:json, 'versions')
    let l:format_version = 'v:val.version . "\t name: " . v:val.name'
    return map(l:json.releases, l:format_version)
  endif
endfunction
