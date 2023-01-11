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
  -- Packer itself :)
  use 'wbthomason/packer.nvim'
  -- targets (extends vim's targets, allowing things like multiline select inside backticks)
  use 'wellle/targets.vim';

  -- GitSigns
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
      map("n", "<leader>s", ":Gitsigns toggle_current_line_blame<cr>", silentnoremap)
    end,
  }

  -- Lualine (Pretty statusbar and titlebar)
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup {
        options = { theme = 'onedark' },
        sections = {
          lualine_x = {'filetype'},
          lualine_y = {}
        },
        tabline = {
          lualine_a = {'buffers'},
          lualine_b = {'branch'},
          lualine_z = {'tabs'}
        }
      }
    end,
  }

  -- nvim-tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' },
    tag = 'nightly', -- optional, updated every week. (see issue #1193)
    config = function()
        require("nvim-tree").setup()
        map("n", "<F3>", ":NvimTreeToggle<cr>", silentnoremap)
    end,
  }

  -- TagBar
  use {
    'preservim/tagbar',
    config = function()
      map("n", "<F2>", ":TagbarToggle<cr>", silentnoremap)
    end,
  }

  -- Vim tmux navigator
  use 'christoomey/vim-tmux-navigator'

  -- fzf (Fuzzy finder for various things)
  use {
      'junegunn/fzf.vim',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = function()
        vim.cmd [[
        let g:fzf_layout = { 'down': '40%' }
        ]]
        map("n", ";", ":Files<cr>", silentnoremap)
        map("n", "<leader>;", ":Rg<cr>", silentnoremap)
      end,
  }

  -- Tpope plugins :)
  -- vim-dadbob (run sql directly)
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
  -- vim-fugitive (Git commands)
  use { 'tpope/vim-fugitive' }
  -- Surround
  use { 'tpope/vim-surround' }

  -- Tree-sitter-mysql
  use { 'PatrickFeiring/tree-sitter-sql' }

  -- terryma/vim-multiple-cursors
  -- preservim/nerdcommenter

  -- Lsp things
  use 'neovim/nvim-lsp'
  use {
    'neovim/nvim-lspconfig',
    config = function()
      local lsp_flags = {
        -- This is the default in Nvim 0.7+
        debounce_text_changes = 150,
      }
      local lspconfig = require('lspconfig')
      lspconfig['pyright'].setup{
          on_attach = on_attach,
          flags = lsp_flags,
      }
      lspconfig.ccls.setup {
        single_file_support = true;
        init_options = {
          compilationDatabaseDirectory = "build";
          index = {
            threads = 0;
          };
          clang = {
            excludeArgs = { "-frounding-math"} ;
          };
        }
      }
      
      lspconfig.ccls.setup{}
      lspconfig.intelephense.setup{}
      lspconfig.cssls.setup{}
      lspconfig.html.setup{}
      lspconfig.bashls.setup{}
    end,
  }
  --use 'kabouzeid/nvim-lspinstall'
  use {
    'williamboman/nvim-lsp-installer',
    config = function()

    end,
  }
  use 'ms-jpq/coq_nvim'

  use 'mfussenegger/nvim-jdtls'

  -- Goyo :)
  use {
      'junegunn/goyo.vim'
  }
  use { 'smithbm2316/centerpad.nvim' }

  -- packer.nvim
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

