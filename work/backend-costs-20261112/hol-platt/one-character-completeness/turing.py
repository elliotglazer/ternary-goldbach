"""Actual integrated Turing operands using the campaign's elementary allowance."""
import csv
import json
from pathlib import Path
from time import perf_counter,process_time
from flint import arb,acb,ctx,dirichlet_char
ctx.prec=96
ctx.threads=1
here=Path(__file__).resolve().parent
T,H,den=61,261,32
h=H-T
q=3
chi=dirichlet_char(q,2)
start,cpu=perf_counter(),process_time()
main=[]
aux=[]
previous=None
with (here/'turing-signs.tsv').open('w',newline='') as f:
    writer=csv.writer(f,delimiter='\t',lineterminator='\n')
    writer.writerow(('t_times_32','sign','hardy_real'))
    for k in range(H*den+1):
        z=chi.hardy_z(arb(k)/den)
        sign=1 if z.real>0 else -1 if z.real<0 else 0
        assert sign and z.imag.contains(0)
        if previous is not None and previous!=sign:
            if k<T*den:
                main.append(k)
            elif k-1>T*den and k<H*den:
                aux.append(k)
        previous=sign
        writer.writerow((k,sign,z.real))
K=2*len(main)
W=arb(2)*sum(H*den-k for k in aux)/den
sign_time=(perf_counter()-start,process_time()-cpu)
start,cpu=perf_counter(),process_time()
A=arb(0)
d=32
logq=(arb(q)/arb.pi()).log()
for k in range(T*d,H*d):
    t=arb(arb(2*k+1)/(2*d),arb(1)/(2*d))
    theta=(t/2)*logq + acb(arb(3)/4,t/2).lgamma().imag
    A+=2*theta/(arb.pi()*d)
b=42+arb(693)/100*(arb(q)*H/(2*arb.pi())).log()
U=(A-W+2*b)/h
assert A < 35000 and b < 76 and W == arb(412619)/16 and K == 46 and U < K+1
print(json.dumps(dict(T=T,H=H,sign_den=den,gamma_den=d,K=K,auxiliary_positive=len(aux),
   W=str(W),A=str(A),b=str(b),U=str(U),K_plus_1_minus_U=str(K+1-U),
   rational_A_upper=int(A.upper().ceil().unique_fmpz()),rational_b_upper=int(b.upper().ceil().unique_fmpz()),
   signs_wall_cpu=sign_time,gamma_wall_cpu=(perf_counter()-start,process_time()-cpu)),indent=2))
