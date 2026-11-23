"""Source bytes and exact rational identities only; no Lean or analytic evaluation."""
from fractions import Fraction as F
from hashlib import sha256
from pathlib import Path
import json
import re

ROOT = Path(__file__).resolve().parents[4]
SRC = ROOT / 'work/openai-math/lean/OAI/NumberTheory/DirichletL'
FILES = '''Detector/CentralPrimeSum.lean
Detector/CentralAllSlots.lean
Detector/CentralBranchProduct.lean
Detector/CentralRepeatedSubset.lean
Detector/CentralRepeatedProduct.lean
Detector/CentralRepeatedChoices.lean
Detector/CentralRepeatedSum.lean
Detector/RowReflectedAllocation.lean
Detector/RayPhaseBins.lean
Detector/RayPhaseAmplitude.lean
Detector/RayCharacterFamily.lean
PrimeRows/CubePhaseBins.lean
PrimeRows/CentralTargetCost.lean
PrimeRows/CentralSlotSum.lean
PrimeRows/CentralSplit.lean
PrimeRows/CentralCosts.lean
PrimeRows/CentralProduct.lean
PrimeRows/CentralNormalized.lean
PrimeRows/CentralRamified.lean
Hecke/PrimeRow.lean
Hecke/PrimeRay.lean
Hecke/PrimeNonprincipal.lean
Hecke/PrimeAmplitudeActual.lean
Hecke/PrimeAmplitudeBins.lean
Hecke/PrimeAmplitudeScale.lean
Hecke/PrimeScale.lean
Hecke/PrimeBin.lean
Hecke/PrimeAnnular.lean
Hecke/PrimePowers.lean
Hecke/PrimeDyadicSource.lean
Hecke/PrimeDyadicScaled.lean
Hecke/PrimeDyadicScale.lean
Hecke/PrimeDyadicBuffered.lean
Hecke/PrimeDyadicControl.lean
Hecke/PrimeDyadicEstimates.lean
Hecke/PrimeDyadicContour.lean
Hecke/PrimeDyadicEuler.lean
Hecke/PrimeDyadic.lean
Hecke/DyadicTailBudget.lean'''.splitlines()

checks = {
    'phase_decay': F(17, 50) - F(1, 2) == -F(4, 25),
    'inverse_frequency_real': 1 - F(17, 50) == F(33, 50),
    'row_epsilon_before_slots': 3 + 4 == 7,
    'row_epsilon_after_slots_constant': 7 + 1 == 8,
    'height_constant': 0 + 2 == 2,
    'height_epsilon': 2 + 2 == 4,
    'external_dyadic_exponent': 2 - F(1, 2) == F(3, 2),
    'buffer_left_real': F(51, 100) > F(1, 2),
    'maximum_buffer_width': 2 - F(51, 100) < 2,
}
assert all(checks.values())
author = ROOT / 'work/qrh-campaign/agents/integration/QRH_CENTRAL_PRIME_ANALYTIC_AUDIT_2026-11-11.md'
author_hash = 'BC79FCD3332ABCF42E19A29ABC594685C98599C4038079957C09795190328376'
assert sha256(author.read_bytes()).hexdigest().upper() == author_hash
author_pins = re.findall(r'^\| ([^|]+\.lean) \| ([A-F0-9]{64}) \|$', author.read_text(encoding='utf-8'), re.M)
assert len(author_pins) == 43
assert all(sha256((SRC / p).read_bytes()).hexdigest().upper() == h for p,h in author_pins)
out = {
    'scope': 'Exact rational identities and byte hashes only; not a Lean build or analytic validation.',
    'source_commit_expected': '4eaee87548250b2682affda7d05d947c05554bae',
    'checks': checks,
    'author_report_sha256': author_hash,
    'author_source_pins_verified': len(author_pins),
    'source_sha256': {p: sha256((SRC / p).read_bytes()).hexdigest().upper() for p in FILES},
}
target = Path(__file__).with_suffix('.json')
target.write_text(json.dumps(out, indent=2) + '\n', encoding='utf-8')
print(f'{len(checks)} exact checks; {len(FILES)} source hashes; {target.name}')
