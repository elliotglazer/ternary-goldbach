"""Exact slot/tail arithmetic only; no analytic-function or transform values."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial
import hashlib,json
root=Path(__file__).parent
def read(name,pin):
    p=root/name
    assert hashlib.sha256(p.read_bytes()).hexdigest().upper()==pin
    return json.loads(p.read_text())
old=read('nonprincipal_platt_schedule_metadata_20261111.json','6F661E61A212D3F65C24625E6A211DCC0494853BDD3D875162E8521E306F296F')
new=read('conditional_r138000_mixed_inventory_20261111.json','0D48AF7655976B5B0A0BC2750CA92F26E30B33E1F45540015627EEFFC5C60D5F')
count=new['profiles']['138000']['large_above10000']['coarse_residue_inputs']
rows=[]
for row in old['adaptive_alpha_lattice_bands']:
    V,D,J=row['upper_height'],row['D'],row['time_nodes']
    ratio=F(V+20,4*D)
    assert ratio<F(5,16)
    tail=F(1266)*ratio**20/factorial(20)
    assert tail<F(1,2**84)
    rows.append(dict(V=V,time_nodes=J,old_D=D,new_D=2*D,old_P=24,new_P=20,
        ratio=str(ratio),character_alpha_tail=str(tail),
        old_seed_slots=J*(D+1)*24,new_seed_slots=J*(2*D+1)*20,
        retained_old_anchor_slots=J*(D+1)*20,new_odd_anchor_slots=J*D*20,
        omitted_old_high_order_slots=J*(D+1)*4))
S24=sum(r['old_seed_slots'] for r in rows);S20=sum(r['new_seed_slots'] for r in rows)
assert S24==old['adaptive_alpha_lattice_total_slots']
assert sum(r['time_nodes'] for r in rows)==new['profiles']['138000']['large_above10000']['max_height_nodes']
tail=F(1266)*F(5,16)**20/factorial(20)
assert tail<F(1,2**84)
saved=4*count
out=dict(status='PASS_CONDITIONAL_P20_ALPHA_TRADEOFF',scope='R138000 candidate, same nominal grid; isolated alpha tail only.',
         rows=rows,uniform_tail=str(tail),uniform_tail_below_2neg84=True,
         residue_height_inputs=count,old_contribution_slots=24*count,new_contribution_slots=20*count,
         old_Horner_real_times_complex_products=23*count,new_Horner_real_times_complex_products=19*count,
         saved_Horner_products=saved,saved_complex_additions=saved,
         saved_real_coordinate_products=2*saved,old_seed_slots=S24,new_seed_slots=S20,
         added_seed_slots=S20-S24,seed_slot_ratio=str(F(S20,S24)),
         uniform_per_seed_cost_over_stage_cost_crossover=str(F(saved,S20-S24)),
         max_old_seed_slots_per_height=max((r['old_D']+1)*24 for r in rows),
         max_new_seed_slots_per_height=max((r['new_D']+1)*20 for r in rows),
         total_shared_heights=sum(r['time_nodes'] for r in rows),
         exclusions='Seed construction, elementary leaves, actual precision, auxiliary heights, signs and complete cost remain unmeasured.')
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf8',newline='\n')
print(json.dumps({k:v for k,v in out.items() if k!='rows'},indent=2))
