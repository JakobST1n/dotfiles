-- Load local configuration
-- For me this is usually something like
-- let g:vimwiki_list = [
--     \ {'name': 'I45', 'syntax': 'markdown', 'ext': 'md', 'auto_toc': 1, 'diary_frequency': 'monthly',
--     \  'path': '~/_library/I45/',
--     \  'nested_syntaxes': {'python': 'python', 'sql': 'sql', 'ioql': 'ioql'}},
--     \ {'name': 'P01', 'syntax': 'markdown', 'ext': 'md', 'auto_toc': 1, 
--     \  'path': '~/_library/',
--     \ }
--     \]
-- let g:db = "mysql://user@db001"
vim.cmd [[
if !empty(glob("~/.env.vim"))
    source ~/.env.vim
endif
]]

-- Convenient sudo saving of file
vim.api.nvim_create_user_command(
 'W', 'w !sudo tee % > /dev/null',
 {bang=true, desc='Save file using sudo'}
)

-- Toggles wether special characters are visible
list_chars_enabled = false
list_chars_when_enabled = "tab:→ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»"
function ToggleListChars()
  list_chars_enabled = not list_chars_enabled
  vim.opt.list = list_chars_enabled
  vim.opt.listchars = list_chars_enabled and list_chars_when_enabled or 'eol:$'
end
vim.keymap.set('n', '<leader><tab>', ToggleListChars, { noremap = true, silent = true })

-- Command to join lines in buffer as list
function JoinLines(args, quotes)
    r = args.args
    o = ""
    for k, v in pairs(vim.fn.getreg(r, 1, 1)) do
        if k > 1 then o = o .. ", " end
        if quotes ~= nil then o = o .. quotes end
        o = o .. v:match( "^%s*(.-)%s*$" )  -- Strip leading and trailing
        if quotes ~= nil then o = o .. quotes end
    end
    vim.fn.setreg(r, o)
end
function JoinLinesSQ(args) JoinLines(args, "'") end
function JoinLinesDQ(args) JoinLines(args, '"') end
function JoinLinesBT(args) JoinLines(args, "`") end
vim.api.nvim_create_user_command('JoinLines', JoinLines, {bang=false, desc='Joins all lines in a register', nargs='?'})
vim.api.nvim_create_user_command('JoinLinesSQ', JoinLinesSQ, {bang=false, desc='Joins all lines in a register', nargs='?'})
vim.api.nvim_create_user_command('JoinLinesDQ', JoinLinesDQ, {bang=false, desc='Joins all lines in a register', nargs='?'})
vim.api.nvim_create_user_command('JoinLinesBT', JoinLinesBT, {bang=false, desc='Joins all lines in a register', nargs='?'})

