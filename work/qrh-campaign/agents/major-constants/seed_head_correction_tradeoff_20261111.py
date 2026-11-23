"""Exact scalar/metadata witnesses for V7000,D8192,N1500,m256. No function values."""
from fractions import Fraction as F
from pathlib import Path
from hashlib import sha256
import json,math
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[3]
checks={}
def ck(name,test):
    assert test,name
    checks[name]=True
V,D,N,m,P=7000,8192,1500,256,27
W=V+32+2*m;r=F(17,20);b=N+2
eta,delta,u=F(1,2**100),F(1,2**118),F(1,2**122)
R=F(4*b,1)/F(4*m-1,2)*r**(2*m)
ck('E_ratio',F(W,6*(N+1))<r<1)
ck('scaled_k_ratio',F(W,D*(N+1))<1)
ck('remainder',R<F(1,2**116))
ck('R_factor',F(V+32,D)<F(5,4))
ck('E_error',1/(1-r)<7)
ck('lambda_factor',F(6,D)<F(1,2))
ck('S_norm',4*r/(1-r*r)<13)
ck('S_rounding',31*m==7936)
ck('S_component_rounding',F(7936,6)+1<1324)
ck('Z_round_error_small',(14*b+1330)*u<1)
ck('Ehat_bound',1+7*u<2)
head_delta=5*N;head_u=5*N*P+3*N+1
end_delta=2*b+3;end_u=36*b+2679
err=(head_delta+end_delta)*delta+(head_u+end_u+1)*u+R
ck('selected_P27_error',err<eta/4)
ck('all_P32_error',(head_delta+end_delta)*delta+(5*N*32+3*N+1+end_u+1)*u+R<eta/4)
C=3*N+7
ck('center_magnitude',4*C+1<2**16)
ck('shift_perturbation',2**27*(eta+330*F(1,2**110))<1)
alpha=F(1266)*F(5,16)**20/math.factorial(20)+F(1266)*F(15,16)**27/math.factorial(27)+2532*eta+633*330*F(1,2**110)+1688*F(1,2**100)
ck('alpha_error',alpha<F(1,2**82))
K=27*D+20;Q=26*D+19
def per(n,m):
    return {'head_scales':n*Q,'head_additions':n*K,'Bernoulli_terms':m*K,'Bernoulli_additions':m*K,
       'E_complex_stages':(27+2*m-2)*D+(20+2*m-2),'source_slots':K,'midpoint_updates':330*D}
old,new=per(2387,64),per(N,m)
ck('net_real_scale_reduction',new['head_scales']+new['Bernoulli_terms']<old['head_scales']+old['Bernoulli_terms'])
ck('net_addition_reduction',new['head_additions']+new['Bernoulli_additions']<old['head_additions']+old['Bernoulli_additions'])
previous=(1720+1)*4096+1
final=(N+1)*D+1
retained=(N+1)*4096+1
introduced=final-retained;retired=previous-retained
union=previous+introduced
full_logs=(1720+1)*D+1
def logblocks(end):
    start=D;count=0
    while start<=end:
        length=min(start//128,end-start+1)
        assert length>0 and length-1<=start//128
        start+=length;count+=1
    return count
anchors=logblocks(1722*D)
ck('log_cover',full_logs>=union)
ck('transition_partition',retained+retired==previous and retained+introduced==final)
scenarios=[]
for H in [20199,20366,20519,20839]:
    row={'last_band_heights':H,'old_work':{k:H*v for k,v in old.items()},'new_work':{k:H*v for k,v in new.items()},
      'old_argument_pairs':H*(2388*D+1),'new_argument_pairs':H*final,
      'old_last_band_updates':H*(2388*D+1)-((2388*D+1)-previous),
      'new_last_band_updates':H*final-introduced}
    scenarios.append(row)
paths=['work/qrh-campaign/agents/independent-feasibility/RETUNED_FINAL_SHARED_SEED_BAND_2026-11-11.md',
 'work/qrh-campaign/agents/prime-estimates/SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md',
 'work/qrh-campaign/agents/integration/SHARED_HURWITZ_EM_SEED_CIRCUIT_2026-11-11.md',
 'work/qrh-blueprint/SELECTED_SCALED_SEED_ORDER_2026-11-11.md',
 'work/qrh-blueprint/SCALED_SEED_HEIGHT_RECURRENCE_2026-11-11.md',
 'work/qrh-campaign/agents/major-constants/combined_odd_even_height_inventory_20261111.json']
out={'scope':'conditional seed parameter and metadata proof only','parameters':{'V':V,'D':D,'N':N,'m':m,'P':P},
 'checks':checks,'remainder_upper':str(R),'P27_error_over_eta':str(err/eta),
 'P27_error_delta_coefficient':head_delta+end_delta,'P27_error_u_coefficient':head_u+end_u+1,
 'old_per_height':old,'new_per_height':new,'scenarios':scenarios,
 'transition':{'previous_arguments':previous,'last_band_arguments':final,'retained':retained,'retired':retired,'introduced':introduced,'total_required_union':union},
 'log_setup_conservative':{'full_grid_points':full_logs,'anchors':anchors,'degree21_stages':21*(full_logs-anchors)},
 'new_exact_gamma_constants':192,'highest_Bernoulli_index':512,
 'input_sha256':{p:sha256((ROOT/p).read_bytes()).hexdigest().upper() for p in paths}}
dest=Path(__file__).with_suffix('.json')
if dest.exists():raise SystemExit('Refusing overwrite')
dest.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps({'checks':len(checks),'error_delta':out['P27_error_delta_coefficient'],'error_u':out['P27_error_u_coefficient'],'old_per_height':old,'new_per_height':new,'transition':out['transition'],'log_setup':out['log_setup_conservative']},indent=2))
