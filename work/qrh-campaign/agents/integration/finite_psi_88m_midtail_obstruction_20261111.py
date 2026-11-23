"""Exact rational obstruction for the fixed 1142 mid-tail envelope; no function values."""
from pathlib import Path
from fractions import Fraction as Q
import json, hashlib

p=Path(__file__).with_name('finite_psi_88m_fixed_rows_20261111.json')
j=json.loads(p.read_text(encoding='utf-8'))
def q(x):return Q(int(x['numerator']),int(x['denominator']))
def enc(x):return {'numerator':str(x.numerator),'denominator':str(x.denominator)}
def floor6(x):return str((x*10**6).numerator//(x*10**6).denominator)+'/1000000'
checks={}
def ck(n,v):assert v,n;checks[n]=True
rows=[]
for row in j['rows'][15:]:
    r={k:q(v) for k,v in row['inputs'].items()}
    x=r['δ']**2*q(j['Y1'])**2/2
    ck(f"{row['index']}_positive_argument_below_10",0<x<10)
    term=total=Q(1)
    for n in range(1,129):
        term*=x/n; total+=term
    # Positive series tail after degree 128, all successive ratios <= x/130.
    upper=total+term*(x/129)/(1-x/130)
    mu_lower=1142/upper
    # Remove full tail entirely. Lower-bound the *chosen numeric envelope*,
    # not the actual line sum or actual psi error.
    L=r['E8']*(r['Eh']+r['sY'])*(Q('.16385')*r['LU']**2-Q('.4271')*r['LU']+Q('7.2032')+Q('57.73')*r['δ']+mu_lower)
    up=(r['E1']/(1-r['q'])-1)*r["rX'"]+L/(1-r['q'])+4*r['y0']*r['E1']/r['rX']+Q('253.3')*r['E8']/r['δ']/(1-r['q'])*(1/r['X']+r['sYX'])
    lo=(r['K']*r['δ']+2*r['q'])*r["rX'"]+2*r['y0']/r['rX']+L+Q('253.3')*r['E8']/r['δ']*(r['Eh']/r['X']+r['sYX'])
    ck(f"{row['index']}_upper_envelope_obstruction",up>r['c'])
    ck(f"{row['index']}_lower_status",(lo>r['c'])==(row['index']>=17))
    rows.append({'index':row['index'],'mu_lower':enc(mu_lower),'upper_without_full_tail_lower_bound':enc(up),'lower_without_full_tail_lower_bound':enc(lo),'upper_excess_floor6':floor6(up-r['c']),'lower_excess_floor6':floor6(lo-r['c'])})
out={'scope':'fixed-row, fixed 1142 mid-tail envelope obstruction, not an actual psi lower bound','input_sha256':hashlib.sha256(p.read_bytes()).hexdigest().upper(),'checks':checks,'rows':rows}
with Path(__file__).with_suffix('.json').open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':len(checks),'excesses':[{k:v for k,v in r.items() if k=='index' or k.endswith('floor6')} for r in rows]}))
