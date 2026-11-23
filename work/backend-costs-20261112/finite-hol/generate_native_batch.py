import hashlib
import json
from pathlib import Path
H=Path(__file__).resolve().parent
f=json.loads((H.parent/'finite-lean/fixture1024.json').read_text())
w=json.loads((H/'cover_fixture.json').read_text())
certs=sorted(f['certificates'],key=lambda c:c['prime'])
lines=[str(len(certs))]
for c in certs:
    fs=[q for q,e in c['factors'] for _ in range(e)]
    lines.append(' '.join(map(str,[c['prime'],c['base'] or 0,len(fs),*fs])))
lines += [str(len(f['roots'])),' '.join(map(str,f['roots'])),
          f'{w["target"]} {w["end_exclusive"]} {w["width"]}']
lines += [f'{p} {q}' for p,q in w['witnesses']]
data='\n'.join(lines)+'\n'
(H/'native_batch_data.txt').write_text(data,encoding='ascii',newline='\n')
print(json.dumps(dict(bytes=len(data),sha256=hashlib.sha256(data.encode()).hexdigest())))
