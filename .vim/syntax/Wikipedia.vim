" Taken from http://en.wikipedia.org/wiki/Wikipedia:Text_editor_support#Vim

" Wikipedia syntax file for Vim
" Published on Wikipedia in 2003-04 and declared authorless.
" 
" Based on the HTML syntax file. Probably too closely based, in fact. There
" may well be name collisions everywhere, but ignorance is bliss, so they say.
"
" To do: plug-in support for downloading and uploading to the server.

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
  finish
endif
  let main_syntax = 'html'
endif

if version < 508
  command! -nargs=+ HtmlHiLink hi link <args>
else
  command! -nargs=+ HtmlHiLink hi def link <args>
endif

syn case ignore
if v:version >= 700
  syn spell toplevel
endif

" tags
syn region  htmlString   contained start=+"+ end=+"+ contains=htmlSpecialChar
syn region  htmlString   contained start=+'+ end=+'+ contains=htmlSpecialChar
syn match   htmlValue    contained "=[\t ]*[^'" \t>][^ \t>]*"hs=s+1
syn region  htmlEndTag             start=+</+      end=+>+ contains=htmlTagN

syn region  htmlTag                start=+<[^/]+   end=+>+ contains=htmlTagN,htmlString,htmlArg,htmlBadArg,htmlValue,htmlTagError,htmlEvent,htmlCssDefinition,@htmlPreproc,@htmlArgCluster

syn match   htmlTagN     contained +<\s*[-a-zA-Z0-9]\++hs=s+1 contains=htmlTagName,htmlSpecialTagName,htmlBadTag,@htmlTagNameCluster
syn match   htmlTagN     contained +</\s*[-a-zA-Z0-9]\++hs=s+2 contains=htmlTagName,htmlSpecialTagName,htmlBadTag,@htmlTagNameCluster
syn match   htmlTagError contained "[^>]<"ms=s+1
" This would highlight all tags and <whatevertext> fragments that are not allowed. 
"syn match   htmlBadTag   contained +<\s*[-a-zA-Z0-9]\++ms=s+1
" Highlight only known disallowed HTML tags, so that not every "<whatevertext>"
" fragment is flagged. 
syn keyword htmlBadTag   contained a acronym address applet area base basefont bdo body button col colgroup dfn dir fieldset form frame frameset head html iframe img input isindex kbd label legend link map menu meta noframes noscript object optgroup option param q script select style tbody textarea tfoot thead title 
syn match   htmlBadArg   contained "\s\+[-a-zA-Z0-9]\+\s*="ms=s+1,me=e-1

" allowed HTML tag names
syn keyword htmlTagName contained b big blockquote br caption center cite code dd del div dl dt em font h1 h2 h3 h4 h5 h6 hr i ins li ol p pre rb rp rt ruby s small span strike strong sub sup table td th tr tt u ul var
" allowed Wiki tag names
syn keyword htmlTagName contained nowiki math references

" allowed arg names
syn keyword htmlArg contained title align lang dir width height nowrap
syn keyword htmlArg contained bgcolor clear noshade
syn keyword htmlArg contained cite datetime size face color
syn keyword htmlArg contained type start value compact
syn keyword htmlArg contained summary border frame rules
syn keyword htmlArg contained cellspacing cellpadding valign char
syn keyword htmlArg contained charoff colgroup col span abbr axis
syn keyword htmlArg contained headers scope rowspan colspan
syn keyword htmlArg contained id class name style

" special characters
syn match htmlSpecialChar "&#\=[0-9A-Za-z]\{1,8};"

" comments
syn region htmlComment                start=+<!+      end=+>+   contains=htmlCommentPart,htmlCommentError
syn match  htmlCommentError contained "[^><!]"
syn region htmlCommentPart  contained start=+--+      end=+--\s*+  contains=@htmlPreProc
syn region htmlComment                  start=+<!DOCTYPE+ keepend end=+>+

" HTML formatting
syn cluster htmlTop contains=@Spell,htmlTag,htmlEndTag,htmlSpecialChar,htmlComment,htmlLink

syn region htmlBold start="<b\>" end="</b>"me=e-4 contains=@htmlTop,htmlBoldUnderline,htmlBoldItalic
syn region htmlBold start="<strong\>" end="</strong>"me=e-9 contains=@htmlTop,htmlBoldUnderline,htmlBoldItalic
syn region htmlBoldUnderline contained start="<u\>" end="</u>"me=e-4 contains=@htmlTop,htmlBoldUnderlineItalic
syn region htmlBoldItalic contained start="<i\>" end="</i>"me=e-4 contains=@htmlTop,htmlBoldItalicUnderline
syn region htmlBoldItalic contained start="<em\>" end="</em>"me=e-5 contains=@htmlTop,htmlBoldItalicUnderline
syn region htmlBoldUnderlineItalic contained start="<i\>" end="</i>"me=e-4 contains=@htmlTop
syn region htmlBoldUnderlineItalic contained start="<em\>" end="</em>"me=e-5 contains=@htmlTop
syn region htmlBoldItalicUnderline contained start="<u\>" end="</u>"me=e-4 contains=@htmlTop,htmlBoldUnderlineItalic

