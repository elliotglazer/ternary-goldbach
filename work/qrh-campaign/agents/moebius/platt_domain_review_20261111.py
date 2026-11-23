"""Independent exact domain arithmetic; no zero computation or Lean proof."""
from pathlib import Path
from fractions import Fraction as F
import csv, hashlib, json
HERE=Path(__file__).resolve().parent
AUTHOR=HERE.parent/'major-constants'
STEM='platt_domain_comparison_20261111'
expected=json.loads((AUTHOR/(STEM+'.json')).read_text())
sets=json.loads((AUTHOR/(STEM+'_sets.json')).read_text())
M=300000
# Independent count algorithm: totient sieve, then divisor-sum inversion
# of phi(n) = sum_{d|n} primitive_count(d).
phi=list(range(M+1))
for p in range(2,M+1):
    if phi[p]==p:
        for n in range(p,M+1,p): phi[n]-=phi[n]//p
counts=phi.copy()
for d in range(1,M+1):
    for n in range(2*d,M+1,d): counts[n]-=counts[d]
active=sorted(list(range(1,150001,2))+list(range(4,M+1,4)))
assert active==[n for n in range(1,M+1) if counts[n]>0 and (n%2==0 or n<=150000)]
assert len(active)==150000 and sum(counts[n] for n in active)==5543640188
def ceil_ratio(n,d): return -(-n//d)
def heights(c):
    den=c if c%2==0 else 2*c
    return [200+max(1000,ceil_ratio(704*1200000,7*den)),
            max(1000,ceil_ratio(704*1200000,343*den)),
            200+max(300,ceil_ratio(484*1200000,7*den)),
            max(250,ceil_ratio(484*1200000,343*den))]
def published(c):
    return F(max(100000000,200*c+(75000000 if c%2==0 else 37500000)),c)
keys=['original_plus','original_star','reduced_plus','reduced_star']
stats={}
for k,key in enumerate(keys):
    bad=[c for c in active if heights(c)[k]*published(c).denominator>published(c).numerator]
    assert bad==sets[key]
    s={'inside':len(active)-len(bad),'outside':len(bad),
       'equality':sum(F(heights(c)[k])==published(c) for c in active),
       'outside_chars':sum(counts[c] for c in bad),
       'inside_chars':sum(counts[c] for c in active)-sum(counts[c] for c in bad),
       'odd_outside':sum(c%2 for c in bad),'even_outside':sum(c%2==0 for c in bad),
       'min_outside':min(bad,default=None),'max_outside':max(bad,default=None)}
    for name,func in [('max_ratio',lambda c:F(heights(c)[k])/published(c)),
                      ('max_excess',lambda c:F(heights(c)[k])-published(c))]:
        value=max(map(func,bad),default=F(0))
        s[name]=str(value);s[name+'_c']=next((c for c in bad if func(c)==value),None)
    s['ceiling_only_exceptions']=sum(heights(c)[k]<=ceil_ratio(published(c).numerator,published(c).denominator) for c in bad)
    lo=hi=0
    for c in bad:
        z=(heights(c)[k]-published(c))*counts[c]*1000000
        lo+=z.numerator//z.denominator;hi+=ceil_ratio(z.numerator,z.denominator)
    s['weighted_height_topup_lower']=str(F(lo,1000000))
    s['weighted_height_topup_upper']=str(F(hi,1000000))
    assert s==expected['stats'][key], (key,s,expected['stats'][key])
    stats[key]=s
with (AUTHOR/(STEM+'_original_exceptions.csv')).open(newline='') as f:
    rows=list(csv.DictReader(f))
assert [int(row['conductor']) for row in rows]==sets['original_plus']
for row in rows:
    c=int(row['conductor']);h=heights(c)[0];p=published(c)
    assert int(row['primitive_characters'])==counts[c]
    assert int(row['requested_Hp'])==h
    assert int(row['published_height_numerator'])==p.numerator
    assert int(row['published_height_denominator'])==p.denominator
    assert F(row['excess_exact'])==h-p
assert sets['original_plus']==[c for c in active if c%2==0 or c>=83335]
assert sets['original_star']==[c for c in active if c>100000]
assert not sets['reduced_star']
for row in expected['samples']:
    c=row['c'];assert row['primitive_characters']==counts[c]
    assert row['published_height_exact']==str(published(c))
    assert all(row[key]==heights(c)[i] for i,key in enumerate(keys))
names=['PLATT_DOMAIN_COMPARISON_2026-11-11.md',STEM+'.py',STEM+'.json',STEM+'_sets.json',STEM+'_original_exceptions.csv']
result={'status':'Independent arithmetic and every CSV/set row passed; not a finite spectral theorem',
 'input_sha256':{n:hashlib.sha256((AUTHOR/n).read_bytes()).hexdigest() for n in names},
 'independent_character_count_method':'totient sieve and divisor-sum inversion',
 'active_conductors':len(active),'primitive_characters':sum(counts[c] for c in active),
 'csv_rows_checked':len(rows),'stats':stats}
HERE.joinpath('platt_domain_review_20261111.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result,indent=2))
