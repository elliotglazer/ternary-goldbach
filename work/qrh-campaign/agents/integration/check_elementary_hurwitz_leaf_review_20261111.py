"""Independent rational bounds and formal-polynomial identities, no leaf values."""
from fractions import Fraction as Q
from math import factorial
from pathlib import Path
import hashlib
import json

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
REPO = AGENTS.parents[2]
MATHLIB = Path('C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib')
count = 0

def check(p):
    global count
    assert p
    count += 1

def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest().upper()

def run():
    fixed = {
        'moebius/ELEMENTARY_HURWITZ_LEAF_BASELINE_2026-11-11.md':'0541F20C55B843683E3C496F8AEA63036A8A7AAF55A49C4F2B97ACC3FAC17C9D',
        'moebius/elementary_hurwitz_leaf_scalars_20261111.py':'089A83420A8950D3EDDC48F42231C7D1AF262313FE7A315150DB1F35D8B6770E',
        'moebius/elementary_hurwitz_leaf_scalars_20261111.json':'49051BA99167C7F8C5CD330621027762FC834939F4CEBA6AB9CCFA6CB8DEB509',
        'prime-estimates/INTERVAL_PRIMITIVES_SOURCE_PLAN_2026-11-11.md':'BD64557F5ABFDDCA57717B180BE6AB93B888351547F3B75505B25226F190B2CC',
        'major-constants/FINITE_EM_RATIONAL_ELEMENTARY_BUDGET_2026-11-11.md':'50D1FFB0385A0F2FCE3BA9EF3BBB4FFD3BAC5A0103E95A8329E79A25D524A541',
        'major-constants/FINITE_EM_INNER_ROUNDING_ALLOCATION_2026-11-11.md':'60B4BC4414A75B90BF036E0CBA2CAB6F12C270CF7DE1F45C767341D872D383E9',
        'zero-sum/REVIEW_FINITE_EM_INNER_ROUNDING_ALLOCATION_2026-11-11.md':'E2AFC3467382506F4D68CDB9E7AA0307C911B0F2195032E505C4EC8E69D6401B',
        'prime-estimates/REVIEW_SIGNED_DYADIC_ROUNDING_WITNESS_PLAN_2026-11-11.md':'F0D115608E1742220E4CAB26EA8DA930D24F2D1D410ED34609EA7B7DC4DABDA5',
        'integration/SHARED_HURWITZ_EM_SEED_CIRCUIT_2026-11-11.md':'1E1D5099D398EE978D635729873F4D3941BC186BD91D086198B39962DF8E564E',
    }
    for name,h in fixed.items(): check(sha(AGENTS/name)==h)
    sources = {}
    for name in ['Analysis/Complex/Exponential.lean','Analysis/SpecialFunctions/Complex/Arctan.lean','Analysis/SpecificLimits/Normed.lean','Analysis/SpecialFunctions/Trigonometric/Arctan.lean','Analysis/Real/Sqrt.lean','Data/Nat/Sqrt.lean','Algebra/Order/Round.lean']:
        sources['Mathlib/'+name]=sha(MATHLIB/'Mathlib'/name)
    sources['TernaryGoldbach/Prelim/RamareHarm.lean']=sha(REPO/'work/ternary-goldbach/TernaryGoldbach/Prelim/RamareHarm.lean')
    check(sources['Mathlib/Analysis/Complex/Exponential.lean']=='564992EF54C295F97D4E00CA0D07A396C068F331D09EFD29B85E4863511986F0')
    check(sources['Mathlib/Analysis/Real/Sqrt.lean']=='A3F48822DEC1066FAB121744C120630DB2207A7124CFE4077969D07529E70273')
    check(sources['Mathlib/Data/Nat/Sqrt.lean']=='259AF8DB2BE15E3A6DF78CC96743E4D6BD7D48DD831C1D2598CFDADDF891658B')
    check(factorial(16)>2**44)
    check(Q(8,3)**9>3389)
    check(Q(133,256)<1)
    check(Q(1,16)+Q(145,1536)+Q(1,4)<1)
    check(Q(100000,6)+Q(1,2)<2**15)
    check(Q(81,8192)<Q(1,64))
    check(Q(10000,2**17)<Q(1,8))
    check(Q(7,16)<1)
    saved=json.loads((AGENTS/'moebius/elementary_hurwitz_leaf_scalars_20261111.json').read_text())
    rows=[]
    for p in sorted(set(range(1,13))|{118,383,417}):
        delta=Q(1,2**p); eta=delta/2**17; epi=delta/2**22
        N=(p+25)//3; M=(p+31)//4; n=max(16,(p+28)//2)
        check(3*N>=p+23 and 4*M>=p+28 and 2*n>=p+27)
        logtail=Q(2,3**(2*N+1)*(2*N+1))*Q(9,8)
        check(logtail<Q(1,2**(3*N)))
        logerror=12*logtail+21*eta/256+eta/4
        check(logerror<=Q(133,256)*eta<eta)
        atantail=Q(20,(2*M+1)*5**(2*M+1))
        pierror=atantail+Q(145,6)*epi/256+epi/4
        check(atantail<epi/16 and pierror<epi)
        coarse_lower=16*(Q(1,5)-Q(1,375))-Q(4,239)
        check(coarse_lower-epi>3 and Q(16,5)+epi<4)
        exptail=Q(2*4**n,factorial(n))
        check(exptail<delta/64)
        # Formal variable polynomials, no value of log, arctan, cis or sqrt.
        poly=[]
        for j in range(N-1,-1,-1): poly=[Q(1,2*j+1)]+poly
        check(poly==[Q(1,2*j+1) for j in range(N)])
        alt=[]
        for j in range(M-1,-1,-1): alt=[Q(1,2*j+1)]+[-c for c in alt]
        check(alt==[Q((-1)**j,2*j+1) for j in range(M)])
        cis=[Q(1)]
        for j in range(n-2,-1,-1): cis=[Q(1)]+[c/(j+1) for c in cis]
        check(cis==[Q(1,factorial(j)) for j in range(n)])
        # Forward error weights, independently unrolled at the worst radius4.
        err=Q(0)
        for j in range(n-2,-1,-1): err=1+Q(4,j+1)*err
        check(err<81)
        match=next((r for r in saved['rows'] if r['p']==p),None)
        if match:
            check(Q(match['log_error_upper'])==logerror)
            check(Q(match['pi_error_upper'])==pierror)
            check(Q(match['cis_taylor_upper'])==exptail)
            check((match['log_terms'],match['atan_terms'],match['cis_terms'])==(N,M,n))
        rows.append({'p':p,'N':N,'M':M,'n':n,'log_error_over_eta':str(logerror/eta),'pi_error_over_eta_pi':str(pierror/epi),'cis_tail_over_delta':str(exptail/delta),'cis_rounding_weight':str(err)})
    return {'scope':'Exact rational bounds and formal polynomial coefficients only; no elementary values.', 'checks':count,'input_pins':fixed,'source_pins':sources,'rows':rows}

if __name__=='__main__':
    out=run()
    HERE.joinpath('check_elementary_hurwitz_leaf_review_20261111.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
    print(out['checks'],'exact checks passed')
