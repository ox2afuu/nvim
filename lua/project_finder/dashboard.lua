local M = {}

--- Default dashboard action: open buffer with project management options
function M.dashboard(repo_path)
  vim.cmd("tabnew")
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
    "# Project Dashboard",
    "",
    "Project: " .. repo_path,
    "",
    "[o] Open project (cd & open files)",
    "[r] Open README.md",
    "[t] Run tests",
    "[s] Open shell",
    "[q] Quit dashboard",
  })
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false
  vim.api.nvim_buf_set_keymap(buf, 'n', 'o', string.format(
    ":lua require('project_finder.dashboard').open_project('%s')<CR>", repo_path), { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', 'r', string.format(
    ":lua require('project_finder.dashboard').open_readme('%s')<CR>", repo_path), { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', 't', string.format(
    ":lua require('project_finder.dashboard').run_tests('%s')<CR>", repo_path), { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', 's', string.format(
    ":lua require('project_finder.dashboard').open_shell('%s')<CR>", repo_path), { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ":bd!<CR>", { noremap = true, silent = true })
end

function M.open_project(repo_path)
  vim.cmd('cd ' .. repo_path)
  vim.cmd('NvimTreeOpen')
end

function M.open_readme(repo_path)
  local readme = repo_path .. "/README.md"
  vim.cmd('edit ' .. readme)
end

function M.run_tests(repo_path)
  vim.cmd('tabnew')
  vim.cmd('term cd ' .. repo_path .. ' && make test')
end

function M.open_shell(repo_path)
  vim.cmd('tabnew')
  vim.cmd('term cd ' .. repo_path)
end

return M
