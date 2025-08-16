#!/usr/bin/env python3

from argparse import ArgumentParser, Namespace
from difflib import unified_diff
from pathlib import Path

import atexit
import platform
import os
import shutil
import subprocess
import sys
import tempfile


# Colors
FG_BRIGHT_RED = '\033[91m'
FG_BRIGHT_GREEN = '\033[92m'
FG_BRIGHT_CYAN = '\033[96m'
RESET = '\033[0m'

# Variants
LITE_VAR = [
    "editor",
    "git",
    "telescope",
    "themes",
    "treesitter",
]
DEFAULT_VAR = [
    *LITE_VAR,
    "nerd-fonts",
    "lsp",
    "lualine",
]
FULL_VAR = [
    *DEFAULT_VAR,
    "dbee",
    "debugger",
    "image",
    "mason",
    "notification",
    "nvim-tree",
    "startup",
    "templates",
    "which-key",
]

VARIANTS = {
    "minimal": [],
    "lite": LITE_VAR,
    "default": DEFAULT_VAR,
    "full": FULL_VAR,
}

# Repo
REPO_URL = "https://github.com/chardoncs/cd-kickstart.nvim.git"

# LFG!

def print_err(*values):
    print("Error:", *values, file=sys.stderr)


def ask(prompt: str):
    if not sys.stdin.isatty():
        return True

    answer = input(f"{prompt} [Y/n]: ").strip().lower()
    return answer == '' or answer.startswith("y")


def clean_tmp_dir(root_dir):
    print(f"Clean up temporary directory: `{root_dir}`...", end=" ", flush=True)
    shutil.rmtree(root_dir)
    print("done")


def has_local_repo() -> bool:
    result = subprocess.run(["git", "remote", "get-url", "origin"], capture_output=True)
    if len(result.stderr) > 0:
        return False

    return result.stdout.strip().decode() == REPO_URL


def process_module_file(target_dir: Path, file: Path):
    if file.is_dir():
        child_dir = target_dir / file.name
        if not child_dir.exists():
            os.mkdir(child_dir)

        for child in file.iterdir():
            process_module_file(target_dir / file.name, child)

        return

    name_chunks = file.name.split(".")
    name = name_chunks[0]
    ext = name_chunks[-1] if len(name_chunks) > 1 else None
    operation = name_chunks[-2] if len(name_chunks) > 2 else None
    target = f"{name}.{ext}" if ext is not None else name

    target_path = target_dir / target

    if not target_path.exists():
        shutil.copy(file, target_path)
    elif operation == "prepend":
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


def colorize_diff(diff_lines):
    for line in diff_lines:
        symbol = line[0]
        if symbol == '+':
            yield f"{FG_BRIGHT_GREEN}{line}{RESET}"
        elif symbol == '-':
            yield f"{FG_BRIGHT_RED}{line}{RESET}"
        elif symbol == '@':
            yield f"{FG_BRIGHT_CYAN}{line}{RESET}"
        else:
            yield line


def check_apply_changes(dest_path: Path, working_dir: Path, base_dir: Path, mod_dir: Path):
    if not dest_path.is_absolute():
        dest_path = dest_path.relative_to(working_dir).resolve()

    if not dest_path.is_relative_to(working_dir):
        print_err("Destination is not in the working directory")
        sys.exit(1)

    rel_path = dest_path.relative_to(working_dir)

    dest_lines = []

    if dest_path.exists():
        with open(dest_path, 'r') as fp:
            dest_lines = fp.readlines()

    src_path = mod_dir / rel_path.name if str(rel_path.parent).endswith("lua/plugins") else base_dir / rel_path
    if not src_path.exists():
        print_err(f"Application source {src_path} does not exist")
        sys.exit(1)

    print("Comparing files...")
    print()

    with open(src_path, 'r') as fp:
        src_lines = fp.readlines()

    diff_lines = [*colorize_diff(unified_diff(dest_lines, src_lines, str(dest_path), str(src_path)))]
    if len(diff_lines) < 1:
        print("No changes found. Nothing to do.")
        return

    sys.stdout.writelines(diff_lines)
    if not ask("Do you want to apply changes?"):
        print("Aborted")
        return

    # Apply changes
    print(f"Applying {rel_path}...", end=' ')
    shutil.copyfile(src_path, dest_path)
    print("done")


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
            print_err("Git exited with errors")
            sys.exit(code)
    else:
        root_dir = Path.cwd()

    base_dir = root_dir / "base"
    modules_dir = root_dir / "modules"

    target: Path = args.dir / "lua" / "profiles" / args.profile\
            if args.profile\
            else args.dir

    if target.exists():
        if not target.is_dir():
            print("Target is not a directory", file=sys.stderr)
            sys.exit(1)

        if any(target.iterdir()) and not args.force and not args.append and not args.apply:
            print_err("Directory not empty. Stopped in cringe...")
            sys.exit(1)

    if args.apply:
        # Apply mode
        check_apply_changes(Path(args.apply), target, base_dir, modules_dir)
        return

    target_plugin_dir = target / "lua" / "plugins"

    # Base config
    print("Copying base configuration...", end=" ", flush=True)
    if not args.append:
        shutil.copytree(base_dir, target, dirs_exist_ok=args.force)
        os.mkdir(target_plugin_dir)
        print("done")
    else:
        print("skipped")

    selected_mods = set([
        *(VARIANTS[args.variant] if not args.append else []),
        *args.use,
    ])

    for excluded in args.exclude:
        selected_mods.remove(excluded)

    print("Installing modules...")
    for mod_name in selected_mods:
        direct_script = f"{mod_name}.lua"

        file = modules_dir / direct_script
        if file.is_file():
            print(f"  - {mod_name} (direct script):", end=" ", flush=True)
            shutil.copy(file, target_plugin_dir / direct_script)
            print("done")

        module_dir = modules_dir / mod_name
        if module_dir.is_dir():
            print(f"  - {mod_name} (module):", end=" ", flush=True)

            for file in module_dir.iterdir():
                process_module_file(target / "lua", file)

            print("done")

    print("done")

    if not args.no_open:
        print("Opening Neovim...", end=" ", flush=True)
        subprocess.run(["nvim"])
        print("done")


if __name__ == "__main__":
    parser = ArgumentParser(
        description="cd-kickstart.nvim setup",
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
        "-n", "--no-open",
        help="Do not launch Neovim after configuration completed",
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

    parser.add_argument(
        "-A", "--apply",
        help="Update the destination file/directory to the latest state",
        type=str,
        default=None,
    )

    parser.add_argument(
        "-f", "--force",
        help="Skip confirmation / enforce overwriting files",
        action="store_true",
    )

    variant_keys = list(VARIANTS.keys())

    parser.add_argument(
        "--variant",
        help="Select variant ({0})".format(", ".join(variant_keys)),
        choices=variant_keys,
        default="default"
    )

    parser.add_argument(
        "-R", "--remote",
        help="Remote mode (Use upstream repository instead)",
        action="store_true",
    )

    parser.add_argument(
        "-u", "--use",
        help="Use optional modules. Use space to delimit",
        action="extend",
        nargs="+",
        type=str,
        default=[],
    )

    parser.add_argument(
        "-e", "--exclude",
        help="Exclude modules. Use space to delimit",
        action="extend",
        nargs="+",
        type=str,
        default=[],
    )

    main(parser.parse_args())
