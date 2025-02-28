-- function ColorMyPencils(color)
--     color = color or "kanagawa-dragon"
--     -- color = color or "rose-pine"
--     vim.cmd.colorscheme(color)
--
--     vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--     vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- end

return {
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = "storm",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        transparent = true,     -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = false },
          keywords = { italic = false },
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark", -- style for sidebars, see below
          floats = "dark",   -- style for floating windows
        },
      })
    end
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require('rose-pine').setup({
        disable_background = true,
      })

      -- vim.cmd("colorscheme rose-pine")
      --
      -- ColorMyPencils()
    end
  },
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    config = function()
      require('kanagawa').setup({
        colors = {
          palette = {
            sumiInk3 = "#0E0E0E",
          },
          theme = {
            all = {
              ui = {
                bg_gutter = "none"
              }
            }
          }
        }
      })

      vim.cmd("colorscheme kanagawa-dragon")
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

      -- ColorMyPencils()
    end
  }
  -- {
  --     "scottmckendry/cyberdream.nvim",
  --     lazy = false,
  --     priority = 1000,
  --     config = function()
  --         require("cyberdream").setup({
  --             transparent = true,
  --             borderless_telescope = true,
  --             terminal_colors = true,
  --         })
  --         vim.cmd("colorscheme cyberdream")
  --     end
  -- }

}
