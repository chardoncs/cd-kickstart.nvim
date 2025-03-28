# Charles' Neovim Kickstarter

Kick start your Neovim with options to choose.

> [Why another kickstarter?](https://github.com/chardoncs/cd-kickstart.nvim/wiki/Why-another-kickstarter%3F)

## Quick start

Copy and execute this command and see what's going to happen :) (You need Python 3.11+ btw)

```bash
curl -L kickstart.chardoncs.dev | python3 - -R -n
# OR use the raw content link if my redirect is not working
curl https://raw.githubusercontent.com/chardoncs/cd-kickstart.nvim/main/setup.py | python3 - -R -n
```

## Setup script

### Options

|    Option        |                                 Description                                    |
|------------------|--------------------------------------------------------------------------------|
| -a, --append, --patch-mode | Skip base configuration and append selected optional features                  |
| -d, --dir        | Specify directory to install<br />By default: `~/.config/nvim/` (Linux), `~/.config/neovim` (MacOS), `~\AppData\Local\nvim` (Windows) |
| -n, --nvim       | Open neovim after the configuration completed                                  |
| -p, --profile    | Install config as a profile instead                                            |
| -R, --remote     | Remote mode (Use upstream repository instead)                                  |
| -r, --resolve    | What to do if the target directory is not empty: abort (default) or overwrite  |
| -u, --use        | Use optional features. Use spaces to delimit multiple items                     |

### Optional features

|     Feature      |                                 Description                                    |
|------------------|--------------------------------------------------------------------------------|
| `dbee`           | [nvim-dbee](https://github.com/kndndrj/nvim-dbee), a database client |
| `flutter`        | [Flutter](https://flutter.dev/) support, using [flutter-tools.nvim](https://github.com/nvim-flutter/flutter-tools.nvim) |
| `hardtime`       | Establish good command workflow habits using [hardtime.nvim](https://github.com/m4xshen/hardtime.nvim)<br />NOTE: You might feel uncomfortable with it since multiple functionalities (like mouse selection, arrow keys) are disabled. |
| `harpoon`        | [Harpoon](https://github.com/ThePrimeagen/harpoon/tree/harpoon2), switching between buffers without using a tabline |
| `mason`          | LSP server management, using [mason.nvim](https://github.com/williamboman/mason.nvim).<br/>Otherwise, LSP servers must be managed manually or using the system package manager, and configured manually in [`lua/plugins/lsp.lua`](./base/lua/plugins/lsp.lua). |
| `notification`   | Notification toasts, using [nvim-notify](https://github.com/rcarriga/nvim-notify) |
| `quarto`         | [Quarto](https://quarto.org/) support, using [official plugin](https://github.com/quarto-dev/quarto-nvim) |
| `snacks`         | [snacks.nvim](https://github.com/folke/snacks.nvim), a collection of useful utilities (many overlapped with current plugins) developed by [Folke](https://github.com/folke) |
| `startup`        | Startup window, using [dashboard-nvim](https://github.com/nvimdev/dashboard-nvim), which will replace the default vim/neovim one. |
| `templates`      | Templates: [.gitignore](https://github.com/wintermute-cell/gitignore.nvim) |
| `tex`            | TeX/LaTeX support, using [VimTeX](https://github.com/lervag/vimtex/), and [telescope-bibtex.nvim](https://github.com/nvim-telescope/telescope-bibtex.nvim) for Telescope BibTeX search |

## Additional setups

### Luarocks

I personally don't use Luarocks. To allow Lazy.nvim using Luarocks, set `rocks.enabled` to `true` in [lua/lazy_setup.lua](/base/lua/lazy_setup.lua)
