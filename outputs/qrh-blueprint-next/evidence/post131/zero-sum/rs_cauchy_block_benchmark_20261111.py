import json,time
from pathlib import Path
from flint import arb,acb,ctx
ctx.prec=128
out={'scope':'One local block per sigma; built-in FLINT zeta trusted for samples; analytic Cauchy alias formula separately stated in report; not a full contour certificate.','precision':128,'runs':[]}
for sig in ['0.5025','0.555']:
 t=1000000; rho=arb(1)/4;r=arb(1)/8;R=arb(1)/2;m=64
 center=acb(arb(sig),t)
 roots=[acb(0,2*arb.pi()*j/m).exp() for j in range(m)]
 begin=time.perf_counter(); vals=[(center+rho*w).zeta() for w in roots]; sampletime=time.perf_counter()-begin
 begin=time.perf_counter(); coeff=[sum((vals[j]*roots[(-j*k)%m] for j in range(m)),acb(0))/m for k in range(m)]; dfttime=time.perf_counter()-begin
 M=33*arb(t+3)/(t-1)*(arb(t+3)/6)**(arb(3)/5)
 err=M/(1-r/R)*((r/R)**m+(rho/R)**m/(1-(rho/R)**m))
 def model(lo,hi):
  z=acb(0,arb(arb(lo+hi)/2,arb(hi-lo)/2))/rho
  ans=acb(0)
  for c in coeff[::-1]:ans=ans*z+c
  return ans+acb(arb(0,err),arb(0,err))
 begin=time.perf_counter(); stack=[(-arb(1)/8,arb(1)/8,0)]; leaves=0; maxdepth=0;calls=0;failed=False
 while stack:
  lo,hi,depth=stack.pop();v=model(lo,hi);calls+=1
  if v.real>0 or v.real<0 or v.imag>0 or v.imag<0:
   leaves+=1;maxdepth=max(maxdepth,depth)
  elif depth<16 and calls<10000:
   mid=(lo+hi)/2;stack.extend([(lo,mid,depth+1),(mid,hi,depth+1)])
  else:failed=True;break
 out['runs'].append({'sigma':sig,'height':t,'block_length':'1/4','samples':m,'sample_seconds':sampletime,'dft_seconds':dfttime,'M_bound':str(M),'alias_plus_truncation_error':str(err),'panel_seconds':time.perf_counter()-begin,'panel_calls':calls,'leaves':leaves,'maxdepth':maxdepth,'complete_local_nonvanishing':not failed})
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2));print(json.dumps(out,indent=2))
