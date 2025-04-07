#!/usr/bin/env python3

from argparse import ArgumentParser, Namespace
from pathlib import Path

import atexit
import platform
import os
import re
import shutil
import subprocess
import sys
import tempfile


VARIANTS = {
    "minimal": [],
    "lite": [
    ],
    "default": [
    ],
    "slop": [
    ],
}

REPO_URL = "https://github.com/chardoncs/cd-kickstart.nvim.git"


def clean_tmp_dir(root_dir):
    print(f"Clean up temporary directory: `{root_dir}`...", end=" ", flush=True)
    shutil.rmtree(root_dir)
    print("done")


def has_local_repo() -> bool:
    result = subprocess.run(["git", "remote", "get-url", "origin"], capture_output=True)
    if len(result.stderr) > 0:
        return False

    return str(result.stdout.strip()) == REPO_URL


def process_module_file(target_dir: Path, file: Path):
    if file.is_dir():
        for child in file.iterdir():
            process_module_file(target_dir / file.name, child)

        return

    name_chunks = file_name.split(".")
    name = name_chunks[0]
    ext = name_chunks[-1] if len(name_chunks) > 1 else None
    operation = name_chunks[-2] if len(name_chunks) > 2 else None
    target = f"{name}.{ext}" if ext is not None else name

    target_path = target_dir / target

    if not target_path.exists():
        shutil.copy(file, target_path)
        continue

    if operation == "prepend":
        addition = file.read_text()
        content = target_path.read_text()

        target_path.write_text(f"{addition}\n{content}")

    elif operation == "append":
        with open(target_path, "a") as fp:
            fp.write(f"\n{file.read_text()}")
    else:
        pos = None
        if operation is not None:
            try:
                pos = int(operation)
            except:
                print(f"Invalid module operation: {operation}", file=sys.stderr)

        if pos is not None:
            # Insert at position
            addition = file.read_text()
            content = target_path.read_text().split("\n")
            content_len = len(content)

            while pos < 0:
                pos += content_len

            if pos > content_len:
                with open(target_path, "a") as fp:
                    fp.write(f"\n{file.read_text()}")
            else:
                with open(target_path, "w") as fp:
                    fp.writelines(content[:pos])
                    fp.write(f"\n{addition}\n")
                    fp.writelines(content[pos:])

        else:
            # Full replace
            shutil.copy(file, target_path)


def main(args: Namespace):
    if args.remote or not has_local_repo():
        root_dir = Path(tempfile.mkdtemp())
        # Clean up temporary directory on exit
        atexit.register(clean_tmp_dir, root_dir)

        code = subprocess.call(
            ["git", "clone", REPO_URL, str(root_dir)],
            stdout=subprocess.PIPE, stderr=subprocess.PIPE,
        )

        if code:
            print("Error: Git exited with errors", file=sys.stderr)
            sys.exit(code)
    else:
        root_dir = Path.cwd()

    base_dir = root_dir / "base"
    options_dir = root_dir / "options"

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

    plugin_dir = target / "lua" / "plugins"

    # Base config
    print("Copying base configuration...", end=" ", flush=True)
    if not args.append:
        shutil.copytree(base_dir, target, dirs_exist_ok=overwrite)
        os.mkdir(plugin_dir)
        print("done")
    else:
        print("skipped")

    selected_options = [*VARIANTS[args.variant], *args.use]

    print("Copying options...")
    for option in selected_options:
        direct_script = f"{option}.lua"

        if (options_dir / direct_script).is_file():
            print(f" - {option}:", end=" ", flush=True)
            shutil.copy(file, plugin_dir / direct_script)
            print("done")

        module_dir = options_dir / option
        if module_dir.is_dir():
            for file in module_dir.iterdir():
                process_module_file(target / "lua", file)

    print("done")

    if args.nvim:
        print("Opening neovim...", end=" ", flush=True)
        subprocess.Popen(["nvim"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
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
        "-a", "--append",
        help="Skip base configuration and append selected optional plugins",
        action="store_true",
    )

    parse.add_argument(
        "--variant",
        help="Select variant (minimal, lite, default, slop)",
        choices=["minimal", "lite", "default", "slop"],
        default="default"
    )

    parser.add_argument(
        "-r", "--resolve",
        help="""What to do if the target directory is not empty:
-- abort: Stop proceeding (default)
-- overwrite: Proceed anyway even files exist""",
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
