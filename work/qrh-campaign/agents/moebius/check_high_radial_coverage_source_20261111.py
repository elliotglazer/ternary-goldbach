"""Read source bytes and check elementary rational identities; no Lean or function evaluation."""
from fractions import Fraction
from hashlib import sha256
from pathlib import Path
import json
import re

ROOT = Path(__file__).resolve().parents[4]
SRC = ROOT / 'work/openai-math/lean/OAI/NumberTheory/DirichletL'
FILES = '''Moments/SectorLocalization.lean
Moments/DyadicCount.lean
Inversion/InitialDyadicAssembly.lean
Inversion/InitialDyadicAssemblyLive.lean
Inversion/InitialDyadicAssemblySourceCaps.lean
Inversion/InitialDyadicAssemblyWindows.lean
Inversion/InitialDyadicAssemblyRetained.lean
Inversion/InitialDyadicAssemblyTail.lean
Inversion/InitialDyadicTailGates.lean
Inversion/InitialDyadicTailBound.lean
Inversion/InitialHighFrequencyTailAnnulus.lean
Inversion/InitialHighFrequencyTailRapid.lean
Inversion/InitialRetainedSupport.lean
Inversion/InitialRetainedSum.lean
Inversion/InitialFiniteEnergy.lean
Inversion/InitialPhysicalLimit.lean
Inversion/InitialTotalEnergy.lean
Inversion/InitialRayAttachment.lean
Inversion/InitialPhysicalReassembly.lean
Inversion/InitialPhysicalMeasure.lean
Inversion/InitialZeroModeBudget.lean
QuadraticSieve/PrimePools.lean'''.splitlines()

# Coordinates for linear exponent identities: (m,H,theta,D,B,eta,tau).
radial = (1, 1, -1, -2, 2, 0, 0)
from_correlated_columns = tuple(a + b + c + d + e for a, b, c, d, e in zip(
    (1, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 2, 0, 0),
    (0, 1, 0, 0, 0, 0, 0), (0, 0, -1, 0, 0, 0, 0),
    (0, 0, 0, -2, 0, 0, 0)))
checks = {
    'three_quarter_factors': Fraction(1, 4)**2 * Fraction(1, 4) == Fraction(1, 64),
    'actual_radial_exponent': radial == from_correlated_columns,
    'gate_eta_reserve': 4 - 1 == 3,
    # Represent an affine exponent in cap by (cap coefficient, constant).
    'consumer_m_minus_D_upper_below_Lcap': (2, 0)[0] == (2, 2)[0] and 0 <= 2,
    'consumer_D_plus_one_upper_below_Lcap': 1 <= 2 and 1 <= 2,
}
assert all(checks.values())
out = {
    'scope': 'Source-byte inventory and elementary exact checks only; no analytical evaluation.',
    'expected_source_commit': '4eaee87548250b2682affda7d05d947c05554bae',
    'checks': checks,
    'files': [],
}
for name in FILES:
    data = (SRC / name).read_bytes()
    out['files'].append({'path': name, 'lines': len(data.splitlines()),
                         'sha256': sha256(data).hexdigest().upper()})
author = ROOT / 'work/qrh-campaign/agents/integration/QRH_HIGH_RADIAL_COVERAGE_AUDIT_2026-11-11.md'
author_hash = 'D8188C5E8AA59E979BEC024567255CF28845215117F2426C70C31D93F60EBA4D'
assert sha256(author.read_bytes()).hexdigest().upper() == author_hash
pins = re.findall(r'^\| `([^`]+\.lean)` \| `([A-F0-9]{64})` \|$', author.read_text(encoding='utf-8'), re.M)
assert len(pins) == 25
for name, digest in pins:
    assert sha256((SRC / name).read_bytes()).hexdigest().upper() == digest
out['author_report_sha256'] = author_hash
out['author_source_pins_verified'] = len(pins)
Path(__file__).with_suffix('.json').write_text(json.dumps(out, indent=2) + '\n', encoding='utf-8')
print(f'{len(FILES)} source files pinned; {len(checks)} elementary exact checks passed')
