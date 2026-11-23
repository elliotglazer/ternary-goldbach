"""Read-only evidence-pin check; not a mathematical or Lean proof checker."""
from pathlib import Path
import hashlib,json,re

HERE=Path(__file__).resolve().parent
A=HERE.parent
root=A.parent.parent/'qrh-blueprint'/'POST_131_RESEARCH.md'
mapping=A/'integration'/'POST131_OBLIGATION_MAP_2026-11-11.md'
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
assert sha(mapping)=='652284dfba292ef119416c181206f773370d2096f960cad29b6c382724ac87de'
checks=[]
for line in mapping.read_text(encoding='utf-8').splitlines():
    fields=[x.strip().strip('`') for x in line.split('|')]
    if len(fields)>=4 and re.fullmatch('[0-9A-Fa-f]{64}',fields[2]):
        p=A/fields[1]
        actual=sha(p)
        assert actual==fields[2].lower(),p
        checks.append({'file':fields[1],'sha256':actual})
assert len(checks)==7
out={'status':'PASS: seven evidence-table hashes only; manual scope review separate',
     'map_sha256':sha(mapping),'root_note_sha256':sha(root),'evidence':checks}
HERE.joinpath('review_post131_scope_20261111.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
