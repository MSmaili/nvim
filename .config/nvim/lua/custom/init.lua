require("custom.utils")
require("custom.core")

vim.api.nvim_set_hl(0, "IlluminatedWordText", {})
vim.api.nvim_set_hl(0, "IlluminatedWordRead", {})
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", {})

vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "LspReferenceText" })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "LspReferenceRead" })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "LspReferenceWrite" })
