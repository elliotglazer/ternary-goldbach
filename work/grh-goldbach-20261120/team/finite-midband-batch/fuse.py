"""Check the same anchor choices with only the witnesses each checker reads."""
from pathlib import Path
from statistics import median
from time import process_time
import re
import json
import sys
from flint import fmpz
here=Path(__file__).resolve().parent
group=int(sys.argv[1])
assert group in (4,8,16,32)
data=(here/'BandRows.lean').read_text(encoding='utf-8')
parts=data[data.index('def part0'):data.index('def witness4_0')]
for original,name in [('BandBaseline','BandFusedBaseline'),(f'BandGroup{group}',f'BandFused{group}')]:
    proof=(here/(original+'.lean')).read_text(encoding='utf-8')
    selected=parts
    if original!='BandBaseline':
        selected,n=re.subn(r',\s*packedHex% "[0-9a-f]+"\s*⟩',',0⟩',parts)
        assert n==256
        selected+='\n'.join(re.findall(rf'^def witness{group}_.*$',data,re.M))+'\n'
    out=proof.replace('import BandRows','import FastHex').replace('namespace '+original,'namespace '+name)
    out=out.replace('theorem piece0',selected+'theorem piece0',1)
    out=out.replace('BandRows.','').replace('end '+original,'end '+name)
    (here/(name+'.lean')).write_text(out,encoding='utf-8')
allrows=re.findall(r'⟨524288,\s*(\d+),\s*packedHex% "([0-9a-f]+)",\s*packedHex% "([0-9a-f]+)"\s*⟩',parts)
assert len(allrows)==256
groups=[fmpz(int(v,16)) for v in re.findall(r'^def witness32_\d+ : Nat := packedHex% "([0-9a-f]+)"',data,re.M)]
assert len(groups)==8
moduli=[]
expected=[]
for k,(n,offsets,inv) in enumerate(allrows):
    base=612345678900+2*524288*k-3-2*4096
    code=int(offsets,16)
    product=fmpz(1)
    for j in range(int(n)):
        product*=base+2*(code%65536)
        code//=65536
    moduli.append(product)
    expected.append(fmpz(int(inv,16)))
times=[]
for _ in range(9):
    t=process_time()
    actual=[groups[k//32]%m for k,m in enumerate(moduli)]
    times.append(process_time()-t)
    assert actual==expected
(here/'recover.json').write_text(json.dumps(dict(trials=times,median=median(times),recovered=256),indent=2)+'\n')
