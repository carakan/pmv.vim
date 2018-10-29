if exists('b:current_syntax')
  finish
endif

setlocal iskeyword+=:
syn case ignore

syn match name "[0-9A-Za-z _-]\+:\s"
syn match valueNumber "\d\+"
syn region string start='"' end='"' skip='\\"'

highlight link name Statement
highlight link valueNumber Number
highlight link string String

let b:current_syntax = 'versioning'
