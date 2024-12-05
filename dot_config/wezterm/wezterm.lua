local wezterm = require("wezterm")
-- configs
local config = wezterm.config_builder()
config.default_prog = { "C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe" }
config.font = wezterm.font("CommitMono Nerd Font Mono")
config.line_height = 1.2
config.font_size = 12.5
config.cell_width = 1.05
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.65
config.window_padding = {
	left = 3,
	right = 3,
	top = 0,
	bottom = 0,
}
config.term = "xterm-256color"
config.win32_system_backdrop = "Acrylic"
config.color_scheme = "Solarized Dark Higher Contrast (Gogh)"
config.use_fancy_tab_bar = false
config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.7,
}
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true

local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_right_half_circle_thick
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_left_half_circle_thick
-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local edge_background = "#333333"
	local background = "#4d4d4d"
	local foreground = "#868686"

	if tab.is_active then
		background = "#a1a1a1"
		foreground = "#ffffff"
	end

	local edge_foreground = background

	local title = tab_title(tab)

	-- ensure that the titles fit in the available space,
	-- and that we have room for the edges.
	title = wezterm.truncate_right(title, max_width - 2)

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)
return config
