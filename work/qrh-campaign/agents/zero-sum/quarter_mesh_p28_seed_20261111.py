"""Exact paper envelopes and operation metadata; no analytic value evaluation."""
from fractions import Fraction as F
from math import factorial
from pathlib import Path
import hashlib,json
HERE=Path(__file__).resolve().parent
AG=HERE.parent
ROOT=HERE.parents[3]
checks={}
def ck(n,b):
    assert b,n
    checks[n]=True
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest().upper()
paths={
 AG/'independent-feasibility/RETUNED_FINAL_SHARED_SEED_BAND_2026-11-11.md':'8F08560DDB2BDFEBEABA0D4D5A44FCBCC625BFD43D1027AF05BF62233863FD9B',
 AG/'independent-feasibility/retuned_final_seed_band_20261111.json':'51EF63920A6E298F21FEC3EE228B9DB75302700847D64532ADA76D1240A15B7D',
 AG/'prime-estimates/SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md':'251B95AE92B6277C0B14C69F3CFE697F3100FD27C2D7963E4B42676FF4DAB231',
 AG/'integration/SHIFTED_HURWITZ_JET_SEED_EFFICIENCY_2026-11-11.md':'861CA2C6F326C57AABDA40B72D723D537223BC0986F0AC25AAE5C6CD37DB2895',
 ROOT/'work/qrh-blueprint/SELECTED_SCALED_SEED_ORDER_2026-11-11.md':'579AAEC28BD4C1DB8FB83F3CDB1E4782160D3D35FA8AB2B8DC83BFF956ACBCD1',
 ROOT/'work/qrh-blueprint/SCALED_SEED_HEIGHT_RECURRENCE_2026-11-11.md':'8ABDD8A1F991AF9FEACE49908E5BA865EC3FD5804311CAE73AB9D80A4456D413',
}
for p,h in paths.items():ck('pin_'+p.name,sha(p)==h)
old=json.loads((AG/'independent-feasibility/retuned_final_seed_band_20261111.json').read_text())
V,D,Do,N,P=7000,4096,8192,2387,28
eta,delta,u,ut=F(1,2**100),F(1,2**118),F(1,2**122),F(1,2**110)
A=F(V+32,D);b=N+2;W=V+160;C=3*N+5;L=20*P-210
ck('scaled_R_factor',A<F(7,4))
ck('R_error_invariant',F(7,8)*8+1==8)
ck('E_factor',F(W,6*(N+1))<F(1,2))
rem=F(108*b,1)/F(255,2)/2**128
for k in range(P):
    ck('R_magnitude_'+str(k),A**k/factorial(k)<2)
    r=F(4*b,1)/F(2*k+255,2)*F(W,N+1)**k/factorial(k)*F(W,6*(N+1))**128
    ck('EM_remainder_'+str(k),r<=rem)
seed=(5*N+2*b+1)*delta+(5*N*P+8*N+1+16*b+255+1)*u+rem
ck('seed_quarter_eta',seed<eta/4)
ck('source_perturbation',2**P*(seed+L*ut)<1)
ck('stored_width',6*C+1<2**16)
coef=2*seed+L*ut+ut
ck('exported_coefficient_radius',coef<eta)
target=F(1266)*F(V+20,4*Do)**20/factorial(20)
shift=F(1266)*F(5*(V+P),8*D)**P/factorial(P)
alpha=target+shift+844*eta+1688*eta
ck('full_alpha',alpha<F(1,2**82))
ck('shift_under_allocation',shift<F(1,2**82))
coarsened_target=F(1266)*F(V+20,4*D)**20/factorial(20)
ck('naive_coarsened_P20_bound_fails',coarsened_target>F(1,2**82))
ck('P27_shift_bound_fails',F(1266)*F(5*(V+27),8*D)**27/factorial(27)>F(1,2**82))
for tau in [F(1,4),F(1,2),F(-1,4)]:
    # Explicit positive matrices also check the exact pruned translation.
    a=[[F(int(i==j)) for j in range(P)] for i in range(P)]
    for i in range(P-2,-1,-1):
        for j in range(i,min(P-2,i+19)+1):
            a[j]=[v+tau*w for v,w in zip(a[j],a[j+1])]
    for k in range(20):
        from math import comb
        expected=[F(0) if j<k else comb(j,k)*tau**(j-k) for j in range(P)]
        ck('shift_'+str(tau)+'_'+str(k),a[k]==expected)
        ck('row_sum_'+str(tau)+'_'+str(k),sum(abs(v) for v in a[k])/2**k<=2)

