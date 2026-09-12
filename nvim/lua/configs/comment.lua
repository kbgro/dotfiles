-- Comment
--

local api = require("Comment.api")

vim.keymap.set("n", "<leader>/", api.toggle.linewise.current, {
  desc = "Toggle comment",
})

vim.keymap.set("x", "<leader>/", function()
  api.toggle.linewise(vim.fn.visualmode())
end, {
  desc = "Toggle comment",
})

