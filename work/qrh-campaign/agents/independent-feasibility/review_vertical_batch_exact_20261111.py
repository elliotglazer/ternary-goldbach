"""Independent exact scalar/count/label checks. No analytic values or transforms."""
from fractions import Fraction as F
from math import factorial
from pathlib import Path
import hashlib,json

HERE=Path(__file__).resolve().parent
ROOT=HERE.parent
PINS={
 'moebius/FINITE_EM_VERTICAL_BATCHING_2026-11-11.md':'814AD0B3012FDA4FD81B485139257409E81E6EAC8FA44FD6824A7D21F02C8818',
 'major-constants/EM_VERTICAL_BATCH_SCALAR_SUPPORT_2026-11-11.md':'44C53A6F71D9B00368568D35C08D2ED69EC9ECA746AE61E2DDC8A79C5BA2C52F',
 'major-constants/em_vertical_batch_scalar_support_20261111.py':'79D62492632A784D58019302F01C310849BB2B4A1D6AB4D782852F1DFCEA204C',
 'major-constants/em_vertical_batch_scalar_support_20261111.json':'B68C8861B4F646C4EC43DEC00E5D364C33A1CEDF8C6F0C5FC976E72210F6F26F',
 'integration/FINITE_EM_VERTICAL_DFT_CONTRACTS_2026-11-11.md':'170C8F976A8AF8B299E4AB737E6924260B3B1D8328FA54C0F2BF7F6E9720F997',
}
for path,pin in PINS.items():
 assert hashlib.sha256((ROOT/path).read_bytes()).hexdigest().upper()==pin,path
checks=0
def check(x):
 global checks
 assert x
 checks+=1

# Exact rational label witnesses at and around positive and negative half-integers.
# These test the algebraic witness rule, not logarithms or actual bins.
for m in range(-20,21):
 for offset in [F(-1,100),F(0),F(1,100)]:
  midpoint=F(2*m+1,2)+offset
  q=(midpoint+F(1,2)).__floor__()
  for displacement in [F(-1,8),F(0),F(1,8)]:
   x=midpoint+displacement
   check(abs(x-q)<=F(5,8))
   for L in [4,8,16]:
    k=q%L
    check(0<=k<L and (q-k)%L==0)
check(F(5,16)*F(22,7)==F(55,56)<1)
N=333334;K=24;M=32;p=32
check(N**5<5120**8)
check(F(629,1250)-F(1,8)>F(3,8))
tail=F(2**14,factorial(p));arithmetic=F(16,7*2**104)
check(tail+arithmetic<F(1,2**100))
old=F(3,2)*(F(1,2**38)+F(1,7*2**21))/2**19
check(old+F(3,2)*(tail+arithmetic)<F(1,2**42))
rows=[]
for J in [1024,4096]:
 L=1
 while L<4*J:L*=2
 d=L.bit_length()-1
 check(4*J<=L<8*J)
 # Downward centers T-1/16-j/8, with full vertical radius 1/16.
 bottom=F(1000000)-F(J,8)
 check(bottom>2**19)
 rows.append(dict(J=J,L=L,minimum_actual_ordinate=str(bottom),
  moments=N*K*p,old_contributions=J*N*K,transforms=K*p,
  butterflies=K*p*(L//2)*d,residual_updates=N*K*(p-1),
  streamed_moment_slots=p*L,horner_steps=J*K*(p-1),
  correction_multiplications_upper=J*((3*M+2)*K+K*(K+1)//2)))
# A concrete schedule's counts, including the Q constant and final g additions.
for m in range(1,41):
 for k in range(1,41):
  H=k*(k+1)//2
  multiplications=(2*m-1)*k+m*k+k+H+k+k
  additions=(2*m-1)*(k-1)+m*k+k+(H-k)+(2*k-1)
  check(multiplications==(3*m+2)*k+H)
  check(additions<=(3*m+2)*k+H)
sources={}
base=Path('C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib')
for path,pin in {
 'Analysis/Fourier/ZMod.lean':'012663E2EB3A3F3196C6BCE04CB530D04E29C8DE8C65AFE703F2D707484EFE10',
 'Analysis/Calculus/Taylor.lean':'0AB79A53A36F87AB2A69D907D7999D2516CC4C085799E306F97D8480AE8CA18A',
}.items():
 digest=hashlib.sha256((base/path).read_bytes()).hexdigest().upper()
 check(digest==pin);sources[path]=digest
out=dict(status='PASS_EXACT_LABEL_SCALAR_AND_COUNT_CHECKS',checks=checks,
 scope='No logarithms, phases, moments, transforms, model/function values, or builds evaluated.',
 input_pins=PINS,source_pins=sources,rows=rows,
 quotient_batch_allowance=str(tail+arithmetic),
 old_square_plus_square_batch=str(old+F(3,2)*(tail+arithmetic)))
HERE.joinpath('review_vertical_batch_exact_20261111.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(out['status'],checks)
