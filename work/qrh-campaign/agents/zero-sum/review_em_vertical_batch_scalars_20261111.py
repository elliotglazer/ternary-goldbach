"""Independent exact scalar review. No values, moments, transforms or builds."""
from fractions import Fraction as F
from math import factorial
from pathlib import Path
import ast,hashlib,json
HERE=Path(__file__).resolve().parent
AUTHOR=HERE.parent/'major-constants'
PINS={
 'EM_VERTICAL_BATCH_SCALAR_SUPPORT_2026-11-11.md':'44C53A6F71D9B00368568D35C08D2ED69EC9ECA746AE61E2DDC8A79C5BA2C52F',
 'em_vertical_batch_scalar_support_20261111.py':'79D62492632A784D58019302F01C310849BB2B4A1D6AB4D782852F1DFCEA204C',
 'em_vertical_batch_scalar_support_20261111.json':'B68C8861B4F646C4EC43DEC00E5D364C33A1CEDF8C6F0C5FC976E72210F6F26F'}
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest().upper()
def main():
 checks=[]
 def ck(name,p):
  assert p,name
  checks.append(name)
 for file,h in PINS.items():ck('pin '+file,sha(AUTHOR/file)==h)
 # Execute only the scalar program prefix before its first write/print.
 # __file__ is not needed by that prefix; no producer file is overwritten.
 source=AUTHOR/'em_vertical_batch_scalar_support_20261111.py'
 tree=ast.parse(source.read_text());prefix=[];found=False
 for n in tree.body:
  if isinstance(n,ast.Expr) and isinstance(n.value,ast.Call) and isinstance(n.value.func,ast.Attribute) and n.value.func.attr=='write_text':
   found=True;break
  prefix.append(n)
 ck('identified first producer write before replay',found)
 env={};exec(compile(ast.Module(body=prefix,type_ignores=[]),str(source),'exec'),env)
 old=json.loads((AUTHOR/'em_vertical_batch_scalar_support_20261111.json').read_text())
 ck('complete author scalar receipt replay',env['out']==old)
 N=333334;K=24
 ck('sqrt upper',N<578**2)
 ck('elementary exp1 lower',sum(F(1,factorial(j)) for j in range(5))>F(8,3))
 ck('logN upper certificate',F(8,3)**13>N+1)
 w=[F(1156)]
 for h in range(1,K):w.append(w[-1]*13/h)
 ck('weight recurrence maximum',max(w)==F(6733146600397009,119750400))
 ck('maximum at h12 and h13',w[12]==w[13]==max(w))
 ck('tight individual weight ceiling',max(w)<2**26)
 ck('loose ceiling',3*max(w)<2**33)
 ck('sigma-rho floor',F(629,1250)-F(1,8)>F(3,8))
 ck('weighted disk sum integer certificate',N**5<5120**8)
 ck('weighted disk sum constant',F(8,5)*5120==8192)
 ck('phase ceiling',F(5,16)*F(22,7)==F(55,56)<1)
 # Exactly verify midpoint rounding bound on representative rational ties.
 for x,m in [(F(3,8),F(1,2)),(F(-5,8),F(-1,2)),(F(-7,8),F(-1)),(F(1,8),F(0))]:
  q=(m+F(1,2)).__floor__()
  ck('rounding tie '+str(x),abs(m-x)<=F(1,8) and abs(x-q)<=F(5,8))
 ck('integral Taylor kernel mass',F(1,31+1)/factorial(31)==F(1,factorial(32)))
 ck('factorial32 exact threshold',factorial(32)>2**114)
 for p,bits in [(36,100),(39,120),(48,120)]:ck(f'loose individual p{p}',F(2**33,factorial(p))<F(1,2**bits))
 ck('p48 actual tighter individual claim',max(w)/factorial(48)<F(1,2**120))
 rho=F(1,8);G=sum(rho**h for h in range(K))
 ck('correct geometric series',G<F(8,7))
 ck('old geometric series is inapplicable',G>F(64,63))
 tail=F(2**14,factorial(32));arith=F(16,7*2**104);batch=tail+arith
 ck('weighted residual comparison',tail<F(1,2**100))
 ck('full corrected batching allowance',batch<F(1,2**100))
 ck('receipt batching comparison',batch==F(old['optional_total_batching_error_upper']))
 baseline=F(3,2)*(F(1,2**38)+F(1,7*2**21))/2**19
 ck('old allowance plus norm batching',baseline+batch<F(1,2**42))
 ck('old allowance plus coordinate-square batching',baseline+F(3,2)*batch<F(1,2**42))
 rows=[]
 for J in (1024,4096):
  L=4*J;lg=0;power=1
  while power<L:power*=2;lg+=1
  ck(f'power-two L J{J}',power==L)
  for p in (32,48):
   row={'J':J,'L':L,'p':p,'jet_orders':K,'moment_contributions':N*K*p,
        'naive_main_coefficient_contributions':J*N*K,'normalized_transforms':K*p,
        'dense_moment_entries':K*p*L,'radix_two_butterflies':K*p*(L//2)*lg,
        'center_contraction_terms':J*K*p,'one_jet_stream_entries':p*L,
        'normalized_output_radius_for_optional_arithmetic':str(F(1,2**104*L*p))}
   ck(f'contraction amplification J{J}p{p}',L*p*F(row['normalized_output_radius_for_optional_arithmetic'])==F(1,2**104))
   rows.append(row)
 ck('all four literal count rows',rows==old['rows'])
 # Algebraic norm propagation: retained shift sum excludes h=23 term.
 e=[F(h+1,2**(h+10)) for h in range(K)];alpha=F(7,8)
 retained=sum(rho**h*(alpha*e[h]+(e[h-1] if h else 0)) for h in range(K))
 ck('retained multiplication exact identity',retained==(alpha+rho)*sum(rho**h*e[h] for h in range(K))-rho**K*e[-1])
 ck('division ratio strictly below two',alpha>3*rho and (alpha+rho)/(alpha-rho)<2)
 out={'status':'PASS_EXACT_SCALAR_AND_COUNT_REVIEW','input_pins':PINS,'check_count':len(checks),'checks':checks,
      'batch_norm_error_bound':str(batch),'norm_plus_old_error_bound':str(baseline+batch),
      'coordinate_square_plus_old_error_bound':str(baseline+F(3,2)*batch),
      'rows':rows,'script_sha256':sha(Path(__file__)),
      'scope':'No moments, logarithms, exp values, theta/L values, Fourier transforms or panels evaluated.'}
 Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2,sort_keys=True)+'\n',newline='\n')
 print(json.dumps({'status':out['status'],'checks':len(checks)}))
if __name__=='__main__':main()
