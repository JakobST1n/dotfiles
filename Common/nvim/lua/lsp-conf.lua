-- lsp
require("mason").setup()
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
