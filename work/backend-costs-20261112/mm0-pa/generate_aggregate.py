"""Close the computed product family with one balanced conjunction theorem."""
import json
import hashlib
import sys
import time
from generate_arithmetic import BASE

start=time.perf_counter()
name=sys.argv[1]
meta=json.loads((BASE/f'{name}.json').read_text())
assert meta['products']>0

def tree(lo,hi):
    if hi-lo==1:
        return f'A{lo} * B{lo} = C{lo}', f'product{lo}'
    mid=(lo+hi)//2
    a,ap=tree(lo,mid);b,bp=tree(mid,hi)
    return f'({a}) /\\ ({b})', f'(iani {ap} {bp})'

statement,proof=tree(0,meta['products'])
target=name+'_all'
(BASE/f'{target}.mm0').write_text(f'import "{name}.mm0";\ntheorem allProducts: $ {statement} $;\n',encoding='utf-8',newline='\n')
(BASE/f'{target}.mm1').write_text(f'import "/dev/shm/goldbach-mm0-pa-runs/{name}.mmb";\npub theorem allProducts: $ {statement} $ = \'{proof};\n',encoding='utf-8',newline='\n')
meta.update(name=target,assembled_from=name,closed_conjunction=True,
            underlying_generation_seconds=meta['generation_seconds'],
            generation_seconds=time.perf_counter()-start,
            mm1_bytes=(BASE/f'{target}.mm1').stat().st_size,
            mm1_sha256=hashlib.sha256((BASE/f'{target}.mm1').read_bytes()).hexdigest())
(BASE/f'{target}.json').write_text(json.dumps(meta,indent=2)+'\n')
print(target)
