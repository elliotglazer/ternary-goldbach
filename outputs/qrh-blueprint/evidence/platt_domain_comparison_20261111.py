"""Exact domain comparison only. No published computation is imported as a proof."""
from fractions import Fraction as F
from pathlib import Path
import json,csv
M=300000;spf=list(range(M+1));a=[0]*(M+1);a[1]=1
for p in range(2,M+1):
    if spf[p]==p:
        for n in range(p,M+1,p):
            if spf[n]==n:spf[n]=p
for n in range(2,M+1):
    p=spf[n];m=n;k=0
    while m%p==0:m//=p;k+=1
    a[n]=a[m]*(p-2 if k==1 else p**(k-2)*(p-1)**2)
def ceil(q):return (q.numerator+q.denominator-1)//q.denominator
def published(c):return max(F(10**8,c),200+F(75000000 if c%2==0 else 37500000,c))
# No upward rounding of the published height is permitted in containment.
profiles={'original_plus':lambda d:200+max(1000,ceil(F(704,7)*d)),
'original_star':lambda d:max(1000,ceil(F(704,343)*d)),
'reduced_plus':lambda d:200+max(300,ceil(F(484,7)*d)),
'reduced_star':lambda d:max(250,ceil(F(484,343)*d))}
stats={k:{'inside':0,'outside':0,'equality':0,'inside_chars':0,'outside_chars':0,'odd_outside':0,'even_outside':0,'min_outside':None,'max_outside':None,'max_ratio':F(0),'max_ratio_c':None,'max_excess':F(0),'max_excess_c':None,'ceiling_only_exceptions':0} for k in profiles}
rows=[];outside={k:[] for k in profiles};samples=[];active=[]
for c in range(1,M+1):
    if not a[c] or (c%2 and c>150000):continue
    active.append(c);d=F(1200000,c if c%2==0 else 2*c);hp=published(c)
    vals={k:f(d) for k,f in profiles.items()}
    for k,h in vals.items():
        s=stats[k];bad=h>hp;side='outside' if bad else'inside';s[side]+=1;s[side+'_chars']+=a[c]
        s['equality']+=h==hp
        if bad:
            outside[k].append(c);s['odd_outside' if c%2 else'even_outside']+=1
            if s['min_outside'] is None:s['min_outside']=c
            s['max_outside']=c
            if F(h)/hp>s['max_ratio']:s['max_ratio']=F(h)/hp;s['max_ratio_c']=c
            if h-hp>s['max_excess']:s['max_excess']=h-hp;s['max_excess_c']=c
            if h<=ceil(hp):s['ceiling_only_exceptions']+=1
    if vals['original_plus']>hp:
        rows.append([c,a[c],vals['original_plus'],hp.numerator,hp.denominator,str(F(vals['original_plus'])-hp)])
    if c in [1,3,4,83333,83335,85136,85140,85144,100000,125000,149999,300000]:
        samples.append({'c':c,'primitive_characters':a[c],'published_height_exact':str(hp),**vals})
assert len(active)==150000 and sum(a[c] for c in active)==5543640188
assert outside['original_plus']==[c for c in active if c%2==0 or c>=83335]
# Star original floor1000: oddfailc>100000; evenfailc>100000 too.
assert outside['original_star']==[c for c in active if c>100000]
assert not outside['reduced_star']
assert all(c%4==0 for c in outside['reduced_plus'])
for s in stats.values():
    s['max_ratio']=str(s['max_ratio']);s['max_excess']=str(s['max_excess'])
out={'status':'exact requested-height vs published-domain arithmetic only; no finite zero theorem certified',
'publication':'Platt, Numerical computations concerning the GRH, accepted manuscript Theorem9.1; arXiv1305.3087v1 Theorem7.1',
'published_height':'max(1e8/c,200+(7.5e7 if even c else3.75e7)/c), exact rational',
'parity':'modulus/conductor parity, not character parity',
'active_conductors':len(active),'primitive_characters':sum(a[c] for c in active),'stats':stats,'samples':samples}
p=Path(__file__);p.with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
with p.with_name(p.stem+'_original_exceptions.csv').open('w',newline='') as f:
    w=csv.writer(f);w.writerow(['conductor','primitive_characters','requested_Hp','published_height_numerator','published_height_denominator','excess_exact']);w.writerows(rows)
p.with_name(p.stem+'_sets.json').write_text(json.dumps(outside,separators=(',',':'))+'\n')
print(json.dumps(out,indent=2))

# Directed rational primitive-character weighted top-up heights (not runtime).
S=10**6
for key,f in profiles.items():
    lo=hi=0
    for c in active:
        d=F(1200000,c if c%2==0 else 2*c)
        deficit=max(F(0),F(f(d))-published(c))*a[c]
        t=deficit*S;lo+=t.numerator//t.denominator;hi+=ceil(t)
    out['stats'][key]['weighted_height_topup_lower']=str(F(lo,S))
    out['stats'][key]['weighted_height_topup_upper']=str(F(hi,S))
p.with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
print('ORIGINAL_WEIGHTED_TOPUP',out['stats']['original_plus']['weighted_height_topup_lower'],out['stats']['original_plus']['weighted_height_topup_upper'])