-- Strip trailing spaces
vim.keymap.set('n', '<Leader>wt', [[:%s/\s\+$//e<cr>]])

-- Quick json formatting using jq
function JsonFormat(start_line, end_line)
    if start_line == nil or end_line == nil then
        if vim.fn.mode() == 'v' then
            start_line, _, end_line, _ = unpack(vim.fn.getpos("'<"), 2, 5)
        else
            start_line, end_line = 1, vim.api.nvim_buf_line_count(0)
        end
    end
    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    local json_string = table.concat(lines, "\n")
    local handle = io.popen("echo '" .. json_string .. "' | jq .", "r")
    local result = handle:read("*a")
    handle:close()
    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, vim.fn.split(result, "\n"))
end
vim.api.nvim_create_user_command('JsonFormat', function(opts)
    JsonFormat(opts.line1, opts.line2)
end, {range = true, desc = 'Format JSON'})
vim.keymap.set('n', '<leader>jq', JsonFormat, { noremap = true, silent = true })
vim.keymap.set('v', '<leader>jq', ':JsonFormat<CR>', { noremap = true, silent = true })

function English()
    vim.opt.spell = true
    vim.opt.spelllang = "en_us"
end
vim.api.nvim_create_user_command('English', English, {bang=false, desc='Enables spellchecking for english'})
function Norsk()
    vim.opt.spell = true
    vim.opt.spelllang = "nb_no"
end
vim.api.nvim_create_user_command('Norsk', Norsk, {bang=false, desc='Enables spellchecking for norsk bokmål'})

-- enable filetype and such
function auto()
    vim.cmd [[
        filetype plugin on
        filetype indent on
    ]]
end
vim.api.nvim_create_user_command('A', auto, {bang=false, desc='Enable filetype plugin and indent'})

 -- Quick rerun of last command in terminal
 function rerun_last_command_in_any_terminal()
     local buffers = vim.api.nvim_list_bufs()
     local terminal_buf = nil

     for _, buf in ipairs(buffers) do
         if (vim.bo[buf].buftype == 'terminal') and (vim.fn.getbufinfo(buf)[1].hidden == 0) then
             terminal_buf = buf
             break
         end
     end

     if terminal_buf then
         local current_win = vim.api.nvim_get_current_win()
         local terminal_win = vim.fn.bufwinid(terminal_buf)

         if terminal_win ~= -1 then
             vim.api.nvim_set_current_win(terminal_win)
             vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('a<Up><CR>', false, false, true), 'n', false)
             vim.defer_fn(function() vim.api.nvim_set_current_win(current_win) end, 100) -- 100 ms delay
         end
     else
         print("No terminal buffer found")
     end
 end

 -- Map F5 to rerun the last command in any terminal buffer
 vim.api.nvim_create_user_command('RerunTermCommand', rerun_last_command_in_any_terminal, {bang=false, desc=''})
 vim.api.nvim_set_keymap('n', '<F5>', ':lua rerun_last_command_in_any_terminal()<CR>', {noremap = true, silent = true})

-- Look at history on range or line
vim.cmd [[
function! ShowCommitDiff(commit)
  " Extract the commit hash from the selected line (assuming it's the first word)
  let commit_hash = split(a:commit)[0]

  tabnew
  setlocal buftype=nofile
  setlocal bufhidden=delete

  " Use 'read !command' to insert the output of the git show command into the buffer
  execute 'read !git show ' . commit_hash

  setlocal nomodifiable
  set filetype=gitcommit
  normal! gg
endfunction

function! GitHistoryForLine(start_line, end_line)
  " Check if the range encompasses the entire file, which might indicate that no specific range was provided
  if a:start_line == 1 && a:end_line == line('$')
    " Default to the current line if it seems like the entire file is being selected
    let l:start_line = line('.')
    let l:end_line = l:start_line
  else
    let l:start_line = a:start_line
    let l:end_line = a:end_line
  endif

  let l:filepath = expand('%:p')
  let l:git_cmd = 'git log -w -C -C -C -s --pretty=format:"%h %s (%an)" -L '.l:start_line.','.l:end_line.':"'.l:filepath.'"'
  let l:options = '--delimiter " " --preview "git show {1}"'
  call fzf#vim#grep(l:git_cmd, 1, {'options': l:options, 'sink': function('ShowCommitDiff')}, 0)
endfunction

command! -range=% GitHistoryForLine call GitHistoryForLine(<line1>, <line2>)
nnoremap <leader><leader>s :GitHistoryForLine<CR>
vnoremap <leader><leader>s :'<,'>GitHistoryForLine<CR>
]]

-- Invert timestamp
function invertNumberUnderCursor()
    local word = vim.fn.expand("<cword>") -- Get the word under the cursor
    local number = tonumber(word)
    if number then
        local invertedNumber = 2147483648 - 1 - number
        -- Replace the word under the cursor with the inverted number
        vim.api.nvim_command('normal ciw'..invertedNumber)
    else
        print("The word under the cursor is not a valid number.")
    end
end
vim.cmd [[
command! InvertNumberUnderCursor lua invertNumberUnderCursor()
]]

-- helpful highlight when yanking text
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Reminders for system clipboard register
vim.api.nvim_set_keymap('v', '<leader>y', [[:lua vim.api.nvim_echo({{"Use register '+' for system clipboard", "ErrorMsg"}}, false, {})<CR>]], {noremap = true, silent=false})
vim.api.nvim_set_keymap('n', '<leader>y', [[:lua vim.api.nvim_echo({{"Use register '+' for system clipboard", "ErrorMsg"}}, false, {})<CR>]], {noremap = true, silent=false})

