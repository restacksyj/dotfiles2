return {
    "stevearc/oil.nvim",
    config=function()
        local oil = require("oil")

        oil.setup({
            view_options = {
                show_hidden = true,
            },
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-s>"] = false,
                ["<C-h>"] = false,
                ["<C-t>"] = false,
                ["<C-p>"] = false,
                ["<C-c>"] = "actions.close",
                ["<C-l>"] = false,
                ["<C-m>"] = false,
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = "actions.tcd",
                ["g."] = "actions.toggle_hidden",
            },
        })

        vim.keymap.set("n", "<leader>pv", vim.cmd.Oil, {silent = true})
    end
}
