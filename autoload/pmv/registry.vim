let s:registry = {
\ 'Gemfile': {
\   'namespace': 'pmv#ruby#rubygems',
\   'languaje': 'Ruby',
\   'description': 'package manager for Ruby'
\ },
\ 'mix.exs': {
\   'namespace': 'pmv#elixir#hex',
\   'languaje': 'Elixir',
\   'description': 'package manager for elixir'
\ },
\ 'package.json': {
\   'namespace': 'pmv#nodejs#npm',
\   'languaje': 'NodeJS',
\   'description': 'package manager for nodejs'
\ },
\}

function! s:getNameSpaceFromFile(filename) abort
  let l:resolved_namespace = s:registry[a:filename].namespace
  return l:resolved_namespace
endfunction

function! pmv#Registry#GetFunction(filename, function_name) abort
  let l:function_name = s:getNameSpaceFromFile(a:filename) . '#' . a:function_name
  return call(l:function_name, [])
endfunction

function! pmv#Registry#GetFunctionAndParam(filename, function_name, package_name) abort
  let l:function_name_cal = s:getNameSpaceFromFile(a:filename)
  return call(l:function_name_cal . '#' . a:function_name, [a:package_name])
endfunction
