"""Retry unresolved high-panel rows after adding a verified left coarse node."""
from fractions import Fraction as Q
from hashlib import sha256
from math import gcd,prod
import json
import sys
from flint import acb,arb,ctx,dirichlet_char
from strip_interpolation import HERE,SRC,LO,STEP,read,real,remainder

sys.path.insert(0,str(SRC))
from complete import phases,factors

ctx.prec,ctx.threads=256,1
panel=json.loads((HERE/"strip-interpolation.json").read_bytes())
screen=json.loads((SRC/"screen.json").read_bytes())
checks=json.loads((SRC/"mid-receipt.json").read_bytes())
assert all(d==screen["sha256"][name]==sha256((SRC/name).read_bytes()).hexdigest()
           for name,d in panel["input_sha256"].items())
assert {tuple(x[:3]) for x in checks["examples"]}=={
    (r["j"],r["k41"],r["k61"]) for r in panel["hidden_rows"]}
target={(r["k41"],r["k61"]) for r in panel["unresolved_rows"]}
assert target=={(9,15),(23,17)}
_,phase=phases()
coarse=read("high-signs.tsv.gz","j")
mid=read("high-midpoints.tsv.gz","left_j")
def residue(a,b,c):
    return (2501*(1+2*a)+4880*pow(6,b,41)+2624*pow(2,c,61))%10004
generators=[residue(1,0,0),residue(0,1,0),residue(0,0,1)]
labels={}
for n in range(1,10004):
    if gcd(n,10004)>1: continue
    chi=dirichlet_char(10004,n)
    if not chi.is_primitive(): continue
    freqs=[int(chi.chi_exponent(g))*d//120 for g,d in zip(generators,(2,40,60))]
    pair=tuple(freqs[1:])
    if freqs[0]==1 and pair in target:
        assert all(acb.exp_pi_i(acb(2*k)/d).overlaps(chi(g)) for k,d,g in zip(freqs,(2,40,60),generators))
        assert pair not in labels
        labels[pair]=n
assert labels.keys()==target
out=[]
for pair,label in sorted(labels.items()):
    chi=dirichlet_char(10004,label)
    a=int(chi.parity())
    def amplitude(j):
        t=real(STEP*j)
        z=phase[pair]*factors(t)[a]*chi.l(acb(arb(1)/2,t))
        assert z.imag.contains(0)
        return z.real
    check=amplitude(LO)
    assert check.overlaps(coarse[LO,*pair][0])
    xs={j:coarse[j,*pair][0] for j in range(LO,LO+16)}
    halo=[]
    for extra in (1,2):
        j=LO-extra
        xs[j]=amplitude(j)
        halo.append(xs[j].str(55))
        nodes=range(j,j+16)
        x=Q(2*LO+1,2)
        weights=[real(prod((x-k)/(v-k) for k in nodes if k!=v)) for v in nodes]
        rem=remainder(16,2,a,nodes,real(abs(prod((x-k)*STEP for k in nodes))))
        iv=sum((w*xs[v] for w,v in zip(weights,nodes)),arb(0))+arb(0,rem)
        sign=1 if iv>0 else -1 if iv<0 else 0
        ref,refsign=mid[LO,*pair]
        assert iv.overlaps(ref)
        if sign:
            assert sign==refsign
            out.append(dict(pair=pair,conrey=label,new_coarse_indices=list(range(LO-1,j-1,-1)),new_amplitudes=halo,
                old_coarse_overlap=str(check),result=iv.str(50),lower=iv.lower().str(35),upper=iv.upper().str(35),sign=sign,direct_reference=ref.str(50),
                derivative_remainder=rem.str(35)))
            break
    else:
        raise AssertionError("two extra coarse nodes did not resolve "+str(pair))
receipt=dict(rows=out,primary_receipt_sha256=sha256((HERE/"strip-interpolation.json").read_bytes()).hexdigest(),
    input_hashes_verified_against="c10004-grid-repair/screen.json",hidden_rows_verified_against="c10004-grid-repair/mid-receipt.json",
    hashes={p.name:sha256(p.read_bytes()).hexdigest() for p in [HERE/"strip_halo.py",SRC/"complete.py",SRC/"screen.json",SRC/"mid-receipt.json"]},
    scope="New coarse samples are 256-bit native FLINT Dirichlet L evaluations, multiplied by the archived gauge's Gauss phase and Hardy completion; production cost and HOL transport unmeasured.")
(HERE/"strip-halo.json").write_text(json.dumps(receipt,indent=2)+"\n")
print([(r["pair"],r["conrey"],r["new_coarse_indices"],r["result"]) for r in out])
