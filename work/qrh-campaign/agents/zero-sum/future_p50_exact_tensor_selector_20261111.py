"""Fixed endpoint/rational checks. No precision, conductor or angle enumeration."""
from pathlib import Path
from fractions import Fraction as F
from hashlib import sha256
import json

HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent
ROOT=HERE.parents[3]
PINS={
 'zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md':'4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4',
 'independent-feasibility/BLUESTEIN_NORMALIZATION_CONTEXT_INTERFACE_2026-11-11.md':'412A96766A6DF164F1332D09BD8CBF41959DB6C0BF9388C3EFD87C94ECBC0ED7',
 'independent-feasibility/SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md':'B7E781617D7E9E041CB340549A52387EC32303CFDE086B7BD5170448905BD266',
 'audit/REVIEW_SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md':'8431B9FF6B172F8ED36644413C359F5B8E2FEB58D9EBF0F88E500F152113EBAD',
 'integration/TIGHT_TENSOR_PRODUCT_TRANSFORM_PRECISION_RULE_2026-11-11.md':'DB2E3B9FF269E551901622B844AF579D7FCE12045F71B66D947CA392FD1A928C',
 'zero-sum/REVIEW_TIGHT_TENSOR_PRODUCT_TRANSFORM_PRECISION_RULE_2026-11-11.md':'EC2FD8569DF2D74B758F6FDD9DC58153BD0FF6B662919ECE43B014C0E064BC26',
 'prime-estimates/SHARED_UNIT_ROOT_CHIRP_PROJECTION_2026-11-11.md':'01C4FE83F6F642D47977825696B70F308156F5E3B2532EBA75A62255A3B03EEB',
 'zero-sum/REVIEW_SHARED_UNIT_ROOT_CHIRP_PROJECTION_2026-11-11.md':'C1D3C4F7AE61B3A1176BC0792C7F2B27CAEAEEB5BE86080770DEC1438AA586C5',
 'zero-sum/SUBGRID_REGRID_ARITHMETIC_COST_INTERFACE_2026-11-11.md':'E2457D3CA0E4436575DBAEA81413D91601312033AC6086233CFB7977D790225D',
 'audit/REVIEW_SUBGRID_REGRID_ARITHMETIC_COST_INTERFACE_2026-11-11.md':'56B27935FF994E3F25F735825196076DF72C8DBC33D2A61D4787B61E3BBDD5F0',
 'prime-estimates/CLARIFICATION_SIGNED_DYADIC_CURRENT_EXPONENT_2026-11-11.md':'8400322999DE07ED203F1556EEC5D8771B9E2910533BFF231C96E244C05BDF03',
}
checks=[]
def ck(name,value):
    assert value,name
    checks.append(name)
for name,pin in PINS.items():
    ck('pin '+name,sha256((AGENTS/name).read_bytes()).hexdigest().upper()==pin)
blue=ROOT/'work/qrh-blueprint/LOWER_TRANSFORM_PRECISION_ALLOCATION_2026-11-11.md'
bluepin='EEBC987DD386E2ED50CC7F56C82714FC1EF51C8A3DF22C2579FFC108C0C1BD39'
ck('old allocation pin',sha256(blue.read_bytes()).hexdigest().upper()==bluepin)
Sg=202305920;Cg=1266*Sg*2**14
ck('59 candidate labels',108-50+1==59)
ck('mask spare bits',64-59==5)
ck('old local guard',29961461170177<2**45<2**50)
ck('old sum guard',2*424706204<2**30<2**50)
ck('exact tensor denominator positive',F(Sg,2**50)<F(1,2**22)<F(1,2))
ck('fallback global constant',Cg==4196258524692480)
ck('regrid max d',100-50==50)
ck('regrid raw left bound',2**114+2**49<2**115)
ck('regrid raw right bound',2**114+2**50<2**115)
ck('regrid common raw signed bytes',(116+7)//8==15)
ck('regrid max remainder bytes',(50+7)//8==7 and 50%8==2)
ck('same input margin',8827+F(1,2**50)<8828<16384)
ck('candidate Q range complete',8826+F(1,2**51)<2**14)
ck('root gap endpoints',110-108==2 and 110-50==60)
ck('root projection guard',F(1,4)+F(3,4)==1 and F(1,2)<F(9,16))
ck('root coordinate integer range',F(1,4)+F(1,2)<1)
ck('root raw residual signed width',((2**110+1)+2**110).bit_length()+1==113)
ck('root raw double signed width',(2*((2**110+1)+2**110)).bit_length()+1==114)
ck('root floor raw bound',2**110+2**61-1<2**111)
ck('root accepted residual max signed',(2**59).bit_length()+1==61)
ck('root unsigned doubled remainder max',(2*(2**60-1)).bit_length()==61)
ck('root accepted doubled residual max signed',(2**60).bit_length()+1==62)
ck('root floor remainder max bytes',(60+7)//8==8)
ck('root direct raw byte capacity',(114+7)//8==15)
# Verify clearing with formal polynomial coefficients in T,S,alpha,beta,rho.
def plus(*polys):
    out={}
    for pol in polys:
        for key,v in pol.items():out[key]=out.get(key,0)+v
    return {k:v for k,v in out.items() if v}
def neg(pol):return {k:-v for k,v in pol.items()}
def times(a,b):
    out={}
    for ka,va in a.items():
        for kb,vb in b.items():
            k=tuple(x+y for x,y in zip(ka,kb))
            out[k]=out.get(k,0)+va*vb
    return {k:v for k,v in out.items() if v}
T={(1,0,0,0,0):1};S={(0,1,0,0,0):1};aa={(0,0,1,0,0):1};bb={(0,0,0,1,0):1};rho={(0,0,0,0,1):1}
num=plus(times(times(rho,bb),plus(T,neg(S))),times(times(aa,S),T))
ck('formal cleared numerator',num=={(1,0,0,1,1):1,(0,1,0,1,1):-1,(1,1,1,0,0):1})
tail=F(927193523,10**9)*F(1,2**46)
fixed=tail+135*(F(1,2**82)+4*F(1,2**63))+10*F(1,2**54)+93*F(1,2**55)+F(1,2**51)
ratio=(fixed+135*F(Cg,2**108))*2**45
ck('old complete ratio unchanged',ratio==F(2804840254168152529,4294967296000000000))
ck('old ceiling',ratio<F(653052762,10**9)<F(691,1024))
record={'scope':'Fixed endpoints, formal polynomial and source pins only; no precision enumeration or inventory.',
 'checks':len(checks),'assertions':checks,'source_pins':PINS,'blueprint_pin':bluepin,
 'candidate_range':[50,108],'candidate_count':59,'assignments_computed':False,
 'R108_ratio':[ratio.numerator,ratio.denominator],
 'owned_pending_magnitude_inputs_consumed':False}
raw=(json.dumps(record,indent=2,sort_keys=True)+'\n').encode()
path=HERE/'future_p50_exact_tensor_selector_20261111.json'
with path.open('xb') as stream:stream.write(raw)
print(json.dumps({'checks':len(checks),'bytes':len(raw),'sha256':sha256(raw).hexdigest().upper()}))
