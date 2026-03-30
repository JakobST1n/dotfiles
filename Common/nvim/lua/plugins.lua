vim.pack.add({
    'https://github.com/tpope/vim-fugitive',
    'https://github.com/tpope/vim-dadbod',
    -- Fzf
    'https://github.com/junegunn/fzf',
    'https://github.com/junegunn/fzf.vim',
    -- LSP
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/mason-org/mason.nvim',
    'https://github.com/mason-org/mason-lspconfig.nvim'
})

-- Fzf setup
vim.cmd [[
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
]]
vim.g.fzf_layout = { down = "40%" }
vim.api.nvim_set_keymap("n", ";", ":Files<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>;", ":Rg<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader><leader>;", ":Lines<cr>", { noremap = true, silent = true })

-- Vim-dadbod setup
vim.cmd [[
xnoremap <expr> <Plug>(DBExe)     db#op_exec()
nnoremap <expr> <Plug>(DBExe)     db#op_exec()
nnoremap <expr> <Plug>(DBExeLine) db#op_exec() . '_'

xmap <leader>db  <Plug>(DBExe)
nmap <leader>db  <Plug>(DBExe)
omap <leader>db  <Plug>(DBExe)
nmap <leader>dbb <Plug>(DBExeLine)

autocmd FileType dbout setlocal nofoldenable
]]

