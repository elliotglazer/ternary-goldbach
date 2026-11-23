"""Independent exact fixed-seed check; no producer or numerical-library import."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial
import hashlib
import json

HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent
PINS={
 'integration/LOSSLESS_SEED_TAYLOR_2026-11-11.md':'E5AB4A2B4B7A81DC6731F337D032A39F6DF2509F580D4E00B109DC2DF9A7D00B',
 'integration/lossless_seed_taylor_20261111.py':'3000DB601B1206E1A128438774D0C33DF7FB3EA27AEAECD65CECD81E63CD2137',
 'integration/lossless_seed_taylor_20261111.json':'6C3EE4AE09014B64541899F276405C607624A5DABF70DFBA3AEE5EF654E82C3F',
 'integration/lossless_modular_two_step_20261111.json':'31DD05C2F85A02D29037E91BA63BE85AEC5C55063FED96010552C5BCF0034FBE',
 'mellin/REVIEW_LOSSLESS_MODULAR_TWO_STEP_2026-11-11.md':'46BDD3D1CA0AD8C730A693AC4CFA7F5D55C3043EDBF4180B82C939C5BC18B697',
}
for path,h in PINS.items():assert hashlib.sha256((AGENTS/path).read_bytes()).hexdigest().upper()==h,path
ML=Path('C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib')
for path,h in {
 'Analysis/SpecialFunctions/Trigonometric/Series.lean':'1C8457816ED5E9D72967890E7C25EECE5A5FF2D9B90248B768E060993ADFC9FF',
 'Analysis/SpecificLimits/Normed.lean':'29AA06CCC31F1BFD454DBF888C108F4C3FBE8AA5A9AEDE4F95D3D7473C03EE70',
}.items():assert hashlib.sha256((ML/path).read_bytes()).hexdigest().upper()==h,path
data=json.loads((AGENTS/'integration/lossless_seed_taylor_20261111.json').read_text())
c=data['certificate'];v=data['verification']
assert c['format']=='fixed-lossless-seed-alternating-taylor-v1'
assert c['source_sha256']==PINS['integration/lossless_modular_two_step_20261111.json']
assert c['source_node']=='tau' and c['T']==1000000 and c['r']=='0'
assert c['argument']=={'numerator':'2','denominator':'1000001'}
expected_expr='-cos(2/1000001)+i*sin(2/1000001); external generation only'
assert c['expression']==expected_expr
def rat(p):return F(int(p['numerator']),int(p['denominator']))
def dy(p):return F(int(p['mantissa']))*F(2)**p['exponent']
x=F(2,1000001);assert 0<x<1
enclosures={}
for name,a in [('cos',0),('sin',1)]:
 ch=c['channels'][name]
 assert ch['parity']==a and ch['lower_terms']==6 and ch['upper_terms']==7
 # Common denominator reconstruction independently of the producer recurrence.
 den=factorial(12+a)*1000001**(12+a)
 terms=[]
 for k in range(7):
  j=2*k+a
  numerator=2**j*(den//(factorial(j)*1000001**j))
  q=F(numerator,den)
  assert q==x**j/factorial(j)==rat(ch['positive_terms'][k])
  terms.append(q)
 low=sum(((-1)**k*terms[k] for k in range(6)),F(0))
 high=low+terms[6]
 assert low==rat(ch['lower']) and high==rat(ch['upper'])
 assert high-low==rat(v['first_omitted_terms'][name])==terms[6]
 ratio=x*x/F((a+1)*(a+2))
 assert 0<ratio<1 and ratio==rat(ch['global_ratio_bound'])==rat(v['global_ratio_bounds'][name])
 for k in range(6):assert 0<terms[k+1]<=ratio*terms[k]<terms[k]
 enclosures[name]=(low,high)
tau={'re':(-enclosures['cos'][1],-enclosures['cos'][0]),'im':enclosures['sin']}
target=json.loads((AGENTS/'integration/lossless_modular_two_step_20261111.json').read_text())['packet']['nodes'][0]
assert target['id']=='tau' and target['op']=='unproved_seed' and target['expression']==expected_expr
margins={}
for part,powers in [('re',[-258,-257]),('im',[-273,-276])]:
 b=target['value'][part]
 m,r,l,h=(dy(b[k]) for k in ['mid','rad','lo','hi'])
 assert r>=0 and (l,h)==(m-r,m+r)
 assert l<tau[part][0]<tau[part][1]<h
 assert list(tau[part])==[rat(z) for z in v['tau_enclosure'][part]]
 margins[part]=[tau[part][0]-l,h-tau[part][1]]
 assert margins[part]==[rat(q) for q in v['strict_containment_margins'][part]]
 assert powers==v['margin_strictly_exceeds_power_of_two'][part]
 for q,e in zip(margins[part],powers):assert q>F(2)**e
out={'status':'PASS fixed seed, paper-series plus exact external arithmetic',
     'artifact_pins_checked':len(PINS),'source_pins_checked':2,'positive_terms':14,
     'margin_lower_powers':{'re':[-258,-257],'im':[-273,-276]},
     'strict_margins':{k:[str(q) for q in qs] for k,qs in margins.items()},
     'scope':'No numerical oracle, no producer import, no modified source or prior receipt, no Lean claim.'}
p=HERE/'review_lossless_seed_taylor_20261111.json'
p.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps({k:v for k,v in out.items() if k!='strict_margins'},indent=2))
