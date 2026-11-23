"""Assemble the actual owned proof closure; do not replace proofs by imported results."""
from pathlib import Path
import hashlib,json,re
here=Path(__file__).resolve().parent
files=[here/'CentralChi4.lean',here/'Elementary.lean',here/'FiniteInputs.lean',
 here/'RoundedInputs.lean',here.parent/'spectral-abel/FiniteAbel.lean',here/'Tail.lean',
 here/'SampleBox.lean',here.parent/'spectral-completion/GammaEnclosure.lean',
 here.parent/'spectral-completion/CompletionFactor.lean',
 here.parent/'spectral-reality/Chi4Reality.lean',here/'PositiveHeight.lean']
local={p.stem for p in files}
imports=[]; bodies=[]; pins=[]
for path in files:
    data=path.read_bytes(); source=data.decode('utf-8-sig')
    pins.append(dict(path=str(path),sha256=hashlib.sha256(data).hexdigest(),bytes=len(data)))
    body=[]
    for line in source.splitlines():
        m=re.fullmatch(r'import (\S+)',line)
        if m:
            if m[1] not in local and m[1] not in imports: imports.append(m[1])
        else: body.append(line)
    bodies.append('-- BEGIN OWN SOURCE '+str(path)+'\n'+'\n'.join(body)+'\n')
header='\n'.join('import '+m for m in imports)+'\n\n'
full=header+'\n'.join(bodies)
for name,content in [('FullSpectralPilot.lean',full),('ImportBaseline.lean',header)]:
    with (here/name).open('x',encoding='utf8',newline='\n') as f: f.write(content)
manifest=dict(sources=pins,external_imports=imports,proofs_replaced_by_imports=False,
 full_sha256=hashlib.sha256((here/'FullSpectralPilot.lean').read_bytes()).hexdigest(),
 baseline_sha256=hashlib.sha256((here/'ImportBaseline.lean').read_bytes()).hexdigest())
with (here/'full_closure_manifest.json').open('x',encoding='utf8') as f: json.dump(manifest,f,indent=2)
print(json.dumps(manifest,indent=2))
