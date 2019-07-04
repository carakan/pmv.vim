if exists('b:current_syntax')
  finish
endif

setlocal iskeyword+=:
syn case ignore

syn match PMVname "[0-9A-Za-z _-]\+:\s"
syn match PMVvalueNumber "\d\|beta\|rc\|pre\+"
syn region PMVstring start='"' end='"' skip='\\"'

highlight link PMVname Statement
highlight link PMVvalueNumber Number
highlight link PMVstring String

let b:current_syntax = 'versioning'
