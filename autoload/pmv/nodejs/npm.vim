function! nodejs#npm#appendRelease()
  let l:package = nodejs#npmUtils#getPackageName('')
  if !empty(l:package)
    let l:latest_release = nodejs#npmApi#getLatestRelease(l:package)
    if !empty(l:latest_release)
      call nodejs#npmUtils#appendRelease(l:package, l:latest_release)
    endif
  end
endfunction

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

function! pmv#nodejs#npm#lastRelease() abort
  let l:package = pmv#nodejs#utils#getPackageName('')
  if !empty(l:package)
    let l:latest = pmv#nodejs#utils#getApiLatestRelease(l:package)
    if !empty(l:latest)
      echo 'Last version of ' . l:package . ' : ' . l:latest
    endif
  end
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

function! pmv#nodejs#npm#opennpmDocs(package_name)
  let l:package = nodejs#npmUtils#getPackageName(a:package_name)
  if !empty(l:package)
    call nodejs#npmUtils#opennpmDocs(l:package)
  endif
endfunction

function! nodejs#npm#openGithub(package_name)
  let l:package = nodejs#npmUtils#getPackageName(a:package_name)
  if !empty(l:package)
    call nodejs#npmUtils#openGithub(l:package)
  endif
endfunction
