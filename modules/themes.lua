-- Shared config for themes
local theme_config = {
  theme = "tokyonight",
  style = "night",
  transparent = false,
  terminal_colors = false,
  cached = true,
}

-- Set your themes here
local theme_loaders = {
  tokyonight = function (config)
    return {
      -- Tokyo Night
      "folke/tokyonight.nvim",
      priority = 1000,
      opts = {
        style = config.style,
        transparent = config.transparent,
        terminal_colors = config.terminal_colors,
        styles = {
          sidebars = config.transparent and "transparent" or "dark",
          floats = "dark",
        },
        --lualine_bold = true,
        cache = config.cached,
        plugins = {
          auto = true,
        },
        on_colors = function (colors)
          colors.border_highlight = colors.blue
          colors.BufferCurrentSign = colors.border_highlight
        end,
      },
      init = function ()
        vim.cmd.colorscheme("tokyonight")
      end,
    }
  end,
  kanagawa = function (config)
    return {
      "rebelot/kanagawa.nvim",
      priority = 1000,
      opts = {
          compile = config.cached,
          terminalColors = config.terminal_colors,
          theme = config.style,
      },
      init = function ()
        require(config.theme).load(config.style)
      end,
    }
  end,
}

local function load_theme()
  local loader_func = theme_loaders[theme_config.theme]
  return loader_func and loader_func(theme_config) or {}
end

return {
  load_theme(),
}
