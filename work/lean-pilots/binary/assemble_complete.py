"""Concatenate owned source for measuring complete proof construction, not imports."""
from pathlib import Path
import hashlib,json
here=Path(__file__).resolve().parent
names=['BinarySupport.lean','PilotPrimes.lean','BinaryPilot.lean']
pieces=[]
for i,name in enumerate(names):
    src=(here/name).read_text(encoding='utf-8')
    if i:src='\n'.join(line for line in src.splitlines() if not line.startswith('import '))+'\n'
    pieces.append(f'/- Owned component: {name} -/\n'+src)
(here/'CompleteBinaryPilot.lean').write_text('\n'.join(pieces),encoding='utf-8')
(here/'ImportBaseline.lean').write_text('\n'.join(line for line in (here/names[0]).read_text(encoding='utf-8').splitlines()
                                                 if line.startswith('import '))+'\n',encoding='utf-8')
(here/'Audit.lean').write_text('import CompleteBinaryPilot\n\n'
    '#print axioms BinaryPilot.binary_interval\n'
    '#check BinaryPilot.binary_interval\n'
    'example : ∀ n : Nat, 3999999997356523524 ≤ n → n ≤ 3999999997356523650 →\n'
    '    Even n → ∃ p q : Nat, Nat.Prime p ∧ Nat.Prime q ∧ n = p+q :=\n'
    '  BinaryPilot.binary_interval\n',encoding='utf-8')
(here/'CorruptCoverage.lean').write_text('import CompleteBinaryPilot\n'
    '-- A deliberately false union certificate must be rejected.\n'
    'example : BinaryPilot.unionMasks (BinaryPilot.slices_0.map BinaryPilot.sliceMask) = 2^32-2 := rfl\n',encoding='utf-8')
print(json.dumps({name:hashlib.sha256((here/name).read_bytes()).hexdigest().upper()
                  for name in names+['CompleteBinaryPilot.lean','ImportBaseline.lean','Audit.lean','CorruptCoverage.lean']},indent=2))
