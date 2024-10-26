return {
    "stevearc/oil.nvim",
    config = function()
        local oil = require("oil")
        local detail = false
        package.loaded["oil.adapters.trash"] = require("oil.adapters.trash.freedesktop")
        function _G.get_oil_winbar()
            local dir = require("oil").get_current_dir()
            if dir then
                return vim.fn.fnamemodify(dir, ":~")
            else
                -- If there is no current directory (e.g. over ssh), just show the buffer name
                return vim.api.nvim_buf_get_name(0)
            end
        end

        oil.setup({
            view_options = {
                show_hidden = true,
                natural_order = true,
                is_always_hidden = function(name, _)
                    return name == ".." or name == ".git"
                end
            },
            win_options = {
                winbar = "%!v:lua.get_oil_winbar()",
            },
            columns = {
                "icon",
            },
            delete_to_trash = true,
            skip_confirm_for_simple_edits = true,
            keymaps = {
                ["gd"] = {
                    desc = "Toggle file detail view",
                    callback = function()
                        detail = not detail
                        if detail then
                            require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
                        else
                            require("oil").set_columns({ "icon" })
                        end
                    end,
                },
                ["<leader>yfp"] = {
                    desc = 'Copy filepath to system clipboard',
                    callback = function()
                        require('oil.actions').copy_entry_path.callback()
                        vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
                    end,
                },
                ["<leader>lo"] = {
                    desc = 'Open current path in finder',
                    callback = function()
                        vim.cmd('silent !open .')
                    end,
                },
                ["<leader>ld"] = {
                    desc = 'Open Downloads folder',
                    callback = function()
                        require('oil').toggle_float("~/Downloads/")
                    end,
                },
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-s>"] = false,
                ["<C-h>"] = false,
                ["<C-t>"] = false,
                ["<C-p>"] = false,
                ["<C-c>"] = "actions.close",
                ["<C-l>"] = false,
                ["<leader>r"] = "actions.refresh",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = "actions.tcd",
                ["g."] = "actions.toggle_hidden",
            },
        })

        vim.keymap.set("n", "<leader>pv", vim.cmd.Oil, { silent = true })
    end
}
