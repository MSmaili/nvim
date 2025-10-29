local wezterm = require("wezterm")

local windowPadding = 5

return {
	window_decorations = "RESIZE",
	-- color_scheme = "Catppuccin Mocha",
	color_scheme = "rose-pine",
	enable_tab_bar = false,
	font_size = 18,
	bold_brightens_ansi_colors = true,
	window_background_opacity = 0.90,
	automatically_reload_config = true,
	macos_window_background_blur = 20,

	freetype_load_target = "Light",
	freetype_render_target = "HorizontalLcd",
	font = wezterm.font_with_fallback({
		{
			family = "MonoLisa Variable",
			harfbuzz_features = {
				"calt",
				"liga",
				"zero",
				"ss01",
				"ss02",
				"ss05",
				"ss06",
				"ss07",
				"ss10",
				"ss11",
				"ss13",
				"ss15",
				"ss16",
				"ss17",
				"ss18",
			},
		},
		{ family = "Maple Mono NF CN", scale = 1.2 },
	}),

	window_padding = {
		left = windowPadding,
		right = windowPadding,
		top = windowPadding,
		bottom = windowPadding,
	},
	keys = {
		{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
		{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
	},
}
