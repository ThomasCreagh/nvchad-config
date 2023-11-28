local M = {}

M.abc = {
  n = {}, i = {}
}

M.rust_tools = {
  plugin = true,
  n = {
    ["<leader>rr"] = { "<cmd> Crun <CR>" },
  }
}

M.crates = {
  plugin = true,
  n = {
    ["<leader>rcu"] = {
      function ()
        require('crates').upgrade_all_crates()
      end,
      "update crates"
    }
  }
}

return M
