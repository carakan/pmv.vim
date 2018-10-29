function! pmv#nodejs#npm#allReleases(package_name)
  let l:package = pmv#nodejs#utils#getPackageName(a:package_name)
  if !empty(l:package)
    let l:releases = pmv#nodejs#utils#getApiAllReleases(l:package)
    echo l:releases[0]
    if !empty(l:releases)
      call pmv#utils#renderPopup(l:releases, 'All releases of: ' . l:package)
    endif
  end
endfunction

function! pmv#nodejs#npm#appendRelease()
  echo 'Not implemented yet!'
endfunction

function! pmv#nodejs#npm#lastRelease() abort
  let l:package = pmv#nodejs#utils#getPackageName('')
  if !empty(l:package)
    let l:jsonApi = pmv#nodejs#utils#getApiPackage(l:package)
    echo 'Last version of ' . l:package . ' : ' . l:jsonApi['dist-tags'].latest
  end
endfunction

" Nodejs doesn't provide docs an alternative could be yarn.pm
function! pmv#nodejs#npm#openDocs(package_name)
  let l:package = pmv#nodejs#utils#getPackageName(a:package_name)
  if !empty(l:package)
    call pmv#utils#openUri('https://yarn.pm/' . l:package)
  endif
endfunction

function! pmv#nodejs#npm#openGithub(package_name)
  let l:package = pmv#nodejs#utils#getPackageName(a:package_name)
  if !empty(l:package)
    call pmv#nodejs#utils#openRepoPage(l:package)
  endif
endfunction

function! pmv#nodejs#npm#packageInfo(package_name)
  let l:package = pmv#nodejs#utils#getPackageName('')
  if !empty(l:package)
    let l:jsonApi = pmv#nodejs#utils#getApiPackage(l:package)

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

function! pmv#nodejs#npm#packageSearch(query)
  let l:query = pmv#ruby#utils#getPackageName(a:query)
  let l:uri = 'https://www.npmjs.com/search?q=' . l:query
  let l:response = pmv#utils#fetchApiPackage(l:uri)
  let l:resultSearch = []
  for l:package in l:response.objects
    call add(l:resultSearch, 'Package: ' . l:package.package.name . ': ' . l:package.package.description)
  endfor
  call pmv#utils#renderPopup(l:resultSearch, 'Search results for: ' . l:query)
endfunction
