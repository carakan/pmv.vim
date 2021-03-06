scriptencoding utf-8

function! pmv#ruby#rubygems#allReleases(packageName) abort
  let l:gem_name = pmv#ruby#utils#getPackageName(a:packageName)
  if empty(l:gem_name)
    return
  endif
  let l:gem_info = pmv#ruby#utils#getApiPackageVersions(l:gem_name)
  call pmv#utils#renderText(l:gem_info[0].number, line('.'))
  let l:format_version = 'v:val.number . "\t built at: " . split(v:val.built_at, "T")[0]'
  call pmv#utils#renderPopup(map(l:gem_info, l:format_version), 'All releases of: "' . l:gem_name . '"')
endfunction

function! pmv#ruby#rubygems#lastRelease() abort
  let l:gem_name = pmv#ruby#utils#getPackageName('')
  if empty(l:gem_name)
    return
  endif
  let l:gem_info = pmv#ruby#utils#getApiPackage(l:gem_name)
  let l:output = 'Last version of: ' . l:gem_name . ' : ' . l:gem_info.version
  call pmv#utils#renderText(l:gem_info.version, line('.'))
  echo l:output
endfunction

function! pmv#ruby#rubygems#packageInfo(packageName) abort
  let l:gem_name = pmv#ruby#utils#getPackageName(a:packageName)
  if empty(l:gem_name)
    return
  endif
  let l:gem_info = pmv#ruby#utils#getApiPackage(l:gem_name)

  let l:messageInfo = ['Last version: ' . l:gem_info.version ]
  call add(l:messageInfo, 'Authors: ' . l:gem_info.authors)
  call add(l:messageInfo, 'Downloads: ' . l:gem_info.version_downloads)
  call add(l:messageInfo, 'Project uri: ' . l:gem_info.project_uri)
  call add(l:messageInfo, 'Source code uri: ' . l:gem_info.source_code_uri)
  call add(l:messageInfo, 'Description: ' . l:gem_info.info)
  call pmv#utils#renderPopup(l:messageInfo)
endfunction

function! pmv#ruby#rubygems#appendRelease() abort
  let l:gemName = pmv#ruby#utils#getPackageName('')
  if empty(l:gemName)
    return
  endif
  let l:gemInfo = pmv#ruby#utils#getApiPackage(l:gemName)
  let l:gemVersion = l:gemInfo.version
  call s:remove_current_version()
  execute "normal! A, '~> " . l:gemVersion . "'"
endfunction

function! pmv#ruby#rubygems#openDocs(packageName) abort
  let l:gemName = pmv#ruby#utils#getPackageName(a:packageName)
  if !empty(l:gemName)
    call pmv#ruby#utils#openPage(l:gemName, 'documentation_uri')
  endif
endfunction

function! pmv#ruby#rubygems#openGithub(packageName)
  let l:gemName = pmv#ruby#utils#getPackageName(a:packageName)
  if !empty(l:gemName)
    call pmv#ruby#utils#openPage(l:gemName, 'homepage_uri')
  endif
endfunction

function! pmv#ruby#rubygems#packageSearch(query) abort
  let l:query = pmv#ruby#utils#getPackageName(a:query)
  let l:uri = 'https://rubygems.org/api/v1/search.json?query=' . l:query
  let l:response = pmv#utils#fetchApiPackage(l:uri)
  let l:resultSearch = []
  for l:gemInfo in l:response
    call add(l:resultSearch, '"' . l:gemInfo.name . '" ' . s:strip(l:gemInfo.info))
  endfor
  call pmv#utils#rssenderPopup(l:resultSearch, 'Search results for: "' . l:query . '"')
endfunction

function! rubygems#clean_signs()
  sign unplace *
endfunction

function! s:extract_gem_version(str)
  let l:str = split(a:str, ' ')
  if len(l:str) > 2 && s:is_gem_definition(l:str)
    let l:gem_version = matchstr(l:str[-1], '[0-9.]\+')
    return l:gem_version
  else
    return
  endif
endfunction

function! s:extract_date(str)
  let l:date = matchstr(a:str, '[0-9-]\+')
  return l:date
endfunction

function! s:strip(input_str)
  let l:output_str = substitute(a:input_str, '^\s*\(.\{-}\)\s*$', '\1', '')
  let l:output_str = s:strip_last_new_line_char(l:output_str)
  return l:output_str
endfunction

function! s:strip_last_new_line_char(str)
  return substitute(a:str, '\n$', '', 'g')
endfunction

function! s:compare_versions(current, last)
  let current = split(a:current, '\.')
  let current_major = current[0]
  let current_minor = current[1]

  if len(current) == 3
    let current_patch = current[2]
  else
    let current_patch = 0
  end

  let last = split(a:last, '\.')
  let last_major = last[0]
  let last_minor = last[1]

  if len(last) == 3
    let last_patch = last[2]
  else
    let last_patch = 0
  endif

  if last_major > current_major
    return 1
  elseif last_minor > current_minor
    return 1
  elseif last_patch > current_patch
    return 1
  else
    return 0
  endif
endfunction

function! s:highlight_signs()
  highlight WarningSign term=standout ctermfg=yellow ctermbg=0
  highlight CheckingSign term=standout ctermfg=118 ctermbg=0
  sign define rubygem_warning text=! texthl=WarningSign
  sign define rubygem_checking text=➡ texthl=CheckingSign
endfunction

function! s:hi_line(line_num, name)
  exe 'sign place ' . a:line_num . ' line=' . a:line_num . ' name=' . a:name . ' file=' . bufname('%')
endfunction

function! s:update_cursor_position(index)
  call setpos('.', [bufname('%'), a:index, 0, 1])
  if &cursorline
    let l:current_cursorline_bg = synIDattr(synIDtrans(hlID('CursorLine')), 'bg')
    exe 'highlight CursorLine ctermbg=' . l:current_cursorline_bg
  endif
endfunction

function! s:remove_current_version()
  let l:line = getline('.')
  let l:line = split(l:line, ',')[0]
  let l:line = substitute(l:line, '^\s\+', '', 'g')
  execute 'normal! ^C' . l:line
endfunction
