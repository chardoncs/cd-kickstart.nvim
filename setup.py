#!/usr/bin/env python3

from argparse import ArgumentParser, Namespace
from pathlib import Path
import textwrap

def main(args: Namespace):
    pass


if __name__ == "__main__":
    parser = ArgumentParser(
        description="cd-kickstart setup tool",
    )

    parser.add_argument(
        "-d", "--dir",
        help='Specify directory to install ("$XDG_CONFIG_HOME/nvim/" by default)',
        default=str(Path.home() / ".config" / "nvim"),
    )

    parser.add_argument(
        "-p", "--profile",
        help="Install config as a profile instead",
        type=str,
        default=None,
    )

    parser.add_argument(
        "-P", "--plugin-profile",
        help="Make profile a plugin profile, with other configurations remained global",
        action="store_true",
    )

    parser.add_argument(
        "-r", "--resolve",
        help=textwrap.dedent("""\
            What to do if the target directory is not empty:

            -- abort: Stop proceeding (default)

            -- ignore: Keep existing files while proceed with others

            -- overwrite: Proceed anyway even files exist\
        """),
        choices=["abort", "ignore", "overwrite"],
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
