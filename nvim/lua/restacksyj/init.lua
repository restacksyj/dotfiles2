require("restacksyj.set")
require("restacksyj.remap")
require("restacksyj.lazy_init")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})
local go_group = augroup("go_group", {})

vim.filetype.add({
    extension = {
        templ = 'templ',
    }
})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
		local cursor = vim.fn.getpos(".")
		if vim.v.event.operator == "y" then
			vim.fn.setpos(".", cursor_pos)
		end
	end,
})

autocmd("BufWritePre", {
	group = go_group,
	pattern = "*.go",
	callback = function()
		-- require("go.format").gofmt()
		-- require("go.format").goimport()
	end,
})

autocmd({ "VimEnter", "CursorMoved" }, {
	group = yank_group,
	pattern = "*",
	callback = function()
		cursor_pos = vim.fn.getpos(".")
	end,
})

augroup("OilLocalCwd", { clear = true })
autocmd("BufEnter", {
  group = "OilLocalCwd",
  callback = function(o)
    if o.match:find("^oil://") then
      vim.cmd("lcd " .. require("oil").get_current_dir())
    else
      vim.cmd("lcd " .. vim.fn.getcwd(-1))
    end
  end,
})

-- autocmd('LspAttach', {
--     group = ThePrimeagenGroup,
--     callback = function(e)
--         local opts = { buffer = e.buf }
--         vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
--         vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
--         vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
--         vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
--         vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
--         vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
--         vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
--         vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
--         vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
--         vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
--     end
-- })

-- To avoid adding comments in next line
vim.cmd([[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o]])
vim.cmd([[autocmd FileType php setlocal autoindent]])
vim.api.nvim_create_autocmd({ "BufRead" }, { command = ":delm a-zA-Z0-9" })

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
