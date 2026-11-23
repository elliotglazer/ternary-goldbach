"""Read-only source provenance and elementary exact identities, not analytic evaluation."""
from pathlib import Path
from fractions import Fraction as F
from hashlib import sha256
import json
import re

ROOT = Path(__file__).resolve().parents[4]
SRC = ROOT / 'work/openai-math/lean/OAI/NumberTheory/DirichletL'
FILES = '''Inversion/InitialHighFrequencyTailRapid.lean
Inversion/InitialHighFrequencyTailPower.lean
Inversion/InitialHighFrequencyTail.lean
Inversion/InitialHighFrequencyTailFiber.lean
Inversion/InitialHighFrequencyTailScale.lean
Inversion/InitialHighFrequencyTailKernel.lean
Inversion/InitialHighFrequencyTailInfinite.lean
Inversion/InitialHighFrequencyTailCoefficient.lean
Inversion/InitialHighFrequencyTailAggregate.lean
Inversion/InitialHighFrequencyTailSource.lean
Inversion/InitialHighFrequencyTailGeometry.lean
Inversion/InitialHighFrequencyTailWeights.lean
Inversion/InitialPhysicalMeasure.lean
Inversion/InitialEnergyCallerWeights.lean
Inversion/InitialDyadicTailBound.lean
Poisson/RadialFourier.lean
GaussSum/SexticRadialPoisson.lean
GaussSum/SecondPoissonScale.lean
Descent/Marks.lean
QuadraticSieve/PrincipalDifference.lean
Mellin/InverseContour.lean'''.splitlines()

# Polynomial coefficients in a,b: q-(a^2+b^2)/2 = (a-b)^2/2.
q = {(2, 0): F(1), (1, 1): F(-1), (0, 2): F(1)}
q[(2, 0)] -= F(1, 2)
q[(0, 2)] -= F(1, 2)
checks = {
    'quadratic_lattice_lower': q == {(2, 0): F(1, 2), (1, 1): F(-1), (0, 2): F(1, 2)},
    'key_and_column_degree': 5 + 2 == 7,
    'minimum_exponent': -1 - 3 == -4,
    'total_scale_cost': 7 + 1 - 2 * (-4) == 16,
    'plane_frequency_norm_factor': F(2)**2 / 3 == F(4, 3),
}
assert all(checks.values())
out = {
    'scope': 'Source-byte checks and elementary exact identities only; no Lean or analytic evaluator.',
    'source_commit_expected': '4eaee87548250b2682affda7d05d947c05554bae',
    'checks': checks,
    'source_sha256': {p: sha256((SRC / p).read_bytes()).hexdigest().upper() for p in FILES},
}
author = ROOT / 'work/qrh-campaign/agents/integration/QRH_GLOBAL_TAIL_ANALYTIC_AUDIT_2026-11-11.md'
author_hash = 'F3DAB6983C136728A4AE0A9467C44397A41F7CA4F476FDB3C16BAA5F5464B0EE'
assert sha256(author.read_bytes()).hexdigest().upper() == author_hash
pins = re.findall(r'^\| ([^|]+\.lean) \| 1-([0-9]+) \| ([A-F0-9]{64}) \|$', author.read_text(encoding='utf-8'), re.M)
assert len(pins) == 28
for p, n, h in pins:
    b = (SRC / p).read_bytes()
    assert sha256(b).hexdigest().upper() == h
    assert len(b.splitlines()) == int(n)
out['author_report_sha256'] = author_hash
out['author_source_pins_verified'] = len(pins)
Path(__file__).with_suffix('.json').write_text(json.dumps(out, indent=2) + '\n', encoding='utf-8')
print(f'{len(checks)} exact identities; {len(FILES)} independently inspected source pins')
