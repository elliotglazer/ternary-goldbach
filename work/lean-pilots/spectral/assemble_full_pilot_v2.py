"""Preserve original file-local open/section scope in the full owned proof closure."""
from pathlib import Path
import hashlib,json,re
here=Path(__file__).resolve().parent
old=json.loads((here/'full_closure_manifest.json').read_text())
local={Path(p['path']).stem for p in old['sources']}
bodies=[];closures=[]
for pin in old['sources']:
    path=Path(pin['path']);data=path.read_bytes()
    assert hashlib.sha256(data).hexdigest()==pin['sha256']
    lines=data.decode('utf-8-sig').splitlines()
    assert not any(re.match(r'^section\b',line) for line in lines)
    implicit=sum(line.strip()=='noncomputable section' for line in lines)
    assert implicit in (0,1)
    body=[line for line in lines if not re.fullmatch(r'import (\S+)',line)]
    bodies.append('-- BEGIN OWN SOURCE '+str(path)+'\nsection\n'+'\n'.join(body)+
        '\n'+'end\n'*(implicit+1))
    closures.append(dict(path=str(path),implicit_noncomputable_sections_closed=implicit,
                         file_scope_wrapper=True))
header='\n'.join('import '+m for m in old['external_imports'])+'\n\n'
full=header+'\n'.join(bodies)
out=here/'FullSpectralPilotV2.lean'
with out.open('x',encoding='utf8',newline='\n') as f:f.write(full)
manifest=dict(old,scope_correction=closures,predecessor_source_sha256=old['full_sha256'],
 full_sha256=hashlib.sha256(out.read_bytes()).hexdigest(),
 reason='Restore original file-local opens and implicit section closure; no proof-body changes')
with (here/'full_closure_manifest_v2.json').open('x',encoding='utf8') as f:json.dump(manifest,f,indent=2)
print(json.dumps({'source':str(out),'sha256':manifest['full_sha256'],'bytes':out.stat().st_size}))
