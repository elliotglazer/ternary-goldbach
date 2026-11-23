"""Exact scalar, finite-polynomial and count checks only; no analytic values."""
from fractions import Fraction as F
from math import factorial, comb
from pathlib import Path
from hashlib import sha256
import json

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
checks={}
def ck(name, test):
    assert test, name
    checks[name]=True
V,D,Q,N,m,P=7000,4096,8192,1500,256,28
b=N+2; W=V+32+2*m; r=F(17,20)
eta,delta,u,ut=F(1,2**100),F(1,2**118),F(1,2**122),F(1,2**110)
A=F(V+32,D); C=3*N+7
rem=F(4*b)/F(4*m-1,2)*r**(2*m)
ck('E_contraction',F(W,6*(N+1))<r<1)
ck('scaled_remainder_k_factor',F(W,D*(N+1))<1)
ck('remainder',rem<F(1,2**116))
ck('R_contraction',A<F(7,4) and F(7,8)*8+1==8)
ck('E_error',1/(1-r)<7)
ck('lambda_contraction',F(6,D)<F(1,2))
ck('S_norm',4*r/(1-r*r)<13)
ck('S_rounding',31*m==7936 and F(7936,6)+1<1324)
ck('Z_rounding_small',(14*b+1330)*u<1)
for k in range(P):
    ck('R_norm_'+str(k),A**k/factorial(k)<2)
    rk=F(4*b)/F(2*k+4*m-1,2)*F(W,D*(N+1))**k/factorial(k)*F(W,6*(N+1))**(2*m)
    ck('actual_remainder_'+str(k),rk<rem)
head_d,head_u=5*N,5*N*P+8*N+1
end_d,end_u=2*b+3,36*b+2679
seed=(head_d+end_d)*delta+(head_u+end_u+1)*u+rem
ck('seed_coefficient',head_d+end_d==10507 and head_u+end_u+1==278753)
ck('seed_quarter',seed<eta/4)
ck('seed_simple_bound',seed<F(107,1000)*eta)
L=20*P-210
coef=2*seed+(L+1)*ut
ck('coefficient_eta',coef<eta)
ck('coefficient_simple_bound',coef<F(557,1000)*eta)
ck('work_center',6*C+1<2**16)
ck('work_perturbation',2**P*(seed+L*ut)<1)
target=1266*F(V+20,4*Q)**20/factorial(20)
shift=1266*F(5*(V+P),8*D)**P/factorial(P)
alpha=target+shift+844*eta+1688*eta
ck('alpha',alpha<F(1,2**82))
ck('alpha_simple_bound',alpha<F(4,25)*F(1,2**82))
for tau in (F(1,4),F(1,2),F(-1,4)):
    mat=[[F(int(i==j)) for j in range(P)] for i in range(P)]
    stages=0
    for i in range(P-2,-1,-1):
        for j in range(i,min(P-2,i+19)+1):
            mat[j]=[x+tau*y for x,y in zip(mat[j],mat[j+1])]
            stages+=1
    ck('stage_count_'+str(tau),stages==L)
    for k in range(20):
        row=[F(0) if j<k else F(comb(j,k))*tau**(j-k) for j in range(P)]
        ck('translation_'+str(tau)+'_'+str(k),mat[k]==row)
        ck('postscale_row_'+str(tau)+'_'+str(k),sum(abs(x) for x in row)/2**k<=2)
for k in range(20):
    for j in range(k,P):
        ck('postscale_injection_'+str(k)+'_'+str(j),F(comb(j,k),2**j)<=1)

def per(d,n,corrections,p,quarter):
    K=p*(d+1) if quarter else p*d+20
    H=(p-1)*(d+1) if quarter else (p-1)*d+19
    return dict(source_slots=K,head_scales=n*H,head_additions=n*K,
        Bernoulli_terms=corrections*K,Bernoulli_additions=corrections*K,
        E_stages=(p+2*corrections-2)*(d+1) if quarter else (p+2*corrections-2)*d+(20+2*corrections-2),
        translations=3*d*(20*p-210) if quarter else d*(20*p-210),
        final_power2_scales=20*(4*d+1) if quarter else 0,
        final_rounds=20*(4*d+1) if quarter else 0,
        delivered_slots=20*(4*d+1) if quarter else 20*(2*d+1),
        shared_R_stages=p-1,coarse_anchors=d+1)
per_height=dict(baseline=per(8192,2387,64,27,False),head_only=per(8192,1500,256,27,False),
    mesh_only=per(4096,2387,64,28,True),joint=per(D,N,m,P,True))
