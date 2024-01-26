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
        options = {
          theme = 'Tomorrow',
          component_separators = '',
          section_separators = ''
        },
        sections = {
          lualine_a = {'mode'},
          lualine_x = {'filetype'},
          lualine_y = {}
        },
        -- tabline = {
        --   lualine_z = {'tabs'}
        -- }
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
        map("n", "<leader><leader>;", ":BLines<cr>", silentnoremap)
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
  -- use { 'PatrickFeiring/tree-sitter-sql' }

  -- terryma/vim-multiple-cursors
  -- preservim/nerdcommenter

  -- Lsp things
  use {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig' ,
  }
  -- Language-specifics
  use 'simrat39/rust-tools.nvim'
  --use 'mfussenegger/nvim-jdtls'

  -- Completion framework:
  use 'hrsh7th/nvim-cmp'
  -- LSP completion source:
  use 'hrsh7th/cmp-nvim-lsp'
  -- Useful completion sources:
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/vim-vsnip'


  -- Goyo :)
  use {
      'junegunn/goyo.vim'
  }
  use { 'smithbm2316/centerpad.nvim' }

  -- Color picker
  use {
    "ziontee113/color-picker.nvim",
    config = function()
      require("color-picker")
    end,
  }

  -- Ledger
  use {
      'ledger/vim-ledger'
  }

  -- VimWiki stuff
  use {
      'vimwiki/vimwiki',
      config = function ()
          vim.g.vimwiki_list = {
            {
                path = '~/Nextcloud/2-Områder/204-profesjonelt/204.06-Infomedia/204.06.AA-wiki',
                syntax = 'markdown',
                ext = 'md',
                name = 'I45',
                auto_toc = 1,
                diary_frequency = 'daily',
                nested_syntaxes = {
                  python = 'python',
                  sql = 'sql',
                },
            },
            {
                path = '~/Nextcloud/wiki/M42',
                syntax = 'markdown',
                ext = 'md',
                name = 'M42',
                auto_toc = 1,
                nested_syntaxes = {
                  python = 'python',
                  sql = 'sql',
                },
            },
            {
                path = '~/Nextcloud/wiki/P01/',
                syntax = 'markdown',
                ext = 'md',
                name = 'P01',
                --nested_syntaxes = {
                --  python = 'python',
                --},
            },
          }
          vim.g.vimwiki_global_ext = 0
          vim.g.vimwiki_auto_header = 1
          vim.g.vimwiki_links_space_char = '_'
          vim.g.vimwiki_url_maxsave = 0
      end,
  }
  use {
      'mattn/calendar-vim',
      config = function()
        vim.g.calendar_monday = 1
        vim.g.calendar_weeknm = 5
        vim.api.nvim_create_autocmd("QuitPre", {
          callback = function()
          local invalid_win = {}
          local wins = vim.api.nvim_list_wins()
          for _, w in ipairs(wins) do
            local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
            if bufname:match("__Calendar") ~= nil then
              table.insert(invalid_win, w)
            end
          end
          if #invalid_win == #wins - 1 then
            for _, w in ipairs(invalid_win) do vim.api.nvim_win_close(w, true) end
          end
        end
        })
     end
  }

  -- packer.nvim
  use 'evanleck/vim-svelte'
  use 'pangloss/vim-javascript'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

