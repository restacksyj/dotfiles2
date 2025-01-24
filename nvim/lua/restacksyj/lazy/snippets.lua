return {
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",

        dependencies = { "rafamadriz/friendly-snippets" },

        config = function()
            require("luasnip/loaders/from_vscode").lazy_load()
            local ls = require("luasnip")
            local s = ls.snippet
            local i = ls.insert_node
            local t = ls.text_node

            ls.add_snippets("php", {
                s("li", {
                    t('\\Log::info("'),
                    i(1),
                    t('");'),
                }),
            })

            ls.add_snippets("php", {
                s("liv", {
                    t("\\Log::info($"),
                    i(1),
                    t(");"),
                }),
            })

            ls.add_snippets("cpp", {
                s("uss", {
                    t({
                        '#include <bits/stdc++.h>',
                        'using namespace std;',
                        '',
                        'int main(){',
                        '',
                    }),
                    i(1),
                    t({
                        '',
                        '',
                        '',
                        '   return 0;',
                        '}',
                        '',
                    }),
                })
            })

            ls.filetype_extend("javascript", { "jsdoc" })
            ls.filetype_extend("typescript", { "javascript" })

            --- TODO: What is expand?
            -- vim.keymap.set({"i"}, "<C-s>e", function() ls.expand() end, {silent = true})
            --
            -- vim.keymap.set({"i", "s"}, "<C-s>;", function() ls.jump(1) end, {silent = true})
            -- vim.keymap.set({"i", "s"}, "<C-s>,", function() ls.jump(-1) end, {silent = true})
            --
            -- vim.keymap.set({"i", "s"}, "<C-E>", function()
            --     if ls.choice_active() then
            --         ls.change_choice(1)
            --     end
            -- end, {silent = true})
        end,
    }
}