ck('identical_outputs',len({p['delivered_slots'] for p in per_height.values()})==1)
previous=1721*4096+1; final=1501*4096+1
transition=dict(previous=previous,final=final,retained=final,retired=previous-final,introduced=0,union=previous)
ck('transition',transition['retired']==901120 and final==6148097)
ck('earlier_grids_nested',all(4096%d==0 and n<=1720 for d,n in [(512,220),(1024,387),(2048,720)]))
argument_specs=dict(baseline=(2388*8192+1,2388*8192+1-previous),
    head_only=(1501*8192+1,1501*8192+1-final),mesh_only=(2388*4096+1,2388*4096+1-previous),joint=(final,0))
scenarios=[]
for extra,H in zip([0,167,320,640],[20199,20366,20519,20839]):
    ck('height_'+str(extra),F(5*(64001+H-1),64)<V and 64001+H<128000)
    scenarios.append(dict(extra_nodes=extra,final_heights=H,
       work={name:{k:H*v for k,v in p.items()} for name,p in per_height.items()},
       argument_work={name:dict(pairs=H*x,updates=H*x-new,initial_B=new,step_cis=new,step_grid=new) for name,(x,new) in argument_specs.items()}))
start=D; end=1722*D; anchors=0
while start<=end:
    length=min(start//128,end-start+1)
    ck('log_block_'+str(anchors),length>0 and F(length-1,start)<=F(1,128))
    start+=length; anchors+=1
logs=dict(points=previous,anchors=anchors,degree21_stages=21*(previous-anchors),new_final_band_points=0)
paths={
'work/qrh-campaign/agents/major-constants/FINAL_SEED_HEAD_CORRECTION_TRADEOFF_2026-11-11.md':'3B760B39986F6A80C1ADB71BCABDEFDE28947964225383AF1073E6601162DE4F',
'work/qrh-campaign/agents/independent-feasibility/REVIEW_FINAL_SEED_HEAD_CORRECTION_TRADEOFF_2026-11-11.md':'7BB25BC96EE9C27FE03038968EFC9E9F52A4B3064D9F0986865CF68AC8E77365',
'work/qrh-campaign/agents/zero-sum/QUARTER_MESH_P28_SHARED_SEED_2026-11-11.md':'A0CD531E1FD20280E49B1EC0AE95E32809C7965222C40916BD4712F7F3A5EA19',
'work/qrh-campaign/agents/prime-estimates/REVIEW_QUARTER_MESH_P28_SHARED_SEED_2026-11-11.md':'8D50DDB6C7398D10930F8437ABE9B3E0C672F9AD1F85851D040EF1BD6D385B6A',
'work/qrh-campaign/agents/prime-estimates/SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md':'251B95AE92B6277C0B14C69F3CFE697F3100FD27C2D7963E4B42676FF4DAB231',
'work/qrh-campaign/agents/integration/SHARED_HURWITZ_EM_SEED_CIRCUIT_2026-11-11.md':'1E1D5099D398EE978D635729873F4D3941BC186BD91D086198B39962DF8E564E',
'work/qrh-campaign/agents/integration/SHIFTED_HURWITZ_JET_SEED_EFFICIENCY_2026-11-11.md':'861CA2C6F326C57AABDA40B72D723D537223BC0986F0AC25AAE5C6CD37DB2895',
'work/qrh-blueprint/SCALED_SEED_HEIGHT_RECURRENCE_2026-11-11.md':'8ABDD8A1F991AF9FEACE49908E5BA865EC3FD5804311CAE73AB9D80A4456D413',
'work/qrh-campaign/agents/major-constants/combined_odd_even_height_inventory_20261111.json':'BCBAA29AE9A963A46170C5B7B355C0399EE6A622EDBE355ECD24BFE92042C2EE'}
for path,pin in paths.items(): ck('pin_'+Path(path).name,sha256((ROOT/path).read_bytes()).hexdigest().upper()==pin)
out=dict(scope='Joint exact envelope and metadata only; no seed values or implementation',checks=len(checks),parameters=dict(V=V,D_source=D,D_output=Q,N=N,m=m,P=P),
    errors={k:str(v) for k,v in dict(remainder=rem,source=seed,source_over_eta=seed/eta,delivered=coef,delivered_over_eta=coef/eta,target=target,shift=shift,alpha=alpha,alpha_over_budget=alpha*2**82).items()},
    source_delta_coefficient=head_d+end_d,source_u_coefficient=head_u+end_u+1,per_height=per_height,scenarios=scenarios,
    transition=transition,log_setup=logs,new_gamma_constants=192,max_E_index=P+2*m-2,input_sha256=paths)
dest=Path(__file__).with_suffix('.json')
with dest.open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({k:out[k] for k in ['checks','per_height','transition','log_setup']},indent=2))
