"""Check two production p81 rows directly against Arb and emit HOL fixture goals."""
import csv
import hashlib
import json
from pathlib import Path

from flint import acb, arb, ctx, dirichlet_char

ctx.prec = 256
ctx.threads = 1
here = Path(__file__).resolve().parent
hol = here.parent
q, scale = 10004, 2**81
paths = [hol / "c10004-full-integer" / name for name in ("spectrum.tsv", "params.tsv")]
paths.append(hol / "c10004-hol-shared-phase/phases.tsv")
paths.append(hol / "c10004-p20-source/h1-rawspectrum.tsv")
spectrum, params, phases = [
    [list(map(int, line.split())) for line in path.read_text().splitlines()]
    for path in paths[:3]
]
provider = list(csv.DictReader(paths[3].read_text().splitlines(), delimiter="\t"))
s = acb(arb(1)/2, arb(5)/64)
receipt = {"precision": ctx.prec, "hashes": {
    str(path.relative_to(hol)): hashlib.sha256(path.read_bytes()).hexdigest() for path in paths
}, "rows": []}
theory = ["Theory DispatchedFixture", "Ancestors DispatchedScore Sector LargeTerminal integer intreal real",
          "Libs realLib intLib", ""]
for label, k, l in [(3, 15, 6), (10003, 20, 30)]:
    chi = dirichlet_char(q, label)
    j = (k-1)*59+l-1
    parity = (1+k+l)%2
    assert chi.is_primitive() and chi.parity() == parity
    p, b = phases[j]
    f, g = params[0][2*parity:2*parity+2]
    e = params[0][-2]
    r, i = spectrum[j]
    row = provider[j]
    assert (k,l,r,i) == tuple(int(row[key]) for key in ["k41","k61","re","im"])
    tau = sum(chi(a)*acb.exp_pi_i(acb(2*a)/q) for a in range(q))
    w = tau / (acb(0,1)**parity * arb(q).sqrt())
    if w.real > -arb(1)/2:
        t = ((1+w.real)/2).sqrt()
        eps = acb(t,-w.imag/(2*t))
    else:
        assert w.real < arb(1)/2
        t = ((1-w.real)/2).sqrt()
        eps = acb(-w.imag/(2*t),t)
    h = (s+parity)/2
    factor = (acb(q)/arb.pi())**h * h.gamma() * acb(q)**(-s)
    z = acb(q)**s * chi.l(s)
    errors = [abs(v*scale-n) for v,n in zip(
        [eps.real,eps.imag,factor.real,factor.imag,z.real,z.imag], [p,b,f,g,r,i])]
    assert all(error < limit for error,limit in zip(errors,[1,1,1,1,e,e]))
    v = eps*factor*z
    expected = int(row["sign"])
    assert v.imag.contains(0) and v.real*expected>0
    assert expected == (1 if params[0][-1]>>j & 1 else -1)
    eligible = all(abs(x)>1 for x in [p,b,f,g])
    use_re = ((p>0)==(f>0)) != ((b>0)==(g>0))
    fast = eligible and abs(r if use_re else i)>e
    receipt["rows"].append(dict(conrey=label,local_modes=[k,l],sign=expected,fast=fast,
        coordinate_errors=[str(x) for x in errors],spectrum_radius=e))
    ints = [str(n) if n>=0 else "(-"+str(-n)+")" for n in (p,b,f,g,e,r,i)]
    p,b,f,g,e,r,i=ints
    raw = f"Sector$one ({p},{b}) ({f},{g},{e}) ({r},{i})"
    fallback = f"LargeTerminal$score ({p},{b}) ({f},{g},{e}) ({r},{i})"
    code = 2 if expected==1 else 1
    theory.extend([f"Theorem fixture_{label}_code:",
        f"  let c={raw} in (if c=0 then {fallback} else c)={code} /\\ (c=0 <=> {'F' if fast else 'T'})",
        "Proof", "  EVAL_TAC", "QED", ""])
    args = ",".join(f"`{n}:int`" for n in ints)
    theory.extend([f"Theorem fixture_{label}_sign:",
        f"  !pp qq ff gg xx yy. abs(pp-real_of_int {p})<=1 /\\ abs(qq-real_of_int {b})<=1 /\\",
        f"  abs(ff-real_of_int {f})<=1 /\\ abs(gg-real_of_int {g})<=1 /\\",
        f"  abs(xx-real_of_int {r})<=real_of_int {e} /\\ abs(yy-real_of_int {i})<=real_of_int {e} /\\",
        "  0 < (pp*ff-qq*gg)*(pp*ff-qq*gg)+(pp*gg+qq*ff)*(pp*gg+qq*ff) /\\",
        "  (pp*ff-qq*gg)*yy+(pp*gg+qq*ff)*xx=0 ==>",
        ("  0 < (pp*ff-qq*gg)*xx-(pp*gg+qq*ff)*yy" if expected==1 else
         "  (pp*ff-qq*gg)*xx-(pp*gg+qq*ff)*yy < 0"), "Proof",
        "  rpt gen_tac >> strip_tac >>",
        f"  mp_tac (Q.SPECL [{args},`pp:real`,`qq:real`,`ff:real`,`gg:real`,`xx:real`,`yy:real`] dispatched_sign) >>",
        "  impl_tac >- (rpt conj_tac >> TRY (first_assum ACCEPT_TAC) >> EVAL_TAC) >>",
        f"  simp_tac bool_ss [LET_THM,CONJUNCT1 (SIMP_RULE bool_ss [LET_THM] fixture_{label}_code)]",
        "QED", ""])
(here / "DispatchedFixtureScript.sml").write_bytes(("\n".join(theory)+"\n").encode())
(here / "fixture.json").write_text(json.dumps(receipt,indent=2)+"\n")
