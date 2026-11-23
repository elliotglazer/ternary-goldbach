"""Fixed proof-budget and typed-count checks only; no values or inventory."""
from pathlib import Path
from fractions import Fraction as F
import hashlib,json
ROOT=Path(__file__).resolve().parent.parent
HERE=Path(__file__).resolve().parent
PINS={
'moebius/ELEMENTARY_HURWITZ_LEAF_BASELINE_2026-11-11.md':'0541F20C55B843683E3C496F8AEA63036A8A7AAF55A49C4F2B97ACC3FAC17C9D',
'integration/REVIEW_ELEMENTARY_HURWITZ_LEAF_BASELINE_2026-11-11.md':'11EA2E715600A6F7E3A3646A64C21F645FB89038B915BF24A01C13D2AC4566DA',
'integration/SHARED_HURWITZ_EM_SEED_CIRCUIT_2026-11-11.md':'1E1D5099D398EE978D635729873F4D3941BC186BD91D086198B39962DF8E564E',
'zero-sum/GRID_ELEMENTARY_ANCHOR_REUSE_2026-11-11.md':'E564A8DDEC5F0AD69F5CF22DFC89147F81EA165B6E6D17B4CF0EFB0EEA3824AF',
'zero-sum/REDUCED_NONPRINCIPAL_PLATT_COST_MODEL_2026-11-11.md':'B3718D22BE11EBE5503EB2124E0B690D49B428E0000D5CD763317367ADB60AFC',
'moebius/platt-reuse-sources/int-l-func5.11.cpp':'3D9B2B23B35129899048C23806AA42A4F2B08BE10304611AC9E1C913300FE852',
'audit/LARGE_CHARACTER_COMPLETE_ERROR_CONTRACT_2026-11-11.md':'96063365898AE39625876AD5FF47D604F83A8C66BF1587F47763489C9F0A1C3D',
'audit/LARGE_BRANCH_UNIFORM_STABILITY_ALLOCATION_2026-11-11.md':'6F856467F0EC3B1BD4EDA6817FC71BCA3DC6DA71F32BF96F3AE85E8D034032BA',
'independent-feasibility/SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md':'B7E781617D7E9E041CB340549A52387EC32303CFDE086B7BD5170448905BD266',
'audit/SQRT_HEAD_FINITE_EM_MAGNITUDE_2026-11-11.md':'03680BE7C2518CA0065244E840DC64203D529E26BE2E867F4C31A37652009904',
'integration/GUARDED_RESIDUE_EVALUATION_FRONTIER_2026-11-11.md':'C24D4CB1338EDDFD46398C5B6D2BB1CA80CA61500B648B1A41039BFEECB6CA8D',
'integration/NORMALIZED_TRANSFORM_SHORT_GUARD_JOIN_2026-11-11.md':'ADDED6BC91975C40C6029A591F4486782932C92B144D39465AC5E0F3CB597E58',
'zero-sum/REDUCED_PREFIX_SELECTED_P27_SEED_COST_2026-11-11.md':'A7021F2EB52E7FCE844BB054864689197B212EF174AAF180B87E027ECA30E758',
'integration/LARGE_CHARACTER_TRANSFORM_PA_COST_MODEL_2026-11-11.md':'DAEA81308B256EEDC68CDC86B20730613FD8F5EE0ECF485A9BCD772C4557F52C',
'integration/REVIEW_MEAN_INPUT_TIGHT_CONSTANT_TENSOR_COMPANION_2026-11-11.md':'A4B204E9EADBB29F51BA56CCC2FBCD417E1AF90254605E9877524970DC2C5021',
'integration/REVIEW_SCALED_SEED_HEIGHT_RECURRENCE_2026-11-11.md':'981E17F2357099061E8AD51A98DB5EFCE2D57DD15AAABEF48CF13122D7614DED'}
BP=Path('work/qrh-blueprint/SCALED_SEED_HEIGHT_RECURRENCE_2026-11-11.md')
BH='8ABDD8A1F991AF9FEACE49908E5BA865EC3FD5804311CAE73AB9D80A4456D413'
checks=[]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest().upper()
def ck(name,test):
 if not test:raise AssertionError(name)
 checks.append(name)
