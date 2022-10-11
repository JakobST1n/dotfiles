-- lualine
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

-- lsp
require("nvim-lsp-installer").setup()
local lspconfig = require'lspconfig'
local coq = require "coq"

-- setup language servers here
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

-- nvim-tree
require("nvim-tree").setup()
map("n", "<F3>", ":NvimTreeToggle<cr>", silentnoremap)

-- TagBar
map("n", "<F2>", ":TagbarToggle<cr>", silentnoremap)

-- gitsigns
require('gitsigns').setup()
map("n", "<leader>s", ":Gitsigns toggle_current_line_blame<cr>", silentnoremap)

-- fzf-lua
map("n", ";", ":FzfLua files<cr>", silentnoremap)

