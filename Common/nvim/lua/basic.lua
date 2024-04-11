--[[
General
--]]

-- Lines of history
vim.opt.history = 500
-- Line numbers
vim.opt.nu = false

-- Autoread when file is changed outside vim
vim.opt.autoread = true

-- Convenient sudo saving of file
vim.api.nvim_create_user_command(
 'W', 'w !sudo tee % > /dev/null',
 {bang=true, desc='Save file using sudo'}
)

-- Disable the auto line wrap
vim.opt.formatoptions:remove("t")

-- Make find more usefull
vim.opt.path:append("**")

-- Turn off netrw banner
vim.g.netrw_banner = 0
-- Tree style listing in netrw
vim.g.netrw_liststyle = 1
-- Make browse set split
-- vim.g.netrw_browse_split = 4
-- Split to the right, instead of to the left
-- vim.g.netrw_altv = 1

--[[
VIM User interface
--]]

-- Set 3 lines to the cursor - when moving vertically using j/k
-- vim.opt.so = 3

-- set WildMenu
--vim.opt.wildmenu = true

-- Ignore compiled files
vim.opt.wildignore = '*.o,*~,*.pyc'
vim.opt.wildignore:append('*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store')

-- Always show current position
--vim.opt.ruler = true

-- Hide buffers when they are abandoned
-- vim.opt.hid = true

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

-- Left column option, used to have it at 1 to always show it. But Gitsigns is not using it anyway
vim.opt.foldcolumn = '0'

-- Show leader commands
vim.opt.showcmd = true

-- Colorscheme
vim.cmd [[ colorscheme default ]]
vim.opt.background = "light"
vim.opt.termguicolors = true
-- No idea why, preview in fzf does at least work extremely porly without this
vim.cmd [[ let $BAT_THEME = 'gruvbox-light' ]]

-- Workaround for gutter color, to remove background?
vim.api.nvim_set_hl(0, "SignColumn", {link = "LineNr"})
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        vim.api.nvim_set_hl(0, "SignColumn", {link = "LineNr"})
    end
}) 

-- Show colour column
vim.opt.colorcolumn = '80,120'
vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = "lightgrey", bg = "#eae7da" })

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

-- Auto indent
vim.opt.ai = true

-- Smart indent
vim.opt.si = true

-- Wrap lines
vim.opt.wrap = true

--[[
Moving around, tabs, windows and buffers
--]]
-- Disable highlight when <leader><cr> is pressed
map('n', '<leader><cr>', ':noh<cr>', silentnoremap)

-- Tab commands
map('n', '<leader>tn', ':tabnext<cr>', silentnoremap)
map('n', '<leader>tc',  ':tabnew<cr>', silentnoremap)
map('n', '<leader>tx',  ':tabclose<cr>', silentnoremap)

-- Always show tabbar
vim.opt.stal = 1

-- Return to last edit position when opening files (You want this!)
vim.cmd [[
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]]

--[[
Status Line
--]]

-- Always show status line
vim.opt.laststatus = 2

--[[
Mappings
--]]

-- Interact with system clipboard
map('v', '<leader>y', '"+y', noremap)
map('n', '<leader>Y', '"+yg_', noremap)
map('n', '<leader>y', '"+y', noremap)

map('v', '<leader>p', '"+p', noremap)
map('v', '<leader>P', '"+P', noremap)
map('n', '<leader>p', '"+p', noremap)
map('n', '<leader>P', '"+P', noremap)

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

--[[
Debugging
--]]
vim.g.termdebug_popup = 0
vim.g.termdebug_wide = 163
vim.cmd([[:packadd termdebug]])


-- This is to get rid of weird artifacts with text showing up inside buffer.
vim.opt.title = false
