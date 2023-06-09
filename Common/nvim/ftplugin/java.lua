vim.opt.tabstop   = 4
vim.opt.expandtab = false

-- Solr
vim.opt.shiftwidth  = 4
vim.opt.tabstop     = 8
vim.opt.softtabstop = 4
vim.opt.expandtab   = false

local config = {
    cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        -- increase lombok Plug in support ,getter setter good bye
        "-javaagent:/home/jakob/.config/nvim/lsp/jdt-language-server/lombok.jar",
        "-Xbootclasspath/a:/home/jakob/.config/nvim/lsp/jdt-language-server/lombok.jar",
        "-jar",
        "/home/jakob/.config/nvim/lsp/jdt-language-server/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
        "-configuration",
        "/home/jakob/.config/nvim/lsp/jdt-language-server/config_linux",
        "-data",
        "/home/jakob/.config/nvim/lsp/jdt-language-server/workspace/folder"
    },
    root_dir = require("jdtls.setup").find_root({
        ".git", "mvnw", "gradlew"
    }),
    settings = {
        java = {
        }
    },
    init_options = {
        bundles = {
        }
    }
}

--require("jdtls").start_or_attach(config)

local current_buff = vim.api.nvim_get_current_buf
-- After the language server attaches to the current buffer
-- Use on_attach The function maps only the following keys
local java_on_attach = function(client, bufnr)
    --local function buf_set_keymap(...)
    --    vim.api.nvim_buf_set_keymap(bufnr, ...)
    --end

    -- Mappings.
    local opts = { noremap = true, silent = true }
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    --buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    --buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    --buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    --buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    --buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    --buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    --buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    --buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    --buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    -- rename
    --buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    -- Intelligent reminders , such as ： Automatic guiding package Has been used lspsaga The function in is replaced by
    --buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    --buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    --buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    --buf_set_keymap('n', '<C-j>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    --buf_set_keymap("n", "<S-C-j>", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    --buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    -- Code formatting
    --buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    --buf_set_keymap("n", "<leader>l", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    --buf_set_keymap("n", "<leader>l", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    -- Automatically import all missing packages , Automatically delete redundant and unused packages
    --buf_set_keymap("n", "<A-o>", "<cmd>lua require'jdtls'.organize_imports()<CR>", opts)
    -- Functions that introduce local variables function to introduce a local variable
    --buf_set_keymap("n", "crv", "<cmd>lua require('jdtls').extract_variable()<CR>", opts)
    --buf_set_keymap("v", "crv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
    --function to extract a constant
    --buf_set_keymap("n", "crc", "<Cmd>lua require('jdtls').extract_constant()<CR>", opts)
    --buf_set_keymap("v", "crc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", opts)
    -- Extract a piece of code into an additional function function to extract a block of code into a method
    --buf_set_keymap("v", "crm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)
    -- Code saving and automatic formatting formatting
    --vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
end

-- java_on_attach(nil, current_buff)
