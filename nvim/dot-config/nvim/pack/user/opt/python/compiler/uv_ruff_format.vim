if exists("current_compiler") | finish | endif
let current_compiler = "uv_ruff_format"

let s:cpo_save = &cpo
set cpo&vim

" In order to both sort imports and format, call the Ruff linter and then the formatter
exe 'CompilerSet makeprg=' .. escape('uv tool run ruff check --select I --fix % && uv tool run ruff format %', ' \|"')

let &cpo = s:cpo_save
unlet s:cpo_save
