function! pmv#elixir#hexUtils#appendRelease(package, release)
  let regex = a:package . ',\?\s*}\?'
  let with_version = a:package . ', "\~> ' . a:release . '"'
  let new_line = substitute(getline('.'), regex, with_version, '')
  call s:check_after_release(new_line, a:release)
  normal! $
endfunction

function! s:check_after_release(line, release)
  let after_version = matchstr(a:line, a:release . '"\zs.')
  if empty(after_version) || after_version == ']'
    let line = substitute(a:line, a:release . '"', a:release . '"}', '')
  else
    let line = substitute(a:line, a:release . '"', a:release . '", ', '')
  endif
  call setline('.', line)
endfunction

function! pmv#elixir#hexUtils#openHexDocs(package)
  let l:uri = 'https://hexdocs.pm/' . a:package
  call pmv#utils#openUri(l:uri)
endfunction

function! pmv#elixir#hexUtils#openGithub(package)
  let json = pmv#utils#fetchApiPackage('https://hex.pm/api/packages/' . a:package)
  if has_key(json, 'meta')
    let links = json.meta.links
    if has_key(links, 'GitHub')
      call pmv#utils#openUri(links.GitHub)
    elseif has_key(links, 'github')
      call pmv#utils#openUri(links.github)
    elseif has_key(links, 'Github')
      call pmv#utils#openUri(links.Github)
    else
      redraw
      echo 'No Github link found for ' . a:package . '!'
    endif
  endif
endfunction

function! pmv#elixir#hexUtils#getPackageName(qarg)
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
  return matchstr(l:line, '{:\zs[a-z]\w*\ze')
endfunction
