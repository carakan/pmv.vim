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

" Nodejs doesn't provide docs an alternative could be yarn.pm
function! pmv#rust#crates#openDocs(package_name)
  let l:package = pmv#rust#utils#getPackageName(a:package_name)
  if !empty(l:package)
    call pmv#utils#openUri('https://yarn.pm/' . l:package)
  endif
endfunction

function! pmv#rust#crates#openGithub(package_name)
  let l:package = pmv#rust#utils#getPackageName(a:package_name)
  if !empty(l:package)
    call pmv#rust#utils#openRepoPage(l:package)
  endif
endfunction

function! pmv#rust#crates#packageInfo(package_name)
  let l:package = pmv#rust#utils#getPackageName('')
  if !empty(l:package)
    let l:jsonApi = pmv#rust#utils#getApiPackage(l:package)

    let l:messageInfo = ['Last version: ' . l:jsonApi['dist-tags'].latest]
    call add(l:messageInfo, 'Authors: ' . l:jsonApi.author.name)
    call add(l:messageInfo, 'Project URL: ' . l:jsonApi.homepage)
    call add(l:messageInfo, 'Bugtracker URL: ' . l:jsonApi.bugs.url)
    call add(l:messageInfo, 'Description: ' . l:jsonApi.description)
    if has_key(l:jsonApi, 'licence')
      call add(l:messageInfo, 'Licence: ' . l:jsonApi.licence)
    endif
    if has_key(l:jsonApi, 'keywords')
      call add(l:messageInfo, 'Keywords: ' . join(l:jsonApi.keywords, ', '))
    endif
    call pmv#utils#renderPopup(l:messageInfo)
  endif
endfunction
