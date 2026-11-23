"""Independent fixed algebra, source pins and byte metadata. No JSON input parsing."""
from pathlib import Path
from fractions import Fraction as F
import hashlib, json, re

HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent
AUTHOR=AGENTS/'major-constants/COMBINED_CONDUCTOR_PRECISION_ASSIGNMENT_PREFLIGHT_2026-11-11.md'
EXPECTED='B563B8CC28DC1F2BCF08390BCF9385AD504432940A0C22D263BC9002037158B2'
checks=[]; pins={}
def ck(label, val):
    assert val, label
    checks.append(label)
def digest(path):
    h=hashlib.sha256()
    with path.open('rb') as f:
        for block in iter(lambda:f.read(65536),b''): h.update(block)
    return h.hexdigest().upper()
ck('frozen author',digest(AUTHOR)==EXPECTED)
ck('author size',AUTHOR.stat().st_size==20153)
text=AUTHOR.read_text(encoding='utf-8')
mdrows=re.findall(r'^\|`([^`]+\.md)`\|`([A-F0-9]{64})`\|$',text,re.M)
datarows=re.findall(r'^\|`([^`]+\.json)`\|(\d+)\|`([A-F0-9]{64})`\|$',text,re.M)
ck('seven component math pins',len(mdrows)==7)
ck('ten fixed JSON byte pins',len(datarows)==10)
total=0
for rel,expected in mdrows:
    ck('math pin '+rel,digest(AGENTS/rel)==expected)
    pins[rel]=expected
for rel,size,expected in datarows:
    size=int(size); path=AGENTS/rel
    ck('size '+rel,path.stat().st_size==size)
    ck('input cap '+rel,size<32*2**20)
    ck('data pin '+rel,digest(path)==expected)
    total+=size; pins[rel]=expected
extra={
 'major-constants/CONDUCTOR_LOCAL_PRECISION_SAVED_PASS_2026-11-11.md':'2F8F93B81BEA0FB4B133B7FEFC6FEDB2BAD2DEEC52FF07837DFA44F05D680A7D',
 'independent-feasibility/REVIEW_CONDUCTOR_LOCAL_PRECISION_SAVED_PASS_2026-11-11.md':'01FFE5405209397C176D193A43DE8436E4F59197C01FF56A172B973CADE5878C',
 'integration/SHARPER_CONDUCTOR_PRECISION_SAVED_PASS_2026-11-11.md':'62D619E84704F6A9D9DA949AF769419E4F4110A9F07C6BFC56EBED127B0DEC57',
 'major-constants/REVIEW_SHARPER_CONDUCTOR_PRECISION_SAVED_PASS_2026-11-11.md':'F213CB6BC227DFE0C5A25DD92B3DE6405165E7281678EA9224596EE7704FCF39',
 'zero-sum/REVIEW_SHORT_WINDOW_SAMPLE_GUARD_LEDGER_2026-11-11.md':'15BA744A36D5D85D1A2E4E2C797B235475A39D2258D9BA07B6472EE45A64C5AA',
}
for rel,expected in extra.items():
    ck('support pin '+rel,digest(AGENTS/rel)==expected); pins[rel]=expected
ck('total bytes',total==75419343)
ck('aggregate input cap',total<96*2**20)
Q=2**52; Ve=8828; Vw=16384; Sg=202305920; B=F(Q,Q-1); Cg=1266*Sg*Vw
ck('S upper bound',0<Sg<2**28)
ck('floor80 tensor range',F(Sg,2**80)<F(1,Q))
ck('proper B52',1<B<2 and B>F(2**72,2**72-1))
ck('actual input margin',F(8827)+F(1,2**80)<Ve<Vw)
ck('old safety guard at floor',max(29961461170177,849412408)<2**80)
ck('fallback positive coefficient',2*Vw*(Q-1)-Q*Ve>0)
ck('complete target unchanged',Cg==4196258524692480)
ck('closed guard domain',F(26525,4)<7000)

# Polynomial coefficients in (S,rho), independently expanded.
def mul(a,b):
    out={}
    for (i,j),x in a.items():
        for (k,l),y in b.items():out[i+k,j+l]=out.get((i+k,j+l),0)+x*y
    return out
linear={(1,0):Q*Ve,(0,1):Q-1}
square=mul(linear,linear)
ck('selector numerator expansion',square=={(2,0):Q*Q*Ve*Ve,(1,1):2*Q*Ve*(Q-1),(0,2):(Q-1)**2})
ck('positive rational denominator clearing',B*(Q-1)==Q)
ck('squaring preserves denominator',(B*Ve)**2*(Q-1)**2==(Q*Ve)**2)
ck('rho99 to rho100 monotonic constant',2*(Q-1)>0)
ck('rho99 to rho100 monotonic S coefficient',2*Q*Ve-Q*Ve>0)
ck('zero S does not cancel rho',(Q-1)**2>0)
ck('selected exponent range',0<=2*(108-108)<=2*(108-80)==56)
T=F(927193523,10**9*2**46)
Rf=T+135*(F(1,2**82)+4*F(1,2**63))+10*F(1,2**54)+93*F(1,2**55)+F(1,2**51)
ratio=(Rf+135*F(Cg,2**108))*2**45
ck('R108 exact',ratio==F(2804840254168152529,4294967296000000000))
ck('old ceiling',ratio<F(653052762,10**9)<F(691,1024))
caps={'legacy_tests':2*2*125400,'new_tests':29*125400,
 'edges_per_assignment':2*37117,'node_memberships':29*37117,
 'kernel_memberships':29*6004,'serialized_substantive':37117+125400+6004,
 'future_context_bound':29*220108}
expectedcaps={'legacy_tests':501600,'new_tests':3636600,'edges_per_assignment':74234,
 'node_memberships':1076393,'kernel_memberships':174116,
 'serialized_substantive':168521,'future_context_bound':6383132}
for name,val in caps.items():ck('cap '+name,val==expectedcaps[name])
ck('compact record reserve',caps['serialized_substantive']<200000)
ck('mask fits29bits',(1<<29)-1<1<<29)
ck('table caps leave artifact room',32+8+4+1<48)
ck('bit mask endpoint positions',108-80==28 and 80-80==0)
# Bound only the proposed selector arithmetic using phi<=c<=265800.
lhs=(265800*(Q*Sg*Ve+Q-1))**2*2**56
rhs=265800*((Q-1)*Cg)**2
ck('fixed selector integers below metadata limit',max(lhs.bit_length(),rhs.bit_length())<1024)
out={'author_sha256':EXPECTED,'checks':len(checks),'assertions':checks,
 'pins':pins,'input_bytes_hashed_without_parsing':total,
 'metadata_rows_parsed':0,'assignment_or_closure_fold':False,
 'caps':caps,'selector_bit_upper':max(lhs.bit_length(),rhs.bit_length()),
 'Q':Q,'V_error':Ve,'V_width':Vw,'R108_ratio':[ratio.numerator,ratio.denominator],
 'verdict_scope':'Paper composition and bounded schema; no writer or execution authorization.'}
raw=(json.dumps(out,indent=2,sort_keys=True)+'\n').encode()
ck('receipt cap',len(raw)<16384)
out['checks']=len(checks)
raw=(json.dumps(out,indent=2,sort_keys=True)+'\n').encode()
with (HERE/'review_combined_precision_preflight_20261111.json').open('xb') as f:f.write(raw)
print(json.dumps({'checks':len(checks),'bytes':len(raw),'sha256':hashlib.sha256(raw).hexdigest().upper()}))
