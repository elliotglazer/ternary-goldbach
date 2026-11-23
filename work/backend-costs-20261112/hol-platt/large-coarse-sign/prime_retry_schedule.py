"""Find the cheapest verified-sign recovery schedule on the six measured heights."""
import itertools
import json
from pathlib import Path

from prime_repair import changes, subsets

HERE = Path(__file__).resolve().parent


def optimize(records, prices, bits, cold_sources):
    choices = []
    for i,row in enumerate(records):
        holes = set(next(t['modes'] for t in row['tests'] if t['bits']==bits))
        dots = {int(k):v for k,v in prices[i]['sparse_times'].items()}
        assert holes<=dots.keys()
        choices.append((holes, dots, int(row['reference_signs_hex'],16)))
    n=records[0]['sign_count']
    modes = set.union(*(h for h,d,b in choices))
    per_mode = {}
    for k in modes:
        signs = [(b>>(n-k))&1 for h,d,b in choices]
        hole = [i for i,(h,d,b) in enumerate(choices) if k in h]
        feasible = [sel for sel in subsets(hole) if
                    changes([s for i,s in enumerate(signs) if i not in hole or i in sel])==changes(signs)]
        if () not in feasible:
            per_mode[k] = feasible

    def score(kinds):
        overhead = sum(
            (r['source_cpu']+r['round_cpu'] if cold_sources else 0) +
            (r['full_axis_cpu']['median'] if kind=='full' else r['radius_cpu'])
            for kind,r in zip(kinds,prices,strict=True) if kind!='skip')
        pairs=[]
        for k,picks in per_mode.items():
            feasible = [sel for sel in picks if all(kinds[i]!='skip' for i in sel)]
            if not feasible:
                return None
            cost = lambda sel: sum(choices[i][1][k] for i in sel if kinds[i]=='dot')
            chosen = min(feasible,key=cost)
            overhead+=cost(chosen)
            pairs.extend([records[i]['j'],k] for i in chosen if kinds[i]=='dot')
        return dict(cpu=overhead, heights={records[i]['j']:kind for i,kind in enumerate(kinds)},
                    direct_signs=len(pairs),pairs=pairs)
    schedules=[r for kinds in itertools.product(('skip','dot','full'),repeat=len(records))
               if (r:=score(kinds)) is not None]
    def cheapest(allowed):
        return min((s for s in schedules if set(s['heights'].values())<=allowed),key=lambda s:s['cpu'])
    return {name:cheapest({'skip'}|allowed) for name,allowed in
            [('full_only',{'full'}),('dot_only',{'dot'}),('mixed',{'dot','full'})]}


if __name__=='__main__':
    panel=json.loads((HERE/'prime-131071.json').read_bytes())
    prices=json.loads((HERE/'prime-retry-price.json').read_bytes())
    result={}
    for i,group in enumerate(('low','high')):
        records=panel['nodes'][3*i:3*i+3]
        observed=prices['panels'][group]['nodes']
        assert [r['j'] for r in records]==[p['j'] for p in observed]
        for bits,cold in itertools.product((24,28), (False,True)):
            key=f"{group}-p{bits}-{'cold' if cold else 'cached'}"
            result[key]=optimize(records,observed,bits,cold)
            print(key,[(s,round(v['cpu'],3)) for s,v in result[key].items()])
    (HERE/'prime-retry-schedule.json').write_text(json.dumps(result,indent=2)+'\n')
