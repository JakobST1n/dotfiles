-- Mason Setup
require("mason").setup({
    ui = {
        icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
        },
    }
})
require("mason-lspconfig").setup({
    ensure_installed = { "rust_analyzer", "tsserver", "clangd", "intelephense", "pyright", "texlab", "jdtls", "sqlls" }
})
require("mason-lspconfig").setup_handlers {
    function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {}
    end,
}

-- LSP Diagnostics Options Setup
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = '!'})
sign({name = 'DiagnosticSignWarn', text = '!!'})
sign({name = 'DiagnosticSignHint', text = '?'})
sign({name = 'DiagnosticSignInfo', text = 'i'})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
})

vim.cmd [[
hi DiagnosticUnderlineError gui=none guibg='LightRed'
hi DiagnosticUnderlineWarn guisp='Orange' gui=undercurl
hi DiagnosticUnderlineInfo guisp='Cyan' gui=undercurl
hi DiagnosticUnderlineHint guisp='Cyan' gui=undercurl
hi DiagnosticUnderlineOk gui=none

hi link DiagnosticFloatingHint Normal
hi link DiagnosticFloatingInfo Normal
hi DiagnosticFloatingOk guifg=Green
hi link DiagnosticFloatingWarn Normal
]]

vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 300)

-- Enable signcolumn
vim.opt.signcolumn = 'yes'
-- Remove background in SignColumn, looks odd without this
vim.api.nvim_set_hl(0, "SignColumn", {link = "LineNr"})

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end
})