for p,h in PINS.items():ck('pin '+p,sha(ROOT/p)==h)
ck('height source pin',sha(BP)==BH)
eta=F(1,2**128);hlog=F(1,2**137)
ck('integer domain',265800<2**19 and 265800<516**2)
ck('45-term log tail',3*45==128+7)
logratio=19*F(1,128)+F(133,2048)+F(1,4)
ck('log full reserve',logratio==F(949,2048)<1)
ck('small step phase',F(5,64)*(19+eta)<2)
ck('cis term choice',73==((118+27+1)//2))
ck('cis tail fixed factorial anchor',__import__('math').factorial(16)>2**44)
ck('cis later-ratio proof endpoint',F(4,17)<F(1,4))
ck('cis Taylor tail exponent',21-2*73<=-124)
ck('cis inner round',81*F(1,2**131)<F(1,2**124))
step=F(5,64)*eta+F(1,2**124)+81*F(1,2**131)+F(1,2**122)
eps=F(1,2**120);delta=F(1,2**96)
ck('complete step error',step<eps)
ck('whole time-grid domain',F(7000,1)/F(5,64)==89600<90000)
ck('growth geometric denominator',90000*eps<F(1,2))
bound=2*F(1,2**98)+2*90000*(eps+eps)
ck('B recurrence radius',bound<delta)
ck('state and step norms',1+delta<2 and 1+eps<2)
head=265800*(2*delta+delta**2)+F(1,2**100)
ck('head point radius',head<F(1,2**75))
ck('nonnegative scaled H sum',633*F(1,2**75)<F(1,2**63))
ck('retained pointwise magnitude',516+head<517)
ck('conductor cache magnitude',516+265800*delta<517)
ck('raw product magnitude for output range',(516+265800*delta)*(1+delta)<517)
ck('final head candidate range',517*2**100+F(1,2)<2**110)
ck('exact assembled source range',173+517<690<2**10)
ck('q factor optional reuse',delta<F(1,2**84))
# Conservative exact integer capacities for the specified four-real circuit.
ck('state magnitude capacity',(1+delta)*2**120<2**121)
ck('step magnitude capacity',(1+eps)*2**122<2**123)
ck('conductor multiplication raw',19+121==140)
ck('conductor accepted magnitude',(516+265800*delta)*2**120<2**130)
ck('recurrence raw product/coordinate',121+123==244 and 244+1==245)
ck('recurrence raw witness addition',2**245+2**121<2**246)
ck('head raw product/coordinate',130+121==251 and 251+1==252)
ck('head round shift',240-100==140)
ck('head raw witness addition',2**252+2**139<2**253)
ck('head candidate witness side',2**110*2**140+2**140<2**251)
def M(a,b):
 m=(a+7)//8;n=(b+7)//8
 return 5*m*n+2*min(m,n)+1
def A(a):return 2*((a+7)//8)+1
cores={'B_update_P':4*M(121,123),'B_update_A':2*A(245)+4*A(246),
'C_cache_P':2*M(121,19),'head_P':4*M(130,121),'head_A':2*A(252)+4*A(253),
'exact_input_add_A':2*A(111)}
ck('fixed unsigned core rows',cores=={'B_update_P':5252,'B_update_A':378,'C_cache_P':494,'head_P':5572,'head_A':390,'exact_input_add_A':58})
ck('dense state payload',(2*((122+7)//8)+2*((124+7)//8))*265800==17011200)
out={'scope':'Source audit and fixed scalar/typed-count checks. No values, inventory or population fold.',
'checks':len(checks),'assertions':checks,'pins':PINS,'blueprint_pin':{str(BP):BH},
'log_error_fraction':str(logratio),'step_error_over_eps':str(step/eps),
'B_error_over_delta':str(bound/delta),'head_error_upper':str(head),
'unsigned_core_examples':cores,
'counts':'Symbolic I,Jstar,N_C,N_R only; no current family aggregation',
'limitations':['New paper producer, not implemented or independently accepted','Full P20 source unchanged','Existing EM head counts do not cover raw residue head','No runtime winner']}
p=HERE/'raw_head_grid100_producer_20261111.json'
with p.open('x',encoding='utf-8',newline='\n') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':len(checks),'receipt_bytes':p.stat().st_size,'sha256':sha(p)}))
