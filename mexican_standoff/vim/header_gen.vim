autocmd BufWritePre *.c if &modified | call Update_Header() | endif

function! Get_User()
	let s:user = system("echo -n $USER | cut -c1-8 | tr -d '\n'")
	if s:user == ""
		let	s:user = "marvin"
	endif
endfunc

" Check wether the header is correctly formatted

function! Check_Header()
	let s:ret = 1

	" line 1
	let l:line = getline(1)
	let l:matched = match(line, "^/\\* \\*\\{74} \\*/$")
	if strlen(l:line) != 80
		let s:ret = 0
		return
	endif
	if l:matched == -1
		let s:ret = 0
		return
	endif

	" line 2
	let l:line = getline(2)
	let l:matched = match(line, "^/\\*  \\{74} \\*/$")
	if strlen(l:line) != 80
		let s:ret = 0
		return
	endif
	if l:matched == -1
		let s:ret = 0
		return
	endif

	" line 3
	let l:line = getline(3)
	let l:matched = match(line, "^/\\* \\{56}:::      ::::::::   \\*/$")
	if strlen(l:line) != 80
		let s:ret = 0
		return
	endif
	if l:matched == -1
		let s:ret = 0
		return
	endif

	" line 4
	let l:line = getline(4)
	let l:matched = match(line, "^/\\*   .\\{42} \\+:+:      :+:    :+:   \\*/$")
	if strlen(l:line) != 80
		let s:ret = 0
		return
	endif
	if l:matched == -1
		let s:ret = 0
		return
	endif

	"line 5
	let l:line = getline(5)
	let l:matched = match(line, "^/\\* \\{52}+:+ +:+         +:+     \\*/$")
	if strlen(l:line) != 80
		let s:ret = 0
		return
	endif
	if l:matched == -1
		let s:ret = 0
		return
	endif

	"line 6
	let l:line = getline(6)
	let l:matched = match(line, "^/\\*   By: .\\{1,8} <[^ ]\\{1,22}> \\{10,33}+#+  +:+       +#+        \\*/$")
	if strlen(l:line) != 80
		let s:ret = 0
		return
	endif
	if l:matched == -1
		let s:ret = 0
		return
	endif

	"line 7
	let l:line = getline(7)
	let l:matched = match(line, "^/\\* \\{48}+#+#+#+#+#+   +#+           \\*/$")
	if strlen(l:line) != 80
		let s:ret = 0
		return
	endif
	if l:matched == -1
		let s:ret = 0
		return
	endif

	"line 8
	let l:line = getline(8)
	let l:matched = match(line, "^/\\*   Created: \\d\\d\\d\\d/\\d\\d/\\d\\d \\d\\d:\\d\\d:\\d\\d by [^ ]\\{,8} \\+#+#    #+#             \\*/$")
	if strlen(l:line) != 80
		let s:ret = 0
		return
	endif
	if l:matched == -1
		let s:ret = 0
		return
	endif

	"line 9
	let l:line = getline(9)
	"let l:matched = match(line, "^/\\*   Updated: \\d\\d\\d\\d/\\d\\d/\\d\\d \\d\\d:\\d\\d:\\d\\d by [^ ]\\{,8} \\+#+#    #+#             \\*/$")
	let l:matched = match(line, "^/\\*   Updated: \\d\\d\\d\\d/\\d\\d/\\d\\d \\d\\d:\\d\\d:\\d\\d by [^ ]\\{,8} \\+###   ########.fr       \\*/$")
	if strlen(l:line) != 80
		let s:ret = 0
		return
	endif
	if l:matched == -1
		let s:ret = 0
		return
	endif

	" line 10
	let l:line = getline(10)
	let l:matched = match(line, "^/\\*  \\{74} \\*/$")
	if strlen(l:line) != 80
		let s:ret = 0
		return
	endif
	if l:matched == -1
		let s:ret = 0
		return
	endif

	" line 11
	let l:line = getline(11)
	let l:matched = match(line, "^/\\* \\*\\{74} \\*/$")
	if strlen(l:line) != 80
		let s:ret = 0
		return
	endif
	if l:matched == -1
		let s:ret = 0
		return
	endif
endfunc

function! Append_Mail()
	let l:begin = "/*   By: "
	let l:end = "+#+  +:+       +#+        */"
	let l:mail = system("echo -n $MAIL | cut -c1-22 | tr -d '\n'")
	if l:mail == ""
		let l:mail = "marvin@42.fr"
	endif
	let l:len = strlen(l:begin) + strlen(l:end) + strlen(l:mail) + strlen(s:user) + 3
	let l:output = l:begin . s:user . " <" . l:mail . ">"
	while l:len < 80
		let l:output .= " "
		let l:len = l:len + 1
	endwhile
	call append(5, l:output . l:end)
endfunc

function! Append_Updated()
	let l:user = system("echo -n $USER | cut -c1-8 | tr -d '\n'")
	let l:begin = "/*   Updated: "
	let l:end = "###   ########.fr       */"
	let l:time = strftime("%Y/%m/%d %H:%M:%S")
	let l:len = strlen(l:user) + strlen(l:begin) + strlen(l:end) + strlen(l:time) + 4
	let l:output = l:begin . l:time . " by " . l:user
	while l:len < 80
		let l:output .= " "
		let l:len = l:len + 1
	endwhile
	call setline(9, l:output . l:end)
endfunc

function! Append_Filename()
	let l:begin = "/*   "
	let l:end = ":+:      :+:    :+:   */"
	let l:filename = strpart(expand("%:t"), 0, 42)
	let l:len = strlen(l:begin) + strlen(l:end) + strlen(l:filename)
	let l:output = l:begin . l:filename
	while l:len < 80
		let l:output .= " "
		let l:len = l:len + 1
	endwhile
	call append(3, l:output . l:end)
endfunc

function! Append_Created()
	let l:begin = "/*   Created: "
	let l:end = "#+#    #+#             */"
	let l:time = strftime("%Y/%m/%d %H:%M:%S")
	let l:len = strlen(s:user) + strlen(l:begin) + strlen(l:end) + strlen(l:time) + 4
	let l:output = l:begin . l:time . " by " . s:user
	while l:len < 80
		let l:output .= " "
		let l:len = l:len + 1
	endwhile
	call append(7, l:output . l:end)
endfunc

" FUNCTION CALLS
function! Update_Header()
	call Check_Header()
	if s:ret == 1
		call Append_Updated()
	endif
endfunc

function! Header_Gen()
	call Check_Header()	
	if s:ret == 0
		call Append_Header()
	endif
endfunc

function! Append_Header()
	call Get_User()
	call cursor(0,0)
	call append(0, "/* ************************************************************************** */")
	call append(1, "/*                                                                            */")
	call append(2, "/*                                                        :::      ::::::::   */")
	call Append_Filename()
	call append(4, "/*                                                    +:+ +:+         +:+     */")
	call Append_Mail()
	call append(6, "/*                                                +#+#+#+#+#+   +#+           */")
	call Append_Created()
	call Append_Updated()
	call append(9, "/*                                                                            */")
	call append(10, "/* ************************************************************************** */")
endfunc
