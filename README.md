# Charles' Neovim Kickstarter

Kick start your Neovim with options to choose.

> [Why another kickstarter?](https://github.com/chardoncs/cd-kickstart.nvim/wiki/FAQ#q-why-another-kickstarter)

## Quick start

Copy and execute this command (btw you need Python 3)

```bash
curl -fsSL kickstart.chardoncs.dev/setup.py | python3
```

or simply

```bash
curl -fsSL kickstart.chardoncs.dev | python3
```

## Setup script

### Options

|    Option        |                                 Description                                    |
|------------------|--------------------------------------------------------------------------------|
| -a, --append     | Skip base configuration and append selected optional features                  |
| -A, --apply      | Update the destination file/directory to the latest state                      |
| -d, --dir        | Specify directory to install<br />By default: `~/.config/nvim` (POSIX), `~\AppData\Local\nvim` (Windows) |
| -f, --force      | Skip confirmation / enforce overwriting files                                  |
| -n, --no-open    | Do not launch Neovim after the configuration completed                         |
| -p, --profile    | Install config as a profile instead                                            |
| -R, --remote     | Remote mode (Use upstream repository instead)                                  |
| -u, --use        | Include modules. Use spaces to delimit multiple items                          |
| -e, --exclude    | Exclude modules                                                                |
| --variant        | Variant (`minimal`, `lite`, `default`, `full`)                                 |

### Variants

- `minimal`: Only basic configurations and lazy.nvim. Good for users who just want a foundation for their customizations.
- `lite`: `minimal` + basic plugins (Telescope, Tree-sitter configs, themes, etc.). Near-lightweight experience.
- `default`: `lite` + basic LSP config, Lualine, and Nerd Fonts. My go-to choices. Suitable for most tasks without getting too bloated.
- `full`: `default` + multiple plugins to make Neovim look like an IDE. Good for new users coming from VS Code or IDEA as a transition.

### Modules

|     Module       |                                 Description                                    |
|------------------|--------------------------------------------------------------------------------|
| `dbee`           | [nvim-dbee](https://github.com/kndndrj/nvim-dbee), a database client |
| `flutter`        | [Flutter](https://flutter.dev/) support, using [flutter-tools.nvim](https://github.com/nvim-flutter/flutter-tools.nvim) |
| `hardtime`       | Establish good command workflow habits using [hardtime.nvim](https://github.com/m4xshen/hardtime.nvim)<br />NOTE: You might feel uncomfortable with it since multiple functionalities (like mouse selection, arrow keys) are disabled. |
| `harpoon`        | ThePrimeagen's [Harpoon](https://github.com/ThePrimeagen/harpoon/tree/harpoon2), an opinionated tool for switching between buffers without using a tabline or bufferline |
| `mason`          | LSP server management, using [mason.nvim](https://github.com/williamboman/mason.nvim).<br/>Otherwise, LSP servers must be managed manually or using the system package manager, and configured manually in `lua/plugins/lsp.lua`. |
| `notification`   | Notification toasts, using [nvim-notify](https://github.com/rcarriga/nvim-notify) |
| `nvim-tree`      | [`nvim-tree`](https://github.com/nvim-tree/nvim-tree.lua), a file explorer tree |
| `quarto`         | [Quarto](https://quarto.org/) support, using [official plugin](https://github.com/quarto-dev/quarto-nvim) |
| `snacks`         | [snacks.nvim](https://github.com/folke/snacks.nvim), a collection of useful utilities (many overlapped with current plugins) developed by [Folke](https://github.com/folke) |
| `sonarlint`      | [SonarQube](https://www.sonarsource.com/products/sonarqube/) linter support using [`sonarlint.nvim`](https://gitlab.com/schrieveslaach/sonarlint.nvim).<br />NOTE: Java Runtime is required for running SonarLint. |
| `startup`        | Startup window, using [dashboard-nvim](https://github.com/nvimdev/dashboard-nvim), which will replace the default vim/neovim one. |
| `tex`            | TeX/LaTeX support, using [VimTeX](https://github.com/lervag/vimtex/), and [telescope-bibtex.nvim](https://github.com/nvim-telescope/telescope-bibtex.nvim) for Telescope BibTeX search |

## Additional setups

### LuaRocks

I personally don't use LuaRocks for Neovim. To allow Lazy.nvim using LuaRocks, set `rocks.enabled` to `true` in [lua/lazy_setup.lua](/base/lua/lazy_setup.lua)
