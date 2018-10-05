function! pmv#allReleases(package_name)
  let l:file_name = expand('%:t')
  call pmv#Registry#GetFunctionAndParam(l:file_name, 'allReleases', a:package_name)
endfunction

function! pmv#appendRelease()
  let l:file_name = expand('%:t')
  call pmv#Registry#GetFunction(l:file_name, 'appendRelease')
endfunction

function! pmv#lastRelease()
  let l:file_name = expand('%:t')
  call pmv#Registry#GetFunction(l:file_name, 'lastRelease')
endfunction

function! pmv#openDocs(package_name)
  let l:file_name = expand('%:t')
  call pmv#Registry#GetFunctionAndParam(l:file_name, 'openDocs', a:package_name)
endfunction

function! pmv#openRepoPage(package_name)
  let l:file_name = expand('%:t')
  call pmv#Registry#GetFunctionAndParam(l:file_name, 'openGithub', a:package_name)
endfunction

function! pmv#packageInfo(package_name)
  let l:file_name = expand('%:t')
  call pmv#Registry#GetFunctionAndParam(l:file_name, 'packageInfo', a:package_name)
endfunction

