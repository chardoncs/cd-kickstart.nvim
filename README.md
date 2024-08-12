# Charles' Neovim Kickstarter

Kick start Neovim with options to choose.

I wrote this because I need a common configuration base for different devices,
but without too much personalization. That is, balancing personalization with generalization.
Because I use different devices for different things.

This kickstarter is not perfect. Please tell me if you have
any suggestion.

## Quick start

The most straightforward way to install it is using the setup script.

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

```bash
curl https://raw.githubusercontent.com/chardoncs/cd-kickstart.nvim/main/setup.py | python - -R -n -d ~/AppData/Local/nvim/
```

## Setup script

### Options

|    Option       |                                 Description                                   |
|-----------------|-------------------------------------------------------------------------------|
| -d, --dir       | Specify directory to install ("$XDG_CONFIG_HOME/nvim/" by default)            |
| -n, --nvim      | Open neovim after the configuration                                           |
| -p, --profile   | Install config as a profile instead                                           |
| -r, --resolve   | What to do if the target directory is not empty: abort (default) or overwrite |
| -R, --remote    | Remote mode (Use upstream repository instead)                                 |
| -u, --use       | Use optional plugins. Use space to delimit multiple plugins                   |

### Available optional plugins

- flutter
- mason
- notification
- quarto
- templates
- tex
