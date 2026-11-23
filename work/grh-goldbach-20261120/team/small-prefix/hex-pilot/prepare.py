"""Re-encode the two longest numerals in the shared ten-billion proof."""
from pathlib import Path
import re

HERE = Path(__file__).resolve().parent
base = HERE.parent/"ten-billion/shards/Power10Common.lean"
source = base.read_text(encoding="utf-8")


def repack(match):
    return f'packedHex% "{match[0][2:]}"'


source,count = re.subn(r"\b0x[0-9a-f]{2048,}\b",repack,source)
assert count == 2
fast = "import FastHex\n"+source.replace("SmallGoldbach.Power10","SmallGoldbach.FastCommon")
(HERE/"FastCommon.lean").write_text(fast,encoding="utf-8",newline="\n")
