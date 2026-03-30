require("mason").setup()
require("mason-lspconfig").setup({
    handlers = {
        function(server_name)
            vim.lsp.enable(server_name)
        end,
    }
})

vim.diagnostic.config({
    update_in_insert = true,
})

local highlights = {
    DiagnosticUnderlineError = { underline = false, bg = "LightRed" },
    DiagnosticUnderlineWarn  = { sp = "Orange", undercurl = true },
    DiagnosticUnderlineInfo  = { sp = "Cyan", undercurl = true },
    DiagnosticUnderlineHint  = { sp = "Cyan", undercurl = true },
    DiagnosticUnderlineOK = { underline = false },

    DiagnosticFloatingHint   = { link = "Normal" },
    DiagnosticFloatingInfo   = { link = "Normal" },
    DiagnosticFloatingWarn   = { link = "Normal" },
    DiagnosticFloatingOk     = { fg = "Green" },
}

for group, settings in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, settings)
end

vim.opt.updatetime = 300
vim.opt.signcolumn = 'yes'
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
