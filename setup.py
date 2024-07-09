#!/usr/bin/env python3

from argparse import ArgumentParser, Namespace
from pathlib import Path
import sys


DEFAULT_TARGET_DIR = str(Path.home() / ".config" / "nvim")

BASE_ROOT = Path.cwd() / "base"
BASE_PLUGIN_ROOT = BASE_ROOT / "lua" / "plugins"

OPTIONAL_ROOT = Path.cwd() / "optional"
OPTIONAL_PLUGIN_ROOT = OPTIONAL_ROOT / "lua" / "plugins"

OPTIONAL_MIXINS = (
    ("flutter", "Include Flutter plugin", OPTIONAL_PLUGIN_ROOT / "flutter.lua", "COPY"),
    ("mason", "Include Mason", OPTIONAL_PLUGIN_ROOT / "lsp[mason].lua.patch", "PATCH", "{target_root}/lua/plugins/lsp.lua"),
    ("notification", "Include notification plugin", OPTIONAL_PLUGIN_ROOT / "notification.lua", "COPY"),
    ("quarto", "Include Quarto", OPTIONAL_PLUGIN_ROOT / "quarto.lua", "COPY"),
    ("tex", "Include TeX plugins", OPTIONAL_PLUGIN_ROOT / "tex.lua", "COPY"),
)


def main(args: Namespace):
    target_root = Path(args.target_root)

    if target_root.exists():
        if target_root.is_dir():
            if any(target_root.iterdir()):
                print("Target root exists and is not empty. What to do?")
                print("  1. Abort (default)")
                print("  2. Backup to ${target_root}/nvim/backups/")
                print("  3. Overwrite")
                print("  4. Delete and overwrite")
                print()

                action = input(">> ").strip()

                if action == "2":
                    # TODO
                    pass
                elif action == "3":
                    # TODO
                    pass
                elif action == "4":
                    # TODO
                    pass
                else:
                    print("Abort.")
                    sys.exit(1)
        else:
            print("Target root exists but is not a directory", file=sys.stderr)
            sys.exit(1)

    # TODO


if __name__ == '__main__':
    parser = ArgumentParser(description="CD Kickstart setup helper")

    parser.add_argument(
        "target_root",
        type=str,
        nargs='?',
        default=DEFAULT_TARGET_DIR,
        help="Install the configuration under the directory (default: `$XDG_CONFIG_HOME/nvim`)",
    )

    parser.add_argument(
        "-p", "--profile",
        type=str,
        help="Enable profile mode (installing the config as a profile. The config will be stored at `${target_root}/lua/profiles/${PROFILE}`)",
    )

    for mixin in OPTIONAL_MIXINS:
        parser.add_argument(
            f"--{mixin[0]}",
            action="store_true",
            help=mixin[1],
        )

    main(parser.parse_args())
