if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "bw"

highlight clear

" Ensure all other common syntax elements use default colors
m4_define(`hir', `highlight $1 guibg=NONE ctermbg=NONE guifg=NONE ctermfg=NONE cterm=NONE gui=NONE')m4_dnl
hir(Normal)
hir(Constant)
hir(Identifier)
hir(Statement)
hir(PreProc)
hir(Type)
hir(Special)
hir(Underlined)
hir(Todo)
hir(String)
hir(Function)
hir(Conditional)
hir(Repeat)
hir(Operator)
hir(Structure)
hir(LineNr)
hir(NonText)
hir(SpecialKey)
hir(Title)
hir(WarningMsg)
hir(DiffAdd)
hir(DiffChange)
hir(DiffDelete)
hir(DiffText)
hir(Folded)
hir(FoldColumn)
hir(SignColumn)
hir(VertSplit)
hir(TabLine)
hir(TabLineFill)
hir(TabLineSel)
hir(CursorLine)
hir(CursorColumn)
hir(QuickFixLine)
hir(PMenu)
hir(PMenuSel)
hir(PMenuSbar)
hir(PMenuThumb)
hir(ModeMsg)
hir(StatusLine)
hir(StatusLineNC)
hir(WinBar)
hir(Menu)
hir(Scrollbar)
hir(Tooltip)
hir(Visual)

" Customize comment color

hi Conceal       guifg=LightGrey         guibg=DarkGrey           ctermfg=LightGrey  ctermbg=DarkGrey                                     
hi NonText       guifg=Blue              gui=bold                 ctermfg=Blue                                                            

hi StatusLine    gui=reverse,bold        cterm=reverse,bold                                                                               
hi StatusLineNC  gui=reverse             cterm=reverse                                                                                    

hi TabLine       term=reverse            cterm=reverse            ctermfg=NONE       ctermbg=NONE      gui=reverse            guifg=NONE  guibg=NONE
hi TabLineFill   term=reverse            cterm=reverse            ctermfg=NONE       ctermbg=NONE      gui=reverse            guifg=NONE  guibg=NONE

hi WinBar        gui=bold                cterm=bold                                                                                       
hi WildMenu      guifg=Black             guibg=Yellow             ctermfg=Black      ctermbg=Yellow                                       

hi PmenuSbar     term=reverse            cterm=reverse            ctermfg=NONE       ctermbg=NONE      gui=reverse            guifg=NONE  guibg=NONE
hi Pmenu         term=reverse            cterm=reverse            ctermfg=NONE       ctermbg=NONE      gui=reverse            guifg=NONE  guibg=NONE
hi PmenuThumb    term=reverse            cterm=reverse            ctermfg=NONE       ctermbg=NONE      gui=reverse            guifg=NONE  guibg=NONE

hi Visual        term=reverse            cterm=reverse            ctermfg=NONE       ctermbg=NONE      gui=reverse            guifg=NONE  guibg=NONE
hi VisualNOS     term=reverse,underline  cterm=reverse,underline  ctermfg=NONE       ctermbg=NONE      gui=reverse,underline  guifg=NONE  guibg=NONE

hi  SpellBad    term=undercurl  cterm=undercurl  ctermfg=5  ctermbg=NONE  gui=undercurl  guifg=NONE  guibg=NONE guisp=DarkRed 
hi  SpellCap    term=undercurl  cterm=undercurl  ctermfg=5  ctermbg=NONE  gui=undercurl  guifg=NONE  guibg=NONE guisp=DarkYellow 
hi  SpellLocal  term=undercurl  cterm=undercurl  ctermfg=5  ctermbg=NONE  gui=undercurl  guifg=NONE  guibg=NONE guisp=Green 
hi  SpellRare   term=undercurl  cterm=undercurl  ctermfg=5  ctermbg=NONE  gui=undercurl  guifg=NONE  guibg=NONE guisp=DarkCyan 

"hi  DiffAdd     term=NONE  cterm=NONE  ctermfg=2   ctermbg=NONE  gui=NONE  guifg=White  guibg=DarkGreen
"hi  DiffChange  term=NONE  cterm=NONE  ctermfg=94  ctermbg=NONE  gui=NONE  guifg=White  guibg=DarkYellow
"hi  DiffDelete  term=NONE  cterm=NONE  ctermfg=1   ctermbg=NONE  gui=NONE  guifg=White  guibg=DarkRed
"hi  DiffText    term=NONE  cterm=NONE  ctermfg=4   ctermbg=NONE  gui=NONE  guifg=Blue   guibg=NONE
hi  DiffAdd     term=NONE  cterm=NONE  ctermfg=2   ctermbg=NONE  gui=NONE  guifg=Green       guibg=NONE
hi  DiffChange  term=NONE  cterm=NONE  ctermfg=94  ctermbg=NONE  gui=NONE  guifg=DarkYellow  guibg=NONE
hi  DiffDelete  term=NONE  cterm=NONE  ctermfg=1   ctermbg=NONE  gui=NONE  guifg=Red         guibg=NONE
hi  DiffText    term=NONE  cterm=NONE  ctermfg=4   ctermbg=NONE  gui=NONE  guifg=Blue        guibg=NONE

hi  Comment         term=NONE  cterm=NONE  ctermfg=248   ctermbg=NONE  gui=NONE  guifg=Grey  guibg=NONE
hi  FoldColumn      term=NONE  cterm=NONE  ctermfg=248   ctermbg=NONE  gui=NONE  guifg=Grey  guibg=NONE
hi  Folded          term=NONE  cterm=NONE  ctermfg=240   ctermbg=NONE  gui=NONE  guifg=Grey  guibg=NONE
hi  LineNr          term=NONE  cterm=NONE  ctermfg=248   ctermbg=NONE  gui=NONE  guifg=Grey  guibg=NONE
hi  NonText         term=NONE  cterm=NONE  ctermfg=248   ctermbg=NONE  gui=NONE  guifg=Grey  guibg=NONE
hi  SignColumn      term=NONE  cterm=NONE  ctermfg=240   ctermbg=NONE  gui=NONE  guifg=Grey  guibg=bg
hi  SpecialComment  term=NONE  cterm=NONE  ctermfg=248   ctermbg=NONE  gui=NONE  guifg=Grey  guibg=NONE
hi  SpecialKey      term=NONE  cterm=NONE  ctermfg=240   ctermbg=NONE  gui=NONE  guifg=Grey  guibg=bg
hi  ColorColumn     term=NONE  cterm=NONE  ctermbg=240   ctermfg=NONE  gui=NONE  guibg=LightGrey  guifg=NONE

"hi  String      ctermbg=NONE  ctermfg=NONE  guifg=Grey  cterm=NONE  gui=NONE
hi  Underlined  ctermbg=NONE  ctermfg=NONE  guifg=NONE  cterm=bold  gui=bold

hi  Normal           ctermbg=NONE    ctermfg=NONE     cterm=NONE         
hi  Constant         ctermbg=NONE    ctermfg=NONE     cterm=bold         
hi  Error            ctermbg=white   ctermfg=red      cterm=reverse      gui=reverse
hi  WarningMsg       ctermbg=NONE    ctermfg=red      cterm=NONE         
hi  Identifier       ctermbg=NONE    ctermfg=NONE     cterm=bold         gui=bold
hi  Ignore           ctermbg=NONE    ctermfg=NONE     cterm=NONE         
hi  PreProc          ctermbg=NONE    ctermfg=NONE     cterm=NONE         
hi  Special          ctermbg=NONE    ctermfg=NONE     cterm=italic       gui=italic
hi  Statement        ctermbg=NONE    ctermfg=NONE     cterm=bold         gui=bold
hi  Todo             ctermbg=NONE    ctermfg=NONE     cterm=reverse      gui=reverse
hi  Type             ctermbg=NONE    ctermfg=NONE     cterm=bold,italic  gui=bold,italic
hi  Title            ctermbg=NONE    ctermfg=NONE     cterm=NONE         
hi  CursorLine       ctermbg=NONE    ctermfg=NONE     cterm=NONE         
hi  LineNr           ctermbg=NONE    ctermfg=NONE     cterm=NONE         
hi  CursorLineNr     ctermbg=NONE    ctermfg=NONE     cterm=NONE         
hi  helpLeadBlank    ctermbg=NONE    ctermfg=NONE     cterm=NONE         
hi  helpNormal       ctermbg=NONE    ctermfg=NONE     cterm=NONE         
hi  PmenuSel         ctermbg=NONE    ctermfg=NONE     cterm=NONE         
hi  SpecialKey       ctermbg=NONE    ctermfg=NONE     cterm=NONE         
hi  IncSearch        ctermbg=green   ctermfg=black    cterm=NONE         
hi  Search           ctermbg=yellow  ctermfg=black    cterm=NONE         
hi  Directory        ctermbg=NONE    ctermfg=NONE     cterm=bold         
hi  MatchParen       ctermbg=NONE    ctermfg=NONE     cterm=reverse      gui=reverse
hi  SignColumn       ctermbg=NONE    ctermfg=NONE     cterm=NONE         
hi  MoreMsg          ctermbg=NONE    ctermfg=magenta  cterm=NONE         
hi  Question         ctermbg=NONE    ctermfg=NONE     cterm=NONE         
hi  Cursor           ctermbg=NONE    ctermfg=NONE     cterm=NONE         
hi  CursorColumn     ctermbg=NONE    ctermfg=NONE     cterm=NONE         
hi  QuickFixLine     ctermbg=NONE    ctermfg=NONE     cterm=NONE         
hi  ToolbarLine      ctermbg=NONE    ctermfg=NONE     cterm=NONE         
hi  ToolbarButton    ctermbg=NONE    ctermfg=NONE     cterm=NONE         
hi  debugPC          ctermbg=NONE    ctermfg=NONE     cterm=NONE         
hi  debugBreakpoint  ctermbg=NONE    ctermfg=NONE     cterm=NONE         
