"""Closed RH-1500 and damped positive-ordinate reciprocal head, native bounds."""
import csv
import json
from fractions import Fraction
from pathlib import Path
from time import perf_counter,process_time
from flint import arb,ctx,dirichlet_char

ctx.prec=96
ctx.threads=1
here=Path(__file__).resolve().parent
chi=dirichlet_char(1,1)
den=8192
def sign(i):
    z=chi.hardy_z(arb(i)/den)
    assert z.imag.contains(0)
    assert z.real>0 or z.real<0
    return 1 if z.real>0 else -1

start,cpu=perf_counter(),process_time()
n=arb(1500).zeta_nzeros().unique_fmpz()
assert n==1069
prev=sign(0)
brackets=[]
step=den//8
for right in range(step,1500*den+1,step):
    val=sign(right)
    if val!=prev:
        a,b=right-step,right
        while b-a>1:
            mid=(a+b)//2
            if sign(mid)==prev:
                a=mid
            else:
                b=mid
        brackets.append((a,b,prev,val))
    prev=val
assert len(brackets)==n
with (here/'principal1500-brackets.tsv').open('w',newline='') as f:
    wr=csv.writer(f,delimiter='\t',lineterminator='\n')
    wr.writerow(('lower_times_8192','upper_times_8192','left_sign','right_sign'))
    wr.writerows(brackets)
# Round outward term by term on a decimal grid; every operation is integer.
scale=10**12
raw_lo=sum((den*scale)//b for a,b,_,_ in brackets)
raw_hi=sum(-((-den*scale)//a) for a,b,_,_ in brackets)
offset=Fraction(int(n),1500)
qlo=Fraction(raw_lo,scale)-offset
qhi=Fraction(raw_hi,scale)-offset
assert qhi<Fraction(1668,1000)
print(json.dumps(dict(T=1500,N=int(n),N_both=2*int(n),signed_brackets=len(brackets),
    gamma_den=den,raw_positive_lower=str(Fraction(raw_lo,scale)),raw_positive_upper=str(Fraction(raw_hi,scale)),
    Q_positive_lower=str(qlo),Q_positive_upper=str(qhi),Q_positive_upper_decimal=str(float(qhi)),
    raw_both_upper=str(2*Fraction(raw_hi,scale)),Q_both_upper=str(2*qhi),
    wall=perf_counter()-start,cpu=process_time()-cpu),indent=2))
