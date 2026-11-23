"""Fixed converter-capacity checks. No numerical source values or inventory."""
from pathlib import Path
from fractions import Fraction as F
import hashlib
import json

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
PINS = {
    'audit/EM692_REGRID_CONVERTER_CAPACITIES_2026-11-11.md':'99FC177B6F200502407802E7A8FF6E98196EBF51A932A2B68EC38B693A46EB35',
    'audit/SQRT_HEAD_FINITE_EM_MAGNITUDE_2026-11-11.md':'03680BE7C2518CA0065244E840DC64203D529E26BE2E867F4C31A37652009904',
    'prime-estimates/REVIEW_SQRT_HEAD_FINITE_EM_MAGNITUDE_2026-11-11.md':'1E9D3CDE80AB9BD78FD250E9404BF9936AA782F92CD9D2BDCC799D6558869328',
    'zero-sum/SUBGRID_REGRID_ARITHMETIC_COST_INTERFACE_2026-11-11.md':'E2457D3CA0E4436575DBAEA81413D91601312033AC6086233CFB7977D790225D',
    'audit/REVIEW_SUBGRID_REGRID_ARITHMETIC_COST_INTERFACE_2026-11-11.md':'56B27935FF994E3F25F735825196076DF72C8DBC33D2A61D4787B61E3BBDD5F0',
    'independent-feasibility/SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md':'B7E781617D7E9E041CB340549A52387EC32303CFDE086B7BD5170448905BD266',
    'prime-estimates/EFFICIENCY_PA_SIGNED_DYADIC_BRIDGE_2026-11-11.md':'EBF10D893D5CF50E8B45FD6EB5A3EE54F44BB99389741961A09E299BD311ADBD',
    'prime-estimates/CLARIFICATION_SIGNED_DYADIC_CURRENT_EXPONENT_2026-11-11.md':'8400322999DE07ED203F1556EEC5D8771B9E2910533BFF231C96E244C05BDF03',
}
checks=[]
def check(name, condition):
    if not condition:
        raise AssertionError(name)
    checks.append(name)
pins=[]
for relative, expected in PINS.items():
    with (AGENTS/relative).open('rb') as stream:
        data=stream.read(256*1024+1)
    check('bounded paper '+relative, len(data)<=256*1024)
    digest=hashlib.sha256(data).hexdigest().upper()
    check('pin '+relative, digest==expected)
    pins.append({'path':relative,'sha256':digest,'bytes':len(data)})

check('assembled magnitude',173+517==690)
check('source integer capacity',690*2**100<2**110)
check('smallest candidate completeness margin',(1024-690)*2**50>F(1,2))
check('largest gap',100-50==50)
check('smallest rounding gap',100-99==1)
check('independent shifted candidate capacity',(50+10)+(100-50)==110)
check('raw left capacity',2**110+2**49<2**111)
check('raw right capacity',2**110+2**50<2**111)
check('complex squared coordinate errors',2*F(1,2)**2<1)
check('source signed bits',110+1==111)
check('raw signed bits',111+1==112)
check('largest rounded output signed bits',99+11==110)
check('largest exact output signed bits',108+11==119)
check('exact branch largest shift',108-100==8)
check('exact branch endpoint exponent',110+(108-100)==118)
check('raw capacity bytes',(112+7)//8==14)
check('old capacity bytes',(116+7)//8==15)
check('partial remainder byte',(50+7)//8==7 and 50-6*8==2)
A=lambda bits:2*((bits+7)//8)+1
check('new unsigned magnitude adder',A(111)==29)
check('new padded adder',A(112)==29)
check('old padded adder',A(116)==31)
check('new complex core',4*A(111)==116)
check('old complex core',4*A(116)==124)
check('matched core difference',4*(A(116)-A(111))==8)

# Fixed signed half-tie examples only, not a coordinate/digit scan.
for name,n,Q,t in [('positive half',1,1,0),('negative half',-1,0,0),('zero',0,0,1),('negative integer',-2,-1,1)]:
    check(name+' witness',n+1==2*Q+t and 0<=t<2)
    check(name+' residual',-1<=n-2*Q<1)

result={'scope':'fixed scalar and paper pins only','checks':len(checks),'check_names':checks,'paper_pins':pins,
        'source_values_or_inventory_read':False,'precision_enumeration':False,'author_program_run':False,
        'unsigned_core_new':116,'unsigned_core_predecessor':124,'complete_cost_or_precision_admission':False}
encoded=(json.dumps(result,indent=2)+'\n').encode()
assert len(encoded)<64*1024
with (HERE/'review_em692_regrid_capacities_20261111.json').open('xb') as stream:
    stream.write(encoded)
print(json.dumps({'checks':len(checks),'bytes':len(encoded),'sha256':hashlib.sha256(encoded).hexdigest().upper()}))
