" Checking camel case words spelling.
" Version 1.0.0
" Author kamykn
" License VIM LICENSE

scriptencoding utf-8

if exists('g:loaded_spelunker')
	finish
endif
let g:loaded_spelunker = 1

let s:save_cpo = &cpo
set cpo&vim


if !exists('g:enable_spelunker_vim')
	let g:enable_spelunker_vim = 1
endif

if !exists('g:spelunker_target_min_char_len')
	let g:spelunker_target_min_char_len = 4
endif

if !exists('g:spelunker_max_suggest_words')
	let g:spelunker_max_suggest_words = 15
endif

if !exists('g:spelunker_max_hi_words_each_buf')
	let g:spelunker_max_hi_words_each_buf = 100
endif

" [spelunker_spell_bad_group] ===========================================================

if !exists('g:spelunker_spell_bad_group')
	let g:spelunker_spell_bad_group = 'SpelunkerSpellBad'
endif

let s:spelunker_spell_bad_hi_list = ""
try
	let s:spelunker_spell_bad_hi_list = execute('highlight ' . g:spelunker_spell_bad_group)
catch
finally
	if strlen(s:spelunker_spell_bad_hi_list) == 0
		execute ('highlight ' . g:spelunker_spell_bad_group . ' cterm=underline ctermfg=247 gui=underline guifg=#9e9e9e')
	endif
endtry

" [spelunker_compound_word_group] =======================================================

if !exists('g:spelunker_compound_word_group')
	let g:spelunker_compound_word_group = 'SpelunkerCompoundWord'
endif

let s:spelunker_compound_word_hi_list = ""
try
	let s:spelunker_compound_word_hi_list = execute('highlight ' . g:spelunker_compound_word_group)
catch
finally
	if strlen(s:spelunker_compound_word_hi_list) == 0
		execute ('highlight ' . g:spelunker_compound_word_group . ' cterm=underline ctermfg=NONE gui=underline guifg=NONE')
	endif
endtry

" [open fix list] ========================================================================
nnoremap <silent> <Plug>(spelunker-correct-from-list) :call spelunker#correct_from_list()<CR>
if !hasmapto('<Plug>(spelunker-correct-from-list)')
	silent! nmap <unique> Zl <Plug>(spelunker-correct-from-list)
endif

nnoremap <silent> <Plug>(spelunker-correct-all-from-list) :call spelunker#correct_all_from_list()<CR>
if !hasmapto('<Plug>(spelunker-correct-all-from-list)')
	silent! nmap <unique> ZL <Plug>(spelunker-correct-all-from-list)
endif

" [correct word] =========================================================================
nnoremap <silent> <Plug>(spelunker-correct) :call spelunker#correct()<CR>
if !hasmapto('<Plug>(spelunker-correct)')
	silent! nmap <unique> Zc <Plug>(spelunker-correct)
endif

nnoremap <silent> <Plug>(spelunker-correct-all) :call spelunker#correct_all()<CR>
if !hasmapto('<Plug>(spelunker-correct-all)')
	silent! nmap <unique> ZC <Plug>(spelunker-correct-all)
endif

" [spell good] ===========================================================================
" vnoremapは古い方法の後方互換です
vnoremap <silent> <Plug>(add-spelunker-good) zg :call spelunker#check()<CR>
if !hasmapto('<Plug>(add-spelunker-good)')
	silent! vmap <unique> Zg <Plug>(add-spelunker-good)
endif

nnoremap <silent> <Plug>(add-spelunker-good-nmap)
		\	:call spelunker#execute_with_target_word('spellgood')<CR> :call spelunker#check()<CR>
if !hasmapto('<Plug>(add-spelunker-good-nmap)')
	silent! nmap <unique> Zg <Plug>(add-spelunker-good-nmap)
endif

" [undo spell good] ======================================================================
vnoremap <silent> <Plug>(undo-spelunker-good) zug :call spelunker#check()<CR>
if !hasmapto('<Plug>(undo-spelunker-good)')
	silent! vmap <unique> Zug <Plug>(undo-spelunker-good)
endif

nnoremap <silent> <Plug>(undo-spelunker-good-nmap)
		\	:call spelunker#execute_with_target_word('spellundo')<CR> :call spelunker#check()<CR>
if !hasmapto('<Plug>(undo-spelunker-good-nmap)')
	silent! nmap <unique> Zug <Plug>(undo-spelunker-good-nmap)
