"""Independent exact scalar enclosure replay; no author imports or math evaluator."""
from fractions import Fraction as Q
from pathlib import Path
import hashlib
import json
import re

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
AUTHOR = HERE.parent / "prime-estimates"
SRC = ROOT / "work/ternary-goldbach/TernaryGoldbach/MinorArcs"
INPUTS = {
    AUTHOR / "source_mass_joint_cutoff_20261111.py": "F243DD01285D8FA78F72A38AFFF1F2842436D4110F1E7B616B2111DB6712488A",
    AUTHOR / "source_mass_joint_cutoff_20261111.json": "67F6C3BAE93EDE7BD93C49A4EC8B442671A921D9E71B5AEC4925031261984FC9",
    SRC / "NumericsCore.lean": "4E2D5351E5BFD0350FBD3B378B123CA1F7155943D467CB4788554800B657F6F8",
    SRC / "NumericsCells.lean": "5192960AD541DCF981C630F538B35EC63FE966A61044AF31576AB83C93A41139",
    SRC / "GBound.lean": "79070A7DD3B3B755A34C3C39690674193CBCF439238D763EB4982889E5B52491",
    SRC / "LinftyLevels.lean": "12605A6C6B8E97BA5ABADEC4F761E322F8C04E8D4C6557AC5BE1084194EA6409",
    SRC / "SecondNumerics.lean": "9EFE248D96FA776558A71D1420E9D22C97F431EAE70A91B83935A7B6C292717C",
    SRC / "GMono.lean": "04C5EDB300E1F256C4B632B6CCA86D949E4E19D846776EB4B05757FC9B7227E1",
    SRC.parent / "Prelim/SmallMuPhi.lean": "7ECE1D48D9679ECF529A5566C79D06FADB3CA70CCAF057ADAA020D6AA390BADF",
}
for path, expected in INPUTS.items():
    assert hashlib.sha256(path.read_bytes()).hexdigest().upper() == expected, path

