"""Read/hash and exact scalar review only; no target imports or evaluations."""
from pathlib import Path
from fractions import Fraction as F
import hashlib
import json
import re

ROOT = Path(__file__).resolve().parents[4]
AGENTS = ROOT / 'work/qrh-campaign/agents'
MATHLIB = Path('C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib')
TG = ROOT / 'work/ternary-goldbach/TernaryGoldbach'
INPUTS = {
    'prime-estimates/TRANSLATED_MASS_DIGAMMA_JOIN_2026-11-11.md': 'DAE3AC2179E3DC43FC0C91DA0297D412DF01A444D96AE3ED27214BE165166115',
    'zero-sum/FINITE_MASS_ORDER_TRANSPORT_2026-11-11.md': 'C62CB504C15A02CB954C35F8F5DAB5B551C483014F6FEE1F957FF37C444C5E0D',
}

def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest().upper()

def main():
    rows = []
    sources = {}
    for rel, expected in INPUTS.items():
        p = AGENTS / rel
        actual = sha(p)
        assert actual == expected, (rel, actual)
        rows.append({'path': str(p), 'sha256': actual})
        for source, pin in re.findall(r'^\| ([^|]+?\.lean) \| `([0-9A-F]{64})` \|', p.read_text(encoding='utf-8'), re.M):
            old = sources.setdefault(source, pin)
            assert old == pin
    for rel, expected in sorted(sources.items()):
        p = (TG if rel.startswith('Explicit/') else MATHLIB) / rel
        actual = sha(p)
        assert actual == expected, (rel, actual)
        rows.append({'path': str(p), 'sha256': actual})
    assert F(1,2)+F(3,4)*F(7,10) == F(41,40)
    assert F(1,2)+1-F(1,2)+F(1,2)+F(41,40) == F(101,40)
    assert 3-F(101,40) == F(19,40) > 0
    result = {'status':'PASS_SOURCE_PINS_AND_EXACT_SCALARS', 'author_reports':len(INPUTS),
              'unique_source_files':len(sources), 'pins':rows,
              'constant':'101/40', 'gap_to_3':'19/40',
              'scope':'Source bytes and rational arithmetic only. The analytic argument is reviewed in the companion Markdown; no Lean validation or numerical function evaluation.'}
    out = Path(__file__).with_suffix('.json')
    with out.open('x', encoding='utf-8') as f:
        json.dump(result, f, indent=2)
        f.write('\n')
    print(json.dumps({'status':result['status'],'sources':len(sources),'output_sha256':sha(out)}))

if __name__ == '__main__':
    main()
