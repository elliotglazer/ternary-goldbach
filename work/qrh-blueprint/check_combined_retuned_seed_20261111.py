"""Join reviewed/candidate schedule metadata; no analytic evaluations."""
from pathlib import Path
from fractions import Fraction as F
import hashlib
import json

root=Path(__file__).resolve().parents[2]
paths={
 'combined':'work/qrh-campaign/agents/major-constants/combined_odd_even_height_inventory_20261111.json',
 'retune':'work/qrh-campaign/agents/independent-feasibility/retuned_final_seed_band_20261111.json',
 'combined_paper':'work/qrh-campaign/agents/major-constants/COMBINED_ODD_EVEN_HEIGHT_CONDITIONAL_COST_2026-11-11.md',
 'retune_paper':'work/qrh-campaign/agents/independent-feasibility/RETUNED_FINAL_SHARED_SEED_BAND_2026-11-11.md',
 'assembly':'work/qrh-campaign/agents/audit/COMBINED_ODD_EVEN_PROFILE_ASSEMBLY_REVIEW_2026-11-11.md',
}
expected={
 'combined':'BCBAA29AE9A963A46170C5B7B355C0399EE6A622EDBE355ECD24BFE92042C2EE',
 'retune':'51EF63920A6E298F21FEC3EE228B9DB75302700847D64532ADA76D1240A15B7D',
 'combined_paper':'6143FA8444ED97084998D769E114DCAB3DC2C12DCAF9649C32CFA1989658487C',
 'retune_paper':'8F08560DDB2BDFEBEABA0D4D5A44FCBCC625BFD43D1027AF05BF62233863FD9B',
 'assembly':'2017E3ECC588438907D0A9582D9C351CE201FE11C41EAF68BDA4559F705FA250',
}
for k,p in paths.items():
    assert hashlib.sha256((root/p).read_bytes()).hexdigest().upper()==expected[k]
combined=json.loads((root/paths['combined']).read_text())
retune=json.loads((root/paths['retune']).read_text())

def ledger(nodes, final_N, final_V):
    specs=[(500,512,220,6401),(1000,1024,387,6400),(2000,2048,720,12800),(5000,4096,1720,38400),(final_V,8192,final_N,nodes-64001)]
    previous=0
    bands=[]
    for V,D,N,H in specs:
        assert H>0
        K=27*D+20
        X=(N+1)*D+1
        introduced=X-previous
        assert introduced>=0
        counts={
          'independent_P27_source_coefficients':H*K,
          'head_reciprocal_scales':H*N*(26*D+19),
          'head_accumulator_additions':H*N*K,
          'E_contracting_complex_stages':H*(153*D+146),
          'Bernoulli_weighted_terms':64*H*K,
          'Bernoulli_accumulator_additions':64*H*K,
          'P27_to_P20_midpoint_shift_updates':330*H*D,
          'P20_fine_anchor_coefficient_deliveries':20*H*(2*D+1),
          'shared_height_R_recurrence_steps':26*H,
          'coarse_anchor_instances':H*(D+1),
          'base_height_argument_pairs':H*X,
          'initial_B_certificates':introduced,
          'step_cis_certificates':introduced,
          'step_grid_conversions':introduced,
          'fine_state_complex_updates':H*X-introduced,
          'state_to_EM_grid_conversions':H*X,
        }
        bands.append(dict(V=V,D=D,N=N,heights=H,counts=counts))
        previous=X
    totals={key:sum(b['counts'][key] for b in bands) for key in counts}
    return dict(bands=bands,totals=totals)

# First independently reconcile both predecessor ledgers, not just the new join.
for scenario in combined['scenarios']:
    assert ledger(scenario['global_nodes'],3387,10000)['totals']==scenario['selected_P27']['totals']
for scenario in retune['scenarios']:
    assert ledger(scenario['global_nodes'],2387,7000)['totals']==scenario['retuned']['totals']

scenarios=[]
for s in combined['scenarios']:
    old=ledger(s['global_nodes'],3387,10000)['totals']
    new=ledger(s['global_nodes'],2387,7000)
    assert F(s['last_height'])<7000
    H=s['global_nodes']-64001
    t=new['totals']
    assert old['head_reciprocal_scales']-t['head_reciprocal_scales']==1000*H*(26*8192+19)
    assert old['head_accumulator_additions']-t['head_accumulator_additions']==1000*H*(27*8192+20)
    assert old['fine_state_complex_updates']-t['fine_state_complex_updates']==8192000*(H-1)
    assert t['initial_B_certificates']==19562497
    scenarios.append(dict(extra_nodes=s['extra_nodes'],global_nodes=s['global_nodes'],last_height=s['last_height'],
        transform_operations=s['operations'],P20_Horner_stages=s['P20_Horner_stages'],selected_P27=new,
        ratios_to_same_combined_height_old_seed={k:str(F(v,old[k])) for k,v in t.items()}))

n=8192; end=2389*8192; anchors=0
while n<=end:
    length=min(n//128,end-n+1)
    assert length>0 and F(length-1,n)<F(1,128)
    anchors+=1; n+=length
assert n==end+1 and anchors==1001
setup=dict(points=19562497,anchors=anchors,log_horner_stages=21*(19562497-anchors),raw_state_step_bytes=19562497*72)
assert setup['log_horner_stages']==410791416
out=dict(scope='conditional combined height and V7000 seed join; no spectral or runtime claim',pins={paths[k]:v for k,v in expected.items()},scenarios=scenarios,setup=setup,
    inherited_unpriced=['principal and small conductors','interpolation and sign discovery','auxiliary success and complete counts','exceptional precision','proof terms and serialization','binary coverage and ladder','analytic libraries and final assembly'])
with Path(__file__).with_name('combined_retuned_seed_20261111.json').open('x',encoding='utf-8') as f:
    json.dump(out,f,indent=2);f.write('\n')
print('PASS: eight predecessor scenarios reconciled; four combined ledgers; five pins; setup reconstructed.')
for s in scenarios:
    t=s['selected_P27']['totals']
    print(s['extra_nodes'],t['head_reciprocal_scales'],t['head_accumulator_additions'],t['fine_state_complex_updates'])
