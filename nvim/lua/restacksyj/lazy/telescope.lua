return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        local actions = require("telescope.actions")
        local builtin = require("telescope.builtin")
        local function telescope_buffer_dir()
            return vim.fn.expand("%:p:h")
        end
        require('telescope').setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-x>"] = false,
                        ["<C-q>"] = actions.smart_send_to_qflist,
                        ["<CR>"] = actions.select_default,
                    },
                    n = {
                        ["q"] = actions.close,
                    },
                },
            }


        })

        -- vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set("n", "<C-p>",  builtin.find_files, {})

        vim.keymap.set("n", "<leader>vrc", function()
           builtin.find_files({
               prompt_title = "< Dotfiles >",
               cwd = "~/.config/nvim",
               hidden = true,
           })
        end, {})

        local function isempty(s)
            return s == nil or s == ""
        end

        vim.keymap.set("n", "<leader>ps", function()
            local search_string = vim.fn.input("Grep > ")
            if not isempty(search_string) then
                builtin.grep_string({ search = search_string })
            else
                --  Very hacky way don't do it
                vim.cmd(":")
            end
        end)
        vim.keymap.set('n', '<leader>pw', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pW', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        -- vim.keymap.set("n", "<leader>gc", builtin.git_branches, {})
        vim.keymap.set("n", "<leader>fh", builtin.live_grep, {})
        vim.keymap.set("n", "<leader>dal", "<cmd>Telescope diagnostics<CR>", {})
        vim.keymap.set("n", "<leader>dl", function()
            builtin.diagnostics({ bufnr = 0 })
        end, {})
        -- vim.keymap.set("n", "<leader>pb", builtin.buffers, {})
        vim.keymap.set("n", "<leader>fj", function()
            builtin.current_buffer_fuzzy_find({ height = 10, previewer = false })
        end, {})

    end
}

