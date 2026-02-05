local _dir = vim.fs.joinpath(vim.fn.stdpath("config"), "/pack/user/opt")
---@param name string
---@return string
local dir = function(name)
  return vim.fs.joinpath(_dir, name)
end

return {
  { dir = dir("rust") },
  { dir = dir("ukrainian"), event = "InsertEnter" },
}
