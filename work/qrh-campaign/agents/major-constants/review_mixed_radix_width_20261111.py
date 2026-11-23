"""Independent integer-only schedule/peak check; no transforms or root values."""
from pathlib import Path
from functools import lru_cache
from math import prod
import hashlib,json

HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent
PINS={
 'independent-feasibility/MIXED_RADIX_INTERMEDIATE_WIDTH_2026-11-11.md':'5327CD0645A36F4081155D786FCEB43586559C1520A5A67CBAB2E68FBC77619A',
 'independent-feasibility/mixed_radix_width_metadata_20261111.py':'CA571F8B74849F3F70EE2DA8867D1AD212B8D3140B2D7CE3E448001B3836DE24',
 'independent-feasibility/mixed_radix_width_metadata_20261111.json':'364B00C1BA63A06CC5B1C3E0CC777280151BB05E0E5B56063231596B0249B48F',
 'zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md':'4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4',
 'audit/REVIEW_MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md':'1268986720865E47569FC5E568546194C0A61EDC9AE80CDD78502CDC77385537',
 'zero-sum/mixed_radix_character_inventory_20261111.json':'2AC4DBAF9D0C41D1DFD8006AC280619DFF6C3059D7DA7FAEF6F1C477D2CE4D3F'}
for name,h in PINS.items():assert hashlib.sha256((AGENTS/name).read_bytes()).hexdigest().upper()==h
saved=json.loads((AGENTS/'independent-feasibility/mixed_radix_width_metadata_20261111.json').read_text())

# Linear sieve and explicit trial-factor recovery, independent of the author's sieve.
limit=300000
least=[0]*(limit+1);primes=[]
for v in range(2,limit+1):
    if least[v]==0:least[v]=v;primes.append(v)
    for p in primes:
        if p>least[v] or p*v>limit:break
        least[p*v]=p
def factor(n):
    ans=[]
    while n>1:
        p=least[n];e=0
        while n%p==0:n//=p;e+=1
        ans.append((p,e))
    return ans
def two(n):return n>0 and n&(n-1)==0
def pad(n):
    p=1
    while p<2*n-1:p*=2
    return p
def bits(n):return (n-1).bit_length()
def vecadd(a,b):return tuple(x+y for x,y in zip(a,b))
def scaled(k,a):return tuple(k*x for x in a)
def radix(n):
    if n==1:return (0,0,0,0,0)
    k=n.bit_length()-1
    return (n*k//2-3*n//2+2,n*k,n//2-1,0,0)
@lru_cache(None)
def blue(n):
    step=prod(p**((e+1)//2) for p,e in factor(n//(2 if n%2==0 else 1)))
    cheap=n//step;phase=2*step*step//n%4
    quarter=cheap//2 if phase%2 else 0
    minus=cheap//2 if phase==2 else 0
    p=pad(n)
    return vecadd(scaled(2,radix(p)),(p+2*(n-cheap),0,2*quarter,2*minus,p))
def baseline(n):return radix(n) if two(n) else blue(n)
@lru_cache(None)
def circuit(n):
    if two(n):return ('radix2',),radix(n)
    r=least[n]
    if r==n:
        if n<=11:return ('direct_prime',),((n-1)**2,n*(n-1),0,0,0)
        return ('bluestein',),blue(n)
    m=n//r;quarters=minuses=0
    for a in range(1,r):
        for phase in (1,2,3):
            num=phase*n
            if num%(4*a)==0 and 0<num//(4*a)<m:
                if phase==2:minuses+=1
                else:quarters+=1
    cross=((r-1)*(m-1)-quarters-minuses,0,quarters,minuses,0)
    candidate=vecadd(vecadd(scaled(r,circuit(m)[1]),scaled(m,circuit(r)[1])),cross)
    old=blue(n)
    if candidate[0]<=old[0] and candidate[1]<=old[1]:return ('split',r,m),candidate
    return ('bluestein',),old
def bp(n):return 4*pad(n)*(n*n+n+1)
def op(n):return (1 if n==1 else 2*n) if two(n) else bp(n)
active=set()
@lru_cache(None)
def peak(n):
    active.add(n);tag=circuit(n)[0]
    if tag[0]=='radix2':return 1 if n==1 else 2*n
    if tag[0]=='direct_prime':return 2*n
    if tag[0]=='bluestein':return bp(n)
    _,r,m=tag
    assert 2*pad(r)<=pad(n)
    assert n*n+n+1-m*(r*r+r+1)==(m-1)*(r*r*m-1)>=0
    return max(peak(m),2*m*peak(r))
axis_set=set();hist={};maxima=[(0,0),(0,0)];examples={};count=0
for c in range(3,limit+1):
    if not (c%4==0 or c%2==1 and c<=150000):continue
    axes=[]
    for p,e in factor(c):
        if p!=2:axes.append((p-1)*p**(e-1))
        elif e==2:axes.append(2)
        elif e>2:axes.extend([2,2**(e-2)])
    axis_set.update(axes);prefix=1;old=mixed=1
    for n in axes:
        old=max(old,2*prefix*op(n));mixed=max(mixed,2*prefix*peak(n));prefix*=n
    assert mixed<=old
    count+=1;delta=bits(old)-bits(mixed);hist[str(delta)]=hist.get(str(delta),0)+1
    maxima[0]=max(maxima[0],(old,c));maxima[1]=max(maxima[1],(mixed,c))
    if str(c) in saved['examples']:examples[str(c)]=dict(axes=axes,old_peak=old,mixed_peak=mixed,old_bits=bits(old),mixed_bits=bits(mixed))
assert count==saved['conductor_count']==149999
assert len(active)==saved['active_nodes']==37117
assert hist==saved['conductor_bit_saving_histogram'] and examples==saved['examples']
axis_rows=[];axis_hist={}
for n in sorted(axis_set):
    a,b=op(n),peak(n)
    assert b<=a
    axis_rows.append(dict(n=n,old_peak=a,mixed_peak=b,old_bits=bits(a),mixed_bits=bits(b)))
    delta=bits(a)-bits(b);axis_hist[str(delta)]=axis_hist.get(str(delta),0)+1
assert axis_rows==saved['axis_rows'] and axis_hist==saved['axis_bit_saving_histogram']
keys=('general_complex_products','complex_add_sub','quarter_turns','negations','dyadic_scales')
plan={str(n):dict(choice=circuit(n)[0],count=dict(zip(keys,circuit(n)[1]))) for n in sorted(active)}
plan_sha=hashlib.sha256(json.dumps(plan,sort_keys=True,separators=(',',':')).encode()).hexdigest()
assert plan_sha==saved['plan_sha256']
for mx,key in zip(maxima,['max_old_conductor_peak','max_mixed_conductor_peak']):
    assert dict(coefficient=mx[0],conductor=mx[1],bits=bits(mx[0]))==saved[key]
out=dict(status='PASS_INDEPENDENT_INTEGER_SCHEDULE_AND_WIDTH_REPLAY',pins=PINS,plan_sha256=plan_sha,axis_count=len(axis_set),active_nodes=len(active),conductor_count=count,maxima=maxima,examples=examples,axis_histogram=axis_hist,conductor_histogram=hist,scope='Integer schedule and envelope metadata only; analytic recurrence checked in prose; no roots or transforms evaluated.')
dest=Path(__file__).with_suffix('.json')
with dest.open('x',encoding='utf-8',newline='\n') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({k:v for k,v in out.items() if k not in ('pins','examples','axis_histogram','conductor_histogram')},indent=2))
print('RECEIPT_SHA256',hashlib.sha256(dest.read_bytes()).hexdigest().upper())
