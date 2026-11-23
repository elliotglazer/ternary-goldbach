"""Read-only exact diagnostic of the original 24 exported reciprocal edges."""
from pathlib import Path
from itertools import product
from collections import Counter
import hashlib, importlib.util, json, sys
sys.dont_write_bytecode=True
HERE=Path(__file__).resolve().parent
PINS={
 'compact_reciprocal_rectangle_20261111.py':'E32289AA8773520002804572C3F95B207850C41574A9BE45ECB178A8E632426F',
 'principal_theta_modular_pilot_20261111.json':'C39982174CAC9C51E9F816275082BCE322CA2AD143D9FCE61081DF72E57B11EF'}
for f,h in PINS.items():assert hashlib.sha256((HERE/f).read_bytes()).hexdigest().upper()==h
spec=importlib.util.spec_from_file_location('reviewed_reciprocal',HERE/'compact_reciprocal_rectangle_20261111.py')
R=importlib.util.module_from_spec(spec);sys.modules[spec.name]=R;spec.loader.exec_module(R)
C=R.C
def wire(d):return {'mantissa':str(d.m),'exponent':d.e}
def trace(a,b,X,Y):
 def candidate(x,y,branch):
  terms=(C.mul(a,C.mul(x,x)),C.mul(a,C.mul(y,y)),x if b==1 else -x)
  return {'branch':branch,'active_coordinate':{'dyadic':wire(x)},
   'inactive_coordinate':wire(y),'residual_terms':list(map(wire,terms)),
   'residual_sign':C.sign3(*terms),'positive_multiplier':'1'}
 if a.m<=0:
  points=[candidate(x,y,'corner') for x,y in product(X,Y)]
 else:
  y=Y[0] if Y[0].m>0 else Y[1] if Y[1].m<0 else C.D(0)
  slopes=[C.sign3(C.mul(C.D(a.m,a.e+1),x),C.D(b)) for x in X]
  if slopes[0]>=0:points=[candidate(X[0],y,'convex_left')]
  elif slopes[1]<=0:points=[candidate(X[1],y,'convex_right')]
  else:
   terms=(C.mul(C.D(1,2),C.mul(C.mul(a,a),C.mul(y,y))),C.D(-1))
   points=[{'branch':'convex_interior','active_coordinate':{
    'numerator':wire(C.D(-b)),'positive_denominator':wire(C.D(a.m,a.e+1))},
    'inactive_coordinate':wire(y),'residual_terms':list(map(wire,terms)),
    'residual_sign':C.sign3(*terms),'positive_multiplier':{'dyadic':wire(C.D(a.m,a.e+2))}}]
  for p in points:p['endpoint_slope_signs']=slopes
 passed=all(p['residual_sign']>=0 for p in points)
 assert passed==R.quadratic_nonnegative(a,b,X,Y)
 return {'a':wire(a),'b':b,'passed':passed,'tested_candidates':points,
  'violating_candidates':[p for p in points if p['residual_sign']<0]}
def diagnose(inp,out,sgn):
 assert all(C.cmp(x[0],x[1])<=0 for x in inp+out)
 assert not all(x[0].m<=0<=x[1].m for x in inp)
 normout=out if sgn==1 else tuple((-x[1],-x[0]) for x in out)
 X,Y=inp;(lr,ur),(li,ui)=normout
 args=[(-lr,1,X,Y), (ur,-1,X,Y), (-li,-1,Y,X), (ui,1,Y,X)]
 rows=[]
 for i,arg in enumerate(args):
  row=trace(*arg);row['coordinate']='real' if i<2 else 'imaginary'
  row['normalized_side']='lower' if i%2==0 else 'upper'
  row['original_output_side']=row['normalized_side'] if sgn==1 else ('upper' if i%2==0 else 'lower')
  row['active_axis']='x' if i<2 else 'y'
  rows.append(row)
 passed=all(r['passed'] for r in rows)
 assert passed==R.accept(inp,out,sgn)
 return passed,rows
def run():
 C.COUNTS.clear();C.MAXIMA.clear()
 data=json.loads((HERE/'principal_theta_modular_pilot_20261111.json').read_text())
 results=[]
 for pidx,p in enumerate(data['points']):
  for sidx,s in enumerate(p['steps']):
   if s['kind']!='S':continue
   for label,inp,out,sgn in [('S_output',C.box(s['input']),C.box(s['output']),-1),
    ('A',C.box(s['root_witness']['root']),C.box(s['root_witness']['A']),1)]:
    passed,rows=diagnose(inp,out,sgn)
    results.append({'point':pidx,'T':p['T'],'r':p['r'],'step':sidx,'gate':label,
     'reciprocal_sign':sgn,'passed':passed,'rows':rows})
 assert len(results)==24
 counts=Counter(('pass' if x['passed'] else 'fail') for x in results)
 return {'status':'COMPLETED exact full-box diagnostic; failures are not point-value errors',
  'pins':PINS,'summary':dict(counts),'edges':results,'counts':dict(C.COUNTS),'maxima':dict(C.MAXIMA),
  'scope':'Original frozen exported endpoints only; no lossless regeneration, analytic evaluations, or seed-status change.'}
if __name__=='__main__':
 result=run();result['script_sha256']=hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper()
 (HERE/'original_reciprocal_edges_20261111.json').write_text(json.dumps(result,indent=2,sort_keys=True)+'\n',encoding='utf8')
 print(json.dumps({'summary':result['summary'],'maxima':result['maxima'],
  'rows':[{'point':r['point'],'step':r['step'],'gate':r['gate'],'passed':r['passed'],
   'failed_bounds':[(t['coordinate'],t['original_output_side']) for t in r['rows'] if not t['passed']]} for r in result['edges']]}))
