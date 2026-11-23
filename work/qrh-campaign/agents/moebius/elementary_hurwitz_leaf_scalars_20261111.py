"""Exact scalar/parameter checks only; no elementary values or leaf arrays."""
from fractions import Fraction as F
from math import factorial
from pathlib import Path
import json

assert factorial(16) > 2**44
assert F(8, 3)**9 > 3389
assert 3**2 > 2**3 and 5**2 > 2**4
assert F(133, 256) < 1
assert F(1,16)+F(145,1536)+F(1,4) < 1
assert F(81,8192) < F(1,64)
assert F(7,16) < 1

rows=[]
for p in (1,2,118,383,417):
    delta=F(1,2**p)
    ell=p+17
    eta=F(1,2**ell)
    nlog=(p+25)//3
    natan=(p+31)//4
    nexp=max(16,(p+28)//2)
    g=p+3
    logtail=12*F(2,3**(2*nlog+1)*(2*nlog+1))*F(9,8)
    logerr=logtail+21*F(1,2**(ell+8))+eta/4
    assert logerr<eta and logtail<eta/4
    epi=F(1,2**(p+22))
    pitail=F(20,(2*natan+1)*5**(2*natan+1))
    pierr=pitail+F(145,6)*epi/256+epi/4
    assert pierr<epi and pitail<epi/16
    lower=16*(F(1,5)-F(1,375))-F(4,239)
    assert lower-epi>3 and F(16,5)+epi<4
    assert F(100000,6)+F(1,2)<2**15
    exptail=2*F(4**nexp,factorial(nexp))
    assert exptail<delta/64
    horner=81*F(1,2**(p+13))
    assert horner<delta/64
    assert 10000*eta<delta/8
    rows.append(dict(p=p,log_bits=ell,log_terms=nlog,
                     atan_terms=natan,cis_terms=nexp,root_scale_bits=g,
                     log_error_upper=str(logerr),pi_error_upper=str(pierr),
                     cis_taylor_upper=str(exptail)))

out=dict(scope="integer/rational bounds only; no log/cis/root values",rows=rows,
         values_evaluated=False,builds_run=False)
target=Path(__file__).with_suffix('.json')
target.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print('PASS: 5 scalar parameter rows; no elementary values')
