"""Bound elaboration memory by compiling the unchanged prime proofs in parts."""
import json
import re
import sys
from pathlib import Path
H=Path(__file__).resolve().parent
width=int(sys.argv[1]);chunk=int(sys.argv[2]) if len(sys.argv)>2 else 128
source=H/f'Primes{width}.lean'
original=H/f'Primes{width}Monolithic.lean'
if not original.exists():original.write_bytes(source.read_bytes())
text=original.read_text()
ns=f'FiniteP0N{width}'
body=text.split(f'namespace {ns}\n',1)[1].rsplit(f'end {ns}',1)[0]
theorems=re.split(r'(?=^theorem prime_)',body,flags=re.M)
theorems=[t for t in theorems if t.strip()]
names=[]
for i,start in enumerate(range(0,len(theorems),chunk)):
    name=f'Primes{width}Part{i:02}'
    imports=names[-1] if names else 'PrimeSupport'
    text=f'import {imports}\nset_option maxRecDepth 65536\nset_option maxHeartbeats 0\nnamespace {ns}\n'+''.join(theorems[start:start+chunk])+f'end {ns}\n'
    (H/f'{name}.lean').write_text(text,encoding='utf-8',newline='\n')
    names.append(name)
source.write_text(f'import {names[-1]}\n',encoding='utf-8',newline='\n')
(H/f'parts{width}.json').write_text(json.dumps(dict(width=width,chunk=chunk,theorems=len(theorems),modules=names),indent=2)+'\n')
print(json.dumps(dict(width=width,chunk=chunk,theorems=len(theorems),modules=len(names))))
