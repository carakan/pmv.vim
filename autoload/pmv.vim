function! pmv#allReleases(package_name) abort
  let l:file_name = expand('%:t')
  call pmv#Registry#GetFunctionAndParam(l:file_name, 'allReleases', a:package_name)
endfunction

function! pmv#appendRelease() abort
  let l:file_name = expand('%:t')
  call pmv#Registry#GetFunction(l:file_name, 'appendRelease')
endfunction

function! pmv#lastRelease() abort
  let l:file_name = expand('%:t')
  call pmv#Registry#GetFunction(l:file_name, 'lastRelease')
endfunction

function! pmv#openDocs(package_name) abort
  let l:file_name = expand('%:t')
  call pmv#Registry#GetFunctionAndParam(l:file_name, 'openDocs', a:package_name)
endfunction

function! pmv#openRepoPage(package_name) abort
  let l:file_name = expand('%:t')
  call pmv#Registry#GetFunctionAndParam(l:file_name, 'openGithub', a:package_name)
endfunction

function! pmv#packageInfo(package_name) abort
  let l:file_name = expand('%:t')
  call pmv#Registry#GetFunctionAndParam(l:file_name, 'packageInfo', a:package_name)
endfunction

function! pmv#packageSearch(query) abort
  let l:file_name = expand('%:t')
  call pmv#Registry#GetFunctionAndParam(l:file_name, 'packageSearch', a:query)
endfunction
