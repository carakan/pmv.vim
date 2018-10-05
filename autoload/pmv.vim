function! pmv#GetCurrentFileName() abort
  return trim(expand('%:t'))
endfunction

function! pmv#packageInfo(package_name)
  let l:file_name = pmv#GetCurrentFileName()
  let l:package_name = getline('.')
  call pmv#Registry#GetFunctionAndParam(l:file_name, 'packageInfo', l:package_name)
endfunction

