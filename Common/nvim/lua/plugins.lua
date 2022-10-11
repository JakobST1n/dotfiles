-- Autoinstall packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Autocompile packer
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'lewis6991/gitsigns.nvim'
  --use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}
  use 'preservim/tagbar'
  use {
      'tpope/vim-dadbod',
      config = function()
        vim.cmd [[
        xnoremap <expr> <Plug>(DBExe)     db#op_exec()
        nnoremap <expr> <Plug>(DBExe)     db#op_exec()
        nnoremap <expr> <Plug>(DBExeLine) db#op_exec() . '_'

        xmap <leader>db  <Plug>(DBExe)
        nmap <leader>db  <Plug>(DBExe)
        omap <leader>db  <Plug>(DBExe)
        nmap <leader>dbb <Plug>(DBExeLine)

        autocmd FileType dbout setlocal nofoldenable

        if !empty(glob("~/.env.vim"))
            source ~/.env.vim
        endif
        ]]
      end,
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }
  use 'christoomey/vim-tmux-navigator'
  use {
      'ibhagwan/fzf-lua', requires = { 'kyazdani42/nvim-web-devicons' }
  }
  -- terryma/vim-multiple-cursors
  -- preservim/nerdcommenter

  use 'neovim/nvim-lsp'
  use 'neovim/nvim-lspconfig'
  --use 'kabouzeid/nvim-lspinstall'
  use 'williamboman/nvim-lsp-installer'
  use 'ms-jpq/coq_nvim'

  use 'mfussenegger/nvim-jdtls'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

