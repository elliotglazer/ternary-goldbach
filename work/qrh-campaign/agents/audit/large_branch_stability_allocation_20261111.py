"""Exact rational stability metadata only; no samples or analytic evaluation."""
from fractions import Fraction as Q
from pathlib import Path
import hashlib,json
HERE=Path(__file__).resolve().parent
checks=[]
def ck(name,value):
    assert value,name
    checks.append(name)
def u(n):return Q(1,2**n)

H40=sum(Q(1,j) for j in range(1,41))
H41=H40+Q(1,41)
ck('finite kernel l1',2+(H40+H41)/Q(157,50)<5)
ck('completion amplitude',Q(14003,2)<10**4 and Q(27,10)*10==27)
ck('L magnitude power',Q(14003,2)**5<16**16)
ck('L magnitude',9*28*16==4032)
ck('sqrt conductor',265800<516**2)
D=u(82)+2*u(63)+u(60)
ck('scaled transform approximation below one',D<1)
ck('stored transform magnitude',516*4033<2**21)
ck('per-head or alignment bound',633*u(73)<u(63))
ck('factor error contribution',2**21*u(84)==u(63))
rL=u(82)+4*u(63)+u(60)
ck('complete L radius',rL<u(59))
ck('stored L magnitude',4032+u(59)<2**12)
root=u(75);cis=2*u(75);unitround=u(74)
unit=root*(1+cis)+cis+unitround
ck('root and canonical phase unit error',unit<u(72))
ck('amplitude center magnitude',27+u(69)<28)
multiplier=u(69)+28*u(72)+u(69)
ck('complete completion multiplier',multiplier<u(66))
direct=27*u(59)+2**12*u(66)+u(54)
ck('direct sample radius',direct<u(52))
ck('actual Y magnitude',27*4032==108864)
ck('all stored sample magnitudes',108864+u(51)<2**17)
negative=u(52)+2**17*u(72)+u(55)
ck('inverse channel radius',negative<u(51))
ck('finite arithmetic allocation',166*u(59)<u(51))
output=u(46)+5*u(51)+83*2**17*u(72)+u(51)
ck('complete output radius',output<Q(7,10)*u(45))
ck('strictly inside stated target',output<u(45))
ck('current target and conservative guards',Q(424195,64)+42*Q(5,64)<7000)
ck('intrinsic transform contribution',135*u(60)<Q(1,200)*u(45))
constant=1266*202305920*2**14
ck('p112 intrinsic bound',constant*u(112)<=u(60))
ck('p112 safety',2**112>=29961461170177 and 2**112>=2*424706204)
pins={
'LARGE_CHARACTER_COMPLETE_ERROR_CONTRACT_2026-11-11.md':'96063365898AE39625876AD5FF47D604F83A8C66BF1587F47763489C9F0A1C3D',
'SHORTER_LARGE_BRANCH_WINDOW_CERTIFICATES_2026-11-11.md':'32ED0BD63C247134910FAE3BE124880EF7548422368230B59EF0F52E39FFB96E',
'../major-constants/REVIEW_SHORTER_LARGE_BRANCH_WINDOW_CERTIFICATES_2026-11-11.md':'61FA9D6594264FBA3EF26AA60157CDB22C5FFD66EB52AEE0DB16C19267E5A730',
'../integration/LARGE_CHARACTER_TRANSFORM_PA_COST_MODEL_2026-11-11.md':'DAEA81308B256EEDC68CDC86B20730613FD8F5EE0ECF485A9BCD772C4557F52C'}
for path,h in pins.items():ck('pin '+path,hashlib.sha256((HERE/path).read_bytes()).hexdigest().upper()==h)
out={'scope':'conditional producer tolerances; no actual values or signs','checks':checks,'count':len(checks),
     'kernel_l1_upper':5,'completion_amplitude_upper':27,'L_true_upper':4032,
     'Shat_upper':2**21,'Yhat_upper':2**17,'direct_sample_radius_upper':'2^-52',
     'all_sample_radius_upper':'2^-51','kernel_radius_upper':'2^-72',
     'output_radius_upper':'(7/10)*2^-45','exact_output_ratio_to_2^-45':str(output/u(45)),
     'intrinsic_p_case':112,'production_p_selected':False,'pins':pins}
with HERE.joinpath('large_branch_stability_allocation_20261111.json').open('x',encoding='utf8',newline='\n') as f:
    json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':len(checks),'output_ratio':str(output/u(45))}))
