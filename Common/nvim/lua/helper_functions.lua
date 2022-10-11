-- opts that replicate the nore part of noremap
silentnoremap = { noremap = true, silent = true }

-- Just to make the map function "shorter"
function map(kind, lhs, rhs, opts)
  vim.api.nvim_set_keymap(kind, lhs, rhs, opts)
end

-- True if Paste Mode is enabled
function HasPaste()
  return vim.opt.paste:get() and 'PASTE MODE  ' or ''
end
vim.api.nvim_create_user_command('HasPaste', HasPaste, {bang=true, desc='Returns a string with PASTE MODE if paste is on.'})

-- Toggles wether special characters are visible
list_chars_enabled = false
list_chars_when_enabled = "tab:→ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»"
function ToggleListChars()
  list_chars_enabled = not list_chars_enabled
  vim.opt.list = list_chars_enabled
  vim.opt.listchars = list_chars_enabled and list_chars_when_enabled or 'eol:$'
end

-- Close buffer without closing window
--[[
vim.cmd [[
  function! <SID>BufcloseCloseIt()
     let l:currentBufNum = bufnr("%")
     let l:alternateBufNum = bufnr("#")

     if buflisted(l:alternateBufNum)
       buffer #
     else
       bnext
     endif

     if bufnr("%") == l:currentBufNum
       new
     endif

     if buflisted(l:currentBufNum)
       execute("bdelete! ".l:currentBufNum)
     endif
  endfunction
]]
--]]

vim.cmd [[
 function! CmdLine(str)
     exe "menu Foo.Bar :" . a:str
     emenu Foo.Bar
     unmenu Foo
 endfunction


 function! VisualSelection(direction, extra_filter) range
     let l:saved_reg = @"
     execute "normal! vgvy"

     let l:pattern = escape(@", "\\/.*'$^~[]")
     let l:pattern = substitute(l:pattern, "\n$", "", "")

     if a:direction == 'gv'
         call CmdLine("Ack '" . l:pattern . "' " )
     elseif a:direction == 'replace'
         call CmdLine("%s" . '/'. l:pattern . '/')
     endif

     let @/ = l:pattern
     let @" = l:saved_reg
 endfunction
]]
