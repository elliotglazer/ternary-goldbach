"""Independent fixed paper/schema checks, without inventory or author imports."""
from pathlib import Path
from fractions import Fraction as F
import hashlib
import json

HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent
PINS={
 'major-constants/MEAN186_EXACT_TENSOR_ASSIGNMENT_PREFLIGHT_2026-11-11.md':'D804D1A6CEBBDB812A35132CC05A79B9FA8A6B3D510CCF49A9ACCFCC588F1A64',
 'independent-feasibility/MEAN_INPUT_TIGHT_CONSTANT_TENSOR_COMPANION_2026-11-11.md':'4A7EB4A925A84F70F882A2AC4A1D44B5EB6132B5C6066C12FB4DC4159EF1CDED',
 'integration/REVIEW_MEAN_INPUT_TIGHT_CONSTANT_TENSOR_COMPANION_2026-11-11.md':'A4B204E9EADBB29F51BA56CCC2FBCD417E1AF90254605E9877524970DC2C5021',
 'major-constants/EM692_EXACT_TENSOR_ASSIGNMENT_PREFLIGHT_2026-11-11.md':'01BC1696B7AF781D5638968A18E551014658B86986823B2C65F7AAE15433292A',
 'zero-sum/REVIEW_EM692_EXACT_TENSOR_ASSIGNMENT_PREFLIGHT_2026-11-11.md':'C5B6F6AF34AC536624DF5B1FAF0AE32FC22CEB670F248F007ACAE7D2AF9F09C2',
 'major-constants/COMBINED_CONDUCTOR_PRECISION_SAVED_PASS_2026-11-11.md':'EBA33B23C531312243495B9B0321597FC26D8AEBA8E1CF24626457474EA3A997',
 'integration/REVIEW_COMBINED_CONDUCTOR_PRECISION_SAVED_PASS_2026-11-11.md':'8745235D810A1F06E8661961A05EF93C8DB24574121700DF6D924AE6EC2615C4',
 'integration/REVIEW_FUTURE_P50_EXACT_TENSOR_SELECTOR_2026-11-11.md':'372F685F72449A11C970ADD855EB5CB64D52E4512B669DB1AD2FC6102FB6DD37',
 'audit/SQRT_HEAD_FINITE_EM_MAGNITUDE_2026-11-11.md':'03680BE7C2518CA0065244E840DC64203D529E26BE2E867F4C31A37652009904',
 'prime-estimates/REVIEW_SQRT_HEAD_FINITE_EM_MAGNITUDE_2026-11-11.md':'1E9D3CDE80AB9BD78FD250E9404BF9936AA782F92CD9D2BDCC799D6558869328',
 'independent-feasibility/FULL_P20_GRID60_MAGNITUDE_SCOPE_COMPANION_2026-11-11.md':'FE52146FBF51009631A9E232492A141053B9936AA90EB1B4017FE7A8D0021A5E',
 'major-constants/REVIEW_FULL_P20_GRID60_MAGNITUDE_SCOPE_2026-11-11.md':'5140949742F0BF54941815DCFC8C34DEB96133A89517FE7EBC874380A03B2EBE',
}
checks=[]
def check(name,claim):
 if not claim: raise AssertionError(name)
 checks.append(name)
pins=[]
for path,expected in PINS.items():
 with (AGENTS/path).open('rb') as stream: data=stream.read(256*1024+1)
 check('bounded paper '+path,len(data)<=256*1024)
 digest=hashlib.sha256(data).hexdigest().upper()
 check('pin '+path,digest==expected)
 pins.append({'path':path,'bytes':len(data),'sha256':digest})

S=202305920
Cg=4196258524692480
check('mean radius reserve',F(1032,2**63)+F(1,2**50)<1)
check('mean gap',186-(175+F(1001,96))==F(55,96)>0)
check('pointwise separate',690+1+F(1,2**50)<692)
check('Cg',1266*S*16384==Cg)
check('positive denominators',S<2**28<2**50)
check('old D guard',29961461170177<2**45<2**50)
check('old peak guard',849412408<2**30<2**50)
check('new q range',80-5==75 and 105-5==100)
check('five-bit denominator loss',F(S,2**75)<F(1,64))
ratio=F(32*186*64,8828*63)
check('five-bit exact ratio',ratio==F(31744,46347))
check('ratio gap',F(3,4)-ratio==F(12065,185388)>0)
check('regrid quarter',4*633*2**33<Cg)
check('combined strict target',ratio+F(633*2**33,Cg)<1)
check('five-bit safety',2**75>max(29961461170177,849412408))
check('S0 source-independent input reserve',F(633,2**75)<F(Cg,4*2**108))

# W polynomial variables (rho,S,T); no candidate evaluation.
w={(1,0,1):1,(1,1,0):-1,(0,1,1):186}
square={}
for x,a in w.items():
 for y,b in w.items():
  key=tuple(i+j for i,j in zip(x,y))
  square[key]=square.get(key,0)+a*b
check('full W square',square=={(2,0,2):1,(2,1,1):-2,(1,1,2):372,(2,2,0):1,(1,2,1):-372,(0,2,2):186**2})
check('S0 term retained',{k:v for k,v in w.items() if k[1]==0}=={(1,0,1):1})
check('selector exponent nonnegative',2*(108-50)==116 and 2*(108-108)==0)
sizes=[25110201,1911933,9568390,2672728,137719,13957,41665]
check('seven input byte total',sum(sizes)==39456593)
check('input caps',sum(sizes)<64*2**20 and max(sizes)<32*2**20)
check('declared labels',108-50+1==59)
check('admitted mask high cutoff',100-50+1==51)
check('new candidate cap',51*125400==6395400)
check('unchanged predecessor checks',3*2*125400==752400)
check('unchanged node-bit cap',59*37117==2189903)
check('unchanged kernel-bit cap',59*6004==354236)
check('all alternative node bits',(9+9+29+59)*37117==3934402)
check('all alternative kernel bits',(9+9+29+59)*6004==636424)
check('edge cap',2*37117==74234)
check('minimal records',125400+37117+6004==168521<200000)
for count,width,cap in [(125400,13,3),(37117,27,3),(6004,26,2)]:
 check('static output cap '+str(count),count*width+2**20<=cap*2**20)
check('aggregate artifacts',3+3+2+1+3==12)

result={'scope':'paper-only fixed rational/polynomial/static schema checks','checks':len(checks),
 'check_names':checks,'paper_pins':pins,'seven_json_inputs_read':False,
 'assignment_or_mask_computed':False,'author_code_run':False,
 'intrinsic_ratio':[ratio.numerator,ratio.denominator],
 'execution_authorized':False}
encoded=(json.dumps(result,indent=2)+'\n').encode()
assert len(encoded)<64*1024
with (HERE/'review_mean186_assignment_preflight_20261111.json').open('xb') as stream: stream.write(encoded)
print(json.dumps({'checks':len(checks),'bytes':len(encoded),'sha256':hashlib.sha256(encoded).hexdigest().upper()}))
