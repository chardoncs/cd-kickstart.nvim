return {
  {
    "https://gitlab.com/schrieveslaach/sonarlint.nvim",
    event = "VeryLazy",
    dependencies = {
      "neovim/nvim-lspconfig",
      --"williamboman/mason-lspconfig.nvim",
    },
    opts = {
      filetypes = {
        -- File types
      },
      ---- Connected mode
      --connected = {
      --  -- client_id is the ID of the Sonar LSP
      --  -- url is the url it wants to connect to
      --  get_credentials = function(client_id, url)
      --    -- This must return a string (User token)
      --    -- This is the default function. You can just set the environment variable.
      --    return vim.fn.getenv("SONAR_TOKEN")
      --  end,
      --},
      ---- SonarQube server
      --server = {
      --  -- Manual
      --  cmd = {
      --    "java",
      --    "-jar",
      --    "sonarlint-language-server-VERSION.jar",
      --    -- Ensure that sonarlint-language-server uses stdio channel
      --    "-stdio",
      --    "-analyzers",
      --    "path/to/analyzer1.jar",
      --    "path/to/analyzer2.jar",
      --    "path/to/analyzer3.jar",
      --  },

      --  -- Mason
      --  --cmd = {
      --  --  "sonarlint-language-server",
      --  --  -- Ensure that sonarlint-language-server uses stdio channel
      --  --  "-stdio",
      --  --  "-analyzers",
      --  --  -- paths to the analyzers you need, using those for python and java in this example
      --  --  vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
      --  --  vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
      --  --  vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
      --  --},
      --  settings = {
      --    sonarlint = {
      --      connectedMode = {
      --        connections = {
      --          sonarqube = {
      --            {
      --              -- identifier for this connection
      --              connectionId = "<server id to use in projects>",
      --              -- this is the url that will go into get_credentials
      --              serverUrl = "https://<sq-domain.yourcompany.com>",
      --              disableNotifications = false,
      --            },
      --          },
      --          sonarcloud = {
      --            {
      --              connectionId = "<server id to use in projects>",
      --              region = "US", -- or EU
      --              organizationKey = "<organization key from sonarcloud>",
      --              disableNotifications = false,
      --            },
      --          },
      --        },
      --      },
      --    },
      --  },

      --  before_init = function(params, config)
      --    -- Your personal configuration needs to provide a mapping of root folders and project keys
      --    --
      --    -- In the future a integration with https://github.com/folke/neoconf.nvim or some similar
      --    -- plugin, might be worthwhile.
      --    local project_root_and_ids = {
      --      ["/path/to/project/root"] = "<project key you to take from sonarqube>",
      --      -- … further mappings …
      --    }

      --    config.settings.sonarlint.connectedMode.project = {
      --      connectionId = "<server id from above>",
      --      projectKey = project_root_and_ids[params.rootPath],
      --    }
      --  end,
      --},
    },
  },
}
