let s:registry = {
\ 'mix.exs': {
\   'namespace': 'elixir#hex',
\   'filename': 'Elixir',
\   'description': 'package manager for elixir'
\ },
\ 'registry.vim': {
\   'namespace': 'nodejs#npm',
\   'filename': 'package.json',
\   'description': 'package manager for nodejs'
\ },
\}

function! s:getNameSpaceFromFile(filename) abort
  let l:resolved_namespace = trim(s:registry[a:filename].namespace)
  return l:resolved_namespace
endfunction

function! pmv#Registry#GetFunction(filename, function_name) abort
  let l:function_name = s:getNameSpaceFromFile(a:filename) . '#' . a:function_name
  return call(l:function_name)
endfunction

function! pmv#Registry#GetFunctionAndParam(filename, function_name, package_name) abort
  let l:function_name_cal = s:getNameSpaceFromFile(a:filename)
  echom l:function_name_cal . '#' . a:function_name . ' - ' . a:package_name
  return call(l:function_name_cal . '#' . a:function_name, [a:package_name])
endfunction
