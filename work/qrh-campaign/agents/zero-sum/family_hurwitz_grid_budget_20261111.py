from fractions import Fraction as F
from math import prod,factorial
import json
from pathlib import Path
A=16;G=16;K=32;S=1002
E=F(2*prod(S+j for j in range(K)),(2*G*A)**K*factorial(K))
assert E<F(1,10**25)
assert 300000*E<F(1,10**19)
d={'A':A,'grid_cells':G,'degree_terms':K,'absolute_s_bound':S,'sigma_min':'111/200','exact_error_upper':str(E),'error_float_diagnostic':float(E),'after_300000_absolute_DFT_terms_upper':str(300000*E),'after_300000_float_diagnostic':float(300000*E),'checks':['E<1e-25','300000E<1e-19'],'scope':'Exact arithmetic for the paper Taylor remainder; no coefficient evaluation or runtime benchmark.'}
Path(__file__).with_suffix('.json').write_text(json.dumps(d,indent=2));print(json.dumps(d,indent=2))
