return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
        config = function()
            vim.keymap.set("n", "<leader>lid", vim.cmd.IBLToggle, { silent = true })
        end
    },
    {
        'smoka7/hop.nvim',
        version = "*",
        opts = {},
        config = function()
            require("hop").setup({ keys = "etovxqpdygfblzhckisura" })
            vim.keymap.set("n", "<leader><leader>j", "<cmd>HopLine<CR>", { silent = true })
            vim.keymap.set("n", "<leader><leader>w", "<cmd>HopWord<CR>", { silent = true })
        end
    },
    {
        -- "iamcco/markdown-preview.nvim",
        -- cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        -- ft = { "markdown" },
        -- build = function() vim.fn["mkdp#util#install"]() end,
        -- Install markdown preview, use npx if available.
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function(plugin)
            if vim.fn.executable "npx" then
                vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
            else
                vim.cmd [[Lazy load markdown-preview.nvim]]
                vim.fn["mkdp#util#install"]()
            end
        end,
        init = function()
            if vim.fn.executable "npx" then vim.g.mkdp_filetypes = { "markdown" } end
        end,
    },
    {
        'nvim-tree/nvim-web-devicons',
    },
    {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
            relative_to_current_file = true,
            -- add options here
            -- or leave it empty to use the default settings
        },
        keys = {
            { "<leader>lp", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
        },

   }
}
