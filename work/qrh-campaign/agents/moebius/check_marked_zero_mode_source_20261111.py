"""Read-only source provenance checks. No Lean import or analytic evaluation."""
from hashlib import sha256
from pathlib import Path
import json
import re

ROOT = Path(__file__).resolve().parents[4]
SRC = ROOT / 'work/openai-math/lean/OAI/NumberTheory/DirichletL'
FILES = '''Inversion/InitialZeroModeBudget.lean
Inversion/InitialZeroModePhysical.lean
Inversion/InitialZeroMode.lean
Inversion/InitialRayAttachment.lean
Inversion/InitialTotalEnergy.lean
Descent/Marks.lean
Descent/MarkBounds.lean
Arithmetic/SquarefreeDivisors.lean
Arithmetic/LatticeCount.lean
CubicSieve/RayCoefficients.lean
CubicSieve/ConjugateProfiles.lean
CubicSieve/SupportNorms.lean
CubicSieve/FixedProfiles.lean
CubicSieve/FrequencyCutoffs.lean
QuadraticSieve/PrincipalDifference.lean
QuadraticSieve/TruncatedSecondTransfer.lean
GaussSum/ActiveConductor.lean
GaussSum/SexticRadialPoisson.lean
PrimeRows/IdealGenerators.lean
Mellin/InverseContour.lean
Hecke/FiniteEulerFactors.lean'''.splitlines()
FILES += ['CubicSieve/FirstPassage.lean', 'GaussSum/SecondPoissonScale.lean',
          'GaussSum/RayCharacters.lean', 'PrimeRows/NormFiberExtraction.lean']

out = {
    'scope': 'Source-byte inventory only; relevant bodies inspected in companion review, not whole transitive proofs.',
    'expected_source_commit': '4eaee87548250b2682affda7d05d947c05554bae',
    'files': [],
}
for name in FILES:
    data = (SRC / name).read_bytes()
    out['files'].append({'path': name, 'lines': len(data.splitlines()),
                         'sha256': sha256(data).hexdigest().upper()})

author = ROOT / 'work/qrh-campaign/agents/integration/QRH_MARKED_ZERO_MODE_ANALYTIC_AUDIT_2026-11-11.md'
author_hash = 'AC63CCA803785C2E4ECBE0AB8C9373206CA19ADE741BBD8A26B5AB5D168BF8DB'
assert sha256(author.read_bytes()).hexdigest().upper() == author_hash
pins = re.findall(r'^\| `([^`]+\.lean)` \| `([A-F0-9]{64})` \|$', author.read_text(encoding='utf-8'), re.M)
assert len(pins) == 27
for name, digest in pins:
    assert sha256((SRC / name).read_bytes()).hexdigest().upper() == digest
out['author_report_sha256'] = author_hash
out['author_source_pins_verified'] = len(pins)
Path(__file__).with_suffix('.json').write_text(json.dumps(out, indent=2) + '\n', encoding='utf-8')
print(f'{len(FILES)} inspected-source pins; {len(pins)} author-source hashes verified')
