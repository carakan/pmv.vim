function! pmv#rust#crates#allReleases(package_name)
  let l:package = pmv#rust#utils#getPackageName(a:package_name)
  if !empty(l:package)
    let l:releases = pmv#rust#utils#getApiAllReleases(l:package)
    echo l:releases[0]
    if !empty(l:releases)
      call pmv#utils#renderPopup(l:releases, 'All releases of: ' . l:package)
    endif
  end
endfunction

function! pmv#rust#crates#appendRelease()
  echo 'Not implemented yet!'
endfunction

function! pmv#rust#crates#lastRelease() abort
  let l:package = pmv#rust#utils#getPackageName('')
  if !empty(l:package)
    let l:jsonApi = pmv#rust#utils#getApiPackage(l:package)
    echo 'Last version of ' . l:package . ' : ' . l:jsonApi.crate['max_version']
  end
endfunction

function! pmv#rust#crates#openDocs(package_name)
  let l:package = pmv#rust#utils#getPackageName(a:package_name)
  if !empty(l:package)
    call pmv#rust#utils#openRepoPage(l:package, 'documentation')
  endif
endfunction

function! pmv#rust#crates#openGithub(package_name)
  let l:package = pmv#rust#utils#getPackageName(a:package_name)
  if !empty(l:package)
    call pmv#rust#utils#openRepoPage(l:package, 'homepage')
  endif
endfunction

function! pmv#rust#crates#packageInfo(package_name)
  echo 'Not implemented yet!'
endfunction
