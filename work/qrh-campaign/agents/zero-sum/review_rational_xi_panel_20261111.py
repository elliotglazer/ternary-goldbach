"""Independent scalar review only. No theta/xi evaluations; author files read-only."""
from fractions import Fraction as F
from pathlib import Path
from math import factorial
from functools import lru_cache
import hashlib, importlib.util, json

HERE=Path(__file__).resolve().parent
AUTHOR=HERE.parent/'prime-estimates'
PINS={
 'NEXT_RATIONAL_XI_PANEL_SPEC_2026-11-11.md':'92E778B5D9C767D18461CD0B239F94FD38B15023B13576FFBBC2EFFE8D00E957',
 'rational_panel_budget_20261111.py':'7F6BBFA8DA690593121F287EB21BEADFA37D9C5EE6132744C5808687904AC013',
 'rational_panel_budget_20261111.json':'B344780B1A7DD6D58C33BC73E9B49AD6FAB1AF70966123F70130977B756A59EF'}
checks=[]
def check(name,p):
 assert p,name
 checks.append(name)
def wire(x): return str(x.numerator)+'/'+str(x.denominator)
def up12(x): return wire(F(-((-x*10**12).__floor__()),10**12))
GRID=2**256
def outward(lo,hi):
 return F((lo*GRID).__floor__(),GRID), F(-((-hi*GRID).__floor__()),GRID)
@lru_cache(None)
def ex(x):
 assert x>=0
 t=x; squares=0
 while t>F(1,4): t/=2; squares+=1
 # 80 terms and an all-index geometric remainder; different from producer.
 lo=sum(t**j/factorial(j) for j in range(80))
 hi=lo+t**80/F(factorial(80))/(1-t/81)
 lo,hi=outward(lo,hi)
 for _ in range(squares):lo,hi=outward(lo*lo,hi*hi)
 return lo,hi
def atan_bounds(x):
 lo=sum((-1)**j*x**(2*j+1)/F(2*j+1) for j in range(64))
 return lo,lo+x**129/129
