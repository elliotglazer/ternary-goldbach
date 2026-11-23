"""Independent integer/rational review; no Hurwitz values or transforms."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial
import hashlib,json
A=Path(__file__).resolve().parents[1]
pins={
'zero-sum/R138000_HURWITZ_SEED_CONTRACTION_EFFICIENCY_2026-11-11.md':'3151FEBCBE953FA458CBFE437222B810468B2E4F173C723F159F67285601D853',
'zero-sum/r138000_p20_alpha_tradeoff_20261111.py':'9EF1BC728B42B9E11E109AEAB6D742BFCD413F0E78FA6C06BD2E377AE40EB891',
'zero-sum/r138000_p20_alpha_tradeoff_20261111.json':'F7D5E9CC9AE271B5DA2FC60A33CE8DFC23C9EED5F05999B442C20182573A8323',
'zero-sum/nonprincipal_platt_schedule_metadata_20261111.json':'6F661E61A212D3F65C24625E6A211DCC0494853BDD3D875162E8521E306F296F',
'zero-sum/conditional_r138000_mixed_inventory_20261111.json':'0D48AF7655976B5B0A0BC2750CA92F26E30B33E1F45540015627EEFFC5C60D5F',
'audit/platt_turing_1305_3087.pdf':'8FD109AA21345BC3FEAC4FDE2FAA7DFB51B4EF1FC9A430F643323612A39EF417',
'audit/platt_turing_1305_3087.txt':'2A2EABBCA321E6B29BC3E0BAE4339245C819B5234C0C4CC222C65E981E84E3E9'}
for path,sha in pins.items():assert hashlib.sha256((A/path).read_bytes()).hexdigest().upper()==sha
receipt=json.loads((A/'zero-sum/r138000_p20_alpha_tradeoff_20261111.json').read_text())
phi=list(range(276001))
for p in range(2,len(phi)):
 if phi[p]==p:
  for n in range(p,len(phi),p):phi[n]-=phi[n]//p
N=Jmax=nc=0
for c in range(10001,276001):
 if not ((c%2 and c<=138000) or c%4==0):continue
 H=F(100000000,c) if c%2 else max(F(100000000,c),200+F(75000000,c))
 scaled=H*F(64,5);J=-(-scaled.numerator//scaled.denominator)+1
 N+=phi[c]*J;Jmax=max(Jmax,J);nc+=1
assert N==103868439142446 and Jmax==127989 and nc==130500
rows=[];previous=-1;checks=len(pins)+3
for V,D in ((500,512),(1000,1024),(2000,2048),(5000,4096),(10000,8192)):
 last=min(Jmax-1,V*64//5);J=max(0,last-previous);previous=last
 ratio=F(V+20,4*D);tail=1266*ratio**20/factorial(20)
 assert ratio<F(5,16) and tail<F(1,2**84)
 row=dict(V=V,time_nodes=J,old_D=D,new_D=2*D,old_P=24,new_P=20,
          ratio=str(ratio),character_alpha_tail=str(tail),
          old_seed_slots=J*(D+1)*24,new_seed_slots=J*(2*D+1)*20,
          retained_old_anchor_slots=J*(D+1)*20,new_odd_anchor_slots=J*D*20,
          omitted_old_high_order_slots=J*(D+1)*4)
 assert row==receipt['rows'][len(rows)];rows.append(row);checks+=3
S24=sum(r['old_seed_slots'] for r in rows);S20=sum(r['new_seed_slots'] for r in rows)
tail=1266*F(5,16)**20/factorial(20)
assert tail<F(1,2**84)<F(1,2**82)
expected=dict(uniform_tail=str(tail),uniform_tail_below_2neg84=True,
 residue_height_inputs=N,old_contribution_slots=24*N,new_contribution_slots=20*N,
 old_Horner_real_times_complex_products=23*N,new_Horner_real_times_complex_products=19*N,
 saved_Horner_products=4*N,saved_complex_additions=4*N,saved_real_coordinate_products=8*N,
 old_seed_slots=S24,new_seed_slots=S20,added_seed_slots=S20-S24,
 seed_slot_ratio=str(F(S20,S24)),uniform_per_seed_cost_over_stage_cost_crossover=str(F(4*N,S20-S24)),
 max_old_seed_slots_per_height=max((r['old_D']+1)*24 for r in rows),
 max_new_seed_slots_per_height=max((r['new_D']+1)*20 for r in rows),total_shared_heights=Jmax)
for k,v in expected.items():assert receipt[k]==v,k;checks+=1
assert F(1,1-F(1,2048))<2
assert 400000<633**2
checks+=3
out=dict(status='PASS_INDEPENDENT_INTEGER_ALPHA_TRADEOFF',pins=pins,checks=checks,
 scope='Isolated alpha truncation and nominal metadata only; no seed/sign success.',
 independent_large_conductors=nc,rows=rows,verified_fields=expected)
with Path(__file__).with_suffix('.json').open('x',encoding='utf8',newline='\n') as f:
 json.dump(out,f,indent=2);f.write('\n')
print(json.dumps(dict(status=out['status'],checks=checks,large_conductors=nc,N=N,Jmax=Jmax)))
