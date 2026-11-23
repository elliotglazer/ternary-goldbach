"""Independent rational reconstruction. No FFT, L-value or array computation."""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json

BASE = Path(__file__).resolve().parent
PROD = BASE.parent / 'zero-sum'
PINS = {
    'FULL_RIGHT_SLAB_FOURIER_EVALUATOR_2026-11-11.md': '618FB579D8657C72F2003BE4D60C68E38648C2F30F266938CE40E2C8F5A5E771',
    'full_right_slab_fourier_parameters_20261111.py': '0F3987B2F5BA8CF45A3D51663E2466207976D5FED520B9E2552D161B1D9872FE',
    'full_right_slab_fourier_parameters_20261111.json': '87E2731447C2FB0B189F4EE77A3189844DA253DF56460BF8860C8056D2F2736B',
}
for name, pin in PINS.items():
    assert hashlib.sha256((PROD/name).read_bytes()).hexdigest().upper() == pin

checks = []
def ck(label, truth):
    assert truth, label
    checks.append(label)

def first(predicate, start=1):
    """Exponential bracket and integer bisection, independent of producer loops."""
    hi = start
    while not predicate(hi):
        hi *= 2
    lo = start-1
    while hi-lo > 1:
        mid = (lo+hi)//2
        if predicate(mid): hi = mid
        else: lo = mid
    return hi

def reconstruct(c, height, tolerance):
    H, e = max(F(1), F(height)), F(tolerance)
    K = first(lambda k: 24*c*c*F(3,8)**k < e/4)
    L = first(lambda k: 18*c*F(3,8)**k < e/4)
    x = first(lambda k: F(8,3)**(2*k) >= c*(2*k+L))
    P = 2*H+4*K
    exponent = first(lambda d: 2**d >= P*x/3)
    N = 2**exponent
    D = F(88*x,21)
    def series(n):
        V = F(3*n*n,c)
        z = F(3*(2*n+1),c)-F(1,n)
        if z <= 0 or V < 2: return None
        return D*2*n*(1+1/z)*F(3,8)**(V.numerator//V.denominator)
    # Avoid assuming monotonicity before admissibility: inspect powers in order.
    n = next(2**k for k in range(1000)
             if series(2**k) is not None and series(2**k) < e/4)
    V,z = F(3*n*n,c), F(3*(2*n+1),c)-F(1,n)
    t,f,s = 24*c*c*F(3,8)**K,18*c*F(3,8)**L,series(n)
    total=t+f+s+e/4
    ck(f'c{c} period and power-of-two range {e}', P>=6 and P>2*H and N>=P*x/3 and N<2*P*x/3)
    ck(f'c{c} complete error {e}', t<e/4 and f<e/4 and s<e/4 and total<e)
    return {'c':c, 'H_used':str(H), 'tolerance':str(e), 'K':K, 'L':L, 'x':x,
            'period':str(P), 'N_integer_only_no_array':N, 'omega_N_upper':str(D),
            'first_omitted_Gaussian_n':n,'V':str(V),'z':str(z),
            'time_upper':str(t),'frequency_upper':str(f),'series_output_upper':str(s),
            'rounding_per_coefficient_target':str(e/(8*D)),
            'finite_transform_error_target':str(e/8),'total_upper':str(total)}

frozen=json.loads((PROD/'full_right_slab_fourier_parameters_20261111.json').read_text())
rows=[]
for old in frozen['cases']:
    new=reconstruct(old['c'],F(old['H_used']),F(old['tolerance']))
    ck(f'exact producer row c{old["c"]}', all(new[k]==old[k] for k in new))
    rows.append(new)

extra=[]
for c,H,e in [(2,0,10**12),(2,F(1,7),F(1,10**60)),
              (101,F(12345,7),F(7,13)), (1000001,10**15,F(1,10**25))]:
    extra.append(reconstruct(c,H,e))

ck('strip cosine', 1-2*F(1,4)**2 == F(7,8))
ck('split Gaussian exponent stronger than reciprocal conductor', 3*F(7,8)/2 > 1)
ck('amplitude below three c', 2/F(7,8) < 3)
ck('least sigma and greatest sigma envelope slopes', F(111,200)-1<=1 and 2-1<=1 and -F(111,200)<=1)
ck('frequency reciprocal denominator', 2*(2*1+1)-1>1)
ck('x search ratio exceeds one', F(64,9)*F(3,5)>1)
ck('series termination prefactor', 2*(1+F(1,6))<3)
ck('series termination ratio', 2*F(3,8)**3==F(27,256)<1)
ck('four budget quarters', F(1,4)*3+F(1,8)*2==1)
for c in (2,3,101,300000):
    n=c
    ck(f'z and V at n=c={c}', F(3*(2*n+1),c)-F(1,n)>6 and F(3*n*n,c)>=3*n)
    M=6*c*c
    for tau in (F(1,10**30),F(10**20)):
        de=min(F(1),tau/(4*c*c))
        dm=min(F(1),tau/(4*(M+1)))
        ck(f'Lambda interval multiplication c{c} tau{tau}', c*c*de+(M+de)*dm<=tau/2)
        ck(f'panel radius c{c} tau{tau}', tau/2+3*c**4*(tau/(6*c**4))==tau)

out={'scope':'Independent exact rational parameter reconstruction; no actual Fourier or spectral data',
     'producer_pins':PINS,'passed_checks':len(checks),'checks':checks,
     'matching_producer_rows':rows,'additional_rows':extra}
path=BASE/'review_full_slab_fourier_20261111.json'
path.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps({'passed_checks':len(checks),'matching_producer_rows':len(rows),'additional_rows':len(extra)}))
