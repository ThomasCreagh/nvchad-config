local M = {}

M.abc = {
  n = {
    ["<leader>qf"] = { "<cmd> q! <CR>" },
  }, i = {}
}

M.rust_tools = {
  plugin = true,
  n = {
    ["<leader>rr"] = { "<cmd> Crun <CR>" },
    ["<leader>rt"] = { "<cmd> Ctest <CR>" },
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