scenarios=[]
prev=(1720+1)*4096+1
for s in old['scenarios']:
    baseline=s['retuned'];last=baseline['bands'][-1];H=last['heights']
    x=(N+1)*D+1;init=x-prev;K=P*(D+1)
    new=dict(independent_P27_source_coefficients=H*K,
      head_reciprocal_scales=H*N*(P-1)*(D+1),head_accumulator_additions=H*N*K,
      E_contracting_complex_stages=H*(P+126)*(D+1),Bernoulli_weighted_terms=64*H*K,
      Bernoulli_accumulator_additions=64*H*K,P27_to_P20_midpoint_shift_updates=3*D*H*L,
      P20_fine_anchor_coefficient_deliveries=20*H*(4*D+1),shared_height_R_recurrence_steps=(P-1)*H,
      coarse_anchor_instances=H*(D+1),base_height_argument_pairs=H*x,
      initial_B_certificates=init,step_cis_certificates=init,step_grid_conversions=init,
      fine_state_complex_updates=H*x-init,state_to_EM_grid_conversions=H*x)
    total={k:baseline['totals'][k]-last[k]+v for k,v in new.items()}
    ck('same_final_outputs_'+str(s['extra_nodes']),total['P20_fine_anchor_coefficient_deliveries']==baseline['totals']['P20_fine_anchor_coefficient_deliveries'])
    ck('same_coverage_'+str(s['extra_nodes']),F(5*(s['global_nodes']-1),64)<V)
    final_conversion=20*H*(4*D+1)
    scenarios.append(dict(extra_nodes=s['extra_nodes'],final_heights=H,new_final_band=new,new_totals=total,
      baseline_totals=baseline['totals'],new_minus_baseline={k:total[k]-baseline['totals'][k] for k in new},
      added_final_coefficient_power2_scales=final_conversion,added_final_coefficient_rounds=final_conversion))
def grid(d):
    start=d;end=b*d;anchors=0
    while start<=end:
        le=min(start//128,end-start+1)
        ck('anchor_'+str(d)+'_'+str(anchors),le>0 and F(le-1,start)<=F(1,128))
        anchors+=1;start+=le
    points=(N+1)*d+1
    return dict(points=points,anchors=anchors,log_horner_stages=21*(points-anchors),dense_state_step_bytes=72*points)
setup=dict(new=grid(D),baseline=grid(Do))
ck('nested_grid',D%4096==0 and N>=1720)
out=dict(status='PASS_PAPER_QUARTER_MESH_P28',checks=len(checks),parameters=dict(V=V,D_source=D,D_output=Do,N=N,P=P,m=64),
 errors={k:str(v) for k,v in dict(seed=seed,seed_over_eta=seed/eta,coefficient=coef,coefficient_over_eta=coef/eta,target=target,shift=shift,alpha=alpha,alpha_over_budget=alpha*2**82).items()},
 setup=setup,scenarios=scenarios,pins={str(p):h for p,h in paths.items()},
 scope='Exact envelopes, finite polynomial identities and operation metadata only. Legacy P27-key names hold the compared category, not the new order.')
dest=Path(__file__).with_suffix('.json')
with dest.open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps(dict(checks=len(checks),errors=out['errors'],setup=setup,rows=[dict(extra=s['extra_nodes'],H=s['final_heights'],head=s['new_totals']['head_reciprocal_scales'],head_delta=s['new_minus_baseline']['head_reciprocal_scales'],shift_delta=s['new_minus_baseline']['P27_to_P20_midpoint_shift_updates'],conversions=s['added_final_coefficient_rounds']) for s in scenarios]),indent=2))
