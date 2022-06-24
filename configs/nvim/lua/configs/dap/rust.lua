local M = {}

function M.setup()
  local extension_path = vim.fn.glob(vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-*/")
  local codelldb_path = extension_path .. 'adapter/codelldb'
  local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

  local dap = require('dap')

  dap.adapters.codelldb = function(on_adapter)
    -- This asks the system for a free port
    local tcp = vim.loop.new_tcp()
    tcp:bind('127.0.0.1', 0)
    local port = tcp:getsockname().port
    tcp:shutdown()
    tcp:close()

    -- Start codelldb with the port
    local stdout = vim.loop.new_pipe(false)
    local stderr = vim.loop.new_pipe(false)
    local opts = {
      stdio = {nil, stdout, stderr},
      args = {"--port", tostring(port),  "--liblldb", liblldb_path},
      detached = true,
    }
    local handle
    local pid_or_err
    handle, pid_or_err = vim.loop.spawn(codelldb_path, opts, function(code)
      stdout:close()
      stderr:close()
      handle:close()
      if code ~= 0 then
        print("codelldb exited with code", code)
      end
    end)
    if not handle then
      vim.notify("Error running codelldb: " .. tostring(pid_or_err), vim.log.levels.ERROR)
      stdout:close()
      stderr:close()
      return
    end
    vim.notify('\nCodelldb started. pid=' .. pid_or_err)
    stderr:read_start(function(err, chunk)
      assert(not err, err)
      if chunk then
        vim.schedule(function()
          require("dap.repl").append(chunk)
        end)
      end
    end)
    local adapter = {
      type = 'server',
      host = '127.0.0.1',
      port = port
    }
    vim.defer_fn(function() on_adapter(adapter) end, 500)
  end

  dap.configurations.cpp = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      cwd = '${workspaceFolder}',
      program = function()
        local workspaceRoot = require("lspconfig").rust_analyzer.get_root_dir()
        local workspaceName = vim.fn.fnamemodify(workspaceRoot, ":t")
        return vim.fn.input("Path to executable: ", workspaceRoot .. "/target/debug/" .. workspaceName, "file")
      end,
      sourceLanguages = { "rust" },
      stopOnEntry = false,
      runInTerminal = false,
    },
  }

  dap.configurations.rust = dap.configurations.cpp
end

return M