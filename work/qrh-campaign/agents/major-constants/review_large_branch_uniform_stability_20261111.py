"""Independent exact error-ledger checks. No numerical function values or builds."""
from pathlib import Path
from fractions import Fraction as Q
import hashlib,json
AG=Path(__file__).resolve().parents[1]
HERE=Path(__file__).resolve().parent
checks=[]
def ck(label,p):
    assert p,label
    checks.append(label)
def u(n):return Q(1,2**n)
pins={
'audit/LARGE_BRANCH_UNIFORM_STABILITY_ALLOCATION_2026-11-11.md':'6F856467F0EC3B1BD4EDA6817FC71BCA3DC6DA71F32BF96F3AE85E8D034032BA',
'audit/large_branch_stability_allocation_20261111.py':'84E00DA5BF28BB94B708BCDB0EBB604D4F87EFB1400F8157650F79402133989E',
'audit/large_branch_stability_allocation_20261111.json':'972E12C7DBA2AD2F648D9C972B1CC8DE069411F7CF5AEFEE5F7108A6E24FEA82',
'audit/LARGE_CHARACTER_COMPLETE_ERROR_CONTRACT_2026-11-11.md':'96063365898AE39625876AD5FF47D604F83A8C66BF1587F47763489C9F0A1C3D',
'audit/SHORTER_LARGE_BRANCH_WINDOW_CERTIFICATES_2026-11-11.md':'32ED0BD63C247134910FAE3BE124880EF7548422368230B59EF0F52E39FFB96E',
'major-constants/REVIEW_SHORTER_LARGE_BRANCH_WINDOW_CERTIFICATES_2026-11-11.md':'61FA9D6594264FBA3EF26AA60157CDB22C5FFD66EB52AEE0DB16C19267E5A730',
'integration/LARGE_CHARACTER_TRANSFORM_PA_COST_MODEL_2026-11-11.md':'DAEA81308B256EEDC68CDC86B20730613FD8F5EE0ECF485A9BCD772C4557F52C'}
for rel,h in pins.items():ck('pin '+rel,hashlib.sha256((AG/rel).read_bytes()).hexdigest().upper()==h)
target=json.loads((AG/'audit/large_branch_stability_allocation_20261111.json').read_text())

H=sum((Q(1,j) for j in range(1,42)),Q(0))
ck('two sided harmonic tail below nine',2*H-Q(1,41)<9)
ck('kernel bound from pi greater than three',2+Q(9,3)==5)
ck('exact author kernel comparison',2+(2*H-Q(1,41))/Q(157,50)<5)
ck('fourth root sample magnitude',Q(14003,2)<10**4)
ck('scaled Gamma amplitude',Q(27,10)*10==27 and 6<27)
ck('Rademacher height power',Q(14003,2)**5<16**16)
trueL=9*28*16
ck('actual L bound',trueL==4032)
trueY=27*trueL
ck('actual Y bound',trueY==108864)
ck('conductor square root',265800<516**2)

terms={'alpha':u(82),'head':u(63),'new_assembly':u(63),'intrinsic':u(60)}
before_scale=sum(terms.values())
ck('pre scale discrepancy',before_scale<1)
Shat=516*(trueL+before_scale)
ck('stored transform without q approximation',Shat<2**21)
ck('head norm conversion',633*u(73)<terms['head'])
ck('assembly norm conversion',633*u(73)<terms['new_assembly'])
terms['q_factor']=2**21*u(84)
terms['scale_formation']=u(63)
ck('q contribution',terms['q_factor']==u(63))
Lradius=sum(terms.values())
ck('complete L radius',Lradius<u(59))
ck('Lhat cap',trueL+Lradius<2**12)

phase_error=u(75)
cis_error=phase_error+u(75)
unit_error=u(75)*(1+cis_error)+cis_error+u(74)
ck('canonical cis radius',cis_error==u(74))
ck('unit multiplier error',unit_error<u(72))
ck('amplitude center cap',27+u(69)<28)
multiplier_error=u(69)+28*u(72)+u(69)
ck('completion multiplier error',multiplier_error<u(66))
direct_radius=27*u(59)+2**12*u(66)+u(54)
ck('direct sample',direct_radius<u(52))
# Establish positive stored sample cap before invoking it in the negative adapter.
positive_cap=trueY+u(52)
ck('positive stored sample',positive_cap<2**17)
adapted= u(52)+positive_cap*u(72)+u(55)
ck('negative adapter',adapted<u(51))
ck('negative author coarse ledger',u(52)+2**17*u(72)+u(55)<u(51))
all_cap=trueY+u(51)
ck('all stored samples',all_cap<2**17)

m=41;samples=2*m+1;adds=samples-1;rounds=samples+adds+1
ck('direct circuit counts',(samples,adds,rounds)==(83,82,166))
acc=rounds*u(59)
ck('finite arithmetic budget',acc<u(51))
ck('exact center product capacity',2**17*(1+u(72))<2**18)
ck('rounded center product capacity',2**17*(1+u(72))+u(59)<2**18)
ck('all partial sum capacity',2**17*(5+samples*u(72))+acc<2**20)
output_terms={'analytic':u(46),'sample':5*u(51),'kernel':samples*2**17*u(72),'arithmetic':u(51)}
output=sum(output_terms.values())
ck('output ratio',output/u(45)==Q(691,1024))
ck('claimed radius',output<Q(7,10)*u(45)<u(45))
ck('strict margin at stated radius',Q(7,10)-Q(691,1024)==Q(129,5120))
Delta=Q(5,64)
ck('main target is on lattice',Q(424195,64)/Delta==84839)
ck('exact main rightmost sample',(84839+m)*Delta==Q(53050,8))
ck('exact samples below cap',(84839+m)*Delta<7000)
ck('conservative guarded cap',Q(424195,64)+(m+1)*Delta<7000)
ck('negative low sample',-m*Delta==Q(-205,64))
ck('target cap alone does not suffice',7000+m*Delta>7000)

C_T=1266*202305920*2**14
ck('intrinsic p112 producer',C_T*u(112)<=u(60))
ck('intrinsic safety',2**112>=max(29961461170177,2*424706204))
ck('intrinsic completion/kernel amplification',5*27*u(60)<u(45)/200)
ck('saved scalar semantics',target['exact_output_ratio_to_2^-45']=='691/1024' and not target['production_p_selected'])
for name,want in [('kernel_l1_upper',5),('completion_amplitude_upper',27),('L_true_upper',4032),('Shat_upper',2**21),('Yhat_upper',2**17)]:
    ck('saved '+name,target[name]==want)
out={'scope':'Independent source/error-ledger review; all numerical producer inputs remain hypotheses.',
     'pins':pins,'count':len(checks),'checks':checks,'L_terms':{k:str(v) for k,v in terms.items()},
     'unit_error':str(unit_error),'completion_error':str(multiplier_error),
     'direct_radius_upper':str(direct_radius),'negative_radius_upper':str(adapted),
     'output_terms':{k:str(v) for k,v in output_terms.items()},
     'output_ratio':'691/1024','production_precision_selected':False,'sign_success':False}
path=HERE/'review_large_branch_uniform_stability_20261111.json'
with path.open('x',encoding='utf-8',newline='\n') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':len(checks),'sha256':hashlib.sha256(path.read_bytes()).hexdigest().upper()},indent=2))
