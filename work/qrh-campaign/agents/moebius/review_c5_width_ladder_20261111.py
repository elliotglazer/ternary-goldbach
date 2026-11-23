"""Independent exact geometry and alternate-model checks on the same32 widths."""
from pathlib import Path
from fractions import Fraction as F
import importlib.util,json,hashlib,time
HERE=Path(__file__).resolve().parent;SRC=HERE.parent/'zero-sum'
PINS={
 'C5_RESIDUAL_WIDTH_LADDER_2026-11-11.md':'E853FB47AEF9BD98D101590E30594299868BCBAAE5F11DCA59FB1111397B0DA2',
 'c5_residual_width_ladder_20261111.py':'BF30372824E93C45FD61BF952E8ACB6B30DB9ABF380AE9C4692DEE3E8425A3F3',
 'c5_residual_width_ladder_20261111.json':'7B0138E4C9455A844ADD83D8EF8ED078A933682AF58A26D24F819ABA85E1142C',
 'c5_residual_width_summary_20261111.py':'45FF286131CCEBC6C1BBDA4076B08B2661B4BB59357712BFE690BB3C1E68C1B1',
 'c5_residual_width_summary_20261111.json':'5C1506DE710E57307665A2138E8E795C1D3533D439F87CB7BB1CDD278AB31194'}
