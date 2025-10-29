return {
	"iamkarasik/sonarqube.nvim",
	lazy = false,
	config = function()
		require("sonarqube").setup({})
	end,
}
