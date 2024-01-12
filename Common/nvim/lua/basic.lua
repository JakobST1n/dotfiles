--[[
General
--]]

-- Lines of history
vim.opt.history = 500
-- Line numbers
vim.opt.nu = true

-- Autoread when file is changed outside vim
vim.opt.autoread = true

-- enable filetype plugins
vim.cmd [[
  filetype plugin on
  filetype indent on
]]

-- Use a mapleader
--vim.opt.mapleader = ","
vim.g.mapleader   = ","

-- Fast saving
map('n', '<leader>w', ':w!<cr>', silentnoremap)

-- Convenient sudo saving of file
vim.api.nvim_create_user_command(
 'W', 'w !sudo tee % > /dev/null',
 {bang=true, desc='Save file using sudo'}
)

-- Disable the auto line wrap
vim.cmd [[ set formatoptions-=t ]]

--[[
VIM User interface
--]]

-- Set 3 lines to the cursor - when moving vertically using j/k
vim.opt.so = 3

-- set WildMenu
--vim.opt.wildmenu = true

-- Ignore compiled files
vim.opt.wildignore = '*.o,*~,*.pyc'
vim.opt.wildignore:append('*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store')

-- Always show current position
--vim.opt.ruler = true

-- Hide buffers when they are abandoned
vim.opt.hid = true

-- Make backspace function normally
vim.opt.backspace = 'eol,start,indent'
vim.opt.whichwrap:append('<,>,h,l')

-- Ignore case when searching
vim.opt.ignorecase = true

-- Be smart about cases when searching
-- If search has uppercases, then we want to respect case
vim.opt.smartcase = true

-- Highlight search results
vim.opt.hlsearch = true

-- Make search act like search in modern browsers
vim.opt.incsearch = true

-- Turn on "magic" for regular expressions
vim.opt.magic = true

-- Show matching brackets when cursor is over one
vim.opt.showmatch = true
vim.opt.mat = 2

-- Turn off annoying bells aon errors
--vim.opt.noerrorbells = false
--vim.opt.novisualbell = false
--vim.opt.t_vb = ''
--vim.opt.tm = 500

