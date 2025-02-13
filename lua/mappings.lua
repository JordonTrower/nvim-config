require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map({ "n", "x" }, "s", "<Nop>")
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- nvim-dap
-- map("n", "db", require("dap").toggle_breakpoint(), { desc = "toggle breakpoint" })
-- map("n", "dc", require("dap").continue(), { desc = "debug continue execution" })
-- map("n", "do", require("dap").step_over(), { desc = "debug step over" })
-- map("n", "di", require("dap").step_into(), { desc = "debug step into" })
-- map("n", "dr", require("dap").repl.open(), { desc = "debug open repl to view state" })
-- -- nvim-jdtls
-- map("n", "dp", require("jdtls").setup_dap_main_class_configs(), { desc = "initialize DAP main class configs" })
-- map("n", "dm", require("jdtls").test_nearest_method(), { desc = "test nearest method" })
-- map("n", "df", require("jdtls").test_class(), { desc = "test class" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
