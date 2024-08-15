# Charles' Neovim Kickstarter

Kick start your Neovim with options to choose.

## Quick start

Copy and execute this command and see what's going to happen :) (You need Python 3.11+ btw)

### Linux (recommended)

```bash
python3 <(curl https://raw.githubusercontent.com/chardoncs/cd-kickstart.nvim/main/setup.py) -R -n
```

### MacOS

```bash
python3 <(curl https://raw.githubusercontent.com/chardoncs/cd-kickstart.nvim/main/setup.py) -R -n -d ~/.config/neovim/
```

### Windows (PowerShell 7+)

> NOTE: Make sure Python is added to the `PATH`

```bash
curl https://raw.githubusercontent.com/chardoncs/cd-kickstart.nvim/main/setup.py | python - -R -n -d ~/AppData/Local/nvim/
```

## Setup script

### Options

|    Option        |                                 Description                                    |
|------------------|--------------------------------------------------------------------------------|
| -a, --patch-mode | Skip base configuration and append selected optional plugins                   |
| -d, --dir        | Specify directory to install ("$XDG_CONFIG_HOME/nvim/" by default)             |
| -n, --nvim       | Open neovim after the configuration completed                                  |
| -p, --profile    | Install config as a profile instead                                            |
| -R, --remote     | Remote mode (Use upstream repository instead)                                  |
| -r, --resolve    | What to do if the target directory is not empty: abort (default) or overwrite  |
| -u, --use        | Use optional plugins. Use space to delimit multiple plugins                    |

### Available optional plugins

- flutter
- mason
- notification
- quarto
- templates
- tex
