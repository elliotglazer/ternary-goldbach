"""Independent exact arithmetic review; no Fourier/character/sign computation.

Reads the frozen author receipt without executing or modifying the author script.
Reconstructs all nine rational claims and supplemental scalar reductions.
"""
from fractions import Fraction as Q
from pathlib import Path
import hashlib
import json

HERE = Path(__file__).resolve().parent
AUTHOR = HERE.parent / 'zero-sum'
PINS = {
    'FAMILY_FOURIER_ALIAS_PROOF_PLAN_2026-11-11.md':
        'e7d5cd24f5faa6b75ed5e1167f3165eacbd7bca7fedf73d521c6b74bd04776ef',
    'family_fourier_alias_scalar_20261111.py':
        'a64ee1ed4da92033c45b6a4254ecf43eba34775744707b1474eeb064722fa6c8',
    'family_fourier_alias_scalar_20261111.json':
        '89b0e22cc7b3ee0447556664c39d493c2851399cb043aba119cb04d43593c31a',
}
for name, sha in PINS.items():
    assert hashlib.sha256((AUTHOR / name).read_bytes()).hexdigest() == sha, name

receipt = json.loads((AUTHOR / 'family_fourier_alias_scalar_20261111.json').read_text())
cap = 10**8
cutoff = 100000
n0 = cutoff + 1
e_lower = Q(8, 3)
claims = {
    'time_alias_upper': (32 * cap / e_lower**96, Q(1, 10**30), '<'),
    'frequency_gaussian_exponent_lower': (Q(3, 2 * cap) * e_lower**24, Q(200), '>'),
    'frequency_alias_upper': (12 * cap / e_lower**200, Q(1, 10**75), '<'),
    'series_exponent_lower': (Q(3 * n0*n0, cap), Q(300), '>'),
    'series_ratio_exponent_lower': (Q(3 * (2*cutoff+3), cap)-Q(1,n0), Q(1,200), '>'),
    'series_per_coefficient_upper': (402 * n0 / e_lower**300, Q(1,10**119), '<'),
    'DFT_norm_factor_upper': (Q(44,7)*(4+Q(2,257)), Q(26), '<'),
    'series_all_coefficient_upper': (Q(26,10**119), Q(1,10**117), '<'),
    'full_example_ledger_upper': (
        sum([Q(1,10**30),Q(1,10**75),Q(1,10**117),Q(26,10**50),Q(1,10**40)]),
        Q(2,10**30), '<'),
}
assert set(claims) == set(receipt['checks'])
checked = {}
for name, (lhs,rhs,rel) in claims.items():
    row = receipt['checks'][name]
    assert Q(row['lhs']) == lhs and Q(row['rhs']) == rhs and row['relation'] == rel
    assert lhs < rhs if rel == '<' else lhs > rhs
    checked[name] = {'lhs':str(lhs),'relation':rel,'rhs':str(rhs)}

# These are additional rational steps, not transcendental evaluations.
extra = {
    'sin_argument_upper_for_T_ge_one': (Q(1,2), Q(1), '<'),
    'odd_outer_A_factor': (Q(16,3), Q(8), '<'),
    'even_outer_A_squared_factor': (Q(32), Q(64), '<'),
    'time_geometric_exponent_lower': (Q(3*257,8), Q(1), '>'),
    'exp_inverse_at_one_upper': (Q(3,8), Q(1,2), '<'),
    'omega_upper_at_T_one': (Q(44,7*257), Q(1), '<'),
    'series_monotonicity_threshold': (Q(300), Q(3,4), '>'),
    'reciprocal_geometric_factor': (Q(1)+1/Q(1,200), Q(202), '<'),
}
for name, (lhs,rhs,rel) in extra.items():
    assert lhs < rhs if rel == '<' else lhs > rhs
    checked[name] = {'lhs':str(lhs),'relation':rel,'rhs':str(rhs)}

# Pure exact sanity checks of the centered block and integer phase relation.
# The universal proof is Euclidean division, given in the review note.
geometry_cases = 0
for N in range(2,34,2):
    centered = range(-N//2,N//2)
    assert len({j % N for j in centered}) == N
    for L in range(4):
        ns = {j+ell*N for j in centered for ell in range(-L,L+1)}
        edge = (2*L+1)*N//2
        assert ns == set(range(-edge,edge))
        for j in centered:
            for ell in range(-L,L+1):
                for m in (-N, -1, 0, 1, N):
                    assert Q((j+ell*N)*m,N)-Q(j*m,N) == ell*m
        geometry_cases += 1

out = {
    'verdict':'PASS: exact scalar and finite indexing checks only; analytic proof reviewed separately',
    'author_pins':PINS,
    'author_checks_reconstructed':len(claims),
    'supplemental_scalar_checks':len(extra),
    'centered_geometry_sanity_cases':geometry_cases,
    'checks':checked,
    'no_FFT_character_or_sign_values_generated':True,
    'author_artifacts_unchanged':all(
        hashlib.sha256((AUTHOR/n).read_bytes()).hexdigest()==s for n,s in PINS.items()),
    'review_script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
}
assert out['author_artifacts_unchanged']
HERE.joinpath('review_family_fourier_alias_20261111.json').write_text(json.dumps(out,indent=2)+'\n')
print('PASS: 9 author rational checks, 8 additional checks, 64 finite indexing sanity cases')
