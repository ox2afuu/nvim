local M = {}

function M.setup()
  require("fidget").setup({
    text = {
      spinner = "dots_negative", -- animation shown when tasks are ongoing
      done = "✓", -- character shown when all tasks are complete
      commenced = "Started", -- message shown when task starts
      completed = "Completed", -- message shown when task completes
    },
    window = {
      blend = 0,
    },
    timer = {
      spinner_rate = 125, -- in ms
      fidget_decay = 2000, -- in ms
      task_decay = 1000, -- in ms
    },
  })
end

return M
