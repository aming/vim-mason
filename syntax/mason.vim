" Vim syntax file
" Language:    Mason (Perl embedded in HTML)
" Maintainer:  AMing <https://github.com/aming>
" URL:	       https://github.com/aming/vim-mason
" Summary:
"   Vim syntax file for Mason file type
"   Base on the version of Andrew Smith from http://www.masonhq.com/editors/mason.vim
"
if version < 600
	syn clear
elseif exists("b:current_syntax")
	finish
endif

" The HTML syntax file included below uses this variable.
"
if !exists("main_syntax")
	let main_syntax = 'mason'
endif

" First pull in the HTML syntax.
"
if version < 600
	so <sfile>:p:h/html.vim
else
	runtime! syntax/html.vim
	unlet b:current_syntax
endif

syn cluster htmlPreproc add=@masonTop

" Now pull in the Perl syntax.
"
if version < 600
	syn include @perlTop <sfile>:p:h/perl.vim
else
	syn include @perlTop syntax/perl.vim
endif

" It's hard to reduce down to the correct sub-set of Perl to highlight in some
" of these cases so I've taken the safe option of just using perlTop in all of
" them. If you have any suggestions, please let me know.
"
syn region masonLine matchgroup=Delimiter start="^%" end="$" contains=@perlTop
syn region masonExpr matchgroup=Delimiter start="<%" end="%>" contains=@perlTop
syn region masonPerl matchgroup=Delimiter start="<%perl>" end="</%perl>" contains=@perlTop
syn region masonComp keepend matchgroup=Delimiter start="<&" end="&>" contains=@perlTop
syn region masonCompStart keepend matchgroup=Delimiter start="<&|" end="&>" contains=@perlTop
syn match masonCompEnd "</&>"
" syn region masonCompBlock keepend start="<&|[^>]*>" end="</&>"

syn region masonArgs matchgroup=Delimiter start="<%args>" end="</%args>" contains=@perlTop
syn region masonSharedVars matchgroup=Delimiter start="<%shared_vars>" end="</%shared_vars>" contains=@perlTop

syn region masonInit matchgroup=Delimiter start="<%init>" end="</%init>" contains=@perlTop
syn region masonCleanup matchgroup=Delimiter start="<%cleanup>" end="</%cleanup>" contains=@perlTop
syn region masonOnce matchgroup=Delimiter start="<%once>" end="</%once>" contains=@perlTop
syn region masonShared matchgroup=Delimiter start="<%shared>" end="</%shared>" contains=@perlTop

syn region masonDef matchgroup=Delimiter start="<%def[^>]*>" end="</%def>" contains=@htmlTop
syn region masonMethod matchgroup=Delimiter start="<%method[^>]*>" end="</%method>" contains=@htmlTop

syn region masonFlags matchgroup=Delimiter start="<%flags>" end="</%flags>" contains=@perlTop
syn region masonAttr matchgroup=Delimiter start="<%attr>" end="</%attr>" contains=@perlTop

syn region masonFilter matchgroup=Delimiter start="<%filter>" end="</%filter>" contains=@perlTop

syn region masonDoc matchgroup=Delimiter start="<%doc>" end="</%doc>"
syn region masonText matchgroup=Delimiter start="<%text>" end="</%text>"

syn cluster masonTop contains=masonLine,masonExpr,masonPerl,masonComp,masonArgs,masonSharedVars,masonInit,masonCleanup,masonOnce,masonShared,masonDef,masonMethod,masonFlags,masonAttr,masonFilter,masonDoc,masonText,masonCompStart,masonCompEnd

" Set up default highlighting. Almost all of this is done in the included
" syntax files.
"
if version >= 508 || !exists("did_mason_syn_inits")
	if version < 508
		let did_mason_syn_inits = 1
		com -nargs=+ HiLink hi link <args>
	else
		com -nargs=+ HiLink hi def link <args>
	endif

	HiLink masonDoc Comment
        HiLink masonCompEnd Delimiter

	delc HiLink
endif

let b:current_syntax = "mason"

if main_syntax == 'mason'
	unlet main_syntax
endif
