"""Write the high factorial in four independently checked balanced-product leaves."""
from math import prod
from pathlib import Path
import sys

here = Path(__file__).resolve().parent
sys.path.insert(0, str(here.parent/'small-prefix'))
from split_power import packed_literals

n = 316227
depth = 14
nodes = [(1, n)]
for _ in range(2):
    nodes = [child for a, count in nodes for child in
             [(a, count//2), (a+count//2, count-count//2)]]
def save(name, lines):
    (here/(name+'.lean')).write_text(packed_literals('\n'.join(lines)+'\n'),encoding='utf-8')

names = []
for i, (a, count) in enumerate(nodes):
    name = f'SampleHighProduct{i}'
    names.append(name)
    save(name,['import SampleBits', 'namespace '+name, 'open SmallGoldbach',
               'set_option maxHeartbeats 0', 'set_option maxRecDepth 20000',
               f'def value : Nat := {hex(prod(range(a,a+count)))}',
               f'theorem eq_prod : value = rangeProduct {depth-2} {a} {count} := by decide +kernel',
               'end '+name])

def pair(xs):
    return '(('+xs[0]+' * '+xs[1]+') * ('+xs[2]+' * '+xs[3]+'))'

rhs = pair([f'(rangeProduct {depth-2} {a} {count})' for a,count in nodes])
save('SampleHigherFactorial', ['import '+s for s in names]+['namespace SampleHigherFactorial',
     'open SmallGoldbach', 'def fac : Nat := '+pair([s+'.value' for s in names]),
     'private theorem join (d a n : Nat) {u v : Nat}',
     '    (hu : u = rangeProduct d a (n/2)) (hv : v = rangeProduct d (a+n/2) (n-n/2)) :',
     '    u*v = rangeProduct (d+1) a n := congrArg₂ Nat.mul hu hv',
     f'theorem fac_eq : fac = Nat.factorial {n} := factorial_of_product {depth}',
     '  (join 13 1 316227 (join 12 1 158113 SampleHighProduct0.eq_prod SampleHighProduct1.eq_prod)',
     '    (join 12 158114 158114 SampleHighProduct2.eq_prod SampleHighProduct3.eq_prod))',
     'end SampleHigherFactorial'])
