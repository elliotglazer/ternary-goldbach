"""Read-only frozen-input checks and one exact comparison; no evaluator imports."""
from pathlib import Path
from fractions import Fraction
import hashlib
import json
import re

ROOT = Path(__file__).resolve().parents[4]
AGENTS = ROOT / 'work/qrh-campaign/agents'
EXPLICIT = ROOT / 'work/ternary-goldbach/TernaryGoldbach/Explicit'
PINS = {
    'prime-estimates/PSI_DAMPED_SHARED_STRIP_2026-11-11.md': '8764E3EFDC940A4F302A761CFD2DE51778A91A5BF30F059F39CD0911F00CF5D0',
    'major-constants/PSI_DAMPED_SCALAR_BUDGET_2026-11-11.md': '062E77E41EF43DC783A6CFAF319454C406897A322FA7D095BCC4C0E610F54209',
    'major-constants/psi_damped_scalar_budget_20261111.py': 'FD27172A20940A71C4C1D5DEF0EFE5B140729BAD243562945A206F5CD9EFA4C5',
    'major-constants/psi_damped_scalar_budget_20261111.json': '7D137201A4452F1C7E739EFB781C150DA2B8299720AFDF2718ADC06ECC107DFE',
    'zero-sum/PSI_DAMPED_SYMMETRY_SOURCE_JOIN_2026-11-11.md': '7574552D55981DCEC5CF5A419D6CEEB6FC7A264FE4A81CBAA8D0C3880F6DAFBE',
    'audit/PRINCIPAL_SIGNS_1500_REVIEW_2026-11-11.md': 'A2961DEBB4BF2734FB048F1500D6E495E42B5DCB8439DD2412299F803A37FFFE',
    'moebius/PSI_HEAD_COUNTS_REVIEW_2026-11-11.md': '0BD2AF981C7F8A201F15597A7EE4C7B9812053C4987231C8EB02E5A6AA8BA491',
    'mellin/RESUME_PSI_ANALYTIC_COUNT_2026-11-11.md': '4648E4C454F4344D4F110E878F6CF619F5AC2128CAC91C2658E443FA3D1DF303',
    'major-constants/RESUME_PSI_ANALYTIC_COUNT_REVIEW_2026-11-11.md': '82B2A416EAE9E4F16F8147C92776AB7D5063355E3EABE828615281AA64D8C418',
    'zero-sum/FINITE_MASS_ORDER_TRANSPORT_2026-11-11.md': 'C62CB504C15A02CB954C35F8F5DAB5B551C483014F6FEE1F957FF37C444C5E0D',
    'mellin/RESUME_PSI_LOW_ZERO_REFINEMENT_2026-11-11.md': '33C01406E927F8F49F329AB52B967AA14B85B64DF7928A034C3028EFEEB91F61',
    'integration/RESUME_PSI_FROM_FINITE_STRIP_2026-11-11.md': 'D4A026F5B7190F0AA577A70A88E7BFCB79740F9CA549EE9B7AC0EF0C782B3826',
    'independent-feasibility/psi_damped_scalar_independent_20261111.json': '45E80E90DA51AF9C04DA068B19EBCC9000868CDAEE457972A29698C89CECF151',
}

def main():
    rows = []
    def check(path, expected):
        raw = path.read_bytes()
        actual = hashlib.sha256(raw).hexdigest().upper()
        assert actual == expected, (str(path), actual, expected)
        rows.append({'path': path.relative_to(ROOT).as_posix(), 'sha256': actual, 'bytes': len(raw)})
    for name, pin in PINS.items():
        check(AGENTS / name, pin)
    main_text = (AGENTS / next(iter(PINS))).read_text(encoding='utf-8')
    source_pins = re.findall(r'\| ([A-Za-z]+\.lean) \| `([0-9A-F]{64})` \|', main_text)
    assert len(source_pins) == 10
    for name, pin in source_pins:
        check(EXPLICIT / name, pin)
    scalar = json.loads((AGENTS / 'independent-feasibility/psi_damped_scalar_independent_20261111.json').read_text())
    bound = Fraction(scalar['full_scaled_upper'])
    assert bound == Fraction(2392484205639, 250000000000000)
    assert bound < Fraction(6, 625)  # .0096, stronger than the receipt's .0099 label
    script = Path(__file__).with_name('psi_damped_scalar_independent_20261111.py')
    result = {'status': 'PASS_PIN_BINDING_AND_EXACT_POINT0096_COMPARISON',
              'frozen_inputs': rows,
              'independent_scalar_script_sha256': hashlib.sha256(script.read_bytes()).hexdigest().upper(),
              'independent_full_upper': str(bound),
              'point0096_margin': str(Fraction(6, 625) - bound),
              'scope': 'Hash checks and exact rational comparison only. No author/evaluator import or rerun.'}
    out = Path(__file__).with_suffix('.json')
    with out.open('x', encoding='utf-8') as stream:
        json.dump(result, stream, indent=2)
        stream.write('\n')
    print(json.dumps({'status': result['status'], 'pins': len(rows),
                      'receipt_sha256': hashlib.sha256(out.read_bytes()).hexdigest().upper(),
                      'independent_scalar_script_sha256': result['independent_scalar_script_sha256'],
                      'margin': result['point0096_margin']}))

if __name__ == '__main__':
    main()
