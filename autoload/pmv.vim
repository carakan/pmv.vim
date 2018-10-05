function! s:getCurrentFileName() abort
  return trim(expand('%:t'))
endfunction

function! pmv#packageInfo(package_name)
  let l:file_name = s:getCurrentFileName()
  call pmv#Registry#GetFunctionAndParam(l:file_name, 'packageInfo', a:package_name)
endfunction

function! pmv#allReleases(package_name)
  let l:file_name = s:getCurrentFileName()
  call pmv#Registry#GetFunctionAndParam(l:file_name, 'allReleases', a:package_name)
endfunction

