return {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    init = function()
        vim.g.vimtex_view_method = 'skim'
        --         vim.cmd([[
        --   filetype plugin indent on
        -- ]])
        --
        --         vim.cmd('syntax enable')
        -- vim.g.vimtex_compiler_method = 'skim'
        -- vim.g.maplocalleader = ','
    end
}
