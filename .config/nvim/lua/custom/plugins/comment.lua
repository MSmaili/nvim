return {
	"numToStr/Comment.nvim",
	dependencies = {
		"folke/ts-comments.nvim",
		opts = {
			allow_empty_lines = true,
			lang = {
				robot = "# %s",
			},
		},
	},
	opts = {},
	keys = { "gc", mode = { "n", "v", "x" } },
}
