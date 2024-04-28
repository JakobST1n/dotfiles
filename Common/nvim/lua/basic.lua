--[[
  General
--]]

vim.opt.autoread = true
vim.opt.formatoptions:remove("t")
vim.opt.path:append("**")
vim.g.netrw_banner = 0
vim.opt.wildignore = '*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store'
vim.opt.smartcase = true
vim.opt.showmatch = true
vim.opt.swapfile = false
vim.opt.smartindent = true

--[[
  Convenience stuff
--]]

-- Default to the "modern normal"
vim.opt.expandtab   = true
vim.opt.shiftwidth  = 4
vim.opt.tabstop     = 4
vim.opt.softtabstop = 4

-- Disable highlight when <leader><cr> is pressed
vim.api.nvim_set_keymap('n', '<leader><cr>', ':noh<cr>', { noremap = true, silent = true })

-- Tab commands
vim.api.nvim_set_keymap('n', '<leader>tn', ':tabnext<cr>',  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tc', ':tabnew<cr>',   { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tx', ':tabclose<cr>', { noremap = true, silent = true })

-- Return to last edit position when opening files (You want this!)
vim.cmd [[
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]]

-- Colorscheme
vim.cmd [[ colorscheme default ]]
vim.opt.background = "light"
vim.opt.termguicolors = true
-- No idea why, preview in fzf does at least work extremely porly without this
vim.cmd [[ let $BAT_THEME = 'gruvbox-light' ]]

