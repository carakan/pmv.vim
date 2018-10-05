function! s:getCurrentFileName() abort
  return trim(expand('%:t'))
endfunction

function! pmv#packageInfo(package_name)
  let l:file_name = s:getCurrentFileName()
  let l:package_name = getline('.')
  call pmv#Registry#GetFunctionAndParam(l:file_name, 'packageInfo', l:package_name)
endfunction

function! pmv#allReleases(package_name)
  let l:file_name = s:getCurrentFileName()
  let l:package_name = getline('.')
  call pmv#Registry#GetFunctionAndParam(l:file_name, 'allReleases', l:package_name)
endfunction

