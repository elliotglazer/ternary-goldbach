"""Independent six-case rational review; no author import or value evaluation."""
from pathlib import Path
from fractions import Fraction as Q
import hashlib
import json

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
# Resolve from the campaign directory, without relying on invocation cwd.
BLUE = AGENTS.parent.parent / 'qrh-blueprint'
checks = 0

def check(ok):
    global checks
    assert ok
    checks += 1

pins = {
    BLUE / 'SHORT_GUARD_HORNER_DOMAIN_ADMISSION_2026-11-11.md': '6DF38245BECCD8A35B94F98787C4DEF64EEB9EFCF9FB07E54E1D9EC554C48DF2',
    BLUE / 'short_guard_horner_admission_20261111.py': '750C046F8B5B79D78E0A3263DC39C642F99AAB6802838002E86DAA87C71FA28B',
    BLUE / 'short_guard_horner_admission_20261111.json': 'C8EA9BEC79CB00DBDCB3FB14D8C00F142592737D3300267CE29F89F2C5BE01B2',
    AGENTS / 'moebius/JOINT_HORNER_LENGTH_PRECISION_TRADEOFF_2026-11-11.md': 'AEAB2BDCF2D767546A7F410CC463D17DFB6C4639BFFC94D771574C134DA36E63',
    AGENTS / 'independent-feasibility/REVIEW_JOINT_HORNER_LENGTH_PRECISION_TRADEOFF_2026-11-11.md': '84B062431F1A7C49C2191E8C4576A6CC6B870A431A5BB3E7BBDDF59150F437D7',
    AGENTS / 'integration/SHORT_WINDOW_SAMPLE_GUARD_LEDGER_2026-11-11.md': '3E447AE8E8EEEC847E95CFB7473879EB2B56CFC5E467863404D3ECDBB0180606',
    AGENTS / 'zero-sum/REVIEW_SHORT_WINDOW_SAMPLE_GUARD_LEDGER_2026-11-11.md': '15BA744A36D5D85D1A2E4E2C797B235475A39D2258D9BA07B6472EE45A64C5AA',
    AGENTS / 'prime-estimates/SHORTER_HURWITZ_OUTPUT_ORDER_2026-11-11.md': '0EAED4F960DFC4F590564A9B8A86E9C22BB621FCE362CCAB7A13D2D3976A1D2A',
    AGENTS / 'integration/REVIEW_SHORTER_HURWITZ_OUTPUT_ORDER_2026-11-11.md': 'B15D0C3B15B8005A6B3DC3CFE1A1CDE157448B83904950487CD124F87647536E',
    AGENTS / 'prime-estimates/STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md': '9B777E02CA50392D0BE0E6582807439E938970961A045B63758EB66A9EEE55D2',
    HERE / 'REVIEW_STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md': '1028156181791D6F0CD4CB0555A2625999CBF091ADD72F3CD9841BFAAD55F3F6',
}
for path, pin in pins.items():
    check(hashlib.sha256(path.read_bytes()).hexdigest().upper() == pin)

def taylor_bound(x, n):
    # Product recurrence instead of the author's power/factorial expression.
    ans = Q(1266)
    for k in range(1, n + 1):
        ans *= x / k
    return ans

shape = [100]*4 + [97] + [95]*3 + [89] + [87]*3 + [81] + [79]*3 + [71]*4
caps = [Q(84839*5,64), Q(84880*5,64), Q(7000)]
check(caps[1] == Q(26525,4))
check(caps[1] - caps[0] == Q(205,64))
check(Q(205,64) < caps[0] < caps[1] < 7000)
shift = taylor_bound(Q(5*7028,32768),28)
source = Q(844,2**100)
saved = json.loads((BLUE/'short_guard_horner_admission_20261111.json').read_text())
check(len(saved['rows']) == 6)
rows=[]
for K,b in [(18,94),(19,93)]:
    grids = [x+b-100 for x in shape[:K]]
    eps = [Q(3,4*2**g) for g in grids]
    # Horner error recurrence: top conversion, then product round and conversion.
    E = eps[-1]
    for j in range(K-2,-1,-1):
        E = E/4 + 2*eps[j]
    ratios=[]
    for V in caps:
        target=taylor_bound((V+K)/32768,K)
        ratio=(target+shift+source+633*E)*2**82
        row=next(r for r in saved['rows'] if r['K']==K and Q(r['V'])==V)
        check(row['b0']==b and row['grids']==grids)
        for key, val in [('target',target),('shift',shift),('source',source),('evaluation',E),('alpha_ratio',ratio)]:
            check(Q(row[key])==val)
        upper=row['alpha_ratio_billionth_upper']
        check(Q(upper-1,10**9)<ratio<Q(upper,10**9))
        check(row['admitted']==(ratio<1))
        ratios.append(ratio)
        rows.append({'K':K,'b0':b,'V':str(V),'alpha_ratio':str(ratio),'upper_billionths':upper,'admitted':ratio<1})
    check(ratios[0]<ratios[1]<ratios[2])
    check(ratios[1]<1)
    check((ratios[2]<1)==(K==19))
    check(all(g<=100 for g in grids) and 100-b in [6,7])

check(8932-8858==74 and 2448-2420==28)
check(8932+2420==11352 and 8858+2448==11306)
out={'scope':'Six rational cases only; source and cost inheritance reviewed on paper. No values, enumeration, author execution, or cost inventory.',
     'checks':checks,'pins':{str(p):h for p,h in pins.items()},'rows':rows,
     'cost_subtotals_inherited_not_repriced':{'18_94':[8932,2420],'19_93':[8858,2448]}}
dest=HERE/'review_short_guard_horner_domain_20261111.json'
with dest.open('x',encoding='utf-8') as f:
    json.dump(out,f,indent=2); f.write('\n')
print(json.dumps({'checks':checks,'sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()}))
