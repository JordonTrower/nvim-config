local dap, dapui = require "dap", require "dapui"
-- adapters
-- jdtls handles java
dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
        command = "node",
        -- 💀 Make sure to update this path to point to your installation
        args = { "/home/jtrower/dev-tools/js-debug/src/dapDebugServer.js", "${port}" },
    },
}

dap.adapters.godot = {
    type = "server",
    host = "127.0.0.1",
    port = "6006",
}

-- Attach to remote java debuggers

dap.configurations.java = {
    {
        type = "java",
        request = "attach",
        name = "Debug (Attach) - Remote 5005",
        hostName = "127.0.0.1",
        port = 5005,
    },
    {
        type = "java",
        request = "attach",
        name = "Debug (Attach) - Remote 8000 (Bloomreach)",
        hostName = "127.0.0.1",
        port = 8000,
    },
}

local jsConfig = {
    {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        runtimeExecutable = "deno",
        runtimeArgs = {
            "run",
            "--inspect-wait",
            "--allow-all",
        },
        program = "${file}",
        cwd = "${workspaceFolder}",
        attachSimplePort = 9229,
    },
}

dap.configurations.javascript = jsConfig
dap.configurations.typescript = jsConfig
dap.configurations.javascriptreact = jsConfig
dap.configurations.typescriptreact = jsConfig

dap.configurations.gdscript = {
    type = "godot",
    request = "launch",
    name = "Launch scene",
    project = "${workspaceFolder}",
    launch_scene = true,
}

-- Set up dapui for a better debugging experience
-- show dapui when attached or debugging
dapui.setup()
dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end
