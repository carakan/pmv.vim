let s:registry = {
\ 'mix.ex': {
\   'namespace': 'elixir#hex',
\   'filename': 'Elixir',
\   'description': 'package manager for elixir'
\ },
\ 'nodejs': {
\   'namespace': 'pmv#nodejs',
\   'filename': 'package.json',
\   'description': 'package manager for nodejs'
\ },
\}

function! s:pmv#GetNameSpaceFromFile(filename) abort
  let l:resolved_namespace = get(s:registry, a:filename)
  return get(l:resolved_namespace(), 'namespace', {'function': ''})
endfunction

function! pvm#Registry#GetFunction(filename, function_name) abort
  return call(s:pmv#GetNameSpaceFromFile(a:filename) . '#' , a:function_name)
endfunction

function! pvm#Registry#GetFunctionAndParam(filename, function_name, package_name) abort
  return call(s:pmv#GetNameSpaceFromFile(a:filename) . '#' , a:function_name, a:package_name)
endfunction
