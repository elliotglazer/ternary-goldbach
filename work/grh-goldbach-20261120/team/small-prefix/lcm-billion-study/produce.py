from pathlib import Path
import sys,math,time,json,re,subprocess
d=Path(__file__).resolve().parent
p=d.parent
sys.path.insert(0,str(p))
sys.path.insert(0,str(p.parent/'aws-pilot/wide'))
from run_wide import windows_stats
src=(p/'lcm-98304-study/generate_lcm.py').read_text(encoding='utf8')
start=src.index('              (f"factorial_of_product')
end=src.index('    if k < 7:',start)
src=src[:start]+'              "by decide +kernel"]\n'+src[end:]
# For setup compute lcm as the product of the maximal power of each small prime.
src=src.replace('__import__("math").lcm(*range(1,cutoff+1))','prod(p**(next(e for e in range(1,40) if p**e>cutoff)-1) for p in primes_through(cutoff))')
(d/'generate_lcm.py').write_text(src,encoding='utf8')
# Native producer with optional FLINT inverse, matching the compact control's witnesses.
import importlib.util
spec=importlib.util.spec_from_file_location('lcm_gen',d/'generate_lcm.py')
gen=importlib.util.module_from_spec(spec);spec.loader.exec_module(gen)
gen.build(9,262144,2592,d,True,192,True,False)
(d/'LcmBridge.lean').write_bytes((p/'lcm-98304-study/LcmBridge.lean').read_bytes())
