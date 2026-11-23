"""Untrusted independent finite proposal. Root alone runs this generator.
No HOL theorem is imported from its success; HOL computes its own map checks.
"""
from pathlib import Path
import json, math, hashlib
p=Path(__file__).resolve().parent
r41=[pow(6,b,41) for b in range(40)]
r61=[pow(2,c,61) for c in range(60)]
assert sorted(r41)==list(range(1,41)) and pow(6,40,41)==1
assert sorted(r61)==list(range(1,61)) and pow(2,60,61)==1
rows=[]
for i in range(4800):
    a,b,c=i//2400,(i//60)%40,i%60
    r=(2501*(1 if a==0 else 3)+4880*r41[b]+2624*r61[c])%10004
    inverse=a*2400+((-b)%40)*60+((-c)%60)
    assert (r%4,r%41,r%61)==(1 if a==0 else 3,r41[b],r61[c])
    rows.append([i,a,b,c,r,inverse])
assert len({r[4] for r in rows})==4800
assert sorted(r[4] for r in rows)==[r for r in range(10004) if math.gcd(r,10004)==1]
for row in rows:
    other=rows[row[5]]
    assert other[5]==row[0] and row[4]*other[4]%10004==1
labels=[[i,1,1+i//59,1+i%59,2300-i] for i in range(2301)]
for i,a,b,c,j in labels:
    assert labels[j][1:4]==[1,(-b)%40,(-c)%60] and labels[j][4]==i
payload={'scope':'untrusted finite map proposal; no Dirichlet character semantics',
 'conductor':10004,'axes':[2,40,60],'generators':[3,6,2],
 'input_order':'((a*40)+b)*60+c','ct_input':'j=a+r*b','ct_output':'k=v+m*u',
 'row_fields':['i','a','b','c','residue','inverse_i'],'rows':rows,
 'label_fields':['i','k4','k41','k61','inverse_i'],'labels':labels}
out=p/'map_proposal.json'
with out.open('x',encoding='utf-8',newline='\n') as f:json.dump(payload,f,separators=(',',':'));f.write('\n')
print('PROPOSAL_ONLY',len(rows),len(labels),hashlib.sha256(out.read_bytes()).hexdigest())
