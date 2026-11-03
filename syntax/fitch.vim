if exists("b:current_syntax")
    finish
endif

syntax match fitchLineNumber /^\s*\d\+/
syntax match fitchOperator   /[∧∨¬→↔=]/
syntax match fitchQuantifier /[∀∃]/
syntax match fitchBottom     /⊥/
syntax match fitchRule       /\<\(Intro\|Elim\|Reit\)\>/
syntax match fitchDelimiter  /[|,:()[\]-]/

highlight default link fitchLineNumber Number
highlight default link fitchOperator   Operator
highlight default link fitchQuantifier Keyword
highlight default link fitchBottom     Constant
highlight default link fitchRule       Keyword
highlight default link fitchDelimiter  Delimiter

let b:current_syntax = "fitch"
