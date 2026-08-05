local uv = vim.uv or vim.loop
local config_path = vim.fn.stdpath("config")
local watch_dir = config_path .. "/after/plugin"
local target_file = "matugen_colors.lua"

local debounce_timer = nil

local function reload_matugen()
    -- Use debounce to avoid multiple reloads in quick succession
    if debounce_timer then
        debounce_timer:stop()
        debounce_timer:close()
    end
    
    debounce_timer = uv.new_timer()
    debounce_timer:start(100, 0, vim.schedule_wrap(function()
        pcall(dofile, config_path .. "/after/plugin/bufferline.lua")
        pcall(dofile, config_path .. "/after/plugin/colors.lua")
        pcall(dofile, config_path .. "/after/plugin/one-liners.lua")
        pcall(function() require("bufferline.highlights").reset_icon_hl_cache() end)
        vim.cmd("redraw!")
        vim.cmd("redrawstatus")
        vim.cmd("redrawtabline")
        
        debounce_timer:stop()
        debounce_timer:close()
        debounce_timer = nil
    end))
end

local w = uv.new_fs_event()
if w then
    w:start(watch_dir, {}, vim.schedule_wrap(function(err, filename, events)
        if not err and filename == target_file then
            reload_matugen()
        end
    end))
end
