#!/usr/bin/env python3

from argparse import ArgumentParser, Namespace
from pathlib import Path

import atexit
import platform
import re
import shutil
import subprocess
import sys
import tempfile
import textwrap


def clean_tmp_dir(root_dir):
    print(f"Clean up temporary directory: `{root_dir}`...", end=" ", flush=True)
    shutil.rmtree(root_dir)
    print("done")


def main(args: Namespace):
    if args.remote:
        root_dir = Path(tempfile.mkdtemp())
        # Clean up temporary directory on exit
        atexit.register(clean_tmp_dir, root_dir)

        code = subprocess.call(
            ["git", "clone", "https://github.com/chardoncs/cd-kickstart.nvim.git", str(root_dir)],
            stdout=subprocess.PIPE,
        )

        if code:
            print("Error: Git exited with errors", file=sys.stderr)
            sys.exit(code)
    else:
        root_dir = Path.cwd()

    base_dir = root_dir / "base"
    optional_dir = root_dir / "optional"
    optional_plugin_dir = optional_dir / "lua" / "plugins"

    target: Path = args.dir / "lua" / "profiles" / args.profile\
            if args.profile\
            else args.dir

    if target.exists():
        if not target.is_dir():
            print("Target is not a directory", file=sys.stderr)
            sys.exit(1)

        if any(target.iterdir()) and args.resolve == "abort" and not args.append:
            print("Error: Directory not empty. Stopped in cringe...", file=sys.stderr)
            sys.exit(1)

    overwrite = args.resolve == "overwrite"

    # Base config
    print("Copying base configuration...", end=" ", flush=True)
    if not args.append:
        shutil.copytree(base_dir, target, dirs_exist_ok=overwrite)
        print("done")
    else:
        print("skipped")

    if len(args.use) > 0:
        # Optional config
        print("Copying optional configurations...")
        for file in optional_plugin_dir.iterdir():
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

    if args.nvim:
        print("Opening neovim...", end=" ", flush=True)
        subprocess.call(["nvim"])
        print("done")


if __name__ == "__main__":
    parser = ArgumentParser(
        description="cd-kickstart setup tool",
    )

    parser.add_argument(
        "-d", "--dir",
        help='Specify directory to install',
        default={
            "Darwin": Path.home() / ".config" / "neovim",
            "Windows": Path.home() / "AppData" / "Local" / "nvim",
        }.get(platform.system(), Path.home() / ".config" / "nvim"),
        type=Path,
    )

    parser.add_argument(
        "-n", "--nvim",
        help="Launch neovim after configuration completed",
        action="store_true",
    )

    parser.add_argument(
        "-p", "--profile",
        help="Install config as a profile instead",
        type=str,
        default=None,
    )

    parser.add_argument(
        "-a", "--append", "--patch-mode",
        help="Skip base configuration and append selected optional plugins",
        action="store_true",
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
        "-R", "--remote",
        help="Remote mode (Use upstream repository instead)",
        action="store_true",
    )

    parser.add_argument(
        "-u", "--use",
        help="Use optional features. Use space to delimit multiple features",
        action="extend",
        nargs="+",
        type=str,
        default=[],
    )

    main(parser.parse_args())