syn region htmlUnderline start="<u\>" end="</u>"me=e-4 contains=@htmlTop,htmlUnderlineBold,htmlUnderlineItalic
syn region htmlUnderlineBold contained start="<b\>" end="</b>"me=e-4 contains=@htmlTop,htmlUnderlineBoldItalic
syn region htmlUnderlineBold contained start="<strong\>" end="</strong>"me=e-9 contains=@htmlTop,htmlUnderlineBoldItalic
syn region htmlUnderlineItalic contained start="<i\>" end="</i>"me=e-4 contains=@htmlTop,htmUnderlineItalicBold
syn region htmlUnderlineItalic contained start="<em\>" end="</em>"me=e-5 contains=@htmlTop,htmUnderlineItalicBold
syn region htmlUnderlineItalicBold contained start="<b\>" end="</b>"me=e-4 contains=@htmlTop
syn region htmlUnderlineItalicBold contained start="<strong\>" end="</strong>"me=e-9 contains=@htmlTop
syn region htmlUnderlineBoldItalic contained start="<i\>" end="</i>"me=e-4 contains=@htmlTop
syn region htmlUnderlineBoldItalic contained start="<em\>" end="</em>"me=e-5 contains=@htmlTop

syn region htmlItalic start="<i\>" end="</i>"me=e-4 contains=@htmlTop,htmlItalicBold,htmlItalicUnderline
syn region htmlItalic start="<em\>" end="</em>"me=e-5 contains=@htmlTop
syn region htmlItalicBold contained start="<b\>" end="</b>"me=e-4 contains=@htmlTop,htmlItalicBoldUnderline
syn region htmlItalicBold contained start="<strong\>" end="</strong>"me=e-9 contains=@htmlTop,htmlItalicBoldUnderline
syn region htmlItalicBoldUnderline contained start="<u\>" end="</u>"me=e-4 contains=@htmlTop
syn region htmlItalicUnderline contained start="<u\>" end="</u>"me=e-4 contains=@htmlTop,htmlItalicUnderlineBold
syn region htmlItalicUnderlineBold contained start="<b\>" end="</b>"me=e-4 contains=@htmlTop
syn region htmlItalicUnderlineBold contained start="<strong\>" end="</strong>"me=e-9 contains=@htmlTop

syn region htmlH1 start="<h1\>" end="</h1>"me=e-5 contains=@htmlTop
syn region htmlH2 start="<h2\>" end="</h2>"me=e-5 contains=@htmlTop
syn region htmlH3 start="<h3\>" end="</h3>"me=e-5 contains=@htmlTop
syn region htmlH4 start="<h4\>" end="</h4>"me=e-5 contains=@htmlTop
syn region htmlH5 start="<h5\>" end="</h5>"me=e-5 contains=@htmlTop
syn region htmlH6 start="<h6\>" end="</h6>"me=e-5 contains=@htmlTop
syn region htmlHead start="<head\>" end="</head>"me=e-7 end="<body\>"me=e-5 end="<h[1-6]\>"me=e-3 contains=htmlTag,htmlEndTag,htmlSpecialChar,htmlPreProc,htmlComment,htmlLink,htmlTitle,cssStyle
syn region htmlTitle start="<title\>" end="</title>"me=e-8 contains=htmlTag,htmlEndTag,htmlSpecialChar,htmlPreProc,htmlComment

" No htmlTop and wikiPre inside HTML preformatted areas, because Wikipedia
" renders everything in there literally (HTML tags and entities, too): 
"   <pre> tags work as the combination of <nowiki> and the standard HTML <pre>
"   tag: the content will preformatted, and it will not be parsed, but shown as
"   in the wikitext source.
" With wikiPre, indented lines would be rendered differently from unindented
" lines.
syn match htmlPreTag /<pre>/ contains=htmlTag
syn match wikiNowikiTag /<nowiki>/ contains=htmlTag
syn match wikiNowikiEndTag /<\/nowiki>/ contains=htmlEndTag
" Note: Cannot use 'start="<pre>"rs=e', so still have the <pre> tag highlighted
" correctly via separate syn-match. Unfortunately, this will also highlight
" <pre> tags inside the preformatted region. 
syn region htmlPre start="<pre>" end="</pre>"me=e-6 contains=htmlPreTag
syn region wikiNowiki start="<nowiki>" end="</nowiki>"me=e-9 contains=wikiNowikiTag

