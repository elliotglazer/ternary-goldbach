"""Build 1000000! as sixteen checked 62500-factor leaves and a balanced join."""
from hashlib import sha256
import json
import math
from pathlib import Path
import shutil
from time import process_time

here=Path(__file__).resolve().parent
source=here.parent/'finite-interval-sample'
for name in ['FastHex','SampleBits']:
    src=source/(name+'.olean')
    receipt=json.loads((source/(name+'.json')).read_text())
    assert sha256(src.read_bytes()).hexdigest()==receipt['olean_sha256']
    shutil.copyfile(src,here/src.name)

def save(name,lines):
    (here/(name+'.lean')).write_text('\n'.join(lines)+'\n',encoding='utf-8')

start=process_time()
leaves=[]
modules=[]
for group in range(8):
    name=f'BandMillionProduct{group}'
    modules.append(name)
    lines=['import FastHex','import PrefixFactorial','namespace '+name,'open SmallGoldbach',
           'set_option maxHeartbeats 0','set_option maxRecDepth 20000']
    for i in (2*group,2*group+1):
        first=62500*i+1
        value=math.prod(range(first,first+62500))
        lines+=[f'def value{i} : Nat := packedHex% "{value:x}"',
                f'theorem sound{i} : value{i} = rangeProduct 11 {first} 62500 := by decide +kernel']
        leaves.append((name+f'.value{i}',name+f'.sound{i}',first,62500))
    save(name,lines+['end '+name])

level=11
while len(leaves)>1:
    combined=[]
    for a,b in zip(leaves[::2],leaves[1::2]):
        assert a[2]+a[3]==b[2] and a[3]==b[3]
        combined.append((f'({a[0]} * {b[0]})',f'(join {level} {a[2]} {a[3]+b[3]} {a[1]} {b[1]})',
                         a[2],a[3]+b[3]))
    leaves=combined
    level+=1
value,proof,first,n=leaves[0]
assert (first,n,level)==(1,1000000,15)
save('BandMillionFactorial',['import '+x for x in modules]+[
     'namespace BandMillionFactorial','open SmallGoldbach',
     'private theorem join (d a n : Nat) {u v : Nat}',
     '    (hu : u = rangeProduct d a (n/2)) (hv : v = rangeProduct d (a+n/2) (n-n/2)) :',
     '    u*v = rangeProduct (d+1) a n := congrArg₂ Nat.mul hu hv',
     'def fac : Nat := '+value,
     f'theorem fac_eq : fac = Nat.factorial 1000000 := factorial_of_product 15 {proof}',
     '#print axioms fac_eq','end BandMillionFactorial'])
(here/'million-generation.json').write_text(json.dumps(dict(leaves=16,leaf_size=62500,
    generator_cpu=process_time()-start),indent=2)+'\n')
