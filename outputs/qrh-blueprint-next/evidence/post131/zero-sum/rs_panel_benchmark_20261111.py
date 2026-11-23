import json,time,math,platform
from pathlib import Path
import flint
from flint import arb,acb,ctx
ctx.prec=128
out={'precision_bits':128,'python':platform.python_version(),'python_flint':flint.__version__,'scope':'Bounded library timing and enclosure diagnostic only; no full contour or explicit RS proof certificate.','runs':[]}
for sigma in ['0.5025','0.555']:
 for height in [10000,100000,1000000]:
  points=[acb(arb(sigma),arb(height)+arb(j)/32) for j in range(32)]
  begin=time.perf_counter(); vals=[z.zeta() for z in points]; elapsed=time.perf_counter()-begin
  rec={'sigma':sigma,'height':height,'point_calls':32,'point_seconds':elapsed,'source_predicted_RS':height>=24*128*math.sqrt(128),'min_point_accuracy_bits':min(z.rel_accuracy_bits() for z in vals),'panels':[]}
  for power in [4,8,12,16]:
   begin=time.perf_counter(); good=0; minacc=10000
   for j in range(16):
    center=arb(height)+arb(2*j+1)/(2**(power+1))
    z=acb(arb(sigma),arb(center,arb(1)/(2**(power+1)))).zeta()
    good+=bool(z.real>0 or z.real<0 or z.imag>0 or z.imag<0)
    minacc=min(minacc,z.rel_accuracy_bits())
   rec['panels'].append({'width_power_minus':power,'calls':16,'halfplane_nonzero':good,'seconds':time.perf_counter()-begin,'min_relative_accuracy_bits':minacc})
  out['runs'].append(rec)
path=Path(__file__).with_suffix('.json');path.write_text(json.dumps(out,indent=2))
print(json.dumps(out,indent=2))
