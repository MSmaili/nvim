local wezterm = require("wezterm")

return {
	window_decorations = "RESIZE", -- was NONE
	enable_tab_bar = false,
	font_size = 16,
	window_background_opacity = 0.85,
	macos_window_background_blur = 25,
	-- dpi = 150,
	-- dpi = 90,
	font = wezterm.font_with_fallback({
		{
			family = "MonoLisa Variable",
			weight = "Regular",
			stretch = "Normal",
			style = "Normal",
			harfbuzz_features = {
				"calt",
				"liga",
				"zero",
				"dlig",
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
	}),
	font_rules = {
		{
			-- Apply this rule when the text is italic
			italic = true,
			font = wezterm.font({
				family = "MonoLisa Variable",
				weight = "Light",
				italic = true,
				harfbuzz_features = {
					"calt",
					"frac",
					"liga",
					"zero",
					"dlig",
					-- "rlig",
					"ss01",
					"ss02",
					"ss05",
					"ss06",
					"ss07",
					"ss10",
					"ss11",
					"ss13",
					"ss15",
					"ss16", -- Include ss16 for italic text @
					"ss17",
					-- "ss18",
				},
			}),
		},
	},

	-- https://wezfurlong.org/wezterm/config/lua/config/font_rules.html
	-- wezterm ls-fonts
	-- wezterm ls-fonts --list-system
	-- font_rules = {
	-- 	{
	-- 		intensity = "Half",
	-- 		italic = true,
	-- 		font = wezterm.font({
	-- 			family = "MonoLisa Variable",
	-- 			weight = "Light",
	-- 			stretch = "Normal",
	-- 			style = "Normal",
	-- 			harfbuzz_features = {
	-- 				"calt",
	-- 				"liga",
	-- 				"zero",
	-- 				"dlig",
	-- 				"ss01",
	-- 				"ss02",
	-- 				"ss05",
	-- 				"ss06",
	-- 				"ss07",
	-- 				"ss10",
	-- 				"ss11",
	-- 				"ss13",
	-- 				"ss15",
	-- 				"ss16",
	-- 				"ss17",
	-- 				"ss18",
	-- 			},
	-- 		}),
	-- 	},
	--
	-- 	--
	-- 	-- Bold (highlighting)
	-- 	--
	-- 	{
	-- 		intensity = "Bold",
	-- 		italic = false,
	-- 		font = wezterm.font({
	-- 			family = "MonoLisa Variable",
	-- 			weight = "Bold",
	-- 			stretch = "Normal",
	-- 			style = "Normal",
	-- 			harfbuzz_features = {
	-- 				"calt",
	-- 				"liga",
	-- 				"zero",
	-- 				"dlig",
	-- 				"ss01",
	-- 				"ss02",
	-- 				"ss05",
	-- 				"ss06",
	-- 				"ss07",
	-- 				"ss10",
	-- 				"ss11",
	-- 				"ss13",
	-- 				"ss15",
	-- 				"ss16",
	-- 				"ss17",
	-- 				"ss18",
	-- 			},
	-- 		}),
	-- 	},
	-- },
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	keys = {
		-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
		{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
		-- Make Option-Right equivalent to Alt-f; forward-word
		{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
	},
	colors = {
		-- background = "#0F172B",
		-- background = "#0B0D0F",
		background = "#22212C",
		-- background = "#2C2E34", -- for sonokai
	},
}
-- {
--          "calt",
-- 					"liga",
-- 					"dlig",
-- 					"ss01",
-- 					"ss03",
-- 					"ss04",
-- 					"ss05",
-- 					"ss06",
-- 					"ss07",
-- 					"ss08",
-- 				}
