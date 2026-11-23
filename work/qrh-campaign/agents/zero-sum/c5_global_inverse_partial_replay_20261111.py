"""Read-only replay of the INCOMPLETE c5 receipt; never emits full PASS."""
from pathlib import Path
from fractions import Fraction as F
import hashlib
import importlib.util
import json
import sys
import time

HERE=Path(__file__).parent
SOURCE=HERE/'c5_global_inverse_certificate_20261111.py'
RECEIPT=SOURCE.with_suffix('.json')


def main():
    start=time.perf_counter()
    d=json.loads(RECEIPT.read_text())
    assert d['status']=='INCOMPLETE_DIAGNOSTIC'
    assert d['script_sha256']==hashlib.sha256(SOURCE.read_bytes()).hexdigest()
    spec=importlib.util.spec_from_file_location('c5_fixed_inverse',SOURCE)
    c=importlib.util.module_from_spec(spec)
    spec.loader.exec_module(c)
    assert d['candidate_sha256']==hashlib.sha256(c.CANDIDATE.read_bytes()).hexdigest()
    assert d['source_sha256']==hashlib.sha256(c.gen.SOURCE.read_bytes()).hexdigest()
    structure_only='--structure-only' in sys.argv
    results={}
    cache={}
    for method,index in [('l1',0),('T16',1)]:
        prev=(c.em.LEFT,-c.em.T)
        length=F(0)
        rows=d[method+'_panels']
        for row in rows:
            a,b=tuple(map(F,row['a'])),tuple(map(F,row['b']))
            assert a==prev
            L,R,T=c.em.LEFT,c.em.RIGHT,c.em.T
            assert ((a[1]==b[1]==-T and L<=a[0]<b[0]<=R) or
                    (a[0]==b[0]==R and -T<=a[1]<b[1]<=T) or
                    (a[1]==b[1]==T and L<=b[0]<a[0]<=R) or
                    (a[0]==b[0]==L and -T<=b[1]<a[1]<=T))
            assert 0<=F(row['bound'])<1
            length+=abs(b[0]-a[0])+abs(b[1]-a[1])
            if not structure_only:
                if (a,b) not in cache:
                    cache[a,b]=c.bounds(a,b)
                q=cache[a,b][index]
                assert q<1 and q<=c.em.ar(F(row['bound']))
            prev=b
        total=2*(R-L+2*T)
        assert prev!=(L,-T) and length<total
        results[method]={'panels':len(rows),'endpoint':list(map(str,prev)),
                         'covered_length':str(length),'total_length':str(total)}
    result={'status':'INCOMPLETE_STRUCTURE_REPLAY' if structure_only else 'INCOMPLETE_PARTIAL_BOUNDS_REPLAY',
            'full_rectangle_certified':False,'methods':results,
            'distinct_bound_recomputations':len(cache),
            'seconds':time.perf_counter()-start}
    print(json.dumps(result,indent=2))


if __name__=='__main__':
    main()
