local wezterm = require 'wezterm'
local mux = wezterm.mux
local io = require 'io'
local os = require 'os'
local act = wezterm.action
local b = require("utils/background")
local w = require("utils/wallpapers")

local wallpapers_glob = os.getenv("HOME")
    .. "/Documents/wallpapers/wezterm/**"

wezterm.on('vim-scrollback', function(window, pane)
    -- local name = os.tmpname()
    -- local text = pane:get_lines_as_text(pane:get_dimensions().scrollback_rows)
    -- local f = io.open(name, 'w+')
    -- f:write(text)
    -- f:flush()
    -- f:close()
    --
    window:perform_action(
        act.SpawnCommandInNewWindow {
            args = { 'sh', "-c", "tmux capture-pane -pS - | nvim - -c 'norm G' -c '?.' " },
        },
        pane
    )
    -- wezterm.sleep_ms(10000)
    -- os.remove(name)
end)

wezterm.on('gui-startup', function()
    local tab, pane, window = mux.spawn_window({})
    window:gui_window():maximize()
    -- window:gui_window():toggle_fullscreen()
    pane:send_text("tmux\n")
end)

local colors = require('lua/rose-pine').colors()
local window_frame = require('lua/rose-pine').window_frame()
local config = {
       background = {
    	w.get_wallpaper(wallpapers_glob),
    	b.get_background(0.8, 0.8),
    },
    adjust_window_size_when_changing_font_size = true,
    debug_key_events = false,
    -- disable_default_key_bindings = true,
    -- enable_tab_bar = false,
    native_macos_fullscreen_mode = false,
    window_close_confirmation = "NeverPrompt",
    window_decorations = "RESIZE",
    force_reverse_video_cursor = true,
    colors = {
        background = "#111",
        foreground = "#c5c9c5",

        cursor_bg = "#C8C093",
        -- cursor_fg = "#C8C093",
        cursor_border = "#C8C093",

        selection_fg = "#C8C093",
        selection_bg = "#2D4F67",

        scrollbar_thumb = "#16161D",
        split = "#16161D",
        ansi = {
            "#0D0C0C",
            "#C4746E",
            "#8A9A7B",
            "#C4B28A",
            "#8BA4B0",
            "#A292A3",
            "#8EA4A2",
            "#C8C093",
        },
        brights = {
            "#A6A69C",
            "#E46876",
            "#87A987",
            "#E6C384",
            "#7FB4CA",
            "#938AA9",
            "#7AA89F",
            "#C5C9C5",
        },
        indexed = { [16] = "#B6927B", [17] = "#B98D7B" },
    },
    -- colors = colors,
    -- window_frame = window_frame,
    default_prog = { '/usr/local/bin/fish', '-l' },
    automatically_reload_config = true,
    line_height = 1.1,
    use_dead_keys = false,
    scrollback_lines = 5000,
    hide_tab_bar_if_only_one_tab = true,
    use_fancy_tab_bar = false,
    window_padding = {
        bottom = 0,
        left = 0,
        right = 0,
        top = 0,
    },
    keys = {
        { key = "Enter", mods = "CTRL",       action = wezterm.action { SendString = "\x1b[13;5u" } },
        { key = "Enter", mods = "SHIFT",      action = wezterm.action { SendString = "\x1b[13;2u" } },
        { key = "Tab",   mods = "CTRL",       action = wezterm.action { SendString = "\x1b[9;5u" } },
        { key = "Tab",   mods = "CTRL|SHIFT", action = wezterm.action { SendString = "\x1b[9;6u" } },
        {
            key = 'e',
            mods = 'SUPER',
            action = act.EmitEvent 'vim-scrollback',
        },
    }

}

config.font = wezterm.font 'Berkeley Mono'
config.font_size = 18
return config
