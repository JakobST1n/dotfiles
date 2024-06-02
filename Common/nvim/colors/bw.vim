if exists("syntax_on")
  syntax reset
endif

highlight clear

" Function to reset all highlight groups
function! ResetAllHighlights()
  " Get all highlight groups
  let highlight_groups = getcompletion('', 'highlight')
  
  " Reset each highlight group
  for group in highlight_groups
    exec 'highlight ' . group . ' guibg=NONE ctermbg=NONE guifg=NONE ctermfg=NONE cterm=NONE gui=NONE'
  endfor
endfunction

" Call the function to reset all highlights
call ResetAllHighlights()

let g:colors_name = "bw"

" Customize comment color
hi Conceal       guifg=LightGrey         guibg=DarkGrey           ctermfg=LightGrey  ctermbg=DarkGrey                                     
hi NonText       guifg=Blue              gui=bold                 ctermfg=Blue                                                            

hi StatusLine    gui=reverse,bold        cterm=reverse,bold                                                                               
hi StatusLineNC  gui=reverse             cterm=reverse                                                                                    

hi TabLine      term=reverse  cterm=reverse  gui=reverse
hi link TabLineFill TabLine

hi WinBar        gui=bold                cterm=bold                                                                                       

hi Pmenu         guibg=LightGray guifg=Black
hi PmenuSbar     term=reverse            cterm=reverse           gui=reverse
hi link PmenuThumb SBar
hi PmenuSel     guibg=Gray
hi link PmenuKind Pmenu
hi link PmenuExtraSel Pmenu
hi WildMenu guifg=Black guibg=Yellow ctermfg=Black ctermbg=Yellow                                       

hi link NormalFloat Pmenu

hi Visual        term=reverse            cterm=reverse           gui=reverse
hi VisualNOS     term=reverse,underline  cterm=reverse,underline gui=reverse,underline

hi SpellBad    term=undercurl  cterm=undercurl  ctermfg=5 gui=undercurl guisp=LightRed
hi SpellCap    term=undercurl  cterm=undercurl  ctermfg=5 gui=undercurl guisp=DarkYellow 
hi SpellLocal  term=undercurl  cterm=undercurl  ctermfg=5 gui=undercurl guisp=Green 
hi SpellRare   term=undercurl  cterm=undercurl  ctermfg=5 gui=undercurl guisp=LightCyan 

"hi DiffAdd     ctermfg=2   guifg=White  guibg=DarkGreen
"hi DiffChange  ctermfg=94  guifg=White  guibg=DarkYellow
"hi DiffDelete  ctermfg=1   guifg=White  guibg=DarkRed
"hi DiffText    ctermfg=4   guifg=Blue
hi DiffAdd     ctermfg=2   guifg=Green
hi DiffChange  ctermfg=94  guifg=DarkYellow
hi DiffDelete  ctermfg=1   guifg=Red
hi DiffText    ctermfg=4   guifg=Blue

hi Comment        ctermfg=248 guifg=Grey
hi link  FoldColumn      Comment
hi link  Folded          Comment
hi link  LineNr          Comment
hi link  NonText         Comment
hi link  SpecialComment  Comment
hi ColorColumn    ctermbg=240 guibg=LightGrey

hi  Underlined  cterm=bold  gui=bold

hi Error       ctermbg=white   ctermfg=red      cterm=reverse      gui=reverse
hi Identifier  cterm=bold         gui=bold
hi Special     cterm=italic       gui=italic
hi Statement   cterm=bold         gui=bold
hi Todo        cterm=reverse      gui=reverse
" hi Type        cterm=bold,italic  gui=bold,italic
" hi Constant    cterm=bold         
hi Directory   cterm=bold         

hi MatchParen  ctermbg=LightGray guibg=LightGray guifg=Black ctermfg=Black

hi MoreMsg     ctermfg=magenta

hi Search ctermbg=11 guibg=Yellow ctermfg=Black guifg=Black
hi link  IncSearch     Search
hi link  QuickFixLine  Search
hi link  Substitute  Search
hi CurSearch  ctermbg=11 guibg=DarkYellow guifg=Black ctermfg=Black
hi IncSearch cterm=reverse gui=reverse



"function! SetTheme()
"  if &background == 'dark'
"    hi Pmenu         guibg=LightGray guifg=Black
"  else
"  endif
"endfunction
"autocmd VimEnter * call SetTheme()
"autocmd OptionSet background call SetTheme()
