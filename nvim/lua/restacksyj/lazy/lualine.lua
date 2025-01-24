local function IsZoomedIn()
    if vim.t['simple-zoom'] == nil then
        return ''
    elseif vim.t['simple-zoom'] == 'zoom' then
        return '󰍉'
    end
end
return {
    "nvim-lualine/lualine.nvim",
    config = function()
        require("lualine").setup({
            options = {
                theme = "kanagawa"
            },
            sections = {
                lualine_a = {
                    { 'filename' },
                    { IsZoomedIn },
                }
            }
        })
    end
}
