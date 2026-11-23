"""Expand the independently proposed bitmap cover into HOL membership witnesses.

This producer has no proof authority. The HOL checker verifies every addition,
every successful tree lookup, every root prime and the full interval theorem.
"""
import hashlib
import json
from pathlib import Path
H = Path(__file__).resolve().parent
source = H.parent / 'finite-lean/fixture1024.json'
f = json.loads(source.read_text())
positive = set(f['indices'])
witnesses = []
for j in range(f['width']):
    for s, q in zip(f['fixture']['shifts'], f['fixture']['anchors']):
        if s + j in positive:
            p = f['first'] + 2 * (s + j)
            assert p + q == f['target'] + 2 * j
            witnesses.append((p, q))
            break
    else:
        raise ValueError(f'uncovered target {j}')
out = 'structure CoverData = struct\n'
out += f'val target = "{f["target"]}";\n'
out += f'val end_exclusive = "{f["end_exclusive"]}";\n'
out += f'val width = {f["width"]};\n'
out += 'val witnesses = [\n' + ',\n'.join(f'("{p}","{q}")' for p,q in witnesses) + '];\nend;\n'
(H / 'CoverData.sml').write_text(out, encoding='utf-8', newline='\n')
manifest = dict(source_sha256=hashlib.sha256(source.read_bytes()).hexdigest(),
                cover_data_sha256=hashlib.sha256(out.encode()).hexdigest(),
                target=f['target'], end_exclusive=f['end_exclusive'], width=f['width'],
                witnesses=witnesses)
(H / 'cover_fixture.json').write_text(json.dumps(manifest, indent=2)+'\n')
print(json.dumps({k:manifest[k] for k in ('target','end_exclusive','width')}))
