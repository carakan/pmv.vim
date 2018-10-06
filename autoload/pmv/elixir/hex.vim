function! pmv#elixir#hex#allReleases(package_name)
  let l:package = pmv#elixir#hexUtils#getPackageName(a:package_name)
  if !empty(l:package)
    let l:releases = pmv#elixir#hexApi#getAllReleases(l:package)
    if !empty(l:releases)
      call pmv#utils#render(l:releases)
    endif
  end
endfunction

function! pmv#elixir#hex#appendRelease()
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
      echo l:releases[0]
    endif
  end
endfunction

function! pmv#elixir#hex#openDocs(package_name)
  let l:package = pmv#elixir#hexUtils#getPackageName(a:package_name)
  if !empty(l:package)
    call pmv#elixir#hexUtils#openHexDocs(l:package)
  endif
endfunction

function! pmv#elixir#hex#openGithub(package_name)
  let l:package = pmv#elixir#hexUtils#getPackageName(a:package_name)
  if !empty(l:package)
    call pmv#elixir#hexUtils#openGithub(l:package)
  endif
endfunction

function! pmv#elixir#hex#packageInfo(package_name)
  let l:package = pmv#elixir#hexUtils#getPackageName(a:package_name)
  if !empty(l:package)
    let l:package_info = pmv#elixir#hexApi#getPackageInfo(l:package)
    if !empty(l:package_info)
      call pmv#utils#render(l:package_info)
    endif
  endif
endfunction
