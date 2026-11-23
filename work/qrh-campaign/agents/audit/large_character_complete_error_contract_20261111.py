"""Pin bounded source reads and recheck only intrinsic precision metadata."""
from pathlib import Path
from fractions import Fraction
import hashlib,json

ROOT=Path(__file__).resolve().parents[4]
BASE=ROOT/'work/qrh-campaign/agents'
FILES=[
('integration/LARGE_CHARACTER_TRANSFORM_PA_COST_MODEL_2026-11-11.md','DAEA81308B256EEDC68CDC86B20730613FD8F5EE0ECF485A9BCD772C4557F52C','sections1-2: exact stored inputs and intrinsic precision'),
('independent-feasibility/REVIEW_LARGE_CHARACTER_TRANSFORM_PA_COST_MODEL_2026-11-11.md','1A0DE2B920A63B27D7E0AB8E6C0DF38F9DCD56872C290C9333783D99A461004E','intrinsic-only acceptance'),
('major-constants/VARIABLE_DEGREE_GRID_ROUNDED_DIFFERENCES_2026-11-11.md','79F8EA3F6F8BE2AA0EC61E335BB068EA2690A3AA84CBB4BBF39D6878FC4F1B55','sections1-5: full alpha inequality and exact export'),
('audit/REVIEW_VARIABLE_DEGREE_GRID_ROUNDED_DIFFERENCES_2026-11-11.md','F77403A37293F22EBCBEA84B4FED2FC2ABED02317B9E0C4F8C50132528DB6E91','independent source-prefix/error review'),
('moebius/JOINT_HORNER_LENGTH_PRECISION_TRADEOFF_2026-11-11.md','AEAB2BDCF2D767546A7F410CC463D17DFB6C4639BFFC94D771574C134DA36E63','sections2,5: matched alpha and output contract'),
('independent-feasibility/REVIEW_JOINT_HORNER_LENGTH_PRECISION_TRADEOFF_2026-11-11.md','84B062431F1A7C49C2191E8C4576A6CC6B870A431A5BB3E7BBDDF59150F437D7','accepted matched error contract'),
('prime-estimates/SHORTER_HURWITZ_OUTPUT_ORDER_2026-11-11.md','0EAED4F960DFC4F590564A9B8A86E9C22BB621FCE362CCAB7A13D2D3976A1D2A','sections1-3: genuine Taylor and finite-shift comparison'),
('integration/REVIEW_SHORTER_HURWITZ_OUTPUT_ORDER_2026-11-11.md','B15D0C3B15B8005A6B3DC3CFE1A1CDE157448B83904950487CD124F87647536E','section4: downstream weaker-radius compatibility'),
('zero-sum/REDUCED_NONPRINCIPAL_PLATT_COST_MODEL_2026-11-11.md','B3718D22BE11EBE5503EB2124E0B690D49B428E0000D5CD763317367ADB60AFC','sections2,6: raw residue identity, head, interpolation radius'),
('integration/R132900_POST_TRANSFORM_CERTIFICATE_COST_2026-11-11.md',None,'sections2-4: sign radius, Y source and closure'),
('zero-sum/REVIEW_R132900_POST_TRANSFORM_CERTIFICATE_COST_2026-11-11.md',None,'reviewed post-transform scope'),
('zero-sum/SELECTED_SIGN_CHECKER_COST_SUPPLEMENT_2026-11-11.md',None,'sections3,6: actual Y, dependency union and missing margins'),
('prime-estimates/FINITE_U_HARDY_NORMALIZATION_2026-11-11.md','06C9D3BF785BB183339D8EC64BE0B5AAD05331184C35356F575A8C126ADB724E','sections1-3,5: exact proxy/phase/count distinctions'),
('zero-sum/REVIEW_FINITE_U_HARDY_NORMALIZATION_2026-11-11.md',None,'review of same exact sign interface'),
('zero-sum/FAMILY_PRODUCTION_ENDPOINT_ADDENDUM_2026-11-11.md','6759192EED071A69B064D793CA307FD563BCB436ACCFB28238C77C5AB74E87F4','closed count and exact F_eta normalization'),
('integration/ELEMENTARY_TURING_PAPER_ASSEMBLY_2026-11-11.md','72275B5CBA95FDD4F933C2150399C214B2509D9EF91D08A494104466DC8D597C','closed-count integral upper interface'),
('major-constants/TURING_SPECTRAL_SURPLUS_REDUCTION_2026-11-11.md','6E7CD152D57679AFBEF754D9A1C0060AAA3F28C6E2DB1F6EFB4BD24A6B15C401','sections1-2: finite-RH-only strict +2 test'),
('independent-feasibility/REVIEW_FINITE_RH_PAIR_DEFICIT_2026-11-11.md',None,'same-character reflection and exact-list limitation'),
('major-constants/RECONCILED_NONPRINCIPAL_OPERATION_SCHEDULE_2026-11-11.md','483B6F4DC38CE5113ADF33419AEC9187BDA03A080FC7ED87ABB1727BBAAAE716','sections1-2: current domains and four requested prefixes'),
('moebius/platt-reuse-sources/int-l-func5.11.cpp','3D9B2B23B35129899048C23806AA42A4F2B08BE10304611AC9E1C913300FE852','lines575-616,697-740,884-893: head/DFT/completion pipeline'),
]

def main():
    pins={};checks=0
    for rel,expected,scope in FILES:
        p=BASE/rel;h=hashlib.sha256(p.read_bytes()).hexdigest().upper()
        if expected is not None:assert h==expected;checks+=1
        pins[str(p)]=dict(sha256=h,read_scope=scope)
    p=ROOT/'work/ternary-goldbach/TernaryGoldbach/MajorArcs/GRH.lean'
    h=hashlib.sha256(p.read_bytes()).hexdigest().upper()
    assert h=='89C6DF8490955EEA8F4141498BCA6D163355C2E7765C9ECD09F8CEE5B257A070';checks+=1
    pins[str(p)]=dict(sha256=h,read_scope='lines32-37: actual inclusive GRHUpTo consumer')
    D=29961461170177;Sold=424706204;Smixed=202305920;V=2**14;C=1266*Smixed*V
    rows=[]
    for s,p in ((60,112),(82,134),(100,152)):
        bounds=[D,2*Sold,C*2**s]
        assert all(2**p>=b for b in bounds);checks+=1
        assert any(2**(p-1)<b for b in bounds);checks+=1
        assert p==(max(bounds)-1).bit_length();checks+=1
        assert Fraction(C,2**p)<=Fraction(1,2**s);checks+=1
        rows.append(dict(epsilon_T=str(Fraction(1,2**s)),p=p,intrinsic_radius=str(Fraction(C,2**p)),
                         scope='Only transform-of-stored-inputs arithmetic after exact conductor magnitude scaling.'))
    out=dict(status='SOURCE_PIN_AND_INTRINSIC_SELECTOR_CHECK',checks=checks,pins=pins,
             intrinsic_coefficient=C,precision_rows=rows,
             no_total_sign_budget_selected=True,no_spectral_values=True)
    dest=Path(__file__).with_suffix('.json')
    with dest.open('x',encoding='utf8',newline='\n') as f:json.dump(out,f,indent=2);f.write('\n')
    print(json.dumps(dict(checks=checks,pins=len(pins),receipt_sha256=hashlib.sha256(dest.read_bytes()).hexdigest().upper())))

if __name__=='__main__':main()
