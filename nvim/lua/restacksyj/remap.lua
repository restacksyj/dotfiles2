vim.g.mapleader = " "
vim.g.maplocalleader = ";"

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- when you use J in normal mode it joins the next line adds 2 spaces and keeps the cursor at the
-- same positon
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<C-y>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("i", "<C-d>", "<C-[>diwi")

vim.keymap.set("n", "<leader>ff", ":lua vim.lsp.buf.format(nil, 2000)<CR>")

vim.keymap.set("n", "<C-Tab>", "<C-^>")


-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
-- vim.keymap.set("n", "<leader>x", vim.cmd("!chmod +x %"), { silent = true })
vim.keymap.set("n", "<leader>ye", "<cmd>%y+<CR>")
vim.keymap.set("n", "<leader>fp", "<cmd>echo expand('%:p')<CR>")
vim.keymap.set("n", "<leader>yfp", "<cmd>let @+ = @% | echo 'Copied filepath'<CR>")
--vim.keymap.set("n", "\\", ":Neotree reveal toggle<CR>", { silent = true })
-- vim.keymap.set("n", "<leader>m", require("treesj").toggle)
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
--vim.keymap.set("n", "<leader>neo", "<cmd>Neorg index<CR>")
--vim.keymap.set("n", "<leader>ner", "<cmd>Neorg return<CR>")
--vim.keymap.set("n", "[c", function()
--	require("treesitter-context").go_to_context()
--end, { silent = true })

-- vim.keymap.set("n", "gp", "<Plug>PSInLinep<CR>")
