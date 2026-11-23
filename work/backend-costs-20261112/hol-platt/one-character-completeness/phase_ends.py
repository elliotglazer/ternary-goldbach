"""Enclose the shared two-channel Turing gamma integral at the ends of each window."""
from fractions import Fraction
from hashlib import sha256
import json
from pathlib import Path
import sys
from time import process_time

from flint import acb, arb, ctx

HERE = Path(__file__).resolve().parent
sys.path.insert(0,str(HERE.parent/"small-character-kernel"))
from plan import SOURCE

SCALE = 1<<32


def ball(value):
    value = Fraction(value)
    return arb(value.numerator)/value.denominator


def endpoint(parity, t):
    z = acb(arb(1+2*parity)/4,t/2)
    return ((z*z/2-z/2+arb(1)/12)*z.log()-3*z*z/4+z/2).real


def enclosure(c, parity, lower, upper):
    T,H = ball(lower),ball(upper)
    assert 0<T and T<H
    pi = arb.pi()
    main = 2/pi*((H-T)*(H+T)/4*(arb(c)/pi).log()-2*(endpoint(parity,H)-endpoint(parity,T)))
    error = 4/(45*pi)*(1/(T*T)-1/(H*H))
    assert error>0
    lo = int(((main-error)*SCALE).lower().floor().unique_fmpz())
    hi = int(((main+error)*SCALE).upper().ceil().unique_fmpz())
    assert lo<hi
    return lo,hi


def independent_integral(c,parity,T,H):
    logq = (arb(c)/arb.pi()).log()
    def f(t,analytic):
        z = acb(arb(1+2*parity)/4)+acb(0,1)*t/2
        other = acb(arb(1+2*parity)/4)-acb(0,1)*t/2
        # These log-Gamma branches are analytic on the right half-plane.
        if analytic and (not z.real>0 or not other.real>0):
            return acb("nan")
        imaginary_part = (z.lgamma()-other.lgamma())/acb(0,2)
        return 2/arb.pi()*(t*logq/2+imaginary_part)
    return acb.integral(f,ball(T),ball(H))


def main():
    ctx.prec,ctx.threads = 160,1
    old = json.loads((HERE/"turing.json").read_bytes())
    lo,hi = enclosure(3,1,61,261)
    W = Fraction(412619,16)
    upper_count = (Fraction(hi,SCALE)-W+2*old["rational_b_upper"])/200
    assert old["K"]==46 and upper_count<47
    checked=[]
    for c,a,T,H in [(3,1,61,261),(5,0,100,115),(10000,1,6580,6630)]:
        l,h = enclosure(c,a,T,H)
        value=independent_integral(c,a,T,H)
        assert value.imag.contains(0) and value.real>ball(Fraction(l,SCALE)) and value.real<ball(Fraction(h,SCALE))
        checked.append(dict(c=c,parity=a,T=T,H=H,independent=str(value),low=l,high=h))
    cases=json.loads(SOURCE.read_bytes())["scenarios"]
    def metadata(s):
        return {c:m for c,m,*_ in s["small_sign_only_conditional_candidate"]["raw_metadata"]}
    base=metadata(cases[0])
    assert [s["extra_nodes"] for s in cases]==[0,167,320,640]
    rows=["conductor\tparity\tbase_tick\textra_ticks\tlow_times_2p32\thigh_times_2p32"]
    largest=Fraction(0)
    start=process_time()
    for s in cases[1:]:
        extra=s["extra_nodes"]
        other=metadata(s)
        assert base.keys()==other.keys()
        for c,m in sorted(base.items()):
            assert other[c]-m==extra
            lower,upper = Fraction(5*m,64),Fraction(5*other[c],64)
            parities=(1,) if c in (3,4) else (0,) if c==12 else (0,1)
            for a in parities:
                l,h=enclosure(c,a,lower,upper)
                largest=max(largest,Fraction(h-l,SCALE)/(upper-lower))
                rows.append(f"{c}\t{a}\t{m}\t{extra}\t{l}\t{h}")
    elapsed=process_time()-start
    assert len(rows)-1==3*(2*7499-3)
    margin_path=SOURCE.parent.parent/"integration/turing_auxiliary_margin_design_20261111.json"
    margins=[]
    for w in json.loads(margin_path.read_bytes())["rows"]:
        c,T,H=w["conductor"],Fraction(w["T_Hcert"]),Fraction(w["H_evaluator"])
        for a in ((1,) if c in (3,4) else (0,1)):
            l,h=enclosure(c,a,T,H)
            margins.append(dict(c=c,T=str(T),H=str(H),parity=a,rho=w["rho"],low=l,high=h))
    tsv=HERE/"phase-windows.tsv"
    tsv.write_text("\n".join(rows)+"\n",newline="\n")
    report=dict(scale=SCALE,grid_step="5/64",conductors=len(base),rows=len(rows)-1,sweep_cpu_seconds=elapsed,
                worst_interval_width_divided_by_window=float(largest),independent=checked,margin_examples=margins,
                c3_archive=dict(gamma_interval_scaled=[lo,hi],W=str(W),K=46,b_upper=76,U_upper=str(upper_count)),
                sha256={p.name:sha256(p.read_bytes()).hexdigest() for p in [tsv, SOURCE, margin_path, HERE/"turing.json"]})
    (HERE/"phase-ends.json").write_text(json.dumps(report,indent=2)+"\n")
    print(report["rows"],elapsed,float(largest),float(upper_count),len(margins))


if __name__=="__main__":
    main()
