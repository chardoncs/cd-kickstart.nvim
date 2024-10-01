# Charles' Neovim Kickstarter

Kick start your Neovim with options to choose.

## Quick start

Copy and execute this command and see what's going to happen :) (You need Python 3.11+ btw)

```bash
curl https://raw.githubusercontent.com/chardoncs/cd-kickstart.nvim/main/setup.py | python3 - -R -n
```

## Setup script

### Options

|    Option        |                                 Description                                    |
|------------------|--------------------------------------------------------------------------------|
| -a, --patch-mode | Skip base configuration and append selected optional features                  |
| -d, --dir        | Specify directory to install<br />By default: `~/.config/nvim/` (Linux), `~/.config/neovim` (MacOS), `~\AppData\Local\nvim` (Windows) |
| -n, --nvim       | Open neovim after the configuration completed                                  |
| -p, --profile    | Install config as a profile instead                                            |
| -R, --remote     | Remote mode (Use upstream repository instead)                                  |
| -r, --resolve    | What to do if the target directory is not empty: abort (default) or overwrite  |
| -u, --use        | Use optional features. Use space to delimit multiple items                     |

### Optional features

|     Feature      |                                 Description                                    |
|------------------|--------------------------------------------------------------------------------|
| `flutter`        | [Flutter](https://flutter.dev/) support, using [flutter-tools.nvim](https://github.com/nvim-flutter/flutter-tools.nvim) |
| `mason`          | LSP server management, using [mason.nvim](https://github.com/williamboman/mason.nvim).<br/>Otherwise, LSP servers must be managed manually or using the system package manager, and configured manually in [`lua/plugins/lsp.lua`](./base/lua/plugins/lsp.lua). |
| `notification`   | Notification toasts, using [nvim-notify](https://github.com/rcarriga/nvim-notify) |
| `quarto`         | [Quarto](https://quarto.org/) support, using [official plugin](https://github.com/quarto-dev/quarto-nvim) |
| `startup`        | Startup window, using [startup.nvim](https://github.com/max397574/startup.nvim), which will replace the default vim/neovim one.<br />Moved to optional from baseline since Oct. 1, 2024. |
| `templates`      | Templates: [.gitignore](https://github.com/wintermute-cell/gitignore.nvim) |
| `tex`            | TeX/LaTeX support, using [Vimtex](https://github.com/lervag/vimtex/), and [telescope-bibtex.nvim](https://github.com/nvim-telescope/telescope-bibtex.nvim) for Telescope BibTex search |