def main():
 for name,h in PINS.items():check('pin '+name,hashlib.sha256((AUTHOR/name).read_bytes()).hexdigest().upper()==h)
 spec=importlib.util.spec_from_file_location('read_only_author_budget',AUTHOR/'rational_panel_budget_20261111.py')
 mod=importlib.util.module_from_spec(spec);spec.loader.exec_module(mod)
 replay=mod.run();replay['script_sha256']=PINS['rational_panel_budget_20261111.py']
 old=json.loads((AUTHOR/'rational_panel_budget_20261111.json').read_text())
 check('full 63-row author replay matches frozen receipt',replay==old)
 x,y=atan_bounds(F(1,5)),atan_bounds(F(1,239))
 pil,pih=16*x[0]-4*y[1],16*x[1]-4*y[0]
 check('independent pi bounds',3<pil<pih<4)
 a=F(1,66);C=3*a;q=C/2;z=3*C/2
 A=(2048/C**2+96/C)*(1+z)/z;M=A/q;D=A*(1/q+1/q**2)
 check('A',A==F(46687168,3));check('M',M==F(2054235392,3));check('D',D==30813530880)
 check('strip cosine lower',F(1,33)-F(1,33)**3/6>a)
 h=F(1,256);K=928;V=K*h;rho=F(1,64);degree=6
 check('V',V==F(29,8))
 Den=ex(2*pil*a/h)[0]-1
 check('positive denominator',Den>0)
 rl,ru=ex(2*V);check('discrete derivative cutoff',q*rl>2)
 em=1/ex(q*rl)[0]
 G=sum(rho**j for j in range(degree+1))
 vals={'Q0':2*M*ex(14*a)[1]/Den,'Qpositive':2*D*ex(15*a)[1]/Den,
       'S0':M*em,'Spositive':A*em*(ru/q+1/q**2),'Cauchy':D*rho**7/(1-rho)}
 vals['analytic_total']=vals['Q0']+vals['S0']+(vals['Qpositive']+vals['Spositive'])*(G-1)+vals['Cauchy']
 vals['coefficient_radius_sum']=G
 for name,v in vals.items():check('independent '+name+' <= published rounded upper',v<=F(old['selected']['bounds'][name]))
 check('G',G<F(64,63))
 check('node exponential',ex(5*V/2)[1]<2**14)
 node=h*(2*K+1)*F(1,2**24)*2**14
 check('node allocation',node==F(1857,262144) and node<F(1,128))
 check('center bound',A*ex(V/2)[1]+F(1,2**24)<2**27)
 weight=(2*K+1)*F(1,2**48)*2**27
 check('weight allocation',weight==F(1857,2097152) and weight<F(1,1024))
 total=vals['analytic_total']+G*(node+weight)
 check('total <= published upper',total<=F(old['selected']['complete_disk_error_upper_rounded']))
 check('total < 1/10',total<F(1,10))
 check('rectangle real endpoints',F(3,5)-F(1,128)==F(379,640) and F(3,5)+F(1,128)==F(389,640))
 check('rectangle imaginary endpoints',14-F(1,128)==F(1791,128) and 14+F(1,128)==F(1793,128))
 check('whole closed rectangle strictly inside disk',2*F(1,128)**2<rho**2)
 check('seed height',F(2,33)-F(2,33)**3/6>F(3,50))
 check('seed modulus',ex(2*V)[1]<2048)
 check('S geometric denominator',F(3,5)**2+F(1,2)**2==F(61,100))
 check('forced stop after fourth S',F(3,50)*F(100,61)**4>F(2,5))
 # The overlapping guards alone can choose a fifth step; this is not asserted.
 check('fourth guaranteed height remains below inversion upper guard',F(3,50)*F(100,61)**4<F(1,2))
 # (k+1)^4 <= 17^4*(k+1)^4 is used after 17+k <=17(k+1).
 # Generating-function derivation: sum_{n>=1} n^4*x^(n-1)
 # = (1+11*x+11*x^2+x^3)/(1-x)^5, at x=1/2.
 t=F(1,2);moment=(1+11*t+11*t*t+t**3)/(1-t)**5
 check('fourth geometric moment',moment==300)
 check('terminal prefactor',32*17**4*moment<2**30)
 check('common Gaussian exponent',F(6,5)*16**2>307)
 check('per-step Gaussian decay dominates 2^-k',F(6,5)*32>1)
 U=F(50,3)
 row0=F(5);row1=5*(U/2+U**2);row2=5*(3*U**2/4+3*U**3+U**4)
 check('root bound',U<25)
 check('largest row',row0<row2 and row1<row2)
 check('jet transport < 2^19',row2<2**19)
 check('P prefactor',ex(V/2)[1]<8)
 pamp=8*(6*2048+4*2048**2)
 check('P transport < 2^28',pamp<2**28)
 check('terminal error < 2^-173',F(1,2**277)*row2**4*pamp<F(1,2**173))
 check('terminal error below node allocation',F(1,2**173)<F(1,2**24))
 check('negative-exp branch range reduction',F(384,2**10)<F(1,2))
 check('signed nodes and products',(2*K+1, (2*K+1)*7)==(1857,12999))
 check('word/mode ceilings',(4*(K+1),16*(K+1))==(3716,14864))
 out={'status':'PASS_SCALAR_AND_CONDITIONAL_SPEC_REVIEW_ONLY','input_pins':PINS,
      'check_count':len(checks),'checks':checks,'independent_bounds_rounded_up':{n:up12(v) for n,v in vals.items()},
      'independent_total_rounded_up':up12(total),'jet_row_upper_exact':wire(row2),
      'four_step_height_lower_exact':wire(F(3,50)*F(100,61)**4),
      'method':'64-term Machin; 80-term exp at <=1/4; 256-bit outward squaring; no function/node evaluation',
      'control_flow':'Four-S cap requires forcing the known stop certificate after the fourth inversion; arbitrary overlap-guard choices do not imply this bound.'}
 out['script_sha256']=hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper()
 Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2,sort_keys=True)+'\n')
 print(json.dumps({'status':out['status'],'checks':len(checks),'total':out['independent_total_rounded_up']}))
if __name__=='__main__':main()