def floor_at(q, scale):
    return Q(q.numerator * scale // q.denominator, scale)

def ceil_at(q, scale):
    return -floor_at(-q, scale)

LOGS = {}
ROOTS = []
N = 48

def small_log_interval(x):
    # log x = 2 sum z^(2j+1)/(2j+1), z=(x-1)/(x+1).
    assert 1 <= x <= Q(3, 2)
    z = (x - 1) / (x + 1)
    assert 0 <= z <= Q(1, 5)
    term = z
    total = Q(0)
    for j in range(N):
        total += 2 * term / (2*j + 1)
        term *= z*z
    remainder = 2 * term / ((2*N + 1) * (1-z*z))
    return total, total + remainder

BASE = small_log_interval(Q(3, 2))

def log_interval(x):
    x = Q(x)
    if x in LOGS:
        return LOGS[x]["lower"], LOGS[x]["upper"]
    assert x >= 1
    w, k = x, 0
    while w >= Q(3, 2):
        w *= Q(2, 3)
        k += 1
        assert k < 2000
    assert x == w * Q(3, 2)**k
    a, b = small_log_interval(w)
    exact_lower, exact_upper = a+k*BASE[0], b+k*BASE[1]
    lower, upper = floor_at(exact_lower, 10**30), ceil_at(exact_upper, 10**30)
    assert lower <= exact_lower <= exact_upper <= upper
    LOGS[x] = dict(argument=x, reduction_base=Q(3, 2), reduction_power=k,
                   reduced=w, z=(w-1)/(w+1), terms=N,
                   lower=lower, upper=upper, width=upper-lower)
    return lower, upper

def log_rounded(x, upward):
    a, b = log_interval(x)
    rounding = ceil_at if upward else floor_at
    left, right = rounding(a, 10**7), rounding(b, 10**7)
    # Both independently certified endpoints give the same rounded value.
    assert left == right, (x, a, b)
    return left

def root_floor(x, degree, scale=1, label=""):
    # Decimal digit search with exact cross-products, independent of isqrt
    # and the author's doubling/binary-search root implementation.
    x = Q(x)
    assert x >= 0 and degree >= 2 and scale >= 1
    numerator = x.numerator * scale**degree
    denominator = x.denominator
    places = (len(str(numerator // denominator)) + degree - 1) // degree
    root = 0
    for position in range(places-1, -1, -1):
        place = 10**position
        for digit in range(9, -1, -1):
            candidate = root + digit*place
            if candidate**degree * denominator <= numerator:
                root = candidate
                break
    low_gap = numerator-root**degree*denominator
    high_gap = (root+1)**degree*denominator-numerator
    assert low_gap >= 0 and high_gap > 0
    ROOTS.append(dict(label=label, argument=x, degree=degree, scale=scale,
                      integer=root, lower_gap=low_gap, upper_gap=high_gap))
    return Q(root, scale)

def sqrt_pair(x, label):
    a = root_floor(x, 2, 10**7, label)
    return a, a + Q(1, 10**7)

saved = json.loads((AUTHOR / "source_mass_joint_cutoff_20261111.json").read_text(encoding="utf-8"))
def unpack(v):
    return Q(int(v["num"]), int(v["den"]))

R = 132900
YLIST = [10**25, 3*10**25, 10**26, 10**27, 10**28,
         10**30, 10**34, 10**42, 10**58]
row = [r for r in saved["rows"] if r["R"] == R]
assert len(row) == 1
row = row[0]
rounding_metadata_checks = 0
def check_saved_rounding(value):
    global rounding_metadata_checks
    if isinstance(value, dict):
        if {"num", "den", "ceil_1e9"} <= value.keys():
            q = unpack(value)
            assert int(value["den"]) > 0
            assert ceil_at(q, 10**9)*10**9 == int(value["ceil_1e9"])
            rounding_metadata_checks += 1
        else:
            for child in value.values():
                check_saved_rounding(child)
    elif isinstance(value, list):
        for child in value:
            check_saved_rounding(child)
check_saved_rounding(row)
for key in ("major_error", "nonprime_allowance", "log10_exp_lower", "ghat_lower"):
    check_saved_rounding(saved[key])
assert [v["Y"] for v in row["cells"]] == YLIST
assert [v["Y"] for v in saved["parsed_cells"]] == YLIST
assert [int(Q(v)) for v in re.findall(r"cell_bound \(Y := ([0-9.e]+)\)",
             (SRC / "NumericsCells.lean").read_text(encoding="utf-8"))] == YLIST

a = log_rounded(2*R, True)
b = log_rounded(8*R, True)
logRlo, logRhi = log_interval(R)
lrlo, lrhi = floor_at(logRlo, 10**7), ceil_at(logRhi, 10**7)
assert lrlo == floor_at(logRhi, 10**7)
assert lrhi == ceil_at(logRlo, 10**7)
c1 = log_rounded(lrhi, True)
c2 = log_rounded(lrlo, False)
assert c2 > 0
fr = Q("1.7882")*c1 + Q("2.50637")/c2
s1 = sqrt_pair(fr, "sqrt_Fr_upper")[1]
s2 = sqrt_pair(2*R, "sqrt_2R_lower")[0]
assert fr <= s1*s1 and 0 < s2 and s2*s2 <= 2*R
tail = Q(17, 3)*Q(670, R)**3
results = []
for index, Y in enumerate(YLIST):
    u = root_floor(Y, 3, label=f"Y{index}_cube")
    v = root_floor(Y, 6, label=f"Y{index}_sixth")
    t = 1/v
    assert Y >= 10**25 and R >= 670 and 6*R <= u
    assert u**3 <= Y and (1/t)**6 <= Y and t > 0
    denominator_log_arg = 9*u/(Q("4.008")*R)
    b2 = log_rounded(denominator_log_arg, False)
    assert b2 > 0
    rho = log_rounded(1 + b/(2*b2), True)
    ell = log_rounded(Y, True)
    sq = sqrt_pair(ell, f"Y{index}_sqrt_log_upper")[1]
    assert sq >= 0 and ell <= sq*sq
    h = Q(".276")*t*ell*sq + 1234*t*t*ell
    first = (((Q(".27125")*rho+Q(".41415"))*a+Q(".8764"))*s1+Q("2.526"))/s2
    second = (fr*(Q(13, 4)*a+Q("7.82"))+Q("13.66")*a+Q("37.55"))/R
    gx_upper = first+second+Q("3.8")*t
    branch_a, branch_b = Q("1.398")*gx_upper+tail, Q("1.398")*h+tail
    G = ceil_at(max(branch_a, branch_b), 10**7)
    assert G == unpack(row["cells"][index]["G"])
    assert branch_a <= G and branch_b <= G
    results.append(dict(cell=index, Y=Y, u=u, sixth_floor=v, t=t,
                        b2_argument=denominator_log_arg, b2=b2, rho=rho,
                        ell=ell, sqrt_ell_upper=sq, h_upper=h, gx_upper=gx_upper,
                        branch_a=branch_a, branch_b=branch_b, G=G,
                        G_margin=G-max(branch_a, branch_b), saved_match=True))

# Source Euler-constant upper bound, using a fresh exact harmonic sum,
# our independent log128 interval, and a positive exponential series.
harmonic128 = sum((Q(1, n) for n in range(1, 129)), Q(0))
assert harmonic128-log_interval(128)[0] < Q(".5812")
def exp_interval(x, terms):
    assert x >= 0 and x < terms+1
    term, total = Q(1), Q(0)
    for j in range(terms):
        total += term
        term *= x/(j+1)
    return total, total+term/(1-x/(terms+1))
gamma_exp = exp_interval(Q(".5812"), 40)
assert gamma_exp[1] < Q("1.7882")

# N0 square root and log10: no log/exp evaluator or source isqrt.
N0 = 989*10**24
sqrtN0 = root_floor(N0, 2, label="sqrt_N0")
assert sqrtN0.denominator == 1 and sqrtN0.numerator == saved["sqrt_N0_floor"]
assert log_interval(10)[1] < Q("2.303")
exp2303 = exp_interval(Q("2.303"), 25)[0]
assert exp2303 > 10 and exp2303 == unpack(saved["log10_exp_lower"])
nonprime = 49*Q("2.02")**2*6700000*27*Q("2.303")/sqrtN0
assert nonprime == unpack(saved["nonprime_allowance"]) < Q(".00265")
assert Q(989, 490)*Q(49, 10)*10**26 == N0
assert Q(69, 10)**32 < N0 and Q(264, 100)**64 < N0 and 10**26 < N0

# Lower ghat guard: source Fs_ge gives Fr>=3.8 on log R>1.
assert logRlo > 1 and Q("1.7")**2 < Q("3.8")
assert log_interval(2*R)[0] > 12 and 2*R < 548**2
ghat_lower = Q("1.398")*((Q(".41415")*12+Q(".8764"))*Q("1.7")+Q("2.526"))/548
assert ghat_lower == unpack(saved["ghat_lower"]) > Q(".03")

# Exact composition, now with independently regenerated G rather than
# merely assuming the saved enclosure direction. Source mass remains the
# previously reviewed finite-checkpoint input, not a new totient evaluation.
major_error = (Q("3.67e-6")+49*Q("8.85e-7")/9)*Q("8.79") \
    +(Q(9, 2)*Q("8.85e-7")*Q("7.78")+49*Q("2.03e-5"))*Q("2.85") \
    +49*Q("8.85e-7")/9*Q(".640208")*Q("13.59756")
assert major_error == unpack(saved["major_error"])
mass = Q(2*6734875660393277758, 10**18)
checkpoint = (SRC.parent / "Prelim/SmallMuPhi.lean").read_text(encoding="utf-8")
assert re.search(r"theorem c_132 : Lt 132000 = 6734875660393277758 :=", checkpoint)
jfull = Q(".638108")*mass-Q(".00108")
j = (jfull-100001*Q(8, 10**11))/Q("1.00001")
singular = 2*(Q(".6606")*Q(198, 199)-Q("22.1")/R)
major = Q(".800689")*singular-major_error
for name, q in (("mass_lower", mass), ("J_lower", jfull), ("I_lower", j),
                ("singular_lower", singular), ("major_lower", major)):
    assert unpack(row[name]) == q and q > 0
margins = []
for p, g, old in zip(saved["parsed_cells"], results, row["cells"]):
    sd, cl = unpack(p["sd"]), unpack(p["cl"])
    base = cl*sd-j
    assert base > 0
    U = g["G"]*base+sd*unpack(p["chain"])+unpack(p["tail"])
    minor = Q("1.0005")*U+2001*Q("22.75")*Q(8, 10**11)
    margin = major-minor-nonprime
    assert U == unpack(old["Mexpr_upper"])
    assert minor == unpack(old["minor_upper"])
    assert margin == unpack(old["margin"]) > 0
    margins.append(margin)
base_a = Q("14.61155")*Q("1.2947")-j
assert base_a > 0
Ua = results[-1]["G"]*base_a+Q("1.2947")*(Q(".165282706731081808")+Q(".00084")+Q("1.398e-10"))+Q(".00022")
minor_a = Q("1.0005")*Ua+2001*Q("22.75")*Q(8, 10**11)
assert minor_a == unpack(row["asymptotic_minor"])
assert major-minor_a-nonprime == unpack(row["asymptotic_margin"]) > 0
gap = Q("1.016")*49**2*Q("5.53")/(8*R)+548*(Q("1.4874e-6")+Q("2e-9"))+Q("2e-9")
assert gap == unpack(row["basegap_upper"]) < Q(".014")
assert min(margins+[major-minor_a-nonprime]) == unpack(row["joint_margin"]) > Q(".0013565")

def encode(x):
    if isinstance(x, Q):
        return dict(num=str(x.numerator), den=str(x.denominator))
    if isinstance(x, list):
        return [encode(y) for y in x]
    if isinstance(x, dict):
        return {k: encode(v) for k, v in x.items()}
    return x

output = dict(status="PASS", scope="R132900 elementary enclosures only; exact rational/integer arithmetic",
    self_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper(),
    inputs={str(p.relative_to(ROOT)).replace("\\", "/"): h for p,h in INPUTS.items()},
    R=R, Y=YLIST, independent_log_base=Q(3, 2), independent_log_terms=N,
    rounding_scale=10**7, enclosure_scale=10**30,
    log_certificates=list(LOGS.values()), root_certificates=ROOTS,
    shared=dict(a=a,b=b,logR_lower=lrlo,logR_upper=lrhi,c1=c1,c2=c2,
                Fr_upper=fr,sqrt_Fr_upper=s1,sqrt_2R_lower=s2,tail=tail),
    ghat_certificates=results, asymptotic_reuses_cell=8,
    Euler_upper=dict(harmonic128=harmonic128,gamma_upper=Q(".5812"),
                     exp_lower=gamma_exp[0],exp_upper=gamma_exp[1]),
    mass_independent=dict(sqrt_N0_floor=sqrtN0,log10_upper=log_interval(10)[1],
        log10_exp_lower=exp2303,nonprime=nonprime,major_error=major_error,
        ghat_lower=ghat_lower,basegap_upper=gap),
    finite_margins=margins,asymptotic_margin=major-minor_a-nonprime,
    joint_margin=unpack(row["joint_margin"]),
    saved_rounding_metadata_checks=rounding_metadata_checks,
    checks=dict(all_nine_G_match=True,all_numeric_ghat_premises=True,
        asymptotic_same_Y_G=True,mass_independent_saved_fields_match=True,
        all_final_margins_positive=True,no_author_imports=True))
target = Path(__file__).with_suffix(".json")
target.write_text(json.dumps(encode(output), indent=2)+"\n", encoding="utf-8")
print("PASS", "logs",len(LOGS),"roots",len(ROOTS),"G",[str(g['G']) for g in results])
print("joint_margin",str(unpack(row["joint_margin"])))
print("receipt_sha256",hashlib.sha256(target.read_bytes()).hexdigest().upper())
