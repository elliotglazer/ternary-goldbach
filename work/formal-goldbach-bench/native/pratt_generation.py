"""Native construction/check of Lucas-Pratt certificates, not a formal proof.

FLINT supplies factorizations. Python independently checks factor products and
Lucas conditions for every node; the recursive prime criterion is not formally
proved by this script. Measures the producer, never a Lean/MM0 checker.
"""
from pathlib import Path
import hashlib
import json
import math
import statistics
import time
from flint import fmpz

HERE = Path(__file__).resolve().parent
source = HERE.parent / 'prime-cover' / 'results.json'
data = json.loads(source.read_text())
roots = [pool['anchors'][i] for pool in data['pools'] for i in range(512)]
nodes = {2: {'prime': 2, 'factors': [], 'base': None}}
timings = []

def make(p):
    if p in nodes:
        return
    factors = [(int(q), int(e)) for q, e in fmpz(p-1).factor()]
    assert math.prod(q**e for q,e in factors) == p-1
    for q,e in factors:
        make(q)
    a = 2
    while not (pow(a,p-1,p) == 1 and
               all(math.gcd(pow(a,(p-1)//q,p)-1,p) == 1 for q,e in factors)):
        a += 1
    nodes[p] = {'prime': p, 'factors': factors, 'base': a}

start_cpu = time.process_time()
start_wall = time.perf_counter()
for p in roots:
    c = time.perf_counter()
    make(p)
    timings.append(time.perf_counter()-c)
cpu = time.process_time()-start_cpu
wall = time.perf_counter()-start_wall
# Recursive verification using only integer operations and supplied certificates.
checked = set()
modpows = 0
def verify(p):
    global modpows
    if p in checked:
        return
    n=nodes[p]
    if p==2:
        assert n['base'] is None
    else:
        factors=n['factors']; a=n['base']
        assert math.prod(q**e for q,e in factors)==p-1
        assert all(e>0 and 2<=q<p for q,e in factors)
        for q,e in factors:
            verify(q)
        assert pow(a,p-1,p)==1
        assert all(math.gcd(pow(a,(p-1)//q,p)-1,p)==1 for q,e in factors)
        modpows += 1+len(factors)
    checked.add(p)
v0=time.process_time()
for p in roots:
    verify(p)
verify_cpu=time.process_time()-v0
verified_modpows=modpows
chosen=roots[0]
saved_base=nodes[chosen]['base']
nodes[chosen]['base']=1
checked.clear()
corrupt_rejected=False
try:
    verify(chosen)
except AssertionError:
    corrupt_rejected=True
finally:
    nodes[chosen]['base']=saved_base
assert corrupt_rejected
ordered=sorted(timings)
out={'kind':'native_Lucas_Pratt_producer_not_formal_checker',
     'source_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),
     'roots':roots,'root_count':len(roots),'distinct_roots':len(set(roots)),
     'node_count':len(nodes),'modular_exponentiations_to_check':verified_modpows,
     'producer_cpu_seconds':cpu,'producer_wall_seconds':wall,
     'native_check_cpu_seconds':verify_cpu,
     'corrupt_base_rejected':corrupt_rejected,
     'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
     'per_root_wall_seconds':{'mean':statistics.mean(timings),'median':statistics.median(timings),
          'p95':ordered[int(.95*(len(ordered)-1))],'max':max(timings)},
     'certificates':[nodes[p] for p in sorted(nodes)]}
(HERE/'pratt_certificates.json').write_text(json.dumps(out,indent=2))
print(json.dumps({k:v for k,v in out.items() if k not in ('roots','certificates')},indent=2))
