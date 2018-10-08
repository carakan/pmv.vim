let s:registry = {
\ 'Gemfile': {
\   'namespace': 'pmv#ruby#rubygems',
\   'language': 'Ruby',
\   'description': 'package manager for Ruby'
\ },
\ 'mix.exs': {
\   'namespace': 'pmv#elixir#hex',
\   'language': 'Elixir',
\   'description': 'package manager for elixir'
\ },
\ 'package.json': {
\   'namespace': 'pmv#nodejs#npm',
\   'language': 'NodeJS',
\   'description': 'package manager for nodejs'
\ },
\}

function s:listAllSupportedLanguages() abort
  return join(values(map(s:registry, 'v:val.language')), ', ')
endfunction

function! s:getNameSpaceFromFile(filename) abort
  if has_key(s:registry, a:filename)
    return s:registry[a:filename].namespace
  else
    echo 'Not supported language/file, currently supported: ' . s:listAllSupportedLanguages()
    return 'pmv#error'
  endif
endfunction

function! pmv#Registry#GetFunction(filename, function_name) abort
  let l:function_name = s:getNameSpaceFromFile(a:filename) . '#' . a:function_name
  return call(l:function_name, [])
endfunction

function! pmv#Registry#GetFunctionAndParam(filename, function_name, package_name) abort
  let l:function_name_cal = s:getNameSpaceFromFile(a:filename)
  return call(l:function_name_cal . '#' . a:function_name, [a:package_name])
endfunction
