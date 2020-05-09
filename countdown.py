#!/usr/bin/env python3
"""Count down in the browser"""
import sys
import tempfile
import webbrowser


TEMPLATE = r"""include(countdown.html.minified)"""


def main():
    """Entry point"""
    seconds = sys.argv[1]

    html = TEMPLATE.replace("let seconds=0;", f"let seconds={seconds};")
    htmlfile = tempfile.NamedTemporaryFile(
        "w", buffering=-1, encoding="utf-8", suffix=".html", delete=False
    )
    htmlfile.write(html)
    webbrowser.open(f"file://{htmlfile.name}")


main()