" wiki formatting
syn region wikiItalic			start=+'\@<!'''\@!+	end=+''+ skip="<nowiki>.*</nowiki>" contains=@Spell,wikiLink,wikiItalicBold,wikiNowiki,wikiNowikiEndTag
syn region wikiBold				start=+'''+			end=+'''+ skip="<nowiki>.*</nowiki>" contains=@Spell,wikiLink,wikiBoldItalic,wikiNowiki,wikiNowikiEndTag
syn region wikiBoldAndItalic	start=+'''''+		end=+'''''+ skip="<nowiki>.*</nowiki>" contains=@Spell,wikiLink,wikiNowiki,wikiNowikiEndTag

syn region wikiBoldItalic	contained	start=+'\@<!'''\@!+	end=+''+ skip="<nowiki>.*</nowiki>" contains=@Spell,wikiLink,wikiNowiki,wikiNowikiEndTag
syn region wikiItalicBold	contained	start=+'''+			end=+'''+ skip="<nowiki>.*</nowiki>" contains=@Spell,wikiLink,wikiNowiki,wikiNowikiEndTag

syn region wikiH1 start="^=" 		end="=" 	skip="<nowiki>.*</nowiki>" oneline contains=@Spell,wikiLink,wikiNowiki,wikiNowikiEndTag
syn region wikiH2 start="^==" 		end="==" 	skip="<nowiki>.*</nowiki>" oneline contains=@Spell,wikiLink,wikiNowiki,wikiNowikiEndTag
syn region wikiH3 start="^===" 		end="===" 	skip="<nowiki>.*</nowiki>" oneline contains=@Spell,wikiLink,wikiNowiki,wikiNowikiEndTag
syn region wikiH4 start="^====" 	end="====" 	skip="<nowiki>.*</nowiki>" oneline contains=@Spell,wikiLink,wikiNowiki,wikiNowikiEndTag
syn region wikiH5 start="^=====" 	end="=====" 	skip="<nowiki>.*</nowiki>" oneline contains=@Spell,wikiLink,wikiNowiki,wikiNowikiEndTag
syn region wikiH6 start="^======" 	end="======" 	skip="<nowiki>.*</nowiki>" oneline contains=@Spell,wikiLink,wikiNowiki,wikiNowikiEndTag
syn region wikiLink start="\[\[" end="\]\]\(s\|'s\|es\|ing\|\)" skip="<nowiki>.*</nowiki>" oneline contains=wikiLink,wikiNowiki,wikiNowikiEndTag
syn region wikiLink start="\[http:" end="\]" skip="<nowiki>.*</nowiki>" oneline contains=wikiNowiki,wikiNowikiEndTag
syn region wikiLink start="\[https:" end="\]" skip="<nowiki>.*</nowiki>" oneline contains=wikiNowiki,wikiNowikiEndTag
syn region wikiLink start="\[ftp:" end="\]" skip="<nowiki>.*</nowiki>" oneline contains=wikiNowiki,wikiNowikiEndTag
syn region wikiLink start="\[gopher:" end="\]" skip="<nowiki>.*</nowiki>" oneline contains=wikiNowiki,wikiNowikiEndTag
syn region wikiLink start="\[news:" end="\]" skip="<nowiki>.*</nowiki>" oneline contains=wikiNowiki,wikiNowikiEndTag
syn region wikiLink start="\[mailto:" end="\]" skip="<nowiki>.*</nowiki>" oneline contains=wikiNowiki,wikiNowikiEndTag
syn region wikiTemplate start="{{" end="}}" skip="<nowiki>.*</nowiki>" contains=wikiNowiki,wikiNowikiEndTag

