vim.filetype.add({ extension = { goon = "goon" } })

local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

configs.setup({
    -- Added java to ensure_installed!
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "go", "javascript", "nix", "php", "rust", "zig", "java" },

    sync_install = false,
    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
    },
})

require("treesitter-context").setup({
    enable = true,
    max_lines = 1, -- Matches Tony's minimal one-line context header!
    trim_scope = 'outer',
})
