"""Exact arithmetic for the conditional moderate Turing proof. No analytic values."""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json

WORK=Path(__file__).resolve().parents[3]
A=WORK/'qrh-campaign/agents'
P={
 A/'major-constants/TURING_MODERATE_ALLOWANCE_PROOF_PATH_2026-11-11.md':'A480D72440F4A5D2C2BF539EB6D3C152428772060A7BFAF35582BCCDB525707D',
 A/'prime-estimates/UNPAIRED_ZERO_RATIO_BOUND_2026-11-11.md':'D315AE5C7B98C8A8E1042FE548B7A5FB704CEB200CFA48E36509A5A23910DB1B',
 A/'moebius/REVIEW_UNPAIRED_ZERO_RATIO_BOUND_2026-11-11.md':'B42C970619E291A81BCFD1B3FBB39498CA471FB07F7DDC47B9DB8D52BAC8D3D4',
 A/'prime-estimates/COARSE_GAMMA_PHASE_FOR_GABCKE_2026-11-11.md':'C7B701CF5B02D34142E30F38D1FFE573AE30167A561B9A759FD9964F41FC6E79',
 A/'moebius/PRINCIPAL_COUNT_FORMAL_BRIDGE_2026-11-11.md':'0A2F4766FCB77668C5461E8A63B97327EF2E6F595E66F805544A7EFA49A4A028',
 A/'integration/REVIEW_PRINCIPAL_COUNT_FORMAL_BRIDGE_2026-11-11.md':'A4401782284FFF48DFFBA27BB9DE2EFAF20E6BECB09A4F3737BDD220EA739547',
 A/'integration/ELEMENTARY_TURING_PAPER_ASSEMBLY_2026-11-11.md':'72275B5CBA95FDD4F933C2150399C214B2509D9EF91D08A494104466DC8D597C',
 A/'integration/REVIEW_ZETA_LOG_INTEGRAL_2026-11-11.md':'262ABBD71433135C1A3EC11703D28112E14DB2047B08303BA2A3829AB86B9DE2',
 A/'integration/REVIEW_FINITE_BLASCHKE_TURING_REFINEMENT_2026-11-11.md':'3488D80262797EE2C9E58D105C5AF31131C28DAD4EF2456C942B04C54F545E46',
 WORK/'ternary-goldbach/TernaryGoldbach/Explicit/XiPartial.lean':'8F47E96329BF7F1CC69F82C3AB5A422087F692BECB74EF70A7908BC323623770',
 WORK/'ternary-goldbach/TernaryGoldbach/Explicit/Datum.lean':'42F14B373106D5508F73080BEC1E57992FDCBCB7A0460182AD396534463ACDDE',
 WORK/'ternary-goldbach/TernaryGoldbach/Explicit/ZeroSums.lean':'3E5CD828CC6ADD2AF6D17F03F97E65F15720AEAF907826847EF191DEA8BCB72D',
 WORK/'ternary-goldbach/TernaryGoldbach/Explicit/ExplicitFormula.lean':'8CDDDBE6934871CA37260E435BE639A49AC33F4A8D92CBB2E33AB9D330869C35',
}
C={}
def ck(k,v):
    assert v,k
    C[k]=True
for p,s in P.items(): ck('pin:'+p.name,hashlib.sha256(p.read_bytes()).hexdigest().upper()==s)
ck('sqrt2 strictly below3/2',F(2)<F(3,2)**2)
ck('exp1 positive polynomial greater5/2',1+1+F(1,2)+F(1,6)>F(5,2))
ck('far J region coefficient',1-F(3,2)/2==F(1,4))
ck('Binet differentiated remainder coefficient',F(1,12)+F(1,6)*F(3,2)==F(1,3))
ck('Gamma real argument domain', (F(1,2)+0+0)/2==F(1,4) and (F(3,2)+1+1)/2==F(7,4))
ck('Gamma log modulus coefficient',F(7,4)**2/2==F(49,32))
dig=F(1,50)+F(49,20000)+F(1,1875)
ck('digamma error at y25',dig<F(1,20))
ck('half shift error',F(1,20)/2==F(1,40))
# log2 > 2/3 from its first integrated-geometric term plus positive remainder.
# Thus the real numerator f(x)=log(x)x^-3/2 decreases for x>=2.
ck('log2 explicit lower polynomial',2*(F(1,3)+F(1,3)**3/3)>F(2,3))
ck('unimodal numerator then denominator bound',(4+1)/F(2)==F(5,2))
tail=2*F(148,125)
ck('two Euler tails',tail==F(296,125))
resolv=F(5,2)+F(1,40)
ck('real resolvent constant',resolv==F(101,40))
lower=F(1,40)+4*resolv+tail
ck('lower intercept',lower==F(12493,1000))
ck('lower slope',4*F(1,2)-F(1,2)==F(3,2))
upper=F(1717,500)
ck('difference intercept',upper+lower==F(15927,1000))
ck('difference slope',F(3,4)+F(3,2)==F(9,4))
num18=upper+lower+F(9,4)*18
ck('b18 strict slack',18*F(157,50)-num18==F(93,1000)>0)
ck('b20 strict slack',20*F(157,50)-(upper+lower+F(9,4)*20)==F(1873,1000)>0)
ck('finite approximation epsilon coefficient',1+4==5)
ck('conditional h25 RH surplus',2-F(1,2)-2*F(18)/25==F(3,50)>0)
ck('same h25 exact count failure',1-F(1,2)-2*F(18)/25==-F(47,50))
ck('conditional b18 width threshold',2*F(18)/(2-F(1,2))==24)
ck('conditional b30.25 width threshold',2*F(121,4)/(2-F(1,2))==F(121,3))
ck('h25 and h50 grid increments',F(64,5)*25==320 and F(64,5)*50==640)
generic_intercept=upper+F(1,40)+tail
ck('generic lambda intercept',generic_intercept==F(5827,1000))
lambda_alt=F(3,2)
num_alt=generic_intercept+resolv*lambda_alt+(F(1,4)+lambda_alt/2)*18
ck('conditional lambda1.5 numerator',num_alt==F(55229,2000)<9*F(157,50))
result={'status':'PASS_CONDITIONAL_EXACT_SCALARS','number_of_checks':len(C),'checks':C,
        'digamma_error_upper':str(dig),'b18_numerator':str(num18),
        'input_pins':{str(p):s for p,s in P.items()},
        'scope':'Exact scalar identities only; finite resolvent and continuum lemmas have separate paper proofs.'}
with Path(__file__).with_suffix('.json').open('x',encoding='utf8',newline='\n') as f:
    f.write(json.dumps(result,indent=2)+'\n')
print(json.dumps({'status':result['status'],'checks':len(C)}))
