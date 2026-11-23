"""Extract theorem goals and tactics for replay in the HOL diagnostic heap."""
from pathlib import Path
import re
import sys

directory = Path(__file__).resolve().parent
for source in ('SourceRawHeadBridge','SourceRawHeadBounds'):
    path = directory / (source + 'Script.sml')
    if not path.exists():
        continue
    for name, statement, proof in re.findall(r'^Theorem (\w+):\n(.*?)\nProof\n(.*?)\nQED', path.read_text(encoding='utf-8'), re.M | re.S):
        target = directory / 'focus' / (name + '.sml')
        target.parent.mkdir(exist_ok=True)
        target.write_text(f'val _ = set_goal ([],``{statement}``);\nval _ = e ({proof});\nval {name} = top_thm ();\nprint "CHECKED {name}\\n";\n', encoding='utf-8')
