function! pmv#GetCurrentFileName() abort
  return expand('%:t')
endfunction

function! pmv#packageInfo(package_name)
  let l:file_name = pmv#GetCurrentFileName()
  call pvm#Registry#GetFunctionAndParam('packageInfo', a:package_name)
endfunction

