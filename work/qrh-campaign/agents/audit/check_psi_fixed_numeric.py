from fractions import Fraction
from math import factorial
from pathlib import Path
import json
A=2*10**28*factorial(50)*250**50
B=35000**47
assert A<=B
ratio=Fraction(B,A)
res={'lhs':str(A),'rhs':str(B),'margin':str(B-A),'ratio_exact':str(ratio),'ratio_decimal':float(ratio),'degree':50,'remainder_degree':47,'threshold':35000}
Path('work/qrh-campaign/agents/audit/psi_fixed_numeric_results.json').write_text(json.dumps(res,indent=2)+'\n')
print('Exact inequality passed; ratio:',float(ratio))
