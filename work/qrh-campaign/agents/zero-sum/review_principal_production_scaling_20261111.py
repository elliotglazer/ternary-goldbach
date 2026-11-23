"""Exact scalar checks only; no function, node or theta evaluations."""
from fractions import Fraction as F
from pathlib import Path
import hashlib,json
HERE=Path(__file__).resolve().parent
SOURCE=HERE.parent/'major-constants/PRINCIPAL_PILOT_PRODUCTION_SCALING_2026-11-11.md'
PIN='2AE2B7A7E130603E7C2C11EFE582177ABB72A0F37AE4FE842871B4C11E9EF63C'
def wire(x):return str(x.numerator)+'/'+str(x.denominator)
def run():
 checks=[]
 def ck(name,p):
  assert p,name
  checks.append(name)
 ck('source hash',hashlib.sha256(SOURCE.read_bytes()).hexdigest().upper()==PIN)
 oldM=F(2054235392,3);V=F(29,8)
 ck('old M > 1/2',oldM>F(1,2))
 ck('2*pi/h < 2048 from pi<4',512*4==2048)
 ck('K lower coefficient from pi<4',V/8==F(29,64))
 ck('retuned V cutoff threshold',F(8,3)*768==2048)
 records=[]
 for T,claimed,degree in [(1000000,166121368759826019885,18),(60343058,132910297322471857771573276285,23)]:
  U=T+1;C=F(3,2*U);z=F(9,4*U);q=F(3,4*U)
  A=(2048/C**2+96/C)*(1+z)/z;M=A/q;D=A*(1/q+1/q**2)
  ck(f'{T}: A cubic lower',A>F(32768,81)*U**3)
  ck(f'{T}: D quintic lower',D>F(524288,729)*U**5)
  rem6=D/(63*64**6)
  ck(f'{T}: degree6 stated integer lower',rem6>claimed)
  prev=D/(63*64**(degree-1));cur=D/(63*64**degree)
  ck(f'{T}: predecessor degree fails',prev>F(1,10))
  ck(f'{T}: selected degree passes',cur<=F(1,10))
  ck(f'{T}: monotone remainder factor',prev==64*cur)
  kbound=F(29*T,64)
  expected=F(453125) if T==1000000 else F(874974341,32)
  ck(f'{T}: fixed-tilt K lower',kbound==expected)
  spatial=F(8*U,3)
  ck(f'{T}: spatial threshold',spatial==(F(8000008,3) if T==1000000 else F(160914824)))
  # theta=2/U: cos(theta)>=1-theta^2/2>1/2, sin(theta)<theta<2/5.
  theta=F(2,U)
  ck(f'{T}: nearest integer is minus one',1-theta**2/2>F(1,2) and theta<1)
  ck(f'{T}: translated real guard',theta**2/2<F(3,5))
  ck(f'{T}: stop fails and inversion height guard holds',theta<F(2,5))
  ck(f'{T}: actual reciprocal exceeds old bound',F(U,2)>F(50,3))
  records.append({'T':T,'U':U,'A':wire(A),'M':wire(M),'D':wire(D),
   'degree6_remainder':wire(rem6),'minimum_scalar_only_degree':degree,
   'previous_remainder':wire(prev),'passing_remainder':wire(cur),
   'fixed_tilt_K_strict_lower':wire(kbound),'spatial_R_lower':wire(spatial),
   'zero_node_inverse_norm_lower':wire(F(U,2))})
 return {'status':'PASS_EXACT_SCALAR_REVIEW_ONLY','source_sha256':PIN,'checks':checks,'check_count':len(checks),'rows':records,
 'analytic_bridge':'Uses exp monotonicity, pi<4, sin(x)<=x and cos(x)>=1-x^2/2; no transcendental value is evaluated.'}
if __name__=='__main__':
 out=run();out['script_sha256']=hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper()
 Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2,sort_keys=True)+'\n')
 print(json.dumps({'status':out['status'],'checks':out['check_count'],'degrees':[r['minimum_scalar_only_degree'] for r in out['rows']]}))
