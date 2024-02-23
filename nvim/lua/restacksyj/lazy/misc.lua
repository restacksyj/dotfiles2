return {
    { "lukas-reineke/indent-blankline.nvim", 
        main = "ibl", 
        opts = {} ,
        config=function()
            vim.keymap.set("n", "<leader>lid", vim.cmd.IBLToggle, { silent = true })
        end
    },
    {
        'smoka7/hop.nvim',
        version = "*",
        opts = {},
        config=function()
            require("hop").setup({ keys = "etovxqpdygfblzhckisura" })
            vim.keymap.set("n", "<leader><leader>j", "<cmd>HopLine<CR>", { silent = true })
            vim.keymap.set("n", "<leader><leader>w", "<cmd>HopWord<CR>", { silent = true })
        end
    }
}
