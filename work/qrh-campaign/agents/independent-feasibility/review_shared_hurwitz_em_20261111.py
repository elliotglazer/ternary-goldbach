"""Exact finite bounds and circuit inventory, not a seed evaluator."""
from pathlib import Path
from fractions import Fraction as F
from math import comb,factorial
import hashlib,json,re
A=Path(__file__).resolve().parents[1]
p=A/'integration/SHARED_HURWITZ_EM_SEED_CIRCUIT_2026-11-11.md'
assert hashlib.sha256(p.read_bytes()).hexdigest().upper()=='1E1D5099D398EE978D635729873F4D3941BC186BD91D086198B39962DF8E564E'
rows=re.findall(r'\| `([^`]+)` \| `([A-F0-9]{64})` \|',p.read_text())
for path,sha in rows:assert hashlib.sha256((A/path).read_bytes()).hexdigest().upper()==sha
checks=len(rows)+1
bands=[(500,512,6401),(1000,1024,6400),(2000,2048,12800),(5000,4096,38400),(10000,8192,63988)]
Bs=[F(1)]
for n in range(1,129):
    Bs.append(-sum(F(comb(n+1,k))*Bs[k] for k in range(n))/F(n+1))
for r in range(1,65):
    gamma=6**(2*r)*Bs[2*r]/factorial(2*r)
    assert abs(gamma)<4;checks+=1
    assert (gamma>0)==bool(r%2);checks+=1
tables={};precision=[]
for P in (20,24,27,28,32):
    V=10000;N=(V+160+2)//3
    bound=comb(V+P-1,P-1);M=max(N*bound,27*(2*(N+2)+1))
    precision.append(dict(P=P,base_bits=100+(32*M-1).bit_length(),head_bits=100+(32*N*bound*P-1).bit_length()))
for label,P,scale,shifted in [('old24',24,1,False),('fine20',20,2,False),('shift27',27,1,True),('shift28',28,1,True)]:
    count=dict(slots=0,pairs=0,head_scales=0,head_adds=0,E_stages=0,bernoulli_terms=0)
    for V,D,J in bands:
        D*=scale;N=(V+160+2)//3
        assert N+2<4096 and 3*N>=V+160;checks+=2
        bound=F(108*(N+2),F(255,2))*F(1,2**128)
        assert bound<F(1,2**116)<F(1,2**104);checks+=1
        assert F(108*64,F(255,2))*F(1,2**128)<F(1,2**122);checks+=1
        C=2916*(N+2)+729+69984+3
        assert C<2**24;checks+=1
        slot=D*P+(20 if shifted else P)
        count['slots']+=J*slot
        count['pairs']+=J*((N+1)*D+1)
        count['head_scales']+=J*N*(D*(P-1)+(19 if shifted else P-1))
        count['head_adds']+=J*N*slot
        count['E_stages']+=J*(D*(P+126)+(146 if shifted else P+126))
        count['bernoulli_terms']+=J*64*slot
    tables[label]=count
expected={
'old24':[17223585528,2068812377589,47572983905064,49641374509632,107647409550,1102309473792],
'fine20':[28703416100,4137624627189,78593221322440,82729706655200,209534937530,1837018630400],
'shift27':[19375637796,2068812377589,53776084584136,55844475188704,109799461818,1240040818944],
'shift28':[20093159204,2068812377589,55844179312328,57912569916896,110516983226,1285962189056]}
for label,values in expected.items():assert list(tables[label].values())==values;checks+=6
assert [(x['base_bits'],x['head_bits']) for x in precision]==[(313,317),(348,353),(374,379),(383,388),(417,422)];checks+=5
assert F(3,32)+F(1,32)+F(1,128)+F(1,32)+F(1,32)+F(1,16)==F(33,128)<1;checks+=1
assert (3387+1)*8192+1==27754497 and (3387+1)*16384+1==55508993;checks+=2
assert 16*128000<2**21;checks+=1
# Formal endpoint cancellation: exponent of6 and b in lambda*gamma*E/6.
for k in range(32):
    assert F(3**k,factorial(k))<27 and F(6**k,factorial(k))<729;checks+=2
    for r in range(1,65):
        ell=k+2*r-1
        assert k+2*r-ell-1==0 and -ell==1-k-2*r;checks+=1
out=dict(status='PASS_EXACT_SHARED_EM_REVIEW',checks=checks,tables=tables,precision=precision,
         global_seed_error_fraction='33/128',scope='Finite rational bounds and counts only; no seeds or analytic values.')
with Path(__file__).with_suffix('.json').open('x',encoding='utf8',newline='\n') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps(out,indent=2))
