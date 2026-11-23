"""Independent fixed algebra and byte pins; no imported producers or inventories."""
from pathlib import Path
from fractions import Fraction
import hashlib
import json
import re

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
ROOT = AGENTS.parents[2]
F = Fraction
checks = 0


def check(proposition):
    global checks
    checks += 1
    if not proposition:
        raise AssertionError(checks)


pins = {
    'independent-feasibility/SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md': 'B7E781617D7E9E041CB340549A52387EC32303CFDE086B7BD5170448905BD266',
    'independent-feasibility/SUBGRID100_ERROR_MAGNITUDE_COMPANION_2026-11-11.md': '39EC80DDC3388A9E470647CC4486D448108BB1FFD0D4CC58C13B61FBE3A4A761',
    'independent-feasibility/subgrid100_transform_input_regrid_20261111.py': '472687A9316E2727AB1A15A195829FCE0FDF5CACDA3AE0C8DF1E8AD0098FF3D3',
    'independent-feasibility/subgrid100_transform_input_regrid_20261111.json': '829D99B26395FA8C9D0D4B4C89A2D04AE193BF39BEED5E7C762654AF3BC33A28',
    'independent-feasibility/subgrid100_error_magnitude_20261111.py': '9B316F1718C4695D3B45B18E02D565009CB303F712A18021CBA4AAF15E45A9E6',
    'independent-feasibility/subgrid100_error_magnitude_20261111.json': 'AE3AAD40AB7DE3D4D537D263AE3FA7F13C99968794B10A5C9F6550DB556FD6C8',
}
base = (AGENTS / next(iter(pins))).read_text(encoding='utf-8')
source_rows = re.findall(r'^\|([^|]+)\|([0-9A-F]{64})\|$', base, re.M)
check(len(source_rows) == 12)
for description, digest in source_rows:
    name = description.split(', sections')[0].split(':')[0]
    pins[name] = digest
for name, digest in pins.items():
    path = ROOT / name if name.startswith('work/') else AGENTS / name
    check(hashlib.sha256(path.read_bytes()).hexdigest().upper() == digest)

# Reconstruct the unchanged radius in units of 2^-45, term by term.
cg = 2 * 633 * 202305920 * 16384
check(cg == 4196258524692480)
fixed_scaled = (F(927193523, 2 * 10**9)
                + 135 * (F(1, 2**37) + F(4, 2**18))
                + F(10, 2**9) + F(93, 2**10) + F(1, 2**6))
radius_scaled = fixed_scaled + F(135 * cg, 2**63)
check(radius_scaled == F(2804840254168152529, 4294967296000000000))
check(radius_scaled < F(653052762, 10**9) < F(691, 1024) < 1)

# The source bound is stronger than any generic M+1<=16384 premise.
check(8192 + 633 + 1 == 8826)
check(F(8827) + F(1, 2**80) < 8828 < 16384)
check(2 * 8828 == 17656)
check(F(8828, 16384) == F(2207, 4096) > F(1, 2))
check(29961461170177 < 2**45 < 2**80)
check(2 * 424706204 < 2**30 < 2**80)
check(265800 < 516**2 < 633**2)
check(516 * 4033 < 2**21 and 4033 < 2**12)
check(F(1, 4) + F(1, 4) < 1)  # squared complex nearest-round radius/u

# Fixed precision-domain capacities only, no conductor rows or gate values.
for p in range(80, 109):
    rho = int(p < 100)
    check(F(8827) + F(rho, 2**p) < 8828)
    check(F(cg + 633 * rho, 2**p) + F(1, 2**82) + F(4, 2**63) < 1)
    check(633 * (2 * 8828 * 202305920 + rho) <= cg + 633 * rho)
    if p < 100:
        d = 100 - p
        check(1 <= d <= 20)
        check((2**114 - 1) + 2**(d - 1) < 2**115)
        check((2**(p + 14) - 1) * 2**d + 2**d - 1 < 2**115)
    else:
        check(0 <= p - 100 <= 8)

# Check examples by cross-multiplied integer inequalities, without sqrt.
for v, p, s in ((16384, 82, 2), (16384, 84, 12), (16384, 90, 771),
                (8828, 80, 1), (8828, 81, 2), (8828, 82, 5)):
    check(633 * (2 * v * s + 1) * 2**(108 - p) <= cg)
check(cg**2 == (2 * 16384)**2 * (633 * 202305920)**2)

result = {
    'scope': 'fixed rational and hash checks only; quantified proofs in review',
    'checks': checks,
    'pins': pins,
    'V_error': 8828,
    'V_width': 16384,
    'R108_over_2^-45': [radius_scaled.numerator, radius_scaled.denominator],
    'producer_imports': False,
    'inventory_or_function_values': False,
}
raw = (json.dumps(result, indent=2) + '\n').encode()
check(len(raw) < 16384)
# The recorded count excludes the serialization-cap assertion itself.
out = HERE / 'review_subgrid100_regrid_20261111.json'
with out.open('xb') as handle:
    handle.write(raw)
print(json.dumps({'recorded_checks': result['checks'], 'bytes': len(raw),
                  'sha256': hashlib.sha256(raw).hexdigest().upper()}))
