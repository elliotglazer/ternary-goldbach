import hashlib
import json
from pathlib import Path
H=Path(__file__).resolve().parent
source=H.parent/'finite-lean/fixture1024.json'
f=json.loads(source.read_text())
certs=sorted(f['certificates'],key=lambda c:c['prime'])
rows=[]
for c in certs:
    if c['prime']<=3:continue
    fs=','.join(f'("{q}",{e})' for q,e in c['factors'])
    rows.append(f'("{c["prime"]}","{c["base"]}",[{fs}])')
source_roots=[f['first']+2*j for j in f['indices']]
def strings(xs):return '['+','.join(f'"{x}"' for x in xs)+']'
text='structure PrimeData = struct\nval certificates = [\n'+',\n'.join(rows)+'];\n'
text+=f'val all_roots = {strings(f["roots"])};\n'
text+=f'val source_roots = {strings(source_roots)};\n'
text+=f'val anchor_roots = {strings(f["fixture"]["anchors"])};\n'
text+='end;\n'
(H/'PrimeData.sml').write_text(text,encoding='utf-8',newline='\n')
out=dict(source_sha256=hashlib.sha256(source.read_bytes()).hexdigest(),
         prime_data_sha256=hashlib.sha256((H/'PrimeData.sml').read_bytes()).hexdigest(),
         roots=f['roots'],source_roots=source_roots,anchor_roots=f['fixture']['anchors'],
         certificate_nodes=len(certs),builtin_primes=[2,3])
(H/'fixture.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(dict(roots=len(f['roots']),certificate_nodes=len(certs))))
