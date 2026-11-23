"""Count exactly which grouped source-table cells have a unit residue as an output."""
import json
from math import gcd
from pathlib import Path

import numpy as np
from schedule import PATH

HERE=Path(__file__).resolve().parent


def occupied(missing,c,grid):
    # The original cells have an open left edge and closed right edge.
    start=np.maximum(1,((2*missing-1)*c)//(2*grid)+1)
    stop=np.minimum(c-1,((2*missing+1)*c)//(2*grid))
    found=np.zeros(len(missing),dtype=bool)
    for delta in range(int((stop-start).max(initial=-1))+1):
        ix=np.flatnonzero(~found & (start+delta<=stop))
        if not ix.size:
            break
        found[ix]=np.gcd(start[ix]+delta,c)==1
    return found


def group_cost(group,grid,lo,hi):
    missing=np.arange(grid+1,dtype=np.int64)
    total=0
    for n,c in sorted(((max(0,min(hi,j)-lo)+7)//8,c) for c,j in group)[::-1]:
        if n==0 or not len(missing):
            break
        mask=occupied(missing,c,grid)
        total+=int(mask.sum())*n
        missing=missing[~mask]
    return total


def main():
    for grid in (4,9,32):
        for c in range(2,100):
            got=set(np.flatnonzero(occupied(np.arange(grid+1),c,grid)))
            want={(2*grid*a+c-1)//(2*c) for a in range(1,c) if gcd(a,c)==1}
            assert got==want
    test=[(8,14),(9,19),(10,43)]
    want=set()
    for c,j in test:
        for a in range(1,c):
            if gcd(a,c)==1:
                for b in range((min(42,j)-3+7)//8):
                    want.add(((2*21*a+c-1)//(2*c),b))
    assert group_cost(test,21,3,42)==len(want)
    manifest=json.loads(PATH.read_bytes())
    rows=sorted((c,j+41) for c,phi,_,_,j,_,_ in manifest['conductors'])
    data=json.loads((HERE/'later-band-budget.json').read_bytes())
    out=[]
    for band in data['bands']:
        lo,hi=band['height_indices']
        grid=band['cells']-1
        calls=sum(group_cost(rows[i:i+32],grid,lo,hi) for i in range(0,len(rows),32))
        assert 0<calls<=band['calls']
        out.append(dict(lo=lo,hi=hi,all_cells=band['calls'],occupied=calls,empty=band['calls']-calls))
        print(lo,hi,calls,band['calls']-calls,flush=True)
    later_saved=sum(b['empty'] for b in out[1:])
    rates=data['thresholds']
    result=dict(group=32,heights=8,bands=out,later_calls_avoided=later_saved,
                hours_saved_at_band1_controls=[later_saved*t['reference_control_seconds']/3600 for t in rates],
                manifest_sha256=data['manifest_sha256'])
    (HERE/'occupied-cells.json').write_text(json.dumps(result,indent=2)+'\n')


if __name__=='__main__':
    main()
