return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      window = {
        mappings = {
          ["y"] = "copy_to_clipboard", -- mark for copy (internal clipboard)
          ["x"] = "cut_to_clipboard", -- mark for cut (move)
          ["p"] = "paste_from_clipboard", -- paste here
        },
      },
    },
    default_component_configs = {
      file_size = { enabled = true },
    },
  },
}
