"""Use the exact previously checked certificate graph, without native trust."""
import hashlib
import json
from pathlib import Path
H=Path(__file__).resolve().parent
source=H.parent/'finite-lean/fixture1024.json'
f=json.loads(source.read_text())
certificates=sorted(f['certificates'],key=lambda c:c['prime'])
assert len(certificates)==1537 and len({c['prime'] for c in certificates})==1537
rows=[]
expanded=0
for c in certificates:
    factors=[q for q,e in c['factors'] for _ in range(e)]
    assert all(e>0 for q,e in c['factors'])
    expanded+=len(factors)
    rows.append(f'("{c["prime"]}","{c["base"] or 0}",['+
                ','.join(f'"{q}"' for q in factors)+'])')
text='structure BatchData = struct\nval certificates = [\n'+',\n'.join(rows)+'];\n'
text+='val all_roots = ['+','.join(f'"{q}"' for q in f['roots'])+'];\nend;\n'
(H/'BatchData.sml').write_text(text,encoding='utf-8',newline='\n')
out=dict(source_sha256=hashlib.sha256(source.read_bytes()).hexdigest(),
         batch_data_sha256=hashlib.sha256(text.encode()).hexdigest(),
         certificate_nodes=len(certificates),expanded_factors=expanded,
         roots=f['roots'],base_case=2)
(H/'batch_fixture.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({k:out[k] for k in ('certificate_nodes','expanded_factors')}))