endif

" [temporary spell good] =================================================================
vnoremap <silent> <Plug>(add-temporary-spelunker-good) zG :call spelunker#check()<CR>
if !hasmapto('<Plug>(add-temporary-spelunker-good)')
	silent! vmap <unique> ZG <Plug>(add-temporary-spelunker-good)
endif

nnoremap <silent> <Plug>(add-temporary-spelunker-good-nmap)
		\	:call spelunker#execute_with_target_word('spellgood!')<CR> :call spelunker#check()<CR>
if !hasmapto('<Plug>(add-temporary-spelunker-good-nmap)')
	silent! nmap <unique> ZG <Plug>(add-temporary-spelunker-good-nmap)
endif

" [undo temporary spell good] ============================================================
vnoremap <silent> <Plug>(undo-temporary-spelunker-good) zuG :call spelunker#check()<CR>
if !hasmapto('<Plug>(undo-temporary-spelunker-good)')
	silent! vmap <unique> ZUG <Plug>(undo-temporary-spelunker-good)
endif

nnoremap <silent> <Plug>(undo-temporary-spelunker-good-nmap)
		\	:call spelunker#execute_with_target_word('spellundo!')<CR> :call spelunker#check()<CR>
if !hasmapto('<Plug>(undo-temporary-spelunker-good-nmap)')
	silent! nmap <unique> ZUG <Plug>(undo-temporary-spelunker-good-nmap)
endif

" [spell bad] ============================================================================
vnoremap <silent> <Plug>(add-spelunker-bad) zw :call spelunker#check()<CR>
if !hasmapto('<Plug>(add-spelunker-bad)')
	silent! vmap <unique> Zw <Plug>(add-spelunker-bad)
endif

nnoremap <silent> <Plug>(add-spell-bad-nmap)
		\	:call spelunker#execute_with_target_word('spellwrong')<CR> :call spelunker#check()<CR>
if !hasmapto('<Plug>(add-spell-bad-nmap)')
	silent! nmap <unique> Zw <Plug>(add-spell-bad-nmap)
endif

" [undo spell bad] =======================================================================
vnoremap <silent> <Plug>(undo-spelunker-bad) zuw :call spelunker#check()<CR>
if !hasmapto('<Plug>(undo-spelunker-bad)')
	silent! vmap <unique> Zuw <Plug>(undo-spelunker-bad)
endif

nnoremap <silent> <Plug>(undo-spelunker-bad-nmap)
		\	:call spelunker#execute_with_target_word('spellundo')<CR> :call spelunker#check()<CR>
if !hasmapto('<Plug>(undo-spelunker-bad-nmap)')
	silent! nmap <unique> Zuw <Plug>(undo-spelunker-bad-nmap)
endif

" [temporary spell bad] ==================================================================
vnoremap <silent> <Plug>(add-temporary-spelunker-bad) zW :call spelunker#check()<CR>
if !hasmapto('<Plug>(add-temporary-spelunker-bad)')
	silent! vmap <unique> ZW <Plug>(add-temporary-spelunker-bad)
endif

nnoremap <silent> <Plug>(add-temporary-spelunker-bad-nmap)
		\	:call spelunker#execute_with_target_word('spellwrong!')<CR> :call spelunker#check()<CR>
if !hasmapto('<Plug>(add-temporary-spelunker-bad-nmap)')
	silent! nmap <unique> ZW <Plug>(add-temporary-spelunker-bad-nmap)
endif

" [temporary spell bad] ==================================================================
vnoremap <silent> <Plug>(undo-temporary-spelunker-bad) zuW :call spelunker#check()<CR>
if !hasmapto('<Plug>(undo-temporary-spelunker-bad)')
	silent! vmap <unique> ZUW <Plug>(undo-temporary-spelunker-bad)
endif

nnoremap <silent> <Plug>(undo-temporary-spelunker-bad-nmap)
		\	:call spelunker#execute_with_target_word('spellundo!')<CR> :call spelunker#check()<CR>
if !hasmapto('<Plug>(undo-temporary-spelunker-bad-nmap)')
	silent! nmap <unique> ZUW <Plug>(undo-temporary-spelunker-bad-nmap)
endif

augroup spelunker
	autocmd!
	autocmd BufWinEnter,BufWritePost * call spelunker#check()
augroup END


let &cpo = s:save_cpo
unlet s:save_cpo