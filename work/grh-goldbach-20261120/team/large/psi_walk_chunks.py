"""Generate intermediate witnesses for the upstream Chebyshev walk through one million."""
import ast
from functools import lru_cache
from math import isqrt
import re

from prepare import REPO


@lru_cache(maxsize=1)
def prime_data():
    table=(REPO/'TernaryGoldbach/Prelim/SmallPsiTable.lean').read_text(encoding='utf8')
    cells=re.search(r'^def LQ [^\n]*? := (\[.*\])$',table,re.M)
    logs={p:(lo,hi) for p,lo,hi in ast.literal_eval(cells[1])}
    limit=10**6
    primes=bytearray([1])*(limit+1)
    primes[:2]=bytes(2)
    for p in range(2,isqrt(limit)+1):
        if primes[p]:
            primes[p*p::p]=bytes((limit-p*p)//p+1)
    powers={}
    for p,interval in logs.items():
        assert primes[p]
        v=p*p
        while v<=limit:
            powers[v]=interval
            v*=p
    return primes,powers


def walk(state,windows):
    n,tl,th,pl,ph,ll,lh=state
    prime,powers=prime_data()
    for gap,l,h in windows:
        end=n+gap
        lower=l if l else ll+10**9*gap//end
        upper=h if l else lh+(10**9*gap+n-1)//n
        weight=lower if gap==1 else ll
        for m in range(n+1,end+1):
            if prime[m]:
                tl+=weight
                th+=upper
            elif m in powers:
                a,b=powers[m]
                pl+=a
                ph+=b
        n,ll,lh=end,lower,upper
    return n,tl,th,pl,ph,ll,lh


def split_long_psi_chunk(raw,module):
    text=raw.decode()
    fields=re.search(r'theorem chunk(\d+) : resEq \(outer ([0-9 ]+) gs\1\) ([0-9 ]+) = true := by\n  decide \+kernel',text)
    k=fields[1]
    args=list(map(int,fields[2].split()))
    params=' '.join(map(str,args[:4]))
    state=tuple(args[4:])
    final=tuple(map(int,fields[3].split()))
    assert len(state)==len(final)==7
    if final[0]-state[0]<3000:
        return {module:raw}
    data=re.search(rf'^def gs{k} [^\n]+? := (\[.*\])$',text,re.M)
    windows=ast.literal_eval(data[1])
    selections=[]
    start=size=0
    for i,w in enumerate(windows):
        if size and size+w[0]>480:
            selections.append(windows[start:i])
            start,size=i,0
        size+=w[0]
    selections.append(windows[start:])
    assert sum(selections,[])==windows
    results,imports,terms={},{},[]
    ns='TernaryGoldbach.Prelim.SmallTab'
    for i,sub in enumerate(selections):
        next_state=walk(state,sub)
        part=module+f'Part{i//4+1:02}'
        name=f'psiStep_{k}_{i}'
        if part not in imports:
            imports[part]=[]
        imports[part].append(f'theorem {name} : outerState {params} {state} {sub} = some {next_state} := by\n'
                             '  apply resEq_spec\n  decide +kernel\n')
        terms.append(name)
        state=next_state
    if state!=final:
        raise ValueError(f'Computed endpoint differs for gs{k}: {state}, expected {final}')
    for part,pieces in imports.items():
        body=f'import GoldbachPsiAppend\n\nnamespace {ns}\n\nset_option maxRecDepth 100000\n\n'+'\n'.join(pieces)+f'\nend {ns}\n'
        results[part]=body.encode()
    proof=terms[-1]
    for name in reversed(terms[:-1]):
        proof=f'outerState_join {name} ({proof})'
    goal=fields[0].split(' := by')[0]
    src=tuple(args[4:])
    replacement=(f'{goal} := by\n  have calculated := {proof}\n'
                 f'  have h : outerState {params} {src} gs{k} = some {final} := calculated\n'
                 f'  change resEq (outerState {params} {src} gs{k}) {fields[3]} = true\n  rw [h]\n  rfl')
    results[module]=(''.join(f'import {p}\n' for p in imports)+text.replace(fields[0],replacement)).encode()
    return results
