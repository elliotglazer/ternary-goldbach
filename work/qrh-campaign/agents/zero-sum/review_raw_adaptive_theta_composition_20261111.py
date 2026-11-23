"""Independent exact composition review. No analytic evaluations/imports."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial
import json, hashlib
A=Path(__file__).resolve().parents[1]
pins={
'audit/RAW_ADAPTIVE_SMALL_THETA_COMPOSITION_2026-11-11.md':'0FF513632780E8DF9FA544E5B8AA8B919126BA8FD482D862B4761093D0996C81',
'audit/raw_adaptive_theta_composition_20261111.py':'92C4A1068691A920F0C3974D6CC45B3D33271C54250BA63238AB4EC0789BED4A',
'audit/raw_adaptive_theta_composition_20261111.json':'B6BC867C1F48648F9012271ACF9EC37F4E771DF9D4CA374016731069A1BA563D',
'zero-sum/REVIEW_SMALL_THETA_RAW_POLYNOMIAL_SIGN_INTERFACE_2026-11-11.md':'5683768E8F7B8B93FD4CD2E45CDBED40BFA9CC1BAE238CF920A22B40FEBB820A',
'integration/REVIEW_ADAPTIVE_SMALL_THETA_INTERPOLATION_ORDER_2026-11-11.md':'EACC35D6B7B05B808C93515665D2616FC322DD65802CB67B0BB2782A150D4948',
}
checks=0
def ck(x):
    global checks
    checks+=1
    assert x, checks
receipt=json.loads((A/'audit/raw_adaptive_theta_composition_20261111.json').read_text())
pins.update(receipt['pins'])
for path,h in pins.items():
    ck(hashlib.sha256((A/path).read_bytes()).hexdigest().upper()==h)
d=json.loads((A/'prime-estimates/adaptive_small_theta_interpolation_20261111.json').read_text())
q=F(160919,393216)
ck(q==F(22,7)*(F(25,192)+F(1,2**18)))
ck(F(506,21)+F(66,21)<47)
ck(F(3,24)+F(21,704)==F(109,704))
ck(F(1,448)<F(7,2816))
for row in d['parameters']:
    W=F(40000000*(2-int(row['odd'])),row['theta'])
    M=44*(2*W*W+1)
    eps=F(1,2**82*3**row['theta'])
    r=row['order']
    ck(F(row['M'])==M and F(row['epsilon'])==eps)
    ck(r%2==0 and M*q**r<eps/16<=M*q**(r-2))
    ck(F(row['remainder_over_epsilon'])==M*q**r/eps)
    # Uniform raw transport using HC_U <=506B/21, H<=22/21.
    B=M/44
    ck(F(506,21)*B*q**r<eps/16)
    ck(F(506,21)*B+F(66,21)<M+3)
for kernel in d['kernels']:
    r=kernel['order'];m=r//2
    for e in kernel['offsets']:
        x=F(e['offset']);prod=F(1)
        for j in range(1-m,m+1): prod*=x-j
        first=prod/((x-(1-m))*(-1)**(r-1)*factorial(r-1))
        ws=[first]
        for j in range(1-m,m):
            ws.append(-ws[-1]*(x-j)*(m-j)/((x-j-1)*(j+m)))
        norm=sum(map(abs,ws))
        ck(sum(ws)==1)
        ck(norm==F(e['Lebesgue']) and norm<4)
        ck(len(ws)==r)
ck(sum(7*k['order'] for k in d['kernels'])==61880)
for s,out in zip(d['scenarios'],receipt['scenarios']):
    hist={int(r):n for r,n in s['order_query_histogram'].items()}
    n=sum(hist.values());p=sum(r*v for r,v in hist.items())
    expected={'extra_nodes':s['extra_nodes'],'new_endpoints':n,'real_products':p,
              'real_additions':p-n,'rounding_gates':2*p,'sample_accesses':p,
              'saved_products':340*n-p}
    for key,val in expected.items(): ck(out[key]==val==s[key])
out={'status':'PASS independent exact composition only','checks':checks,'pins':pins,
     'parameters':len(d['parameters']),'independently_rebuilt_kernel_norms':280,
     'scenarios':receipt['scenarios']}
with Path(__file__).with_suffix('.json').open('x',encoding='utf8',newline='\n') as f:
    json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'status':out['status'],'checks':checks}))
