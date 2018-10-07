function! pmv#nodejs#npm#allReleases(package_name)
  let l:package = pmv#nodejs#utils#getPackageName(a:package_name)
  if !empty(l:package)
    let l:releases = pmv#nodejs#utils#getApiAllReleases(l:package)
    echo l:releases[0]
    if !empty(l:releases)
      call pmv#utils#render(l:releases)
    endif
  end
endfunction

function! pvm#nodejs#npm#appendRelease()
  echo 'Not implemented'
endfunction

function! pmv#nodejs#npm#lastRelease() abort
  let l:package = pmv#nodejs#utils#getPackageName('')
  if !empty(l:package)
    let l:jsonApi = pmv#nodejs#utils#getApiLatestRelease(l:package)
    echo 'Last version of ' . l:package . ' : ' . l:jsonApi['dist-tags'].latest
  end
endfunction

function! pmv#nodejs#npm#openDocs(package_name)
  echo 'Not implemented'
endfunction

function! pmv#nodejs#npm#openGithub(package_name)
  let l:package = nodejs#npmUtils#getPackageName(a:package_name)
  if !empty(l:package)
    call pmv#nodejs#utils#openRepoPage(l:package)
  endif
endfunction

function! pmv#nodejs#npm#packageInfo(package_name)
  let l:package = pvm#nodejs#utils#getPackageName(a:package_name)
  if !empty(l:package)
    let l:package_info = nodejs#npmApi#getPackageInfo(l:package)
    if !empty(l:package_info)
      call pmv#utils#render(l:package_info)
    endif
  else
    echo 'Error on:' . a:package_name
  endif
endfunction
