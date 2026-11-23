"""Exact metadata reconciliation only; no analytic or primality evaluations."""
from pathlib import Path
from hashlib import sha256
from fractions import Fraction
import json

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent / 'qrh-campaign' / 'agents'
PINS = {
 'zero-sum/MIXED_RADIX_CHARACTER_TRANSFORM_EFFICIENCY_2026-11-11.md': 'C2DF53947BA4EC8B401148F63EBDE8EAB95C5C6EA029317EDF4C326D38A87E01',
 'zero-sum/mixed_radix_character_inventory_20261111.json': '2AC4DBAF9D0C41D1DFD8006AC280619DFF6C3059D7DA7FAEF6F1C477D2CE4D3F',
 'zero-sum/conditional_r138000_mixed_inventory_20261111.json': '0D48AF7655976B5B0A0BC2750CA92F26E30B33E1F45540015627EEFFC5C60D5F',
 'major-constants/EFFICIENCY_ORIGINAL_RH_MODEST_CUTOFF_V2_2026-11-11.md': '33A3D9645BD9A8F856DD13A40028FF314A2769E8938FA90050A194C048C84517',
 'integration/REVIEW_EFFICIENCY_ORIGINAL_RH_MODEST_CUTOFF_2026-11-11.md': '3DDA3A1073AD671AA418816D96966D07B0AA0B08D686C67E701B2B81302DC3A2',
 'independent-feasibility/REVIEW_ORIGINAL_RH_MODEST_CUTOFF_V2_DEPENDENCIES_2026-11-11.md': '4B4D08E33694B97F63F11DBB9995259E71D5130E0A05578219A501F84DBC9F9D',
 'major-constants/EFFICIENCY_ORIGINAL_RH_CUTOFF_FRONTIER_2026-11-11.md': '92D9973CE90C99748317A4D029057B7D3A2522BC1DE30A5EA300F4A3EA61FEE6',
 'integration/REVIEW_EFFICIENCY_ORIGINAL_RH_CUTOFF_FRONTIER_2026-11-11.md': 'F4AA21A1C9E3AA3D5EEFDF3A03E750C09781CA37D47DC61E762AF1B97EC96EB8',
 'zero-sum/CONDITIONAL_R138000_SPECTRAL_INVENTORY_2026-11-11.md': 'C14E47FBD3EFBC67C541076B99CCF2949FA2BEDFA9217EFD3C87B9AA8617E78B',
 'zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md': '4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4',
 'audit/REVIEW_MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md': '1268986720865E47569FC5E568546194C0A61EDC9AE80CDD78502CDC77385537',
 'prime-estimates/EFFICIENCY_COMPLEX_THREE_PRODUCT_2026-11-11.md': '83D8C2953A4AEE557786904C09CED8433972876AA0B6698EBA8BF2C3B5F39EF4',
 'prime-estimates/ERRATUM_COMPLEX_ADD_WIDTHS_2026-11-11.md': 'AD8DC7692F68A44BF0D10BB6E348DD0D8A3368FF76FC5A94BBF07BFD76030362',
 'independent-feasibility/REVIEW_EFFICIENCY_COMPLEX_THREE_PRODUCT_2026-11-11.md': '684D012748AD53D492A46B643CEF78550D5CF7359AFFECEB7048E9B5118F39DE',
 'prime-estimates/EFFICIENCY_NTT_GRID_REUSE_2026-11-11.md': '84F02A3867A371313E81CC89664293986C52EC515EED2B2046BFCB0D94097738',
 'moebius/REVIEW_EFFICIENCY_NTT_GRID_REUSE_2026-11-11.md': '7301FB9AEBEF376903826333A559ABCF7195801F505E2ED191ADC6A5D2C24779',
}
for rel, expected in PINS.items():
    actual = sha256((AGENTS / rel).read_bytes()).hexdigest().upper()
    assert actual == expected, (rel, actual)

# Independent character-count metadata using the multiplicative formula for
# primitive characters. This does not construct/evaluate any character.
limit = 300000
spf = list(range(limit + 1))
for p in range(2, limit + 1):
    if spf[p] == p:
        for k in range(p*p, limit + 1, p):
            if spf[k] == k:
                spf[k] = p
primitive = [0] * (limit + 1)
primitive[1] = 1
for n in range(2, limit + 1):
    p, m, exponent = spf[n], n, 0
    while m % p == 0:
        m //= p
        exponent += 1
    local = p-2 if exponent == 1 else (p-1)**2 * p**(exponent-2)
    primitive[n] = primitive[m] * local
labels = {}
for radius, expected in [(150000,5543640187),(140000,4829158813),(138000,4692136729)]:
    conductors = list(range(3,radius+1,2)) + list(range(4,2*radius+1,4))
    total = sum(primitive[n] for n in conductors)
    assert total == expected
    labels[str(radius)] = {'conductor_indices':len(conductors),'primitive_labels':total}

# Quoted circuit counts, not an independent reconstruction of the FFT plan.
g_old, a_old = 4890157406463512, 11446911736111484
g_138, a_138 = 2736537742659260, 5668480164659994
ratios = {
 'labels_138_over_150': Fraction(labels['138000']['primitive_labels'],labels['150000']['primitive_labels']),
 'complex_products_138_mixed_over_150_whole_axis':Fraction(g_138,g_old),
 'real_products_138_fixed_three_over_150_four':Fraction(3*g_138,4*g_old),
 'real_additions_138_fixed_three_over_150_four':Fraction(2*a_138+3*g_138,2*a_old+2*g_old),
}
out = {
 'scope':'pins, independent character-label metadata, and conditional arithmetic composition only',
 'pins':PINS, 'labels':labels,
 'quoted_circuit_counts':{'old_G':g_old,'old_A':a_old,'R138_G':g_138,'R138_A':a_138},
 'ratios':{k:{'numerator':v.numerator,'denominator':v.denominator,'decimal_display':float(v)} for k,v in ratios.items()},
 'runtime_claim':False, 'actual_certificates_checked':False,
}
(HERE / 'reconcile_cutoff_precision_reuse_20261111.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps({'pins':len(PINS),'labels':labels,'ratios':out['ratios']},indent=2))
