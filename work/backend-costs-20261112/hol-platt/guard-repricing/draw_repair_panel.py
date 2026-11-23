"""Freeze an output-weighted sample of nonreal primitive character pairs."""
from bisect import bisect_right
from hashlib import sha256
from itertools import accumulate
from math import gcd,isqrt
from pathlib import Path
import json
import sys

from flint import dirichlet_char

from endpoint_policy import HERE,HOL
from repair_budget import quadratic_characters
from rounded_coverage import target

sys.path.insert(0,str(HOL/'time-pruning'))
from count_time_fft import primitive_count


def draw(anchor,role,limit):
    if limit<1:
        raise ValueError('empty selection range')
    # Rejection removes the small modular bias of indexing with a 256-bit hash.
    modulus=1<<256
    ceiling=modulus-modulus%limit
    for counter in range(1_000_000):
        x=int.from_bytes(sha256(f'{anchor}/{role}/{counter}'.encode()).digest(),'big')
        if x<ceiling:
            return x%limit
    raise RuntimeError('hash draw exhausted')


def main():
    schedule=json.loads((HERE/'rounded-coverage.json').read_bytes())
    manifest_digest=schedule['sha256']['qrh-campaign/agents/integration/transform_structural_manifest_20261111.json']
    seed=manifest_digest+'/short-repair-weighted-v1'
    max_q=265800
    squarefree=bytearray([1])*(max_q+1)
    for k in range(2,isqrt(max_q)+1):
        sq=k*k
        squarefree[sq::sq]=bytes(max_q//sq)

    strata={}
    for q in range(10001,max_q+1):
        odd=q%2
        if (odd and q>132900) or (not odd and q%4):
            continue
        nonreal=primitive_count(q)-quadratic_characters(q,squarefree)
        assert nonreal%2==0
        height=target(q)
        cells=(64*height+4)//5+640
        band=sum(q>cut for cut in (40000,80000,132900))
        name=f'{band}-{"odd" if odd else "even"}'
        strata.setdefault(name,[]).append((q,nonreal*cells))
    selected=[]
    for name,rows in sorted(strata.items()):
        cdf=list(accumulate(w for _,w in rows))
        for slot in range(2):
            key=f'{seed}/{name}/{slot}'
            q=rows[bisect_right(cdf,draw(key,'modulus',cdf[-1]))][0]
            for attempt in range(10000):
                label=1+draw(key,f'label/{attempt}',q-1)
                if gcd(q,label)!=1:
                    continue
                inv=pow(label,-1,q)
                if label==inv:
                    continue
                chi=dirichlet_char(q,label)
                if chi.is_primitive():
                    break
            else:
                raise RuntimeError('character draw exhausted')
            selected.append(dict(stratum=name,slot=slot,weight=cdf[-1],q=q,height=target(q),
                                 label=min(label,inv),inverse=max(label,inv),parity=int(chi.parity())))
    assert len(strata)==7 and len(selected)==14
    assert sum(sum(w for _,w in rows) for rows in strata.values())==39059843252180-1298972886
    report=dict(scope='Large-family nonreal inverse pairs. Two draws with replacement per physical conductor band and modulus parity. Each draw weights conductors by nonreal primitive labels times physical intervals through guard 50. Uniform primitive nonreal character within the selected conductor. No numerical signs, failures, or repair counts read.',
                seed=seed,normalization='Average each drawn pair’s jobs per physical interval within its stratum, then weight strata by their listed interval counts. Count pairs with no repairs and every failed test.',
                selection=selected)
    path=HERE/'weighted-repair-panel.json'
    encoded=(json.dumps(report,indent=2)+'\n').encode()
    if path.exists() and path.read_bytes()!=encoded:
        raise ValueError('frozen selection differs')
    path.write_bytes(encoded)
    print(sha256(encoded).hexdigest(),[(r['q'],r['label'],r['inverse']) for r in selected])


if __name__=='__main__':
    main()
