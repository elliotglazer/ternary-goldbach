"""Bounded exact composition checks, not regeneration of analytic data."""
from pathlib import Path
from fractions import Fraction as F
import json,hashlib
A=Path(__file__).resolve().parents[1]
pins={
'audit/SMALL_THETA_RAW_POLYNOMIAL_SIGN_INTERFACE_2026-11-11.md':'076030481DEB4A922356A5BC0B8CCB243DF3FBB15A0DD427A29DEB044E82D430',
'prime-estimates/ADAPTIVE_SMALL_THETA_INTERPOLATION_ORDER_2026-11-11.md':'6F275BC37931D5AF741AC9DFA87C8CFC5022BC61FF829B3A45AD4C288539416C',
'prime-estimates/adaptive_small_theta_interpolation_20261111.py':'83397BC9122A7D965E91503990AAF7DAFE6A3A8FEB4CF1508C92C2886FBF229A',
'prime-estimates/adaptive_small_theta_interpolation_20261111.json':'3E6F184E7C7D2F13915F925C6687E3970204990035487DAC8BD41D9991C283A2'}
checks=0
def ck(x):
 global checks
 checks+=1
 assert x,checks
for f,h in pins.items():ck(hashlib.sha256((A/f).read_bytes()).hexdigest().upper()==h)
d=json.loads((A/'prime-estimates/adaptive_small_theta_interpolation_20261111.json').read_text())
q=F(22,7)*(F(25,192)+F(1,2**18))
ck(q==F(160919,393216)==F(d['bandwidth_halfstep_bound']))
ck(q<F(605,1344)<F(1,2))
ck(d['min_N']==2**18)
ck(F(506,21)+3*F(22,21)<47) # H*(CU+3)<=44B+3 for every B>=1
ck(F(44,7*56*8)<F(1,64))
ck(F(3,4)/6+F(3,16)*F(7,44)==F(109,704))
for row in d['parameters']:
 th=row['theta'];r=row['order'];W=F(40000000 if row['odd'] else 80000000,th)
 M=44*(2*W*W+1);eps=F(1,2**82*3**th)
 ck(F(row['M'])==M and F(row['epsilon'])==eps)
 ck(r%2==0 and 182<=r<=260)
 ck(M*q**r<eps/16 and M*q**(r-2)>=eps/16)
 ck(F(row['remainder_over_epsilon'])==M*q**r/eps)
ck(len(d['parameters'])==130)
for kernel in d['kernels']:
 r=kernel['order']
 ck(kernel['nodes']==[-r//2+1,r//2])
 ck(len(kernel['offsets'])==7)
 for l,entry in enumerate(kernel['offsets'],1):
  ck(F(entry['offset'])==F(l,8) and F(entry['Lebesgue'])<4)
ck(len(d['kernels'])==40 and d['shared_exact_weights']==7*sum(range(182,261,2))==61880)
rows=[]
for s in d['scenarios']:
 hist={int(r):n for r,n in s['order_query_histogram'].items()}
 n=sum(hist.values());prods=sum(r*k for r,k in hist.items());adds=sum((r-1)*k for r,k in hist.items())
 ck(n==s['new_endpoints'] and prods==s['real_products'] and adds==s['real_additions'])
 ck(2*prods==s['rounding_gates'] and prods==s['sample_accesses'])
 ck(prods+adds+n==s['rounding_gates'])
 ck(340*n==s['fixed340_products'] and 340*n-prods==s['saved_products'])
 rows.append({k:s[k] for k in ['extra_nodes','new_endpoints','real_products','real_additions','rounding_gates','sample_accesses','saved_products']})
out=dict(status='PASS bounded rational composition checks; component reviews remain separate gates',checks=checks,pins=pins,orders=40,parameter_rows=130,saved_kernel_norms_checked=280,shared_exact_weights=61880,scenarios=rows)
with Path(__file__).with_suffix('.json').open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print('PASS',checks,'exact composition checks')