for name,pin in PINS.items():assert hashlib.sha256((SRC/name).read_bytes()).hexdigest().upper()==pin
HELP=HERE/'review_c5_taylor_panels_20261111.py'
assert hashlib.sha256(HELP.read_bytes()).hexdigest().upper()=='B00458A4885C842DAF57CBC6A095BA9134E115898A7670D49111E92B8385409F'
spec=importlib.util.spec_from_file_location('independent_taylor',HELP)
t=importlib.util.module_from_spec(spec);spec.loader.exec_module(t)
def main():
 start=time.perf_counter();d=json.loads((SRC/'c5_residual_width_ladder_20261111.json').read_text())
 prior=json.loads((SRC/'c5_residual_taylor_panels_20261111.json').read_text())
 cand=json.loads((SRC/'c5_global_inverse_candidate_20261111.json').read_text())
 widths=[F(1,2048),F(1,1024),F(1,512),F(1,256),F(1,128),F(1,64),F(1,32),F(3,64)]
 assert d['panel_evaluations']==32 and list(map(F,d['half_width_ladder']))==widths
 assert len(d['centers'])==4 and d['full_rectangle_certified'] is False
 cc=[[t.acb(t.ar(F(z[0])),t.ar(F(z[1]))) for z in row] for row in cand['coefficients']]
 poles=[t.acb(t.ar(F(x)),t.ar(F(y))) for x,y in cand['poles']]
 summary=json.loads((SRC/'c5_residual_width_summary_20261111.json').read_text())
 rows=[];counter=0;error_check=None
 for c,p in zip(d['centers'],prior['panels']):
  assert c['attempt_index']==p['attempt_index'] and c['center']==p['center']
  # The cached coefficients equal the prior coefficient arrays byte-for-byte
  # after the documented canonical JSON serialization.
  for short,long in [('g','g_coefficients'),('B','B_coefficients'),('residual','residual_coefficients')]:
   got=hashlib.sha256(json.dumps(p[long],sort_keys=True).encode()).hexdigest()
   assert got==c[short+'_coefficients_sha256']
  center=tuple(map(F,c['center']));s=t.acb(t.ar(center[0]),t.ar(center[1]))
  assert center[0] in (F(111,200),F(2))
  assert F(c['geometric_half_width_limit'])==12-abs(center[1])
  gj=t.jets(center);bj=[t.const(x) for x in cc[0]];terms=[]
  for pole,w in zip(poles,cc[1:]):
   diff=s-pole;dist=abs(diff).lower();inv=1/diff;power=inv
   for j in range(t.D+1):
    for k in range(3):bj[k][j]+=w[k]*power
    power*=-inv
   terms.append((dist,[abs(x).upper()/dist**(t.D+1) for x in w]))
  rp=[t.scale(t.mul(gj[k],bj[k],2*t.D+1),-1) for k in range(3)]
  for poly in rp:poly[0]+=1
  mg,_=t.controls(center,t.R)
  assert len(c['widths'])==8
  for rho,r in zip(widths,c['widths']):
   counter+=1;assert F(r['half_width'])==rho and F(r['full_width'])==2*rho
   assert rho<=12-abs(center[1]) and rho<F(11,200)<F(1,4) and rho<t.R
   sign=-1 if center[0]==F(111,200) else 1
   a=(center[0],center[1]-sign*rho);b=(center[0],center[1]+sign*rho)
   assert list(map(F,r['a']))==list(a) and list(map(F,r['b']))==list(b)
   assert r['domain_admissible'] is True
   l1=F(r['l1_upper']);moment=F(r['T16_upper'])
   assert r['l1_pass']==(l1<1) and r['T16_pass']==(moment<1)
   propagated=3*l1**32
   sr=next(test for sc in summary['centers'] if sc['attempt_index']==c['attempt_index'] for test in sc['tests'] if F(test['half_width'])==rho)
   assert F(sr['l1_implied_T16_upper'])==propagated
   assert F(sr['best_T16_upper'])==min(moment,propagated)
   assert sr['best_T16_pass']==(min(moment,propagated)<1)
   if c['attempt_index']==3871 and rho==F(1,32):
    contribution=F(283,200)*sum(map(F,r['residual_analytic_errors']))
    assert F(283,200)**2>2 and contribution<F(3,250)
    error_check=str(contribution)
   tails=[t.arb(0) for _ in range(3)]
   for dist,w in terms:
    assert dist>t.ar(rho)
    for k in range(3):tails[k]+=w[k]*t.ar(rho)**(t.D+1)/(dist-t.ar(rho))
   _,ep=t.controls(center,rho);gt=mg*t.ar(rho/t.R)**(t.D+1)/(1-t.ar(rho/t.R));le=ep+gt
   scalar=[]
   for k in range(3):
    er=le*(t.norm(bj[k],rho)+tails[k])+t.norm(gj[k],rho)*tails[k]
    scalar.append((t.norm(rp[k],rho)+er).upper())
   al=sum(scalar,t.arb(0)).upper();am=sum((z**32 for z in scalar),t.arb(0)).upper()
   rows.append({'index':c['attempt_index'],'rho':str(rho),'original_l1_pass':l1<1,
    'original_direct_T16_pass':moment<1,'exact_propagated_T16_pass':propagated<1,
    'exact_propagated_T16':str(propagated),'alternate_l1_upper':t.rat(al),
    'alternate_T16_upper':t.rat(am),'alternate_l1_pass':bool(al<1),'alternate_T16_pass':bool(am<1)})
 assert counter==32
 names=['c5_residual_width_ladder_20261111.py','c5_residual_width_ladder_20261111.json']
 result={'status':'REVIEWED_SAME32_WIDTHS','full_rectangle_certified':False,'panel_evaluations':counter,
  'author_hashes':{n:hashlib.sha256((SRC/n).read_bytes()).hexdigest() for n in names},
  'independent_parameters':{'N':t.N,'M':t.M,'D':t.D,'R':str(t.R),'bits':224},
  'cached_coefficient_digest_matches':12,'scalar_error_l1_contribution_upper_at_3871_rho1_32':error_check,
  'verified_pins':PINS,'rows':rows,'elapsed_seconds':time.perf_counter()-start}
 Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2)+'\n')
 print(json.dumps({k:v for k,v in result.items() if k!='rows'},indent=2))
 for idx in [29999,3871,457,24860]:
  subset=[r for r in rows if r['index']==idx]
  print(idx,[(r['rho'],r['alternate_l1_pass'],r['alternate_T16_pass']) for r in subset])
if __name__=='__main__':main()
