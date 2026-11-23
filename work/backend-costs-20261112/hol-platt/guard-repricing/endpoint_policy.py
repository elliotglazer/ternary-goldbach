"""Replay endpoint-probe policies from fixed candidate signs and independent raw grids.

Try the ordinary strict Turing test before requesting any extra boundary sign.
If needed, use linear interpolation only to rank possible probes, then score
the *certified* sign from the archived input. A failed ranking exhausts the
available candidates before reporting failure. The historical analytic phase
and Turing allowance remain premises throughout.
"""
from ast import literal_eval
from bisect import bisect_left
from fractions import Fraction as F
from hashlib import sha256
from itertools import pairwise
from pathlib import Path
import json
import os
import argparse


HERE = Path(__file__).resolve().parent
HOL = HERE.parent
TEAM = HOL.parents[1] / 'grh-goldbach-20261120' / 'team'


def checked(path, digest):
    data = path.read_bytes()
    if sha256(data).hexdigest() != digest:
        raise ValueError(f'changed source {path}')
    return data


class Region:
    def __init__(self, signs, lower, upper, inclusive):
        self.lower, self.upper, self.inclusive = lower, upper, inclusive
        self.samples = [(t,s) for t,s in signs if self.contains(t)]
        self.ticks = [t for t,_ in self.samples]
        flips = [v for (_,s),(v,z) in pairwise(self.samples) if s != z]
        self.count, self.weight = len(flips), sum(upper-v for v in flips)

    def contains(self, pos):
        return self.lower <= pos <= self.upper if self.inclusive else self.lower < pos < self.upper

    def change(self, pos, sign, kept):
        if not self.contains(pos):
            return 0, 0
        i = bisect_left(self.ticks,pos)
        if i < len(self.ticks) and self.ticks[i] == pos:
            raise ValueError('duplicate probe')
        left = self.samples[i-1] if i else None
        right = self.samples[i] if i<len(self.ticks) else None
        for t,s in kept.items():
            if not self.contains(t):
                continue
            if t<pos and (left is None or t>left[0]): left = (t,s)
            if pos<t and (right is None or t<right[0]): right = (t,s)
        before = int(left is not None and right is not None and left[1]!=right[1])
        first = int(left is not None and left[1]!=sign)
        second = int(right is not None and right[1]!=sign)
        change_at_right = (second-before)*(self.upper-right[0]) if right else 0
        return first+second-before, first*(self.upper-pos)+change_at_right


def evaluate_pair(signs, raw, halo, edges, t_tick, h_tick, sub, phase, allowance, inclusive):
    regions = [[Region([(t,s) for t,s in table.items() if t not in edges], l,h,inclusive)
                for l,h in [(0,t_tick),(t_tick,h_tick)]] for table in signs]
    available = [(j,t) for j in (0,1) for t in sorted(edges) if 0<t<h_tick]
    actual = [{},{}]
    scans = [[a.count,a.weight,b.count,b.weight] for a,b in regions]

    def update(j,t,s):
        return [v for reg in regions[j] for v in reg.change(t,s,actual[j])]

    def predicted(j,t):
        i,k = divmod(t,sub)
        v = (sub-k)*raw[j][i+halo]+k*raw[j][i+halo+1]
        return 1 if v>0 else -1

    def record(policy):
        k = sum(r[0] for r in scans)
        w = sum(r[3] for r in scans)
        span = h_tick-t_tick
        excess = (phase+2*allowance)*F(64*sub,5*span) - F(w,span) - k
        if excess < 0:
            raise ValueError(f'inconsistent lower and upper bounds for {policy}: {excess}')
        return dict(policy=policy, kept_edges=[sorted(x) for x in actual],
                    scans=[list(x) for x in scans], excess=str(excess),passes=excess<1)

    first = record('no_edges')
    chosen = None
    while available:
        if chosen is None and record('selected')['passes']:
            chosen = record('selected')
        ranks = []
        for j,t in available:
            main,_,_,w = update(j,t,predicted(j,t))
            ranks.append(main*(h_tick-t_tick)+w)
        j,t = available.pop(ranks.index(max(ranks)))
        s = signs[j][t]
        scans[j] = [a+b for a,b in zip(scans[j],update(j,t,s),strict=True)]
        actual[j][t] = s
    return [first,chosen or record('selected'),record('all')]


def run(folder,q):
    counts = json.loads((folder/'counts.json').read_bytes())
    grid = json.loads((folder/'grid.json').read_bytes())
    T, sub = F(counts['T']), counts['sub']
    t_pos = T*F(64,5)*sub
    assert t_pos.denominator==1
    t_tick = int(t_pos)
    guards = [r['extra'] for r in next(iter(counts['counts'].values()))['fixed']]
    edges = {1,t_tick-1,t_tick+1,*(t_tick+g*sub-1 for g in guards)}
    info = {}
    for row in grid['rows']:
        lab = row['label']
        path = folder/f'signs-{lab}.tsv'
        sign_digest = counts['sha256'][path.name]
        pairs = [tuple(map(int,line.split())) for line in checked(path,sign_digest).splitlines()]
        assert all(a[0]<b[0] for a,b in pairwise(pairs)) and all(s in (-1,1) for _,s in pairs)
        signs = dict(pairs)
        assert edges <= signs.keys()
        raw = list(map(int,checked(folder/f'grid-{lab}.txt',row['grid_sha256']).splitlines()))
        info[lab] = (signs,raw,os.path.relpath(path,HERE).replace('\\','/'),sign_digest)
    records=[]
    for pair,versions in counts['counts'].items():
        labs = list(literal_eval(pair))
        signs,raw,paths,digests = zip(*(info[l] for l in labs))
        for ref in versions['fixed']:
            guard = ref['extra']
            h_tick = t_tick + guard*sub
            phase, bound = F(ref['phase_upper']), F(ref['allowance']['moderate'])
            for inclusive in (False,True):
                results = evaluate_pair(signs,raw,grid['halo'],edges,t_tick,h_tick,sub,phase,bound,inclusive)
                full=results[-1]
                if not inclusive:
                    assert sum(r[0] for r in full['scans'])==ref['K']
                    assert sum(r[3] for r in full['scans'])==ref['W_ticks']
                    assert F(full['excess'])==1-F(ref['exact_margin']['moderate'])
                common = dict(q=q,labels=labs,T=str(T),sub=sub,t_tick=t_tick,h_tick=h_tick,
                              guard=guard,endpoint_inclusive=inclusive,phase_upper=str(phase),
                              allowance=str(bound),available_edges=sorted(edges),signs=list(paths),
                              sign_sha256=list(digests))
                for result in results:
                    records.append(common|result)
    return records


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--panel',action='store_true')
    panel=parser.parse_args().panel
    records=[]
    folders=[(HOL/'full-height-count',10000),(TEAM/'q10004-gaussian',10004),(TEAM/'high-conductor-full',265800)]
    if panel:
        folders=[(TEAM/f'gaussian-panel-q{q}',q) for q in (65536,180180)]
    for folder,q in folders:
        records.extend(run(folder,q))
    path=HERE/('endpoint-policy-panel.json' if panel else 'endpoint-policy.json')
    path.write_text(json.dumps(dict(rows=records),indent=2)+'\n')
    for r in records:
        if r['guard']==640 and r['policy'] in ('selected','no_edges'):
            print(r['q'],r['labels'][0],r['endpoint_inclusive'],r['policy'],
                  sum(map(len,r['kept_edges'])),round(float(F(r['excess'])),5),r['passes'])


if __name__=='__main__':
    main()
