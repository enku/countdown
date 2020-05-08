#!/usr/bin/env python3
"""Count down in the browser"""
import sys
import tempfile
import webbrowser


TEMPLATE = r"""<!DOCTYPE html>
<meta charset="utf-8">
<title>Countdown!</title>
<style>
@keyframes countdown {{
    from {{
        font-size: 60vmin;
        opacity: 1.0;
    }}
    to {{
        font-size: 80vmin;
        opacity: 0.1;
    }}
}}

html, body {{
    border: 0;
    border-collapse: collapse;
    margin: 0;
    padding: 0;
}}

.container {{
    background-color: #000;
    color: #fff;
    display: flex;
    height: 100vh;
    vertical-align: middle;
    width: 100vw;
}}

.count {{
    animation-duration: 1s;
    animation-name: countdown;
    font-family: "San Francisco", "SF UI Display", sans-serif;
    font-size: 80vmin;
    margin: auto;
    text-align: center;
}}
</style>
<script>
let seconds={seconds};

function countDown() {{
  const count = document.getElementById('count');

  if (seconds === 0) {{
    count.innerHTML = '\u{{1f680}}';
    return;
  }}

  const newCount = count.cloneNode(true);
  newCount.innerHTML = seconds;
  count.parentNode.replaceChild(newCount, count);
  seconds-= 1;
  setTimeout(countDown, 1000);
}};

document.addEventListener('DOMContentLoaded', countDown);
</script>
<div id="container" class="container"><span id="count" class="count"></span></div>
"""


def main():
    """Entry point"""
    seconds = sys.argv[1]

    html = TEMPLATE.format(seconds=seconds)
    htmlfile = tempfile.NamedTemporaryFile(
        "w", buffering=-1, encoding="utf-8", suffix=".html", delete=False
    )
    htmlfile.write(html)
    webbrowser.open(f"file://{htmlfile.name}")


main()