-- Add extra margin to the left (makes changing margins less annoying
vim.opt.foldcolumn = '1'

-- Show leader commands
vim.opt.showcmd = true

-- Show colour column
vim.opt.colorcolumn = '80,120'
vim.cmd [[ highlight ColorColumn ctermbg=16 ]]

-- => Colors and Fonts

-- Enable syntac highlighting
--vim.opt.syntax = 'enable'

-- Colorscheme
-- default
vim.cmd [[ colorscheme default ]]
vim.cmd [[ set background=light ]]

-- Workaround for gutter color
vim.cmd [[
highlight! link SignColumn LineNr
autocmd ColorScheme * highlight! link SignColumn LineNr
]]

-- Change git colors
--vim.api.nvim_set_hl(0, "DiffAdd", {fg = "#bada9f", bg = "None"})
--vim.api.nvim_set_hl(0, "DiffChange", {fg = "Purple", bg = "None"})
--vim.api.nvim_set_hl(0, "DiffDelete", {fg = "Red", bg = "None"})
--vim.api.nvim_set_hl(0, "DiffText", {fg = "Yellow", bg = "None"})

-- Set utf8 as standard encoding
vim.opt.encoding = 'utf8'

-- Use Unix as the standard file type
vim.opt.ffs = 'unix,dos,mac'

--[[
Files, backups and undo
--]]
vim.opt.swapfile = false

--[[
Text, tab and indent related
--]]

-- Use spaces instead of tabs
vim.opt.expandtab = true

-- Be smart when using tabs
vim.opt.smarttab = true

-- 1 tab is 4 spaces
vim.opt.shiftwidth  = 4
vim.opt.tabstop     = 4
vim.opt.softtabstop = 4

-- Linebreak on 500 ch
vim.opt.lbr = true
vim.opt.tw = 500

-- Auto indent
vim.opt.ai = true
-- Smart indent
vim.opt.si = true
-- Wrap lines
vim.opt.wrap = true

--[[
Visual mode related
--]]
map('v', '<silent> *', ':<C-u>call VisualSelection("","")<CR>/<C-R>=@/<CR><CR>', silentnoremap)
map('v', '<silent> #', ':<C-u>call VisualSelection("","")<CR>?<C-R>=@/<CR><CR>', silentnoremap)

--[[
Moving around, tabs, windows and buffers
--]]
-- Disable highlight when <leader><cr> is pressed
map('n', '<leader><cr>', ':noh<cr>', silentnoremap)

-- Smart way to move between windows
map('', '<C-j>', '<C-W>j', silentnoremap)
map('', '<C-k>', '<C-W>k', silentnoremap)
map('', '<C-h>', '<C-W>h', silentnoremap)
map('', '<C-l>', '<C-W>l', silentnoremap)

-- Close current buffer
map('n', '<leader>bd', ':Bclose<cr>:tabclose<cr>gT', silentnoremap)
-- Close all buffers
map('n', '<leader>ba', ':bufdo bd<cr>', silentnoremap)
-- Navigate buffers
map('n', '<leader>l', ':bnext<cr>', silentnoremap)
map('n', '<leader>h', ':bprevious<cr>', silentnoremap)

-- Tab commands
map('n', '<leader>tn',  ':tabnew<cr>', silentnoremap)
map('n', '<leader>to',  ':tabonly<cr>', silentnoremap)
--map('n', '<leader>tc',  ':tabclose<cr>', silentnoremap)
map('n', '<leader>tm',  ':tabmove', silentnoremap)
map('n', '<leader>t<leader>', ':tabnext', silentnoremap)

-- Switch CWD to directory of the open buffer
map('n', '<leader>cd', ':cd %:p:h<cr>:pwd<cr', silentnoremap)

-- Behaviour when switching between buffers
vim.opt.switchbuf = 'useopen,usetab,newtab'

-- Always show tabbar
vim.opt.stal = 2

-- Return to last edit position when opening files (You want this!)
vim.cmd [[
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]]

-- Make mouse work nice with tmux
vim.opt.mouse = 'a'

--[[
Status Line
--]]

-- Always show status line
vim.opt.laststatus = 2

--[[
Mappings
--]]

-- Move a line of text using ALT+[jk]
map('n', '<M-j>', 'mz:m+<cr>`z', silentnoremap)
map('n', '<M-k>', 'mz:m-2<cr>`z', silentnoremap)
map('v', '<M-j>', ":m'>+<cr>`<my`>mzgv`yo`z", silentnoremap)
map('v', '<M-k>', ":m'<-2<cr>`>my`<mzgv`yo`z", silentnoremap)

-- Move line using Command+[jk] on mac
if vim.fn.has("mac") or vim.fn.has("macunix") then
  map('n', '<D-j>', '<M-j>', silentnoremap)
  map('n', '<D-k>', '<M-k>', silentnoremap)
  map('v', '<D-j>', '<M-j>', silentnoremap)
  map('v', '<D-k>', '<M-k>', silentnoremap)
end

-- Interact with system clipboard
map('v', '<leader>y', '"+y', noremap)
map('n', '<leader>Y', '"+yg_', noremap)
map('n', '<leader>y', '"+y', noremap)

map('v', '<leader>p', '"+p', noremap)
map('v', '<leader>P', '"+P', noremap)
map('n', '<leader>p', '"+p', noremap)
map('n', '<leader>P', '"+P', noremap)

-- Delete trailing whitespace on save
--vim.api.nvim_create_autocmd("BufWritePre", {
--  pattern = { "*" },
--  command = [[%s/\s\+$//e]]
--})

--[[
Misc
--]]

-- Scribble buffer
map('n', '<leader>q', ':e ~/buffer<cr>', silentnoremap)

-- Toggle paste mode
map('n', '<leader>pp', ':setlocal paste!<cr>', silentnoremap)

-- Send file-title to tmux
vim.opt.titlestring = [[%f %h%m%r%w%{v:progname} (%{tabpagenr()} of %{tabpagenr('$')}})]]
vim.opt.title = true

-- Toggle displaying special characters
vim.keymap.set('n', '<leader><tab>', ToggleListChars, silentnoremap)

-- Load and save session
map('n', '<leader>sm', ':mksession! vim_session.vim<cr>', silentnoremap)
map('n', '<leader>sl', ':source vim_session.vim<cr>', silentnoremap)

-- Dont't close window when deleting buffer
--vim.api.nvim_create_user_command("Bclose",
--  "<SID>BufcloseCloseIt()",
--  {bang = true}
--)

--[[
Debugging
--]]
vim.g.termdebug_popup = 0
vim.g.termdebug_wide = 163
vim.cmd([[:packadd termdebug]])



-- This is to get rid of weird artifacts with text showing up inside buffer.
vim.opt.title = false
