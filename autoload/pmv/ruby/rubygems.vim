function! pmv#ruby#rubygems#allReleases(package_name)
  let l:gem_name = s:gem_name_from_current_line()
  if empty(l:gem_name)
    return
  endif
  let l:gem_info = pmv#ruby#utils#getApiPackageVersions(l:gem_name)
  let l:format_version = 'v:val.number . "\t built at: " . v:val.built_at'
  call pmv#utils#renderPopup(map(l:gem_info, l:format_version), 'All releases of: ' . l:gem_name)
endfunction

function! pmv#ruby#rubygems#lastRelease()
  let l:gem_name = s:gem_name_from_current_line()
  if empty(l:gem_name)
    return
  endif
  let l:gem_info = pmv#ruby#utils#getApiPackage(l:gem_name)
  let l:output = 'Last version of: ' . l:gem_name . ' : ' . l:gem_info.version
  echo l:output
endfunction

function! pmv#ruby#rubygems#packageInfo(package_name)
  let gem_name = s:gem_name_from_current_line()
  if empty(gem_name)
    return
  endif
  let l:gem_info = pmv#ruby#utils#getApiPackage(gem_name)

  let l:messageInfo = ['Last version: ' . l:gem_info.version ]
  call add(l:messageInfo, 'Authors: ' . l:gem_info.authors)
  call add(l:messageInfo, 'Downloads: ' . l:gem_info.version_downloads)
  call add(l:messageInfo, 'Project uri: ' . l:gem_info.project_uri)
  call add(l:messageInfo, 'Source code uri: ' . l:gem_info.source_code_uri)
  call add(l:messageInfo, 'Description: ' . l:gem_info.info)
  call pmv#utils#renderPopup(l:messageInfo)
endfunction

function! pmv#ruby#rubygems#appendRelease()
  let gem_name = s:gem_name_from_current_line()
  if empty(gem_name)
    return
  endif
  let gem_info = pmv#ruby#utils#getApiPackage(gem_name)
  let gem_version = gem_info.version
  call s:remove_current_version()
  execute "normal! A, '~> ".gem_version."'"
endfunction

function! pmv#ruby#rubygems#openDocs(package_name)
  let l:gemName = s:gem_name_from_current_line()
  if !empty(l:gemName)
    call pmv#ruby#utils#openPage(l:gemName, 'documentation_uri')
  endif
endfunction

function! pmv#ruby#rubygems#openGithub(package_name)
  let l:gemName = s:gem_name_from_current_line()
  if !empty(l:gemName)
    call pmv#ruby#utils#openPage(l:gemName, 'homepage_uri')
  endif
endfunction

function! rubygems#Search(query)
  let uri = 'https://rubygems.org/api/v1/search.json?query=' . a:query
  let response = pmv#utils#fetchApiPackage(uri)
  let content = ''
  for gem in response
    let content = content . gem.name . ': ' . s:strip(gem.info) . "\<cr>"
  endfor
  call pmv#utils#renderPopup(content)
endfunction

function! rubygems#clean_signs()
  sign unplace *
endfunction

function! rubygems#GemfileCheck()
  sign unplace *
  normal! gg
  call s:highlight_signs()
  let lines = getbufline(bufname('%'), 0, line('$'))
  let index = 0
  for line in lines
    let index += 1
    call s:update_cursor_position(index)
    let gem_name = s:extract_gem_name(line)
    let current_gem_version = s:extract_gem_version(line)

    if strlen(gem_name) < 2 || strlen(current_gem_version) < 2
      continue
    endif

    call s:hi_line(index, 'rubygem_checking')
    let gem_info = pmv#ruby#utils#getApiPackage(gem_name)
    if s:compare_versions(current_gem_version, gem_info.version)
      call s:hi_line(index, 'rubygem_warning',)
    else
      exe 'sign unplace ' . index
    endif
  endfor
endfunction

function! s:gem_name_from_current_line()
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

function! s:extract_gem_version(str)
  let str = split(a:str, ' ')
  if len(str) > 2 && s:is_gem_definition(str)
    let gem_version = matchstr(str[-1], '[0-9.]\+')
    return gem_version
  else
    return
  endif
endfunction

function! s:extract_date(str)
  let date = matchstr(a:str, '[0-9-]\+')
  return date
endfunction

function! s:strip(input_str)
  let output_str = substitute(a:input_str, '^\s*\(.\{-}\)\s*$', '\1', '')
  let output_str = s:strip_last_new_line_char(output_str)
  return output_str
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
    let current_cursorline_bg = synIDattr(synIDtrans(hlID('CursorLine')), 'bg')
    exe 'highlight CursorLine ctermbg=' . current_cursorline_bg
  endif
endfunction

function! s:remove_current_version()
  let line = getline('.')
  let line = split(line, ',')[0]
  let line = substitute(line, '^\s\+', '', 'g')
  execute 'normal! ^C' . line
endfunction
