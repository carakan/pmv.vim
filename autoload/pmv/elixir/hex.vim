function! pmv#elixir#hex#allReleases(package_name) abort
  let l:package = pmv#elixir#hexUtils#getPackageName(a:package_name)
  if !empty(l:package)
    let l:releases = pmv#elixir#hexApi#getAllReleases(l:package)
    if !empty(l:releases)
      call pmv#utils#renderPopup(l:releases, 'All releases of: "' . l:package . '"')
      call pmv#utils#renderText(l:releases[0], line('.'))
    endif
  end
endfunction

function! pmv#elixir#hex#appendRelease() abort
  let l:package = pmv#elixir#hexUtils#getPackageName('')
  if !empty(l:package)
    let l:latest_release = pmv#elixir#hexApi#getLatestRelease(l:package)
    if !empty(l:latest_release)
      call pmv#elixir#hexUtils#appendRelease(l:package, l:latest_release)
    endif
  end
endfunction

function! pmv#elixir#hex#lastRelease() abort
  let l:package = pmv#elixir#hexUtils#getPackageName('')
  if !empty(l:package)
    let l:releases = pmv#elixir#hexApi#getAllReleases(l:package)
    if !empty(l:releases)
      call pmv#utils#renderText(l:releases[0], line('.'))
      echo 'Last version of ' . l:package . ' : ' . l:releases[0]
    endif
  end
endfunction

function! pmv#elixir#hex#openDocs(package_name) abort
  let l:package = pmv#elixir#hexUtils#getPackageName(a:package_name)
  if !empty(l:package)
    call pmv#elixir#hexUtils#openHexDocs(l:package)
  endif
endfunction

function! pmv#elixir#hex#openGithub(package_name) abort
  let l:package = pmv#elixir#hexUtils#getPackageName(a:package_name)
  if !empty(l:package)
    call pmv#elixir#hexUtils#openGithub(l:package)
  endif
endfunction

function! pmv#elixir#hex#packageInfo(package_name) abort
  let l:package = pmv#elixir#hexUtils#getPackageName(a:package_name)
  if !empty(l:package)
    let l:package_info = pmv#elixir#hexApi#getPackageInfo(l:package)
    if !empty(l:package_info)
      call pmv#utils#renderPopup(l:package_info)
    endif
  endif
endfunction

function! pmv#elixir#hex#packageSearch(query) abort
  let l:query = pmv#elixir#hexUtils#getPackageName(a:query)
  let l:uri = 'https://hex.pm/api/packages?search=' . l:query
  let l:response = pmv#utils#fetchApiPackage(l:uri)
  let l:resultSearch = []
  for l:package in l:response
    call add(l:resultSearch, '"' . l:package.name . '", ' . l:package.meta.description . ', Downloads: ' . l:package.downloads.all)
  endfor
  call pmv#utils#renderPopup(l:resultSearch, 'Search results for: "' . l:query . '"')
endfunction
