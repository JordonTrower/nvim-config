local jdtls = require "jdtls"
--
-- local conf = {
--   cmd = { vim.fn.expand "~/dev-tools/jdtls/bin/jdtls" },
--   root_dir = vim.fs.dirname((vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true }))[1]),
-- }
--
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = "/home/jtrower/dev-tools/jdtls/data_dir/" .. project_name

local bundles = {
    vim.fn.glob(
        "/home/jtrower/dev-tools/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
        1
    ),
}
vim.list_extend(bundles, vim.split(vim.fn.glob("/home/jtrower/dev-tools/vscode-java-test/server/*.jar", 1), "\n"))

local function run_dap_setup()
    require("jdtls.dap").setup_dap_main_class_configs()
end

-- change anything with 💀
local config = {
    cmd = {

        -- 💀
        "/home/jtrower/.asdf/installs/java/openjdk-23.0.2/bin/java", -- or '/path/to/java17_or_newer/bin/java'
        -- depends on if `java` is in your $PATH env variable and if it points to the right version.

        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx5g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",

        -- 💀
        "-jar",
        "/home/jtrower/dev-tools/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar",
        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
        -- Must point to the                                                     Change this to
        -- eclipse.jdt.ls installation                                           the actual version

        -- 💀
        "-configuration",
        "/home/jtrower/dev-tools/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_linux",
        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
        -- Must point to the                      Change to one of `linux`, `win` or `mac`
        -- eclipse.jdt.ls installation            Depending on your system.

        -- 💀
        -- See `data directory configuration` section in the README
        "-data",
        workspace_dir,
    },
    capabilities = require("nvchad.configs.lspconfig").capabilities,
    on_attach = function()
        require("nvchad.configs.lspconfig").on_attach()

        require("jdtls").setup_dap { hotcodereplace = "auto" }
        require("jdtls.setup").add_commands()

        local map = vim.keymap.set
        map("n", "<leader>db", require("dap").toggle_breakpoint, { desc = "debug toggle breakpoint" })
        map("n", "<leader>dc", require("dap").continue, { desc = "debug continue execution" })
        map("n", "<leader>do", require("dap").step_over, { desc = "debug step over" })
        map("n", "<leader>di", require("dap").step_into, { desc = "debug step into" })
        map("n", "<leader>dr", require("dap").repl.open, { desc = "debug open repl to view state" })
        map("n", "<leader>dp", run_dap_setup, { desc = "debug initialize DAP main class configs" })
        map("n", "<leader>dm", require("jdtls").test_nearest_method, { desc = "debug test nearest method" })
        map("n", "<leader>df", require("jdtls").test_class, { desc = "debug test class" })
    end,
    on_init = require("nvchad.configs.lspconfig").on_init,
    -- 💀
    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = require("jdtls.setup").find_root { ".git", "mvnw", "gradlew" },

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
            references = {
                includeDecompliledSources = true,
            },
            format = {
                enabled = true,
            },
            eclipse = {
                downloadSources = true,
            },
            maven = {
                downloadSources = true,
            },
            signatureHelp = { enabled = true },
        },
    },

    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
}

config["init_options"] = {
    bundles = bundles,
}
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"
local actions = require "telescope.actions"
local pickers = require "telescope.pickers"
require("jdtls.ui").pick_one_async = function(items, prompt, label_fn, cb)
    local opts = {}
    pickers
        .new(opts, {
            prompt_title = prompt,
            finder = finders.new_table {
                results = items,
                entry_maker = function(entry)
                    return {
                        value = entry,
                        display = label_fn(entry),
                        ordinal = label_fn(entry),
                    }
                end,
            },
            sorter = sorters.get_generic_fuzzy_sorter(),
            attach_mappings = function(prompt_bufnr)
                actions.goto_file_selection_edit:replace(function()
                    local selection = actions.get_selected_entry(prompt_bufnr)
                    actions.close(prompt_bufnr)

                    cb(selection.value)
                end)

                return true
            end,
        })
        :find()
end
jdtls.start_or_attach(config)
