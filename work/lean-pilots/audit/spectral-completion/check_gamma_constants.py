"""Independent exact rational audit. No function evaluations or Lean execution."""
from fractions import Fraction as F
from pathlib import Path
import hashlib, json

checks = []
def check(name, condition):
    assert condition, name
    checks.append(name)

a, t = F(3,4), F(5,128)
check('convexity interpolation point', a*a+F(1,4)*F(7,4)==1)
check('convexity total weight', a+F(1,4)==1)
check('lower reciprocal', 1/(a+F(1,4)*a)==F(16,15))
check('upper gamma34', 1/a==F(4,3))
check('upper gamma14', 1/F(1,4)==4)
check('integral upper exponent', a-1+F(1,2)==F(5,4)-1)
check('integral lower exponent', a-1-F(1,2)==F(1,4)-1)
vertical=t*(1+4)
phase=t*F(1,3)
distance=vertical+phase*F(4,3)
check('vertical bound', vertical==F(25,128))
check('phase bound', phase==F(5,384))
check('distance bound', distance==F(245,1152))
check('real enclosure reserve', F(16,15)-distance-F(3,4)==F(599,5760)>0)
check('imag enclosure reserve', F(1,4)-distance==F(43,1152)>0)
check('gamma argument real', (F(1,2)+1)/2==a)
check('gamma argument imag', F(5,64)/2==t)
check('conductor amplitude exponent', F(1,2)/2==F(1,4))
check('pi amplitude exponent', -(F(1,2)+1)/2==F(-3,4))
check('conductor and pi phase cancellation', t+(-t)==0)
check('positive product strict reserve', F(3,4)*F(1,4)-F(1,4)*F(1,2)==F(1,16)>0)

here=Path(__file__).resolve().parent
receipt={'scope':'Exact rational constants only; source/analytic and compiled closure in report',
         'checks':checks,'count':len(checks),
         'vertical':str(vertical),'phase':str(phase),'distance':str(distance),
         'real_margin':str(F(16,15)-distance-F(3,4)),
         'imag_margin':str(F(1,4)-distance),
         'consumer_margin':str(F(1,16))}
with (here/'gamma_constants_receipt.json').open('x',encoding='utf-8') as f:
    json.dump(receipt,f,indent=2);f.write('\n')
print(len(checks),'exact rational checks passed')
