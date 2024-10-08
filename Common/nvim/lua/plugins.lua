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

  use 'tpope/vim-fugitive'
  use {
      'junegunn/fzf.vim',
      requires = { 'junegunn/fzf', 'kyazdani42/nvim-web-devicons' },
      config = function()
        vim.cmd [[
        let g:fzf_layout = { 'down': '40%' }

        autocmd! FileType fzf
        autocmd  FileType fzf set laststatus=0 noshowmode noruler
          \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

        let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
              \ 'bg':      ['bg', 'Normal'],
              \ 'hl':      ['fg', 'Comment'],
              \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
              \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
              \ 'hl+':     ['fg', 'Statement'],
              \ 'info':    ['fg', 'PreProc'],
              \ 'border':  ['fg', 'Ignore'],
              \ 'prompt':  ['fg', 'Conditional'],
              \ 'pointer': ['fg', 'Exception'],
              \ 'marker':  ['fg', 'Keyword'],
              \ 'spinner': ['fg', 'Label'],
              \ 'header':  ['fg', 'Comment'] }
        ]]
        vim.api.nvim_set_keymap("n", ";", ":Files<cr>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>;", ":Rg<cr>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader><leader>;", ":Lines<cr>", { noremap = true, silent = true })
      end,
  }

  -- Lsp things
  use {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig' ,
  }

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
        ]]
      end,
  }

  -- VimWiki stuff
  use {
      'vimwiki/vimwiki',
      config = function ()
          vim.g.vimwiki_global_ext = 0
          vim.g.vimwiki_auto_header = 1
          vim.g.vimwiki_links_space_char = '_'
          vim.g.vimwiki_url_maxsave = 0
          vim.g.vimwiki_auto_chdir = 1
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

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