syn match wikiParaFormatChar /^[\:|\*|;|#]\+/
syn match wikiParaFormatChar /^-----*/
syn match wikiPre /^\ .*$/ contains=wikiNowiki,wikiNowikiEndTag

syn include @TeX syntax/tex.vim
syntax region wikiTeX matchgroup=htmlTag start="<math>" end="</math>" skip="<nowiki>.*</nowiki>" contains=@TeX,wikiNowiki,wikiNowikiEndTag
syntax region wikiRef matchgroup=htmlTag start="<ref>" end="</ref>" skip="<nowiki>.*</nowiki>" contains=wikiNowiki,wikiNowikiEndTag


" HTML highlighting

HtmlHiLink htmlTag                     Function
HtmlHiLink htmlEndTag                  Identifier
HtmlHiLink htmlArg                     Type
HtmlHiLink htmlTagName                 htmlStatement
HtmlHiLink htmlSpecialTagName          Exception
HtmlHiLink htmlValue                     String
HtmlHiLink htmlSpecialChar             Special

HtmlHiLink htmlH1                      Title
HtmlHiLink htmlH2                      htmlH1
HtmlHiLink htmlH3                      htmlH2
HtmlHiLink htmlH4                      htmlH3
HtmlHiLink htmlH5                      htmlH4
HtmlHiLink htmlH6                      htmlH5
HtmlHiLink htmlHead                    PreProc
HtmlHiLink htmlTitle                   Title
HtmlHiLink htmlBoldItalicUnderline     htmlBoldUnderlineItalic
HtmlHiLink htmlUnderlineBold           htmlBoldUnderline
HtmlHiLink htmlUnderlineItalicBold     htmlBoldUnderlineItalic
HtmlHiLink htmlUnderlineBoldItalic     htmlBoldUnderlineItalic
HtmlHiLink htmlItalicUnderline         htmlUnderlineItalic
HtmlHiLink htmlItalicBold              htmlBoldItalic
HtmlHiLink htmlItalicBoldUnderline     htmlBoldUnderlineItalic
HtmlHiLink htmlItalicUnderlineBold     htmlBoldUnderlineItalic

HtmlHiLink htmlSpecial            Special
HtmlHiLink htmlSpecialChar        Special
HtmlHiLink htmlString             String
HtmlHiLink htmlStatement          Statement
HtmlHiLink htmlComment            Comment
HtmlHiLink htmlCommentPart        Comment
HtmlHiLink htmlValue              String
HtmlHiLink htmlCommentError       htmlError
HtmlHiLink htmlTagError           htmlError
HtmlHiLink htmlBadTag             htmlError
HtmlHiLink htmlBadArg             htmlError
HtmlHiLink htmlEvent              javaScript
HtmlHiLink htmlError              Error

HtmlHiLink htmlCssStyleComment    Comment
HtmlHiLink htmlCssDefinition      Special

" The default highlighting.
if version >= 508 || !exists("did_html_syn_inits")
  if version < 508
    let did_html_syn_inits = 1
  endif
  HtmlHiLink htmlTag                     Function
  HtmlHiLink htmlEndTag                  Identifier
  HtmlHiLink htmlArg                     Type
  HtmlHiLink htmlTagName                 htmlStatement
  HtmlHiLink htmlSpecialTagName          Exception
  HtmlHiLink htmlValue                     String
  HtmlHiLink htmlSpecialChar             Special

if !exists("html_no_rendering")
    HtmlHiLink htmlH1                      Title
    HtmlHiLink htmlH2                      htmlH1
    HtmlHiLink htmlH3                      htmlH2
    HtmlHiLink htmlH4                      htmlH3
    HtmlHiLink htmlH5                      htmlH4
    HtmlHiLink htmlH6                      htmlH5
    HtmlHiLink htmlHead                    PreProc
    HtmlHiLink htmlTitle                   Title
    HtmlHiLink htmlBoldItalicUnderline     htmlBoldUnderlineItalic
    HtmlHiLink htmlUnderlineBold           htmlBoldUnderline
    HtmlHiLink htmlUnderlineItalicBold     htmlBoldUnderlineItalic
    HtmlHiLink htmlUnderlineBoldItalic     htmlBoldUnderlineItalic
    HtmlHiLink htmlItalicUnderline         htmlUnderlineItalic
    HtmlHiLink htmlItalicBold              htmlBoldItalic
    HtmlHiLink htmlItalicBoldUnderline     htmlBoldUnderlineItalic
    HtmlHiLink htmlItalicUnderlineBold     htmlBoldUnderlineItalic
    HtmlHiLink htmlLink			   Underlined
  if !exists("html_my_rendering")
    hi def htmlBold                term=bold cterm=bold gui=bold
    hi def htmlBoldUnderline       term=bold,underline cterm=bold,underline gui=bold,underline
    hi def htmlBoldItalic          term=bold,italic cterm=bold,italic gui=bold,italic
    hi def htmlBoldUnderlineItalic term=bold,italic,underline cterm=bold,italic,underline gui=bold,italic,underline
    hi def htmlUnderline           term=underline cterm=underline gui=underline
    hi def htmlUnderlineItalic     term=italic,underline cterm=italic,underline gui=italic,underline
    hi def htmlItalic              term=italic cterm=italic gui=italic
  endif
endif

  HtmlHiLink htmlPreStmt            PreProc
  HtmlHiLink htmlPreError           Error
  HtmlHiLink htmlPreProc            PreProc
  HtmlHiLink htmlPreAttr            String
  HtmlHiLink htmlPreProcAttrName    PreProc
  HtmlHiLink htmlPreProcAttrError   Error
  HtmlHiLink htmlSpecial            Special
  HtmlHiLink htmlSpecialChar        Special
  HtmlHiLink htmlString             String
  HtmlHiLink htmlStatement          Statement
  HtmlHiLink htmlComment            Comment
  HtmlHiLink htmlCommentPart        Comment
  HtmlHiLink htmlValue              String
  HtmlHiLink htmlCommentError       htmlError
  HtmlHiLink htmlTagError           htmlError
  HtmlHiLink htmlBadTag             htmlError
  HtmlHiLink htmlBadArg             htmlError
  HtmlHiLink htmlEvent              javaScript
  HtmlHiLink htmlError              Error

  HtmlHiLink javaScript             Special
  HtmlHiLink javaScriptExpression   javaScript
  HtmlHiLink htmlCssStyleComment    Comment
  HtmlHiLink htmlCssDefinition      Special
endif

" wiki highlighting

HtmlHiLink wikiItalic		htmlItalic
HtmlHiLink wikiBold		htmlBold

HtmlHiLink wikiBoldItalic	htmlBoldItalic
HtmlHiLink wikiItalicBold	htmlBoldItalic

HtmlHiLink wikiBoldAndItalic	htmlBoldItalic

HtmlHiLink wikiH1		htmlH1
HtmlHiLink wikiH2		htmlH2
HtmlHiLink wikiH3		htmlH3
HtmlHiLink wikiH4		htmlH4
HtmlHiLink wikiH5		htmlH5
HtmlHiLink wikiH6		htmlH6
HtmlHiLink wikiLink		Underlined
HtmlHiLink wikiTemplate		Special
HtmlHiLink wikiParaFormatChar	Special
HtmlHiLink wikiPre		Constant
HtmlHiLink wikiRef		Comment


let b:current_syntax = "html"

delcommand HtmlHiLink

if main_syntax == 'html'
  unlet main_syntax
endif

" Wikipedia prefers line breaks only at the end of paragraphs (like in a text
 " processor), which results in long, wrapping lines. 
setlocal wrap linebreak
setlocal textwidth=0

" No auto-wrap at all.
setlocal formatoptions-=tc formatoptions+=l
if v:version >= 602 | setlocal formatoptions-=a | endif

" Make navigation more amenable to the long wrapping lines. 
noremap <buffer> k gk
noremap <buffer> j gj
noremap <buffer> <Up> gk
noremap <buffer> <Down> gj
noremap <buffer> 0 g0
noremap <buffer> ^ g^
noremap <buffer> $ g$
noremap <buffer> D dg$ 
noremap <buffer> C cg$ 
noremap <buffer> A g$a

inoremap <buffer> <Up> <C-O>gk
inoremap <buffer> <Down> <C-O>gj

" utf-8 should be set if not already done globally
setlocal fileencoding=utf-8
setlocal matchpairs+=<:>

" Treat lists, indented text and tables as comment lines and continue with the
" same formatting in the next line (i.e. insert the comment leader) when hitting
" <CR> or using "o".
setlocal comments=n:#,n:*,n:\:,s:{\|,m:\|,ex:\|} 
setlocal formatoptions+=roq

" match HTML tags (taken directly from $VIM/ftplugin/html.vim)
if exists("loaded_matchit")
    let b:match_ignorecase=0
    let b:match_skip = 's:Comment'
    let b:match_words = '<:>,' .
    \ '<\@<=[ou]l\>[^>]*\%(>\|$\):<\@<=li\>:<\@<=/[ou]l>,' .
    \ '<\@<=dl\>[^>]*\%(>\|$\):<\@<=d[td]\>:<\@<=/dl>,' .
    \ '<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>'
endif

" Other useful mappings
" Insert a matching = automatically while starting a new header.
inoremap <buffer> <silent> = <C-R>=(getline('.')==''\|\|getline('.')=~'^=\+$')?"==\<Lt>Left>":"="<CR>

" Enable folding based on ==sections==
:set foldexpr=getline(v:lnum)=~'^\\(=\\+\\)[^=]\\+\\1\\(\\s*<!--.*-->\\)\\=\\s*$'?\">\".(len(matchstr(getline(v:lnum),'^=\\+'))-1):\"=\"
:set fdm=expr
