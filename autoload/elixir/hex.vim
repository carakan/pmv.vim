function! elixir#hex#appendRelease()
  let l:package = elixir#hexUtils#getPackageName('')
  if !empty(l:package)
    let l:latest_release = elixir#hexApi#getLatestRelease(l:package)
    if !empty(l:latest_release)
      call elixir#hexUtils#appendRelease(l:package, l:latest_release)
    endif
  end
endfunction

function! elixir#hex#allReleases(package_name)
  let l:package = elixir#hexUtils#getPackageName(a:package_name)
  if !empty(l:package)
    let l:releases = elixir#hexApi#getAllReleases(l:package)
    if !empty(l:releases)
      call elixir#hexUtils#render(l:releases)
    endif
  end
endfunction

function! elixir#hex#packageInfo(package_name)
  let l:package = elixir#hexUtils#getPackageName(a:package_name)
  if !empty(l:package)
    let l:package_info = elixir#hexApi#getPackageInfo(l:package)
    if !empty(l:package_info)
      call elixir#hexUtils#render(l:package_info)
    endif
  endif
endfunction

function! elixir#hex#openHexDocs(package_name)
  let l:package = elixir#hexUtils#getPackageName(a:package_name)
  if !empty(l:package)
    call elixir#hexUtils#openHexDocs(l:package)
  endif
endfunction

function! elixir#hex#openGithub(package_name)
  let l:package = elixir#hexUtils#getPackageName(a:package_name)
  if !empty(l:package)
    call elixir#hexUtils#openGithub(l:package)
  endif
endfunction
