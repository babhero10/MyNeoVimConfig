return {
  "thibthib18/ros-nvim",
  config = function()
    local vim_utils = require "ros-nvim.vim-utils"
    local action_state = require('telescope.actions.state')  -- Import action_state for cycle_previewers

    require('ros-nvim').setup {
      -- path to your catkin workspace
      catkin_ws_path = "~/catkin_ws",

      -- make program (e.g. "catkin_make" or "catkin build")
      catkin_program = "catkin_make",

      -- method for opening terminal for e.g. catkin_make: `vim_utils.open_new_buffer` or custom function
      open_terminal_method = function()
        vim_utils.open_split()  -- Use function directly from vim_utils
      end,

      -- terminal height for build / test, only valid with `open_terminal_method=open_split()`
      terminal_height = 8,

      -- Picker mappings
      node_picker_mappings = function(map)
        map("n", "<c-k>", vim_utils.open_terminal_with_format_cmd_entry("rosnode kill %s"))
        map("i", "<c-k>", vim_utils.open_terminal_with_format_cmd_entry("rosnode kill %s"))
      end,
      topic_picker_mappings = function(map)
        local cycle_previewers = function(prompt_bufnr)
          local picker = action_state.get_current_picker(prompt_bufnr)
          picker:cycle_previewers(1)
        end
        map("n", "<c-b>", vim_utils.open_terminal_with_format_cmd_entry("rostopic pub %s"))
        map("i", "<c-b>", vim_utils.open_terminal_with_format_cmd_entry("rostopic pub %s"))
        -- While browsing topics, press <c-e> to switch between `rostopic info` and `rostopic echo`
        map("n", "<c-e>", cycle_previewers)
        map("i", "<c-e>", cycle_previewers)
      end,
      service_picker_mappings = function(map)
        map("n", "<c-e>", vim_utils.open_terminal_with_format_cmd_entry("rosservice call %s"))
        map("i", "<c-e>", vim_utils.open_terminal_with_format_cmd_entry("rosservice call %s"))
      end,
      param_picker_mappings = function(map)
        map("n", "<c-e>", vim_utils.open_terminal_with_format_cmd_entry("rosparam set %s"))
        map("i", "<c-e>", vim_utils.open_terminal_with_format_cmd_entry("rosparam set %s"))
      end,
    }
  end,
}

