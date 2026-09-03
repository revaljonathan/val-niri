-- Terminals: <leader>ft -> persistent bottom-split terminal (~35% height)
--             :Flterm      -> persistent centered floating terminal
-- Shells start in the directory of the file you're editing (falls back to nvim's cwd).

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

local BOTTOM_RATIO = 0.35

local terminals = {
    bottom = { buf = -1, win = -1 },
    floating = { buf = -1, win = -1 },
}

-- Directory of the current file, or nil to use nvim's working directory.
local function current_file_dir()
    local cur = vim.api.nvim_win_get_buf(0)
    local name = vim.api.nvim_buf_get_name(cur)
    if name ~= "" and vim.bo[cur].buftype == "" then
        local dir = vim.fn.fnamemodify(name, ":p:h")
        if vim.uv.fs_stat(dir) then
            return dir
        end
    end
    return nil
end

-- True if t.buf is a terminal whose shell process is still running.
local function session_alive(t)
    if not vim.api.nvim_buf_is_valid(t.buf) then
        return false
    end
    if vim.bo[t.buf].buftype ~= "terminal" then
        return false
    end
    local chan = vim.bo[t.buf].channel
    -- -1 means the job is still running; dead/closed jobs return >= 0 or -3
    return chan > 0 and vim.fn.jobwait({ chan }, 0)[1] == -1
end

-- Spawn a fresh interactive shell attached to the current buffer.
local function spawn_shell(dir)
    local opts = { term = true }
    if dir then
        opts.cwd = dir
    end
    vim.fn.jobstart(vim.o.shell, opts)
    vim.cmd("startinsert!")
end

local function toggle_bottom()
    local dir = current_file_dir()

    if vim.api.nvim_win_is_valid(terminals.bottom.win) then
        vim.api.nvim_win_close(terminals.bottom.win, false)
        return
    end

    local fresh = not session_alive(terminals.bottom)
    if fresh then
        terminals.bottom.buf = vim.api.nvim_create_buf(false, true)
    end

    vim.cmd("belowright split")
    terminals.bottom.win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(0, terminals.bottom.buf)
    vim.api.nvim_win_set_height(0, math.floor(vim.o.lines * BOTTOM_RATIO))

    if fresh then
        spawn_shell(dir)
    else
        vim.cmd("startinsert!")
    end
end

local function toggle_floating()
    local dir = current_file_dir()

    if vim.api.nvim_win_is_valid(terminals.floating.win) then
        vim.api.nvim_win_hide(terminals.floating.win)
        return
    end

    local fresh = not session_alive(terminals.floating)
    if fresh then
        terminals.floating.buf = vim.api.nvim_create_buf(false, true)
    end

    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    terminals.floating.win = vim.api.nvim_open_win(terminals.floating.buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = math.floor((vim.o.lines - height) / 2),
        col = math.floor((vim.o.columns - width) / 2),
        style = "minimal",
        border = "rounded",
    })

    if fresh then
        spawn_shell(dir)
    else
        vim.cmd("startinsert!")
    end
end

vim.api.nvim_create_user_command("Flterm", toggle_floating, {})
vim.api.nvim_create_user_command("Bterm", toggle_bottom, {})
vim.keymap.set("n", "<leader>ft", toggle_bottom, { silent = true, desc = "Toggle terminal (bottom)" })
