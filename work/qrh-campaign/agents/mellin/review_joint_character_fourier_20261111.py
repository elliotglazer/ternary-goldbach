"""Independent exact algebra/pin review; no analytic or spectral evaluation."""
from pathlib import Path
from fractions import Fraction as F
import hashlib
import json

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
PINS = {
    'major-constants/JOINT_CHARACTER_FOURIER_BATCH_PLAN_2026-11-11.md': '3D41376E00A58D5EBC8403151807694163F0E59923869DCAAAB08F51A6A3625D',
    'major-constants/joint_character_fourier_algebra_20261111.py': 'BADF7BBAE39D39E3676F284F13E934365D0350FFC633F66571BC171B0208E462',
    'major-constants/joint_character_fourier_algebra_20261111.json': 'DB9D5DEB34FCDF492719BABA442BAE4C7B1546F1F6EF10FC4DB03AB8004B5357',
    'zero-sum/FAMILY_CHARACTER_MANIFEST_PROOF_PLAN_2026-11-11.md': '53D6DE424680957E9467FE5CF608578BB356DE08C57979E7494E4F1E387D4D54',
    'zero-sum/FAMILY_GAUSSIAN_FOURIER_PROOF_PLAN_2026-11-11.md': '5FED76F0F59A6422977D968DD7F2018FEDAE0A175DE1ECD43D956EFDEDF44F41',
    'integration/REVIEW_FAMILY_GAUSSIAN_FOURIER_PROOF_PLAN_2026-11-11.md': '098171B14232E392AAA0C4BDD083C0E737D459315E23039F624C862B8E06C577',
    'zero-sum/OFF_CRITICAL_GAUSSIAN_FOURIER_PLAN_2026-11-11.md': 'BA7A5D0517972FD9C93496E6166DEC471B36C18CA0B6BBA734985016ECD24B25',
    'moebius/REVIEW_OFF_CRITICAL_GAUSSIAN_FOURIER_PLAN_2026-11-11.md': 'F9431FA70E33B7FFA3A16B6C12CB254A14D590C8FEEF81CC86E328418A304D0F',
    'zero-sum/FULL_RIGHT_SLAB_FOURIER_EVALUATOR_2026-11-11.md': '618FB579D8657C72F2003BE4D60C68E38648C2F30F266938CE40E2C8F5A5E771',
    'moebius/REVIEW_FULL_RIGHT_SLAB_FOURIER_EVALUATOR_2026-11-11.md': 'AE8F8F852F969B6505EE9AC60E5F4D67B7AF686E94F6A9B4E4FED54D8F9ED271',
    'zero-sum/FAMILY_FOURIER_ALIAS_PROOF_PLAN_2026-11-11.md': 'E7D5CD24F5FAA6B75ED5E1167F3165EACBD7BCA7FEDF73D521C6B74BD04776EF',
    'moebius/REVIEW_FAMILY_FOURIER_ALIAS_PROOF_PLAN_2026-11-11.md': 'A1B71C24E818CD5628C7A5F5B24105E19BDF5FC4840CCFC47239CAB435A85B33',
}
for path, expected in PINS.items():
    assert hashlib.sha256((AGENTS / path).read_bytes()).hexdigest().upper() == expected, path

# Replay only the assertion-bearing prefix; never execute its receipt writer.
author = (AGENTS / 'major-constants/joint_character_fourier_algebra_20261111.py').read_text()
ns = {}
exec(compile(author.split("out={'scope':", 1)[0], '<frozen-author-assertions>', 'exec'), ns)
assert ns['checks'] == 32

Z = (F(0), F(0))
def plus(z, w): return (z[0] + w[0], z[1] + w[1])
def times(z, w): return (z[0]*w[0] - z[1]*w[1], z[0]*w[1] + z[1]*w[0])
def conj(z): return (z[0], -z[1])
def total(items):
    z = Z
    for w in items: z = plus(z, w)
    return z
def root(k): return [(F(1),F(0)),(F(0),F(1)),(F(-1),F(0)),(F(0),F(-1))][k % 4]
def scale(a,z): return (a*z[0],a*z[1])

checks = 0
# Cyclic mod 5 and product-group mod 8, including nonunit zero extension.
for c, coords, labels in [
    (5, {1:(0,),2:(1,),4:(2,),3:(3,)}, [(r,) for r in range(4)]),
    (8, {1:(0,0),7:(2,0),5:(0,2),3:(2,2)}, [(r,s) for r in range(2) for s in range(2)]),
]:
    def value(label, n):
        xy = coords.get(n % c)
        return Z if xy is None else root(sum(a*b for a,b in zip(label,xy)))
    def dft(label, buckets):
        return total(times(value(label,u),z) for u,z in buckets.items())
    for a in range(2):
        data = {m:scale(F(m**a),(F(m+1,m+3),F(2-m,m+5))) for m in range(1,30)}
        bucket = {u:total(z for m,z in data.items() if m % c == u) for u in coords}
        for label in labels:
            inv = tuple(-r for r in label)
            actual = dft(label,bucket)
            assert actual == total(times(value(label,m),z) for m,z in data.items())
            assert dft(inv,{u:conj(z) for u,z in bucket.items()}) == conj(actual)
            checks += 2
            # Two distinct scalar branches, all four time nodes, exact finite Fubini.
            rows = {j:{u:plus(z,(F(j+2,u+1),F(j-u,13))) for u,z in bucket.items()} for j in range(-2,2)}
            pref = {j:(F(j+4,7),F(j*j+1,11)) for j in rows}
            W = (F(5,13), F(12,13))
            for m in range(4):
                left = total(times(root(j*m),times(pref[j],times(W if j<0 else (F(1),F(0)),dft(inv if j<0 else label,rows[j])))) for j in rows)
                ups = {u:total(times(root(j*m),times(pref[j],rows[j][u])) for j in rows if j>=0) for u in coords}
                ums = {u:total(times(root(j*m),times(pref[j],rows[j][u])) for j in rows if j<0) for u in coords}
                assert left == plus(dft(label,ups),times(W,dft(inv,ums)))
                checks += 1

for folds in range(4):
    N=4
    J=(2*folds+1)*N//2
    coeff = {j:(F(j+J+2,17), F(j*j-3,19)) for j in range(-J,J)}
    packed = {k:total(z for j,z in coeff.items() if (j-k)%N==0) for k in range(-2,2)}
    for m in range(4):
        assert total(times(z,root(j*m)) for j,z in coeff.items()) == total(times(z,root(k*m)) for k,z in packed.items())
        checks += 1
    assert len(coeff)==2*J and len({abs(j) for j in coeff})==J+1
    assert sum(1 for j in coeff if j==0)==1 and -J in coeff and J not in coeff
    checks += 2

result = {
    'status':'PASS', 'pins_checked':len(PINS), 'author_checks_replayed_without_writes':32,
    'independent_exact_algebra_checks':checks,
    'scope':'Finite rational-complex regrouping, conjugation, two-channel Fubini, folding and endpoint counts only. No Gaussian values, spectral data, runtime forecast or Lean validation.'
}
HERE.joinpath('review_joint_character_fourier_20261111.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
print(json.dumps(result,indent=2))
