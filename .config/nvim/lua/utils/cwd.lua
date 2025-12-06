local M = {}

function M.smart()
  local oil_ok, oil = pcall(require, "oil")
  if oil_ok and vim.bo.filetype == "oil" then
    return oil.get_current_dir()
  end

  local file = vim.api.nvim_buf_get_name(0)
  if file ~= "" then
    return vim.fn.fnamemodify(file, ":p:h")
  end

  return vim.fn.getcwd()
end

return M
