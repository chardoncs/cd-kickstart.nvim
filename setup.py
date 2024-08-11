#!/usr/bin/env python3

from argparse import ArgumentParser, Namespace
from pathlib import Path
import re
import shutil
import sys
import textwrap


BASE_DIR = Path.cwd() / "base"
OPTIONAL_DIR = Path.cwd() / "optional"
OPTIONAL_PLUGIN_DIR = OPTIONAL_DIR / "lua" / "plugins"


def main(args: Namespace):
    target: Path = args.dir / "lua" / "profiles" / args.profile\
            if args.profile\
            else args.dir

    if target.exists():
        if not target.is_dir():
            print("Target is not a directory", file=sys.stderr)
            sys.exit(1)

        if any(target.iterdir()) and args.resolve == "abort":
            print("Directory not empty. Stopped in cringe...", file=sys.stderr)
            sys.exit(1)

    overwrite = args.resolve == "overwrite"

    # Base config
    print("Copying base configuration...", end=" ", flush=True)
    shutil.copytree(BASE_DIR, target, dirs_exist_ok=overwrite)
    print("done")

    # Optional config
    if len(args.use) > 0:
        print("Copying optional configurations...")
        for file in OPTIONAL_PLUGIN_DIR.iterdir():
            file_name = file.name.split(".")[0]
            token_match = re.findall(r'\[\w+\]', file_name)
            token = token_match[0].strip("[]") if len(token_match) > 0 else file_name
            if token != file_name:
                file_name = file_name.replace(f"[{token}]", "")

            if token in args.use:
                print(f" - {token}:", end=" ", flush=True)
                shutil.copy(file, target / "lua" / "plugins" / f"{file_name}.lua")
                print("done")

        print("done")

    print("All done!")


if __name__ == "__main__":
    parser = ArgumentParser(
        description="cd-kickstart setup tool",
    )

    parser.add_argument(
        "-d", "--dir",
        help='Specify directory to install ("$XDG_CONFIG_HOME/nvim/" by default)',
        default=Path.home() / ".config" / "nvim",
        type=Path,
    )

    parser.add_argument(
        "-p", "--profile",
        help="Install config as a profile instead",
        type=str,
        default=None,
    )

    parser.add_argument(
        "-r", "--resolve",
        help=textwrap.dedent("""\
            What to do if the target directory is not empty:

            -- abort: Stop proceeding (default)

            -- overwrite: Proceed anyway even files exist\
        """),
        choices=["abort", "overwrite"],
        default="abort",
    )

    parser.add_argument(
        "-u", "--use",
        help="Use optional plugins. Use space to delimit multiple plugins",
        action="extend",
        nargs="+",
        type=str,
        default=[],
    )

    main(parser.parse_args())
