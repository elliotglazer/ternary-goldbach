"""Integer schedule metadata only. No step values, digit tables or proofs generated."""
from pathlib import Path
import hashlib, json
ROOT=Path(__file__).resolve().parents[4]
paths=[
'work/qrh-campaign/agents/zero-sum/REDUCED_PREFIX_SELECTED_P27_SEED_COST_2026-11-11.md',
'work/qrh-blueprint/SCALED_SEED_HEIGHT_RECURRENCE_2026-11-11.md',
'work/qrh-blueprint/SELECTED_SCALED_SEED_ORDER_2026-11-11.md',
'work/qrh-campaign/agents/audit/EFFICIENCY_MM0_SPECTRAL_PROOF_VOLUME_2026-11-11.md',
'work/qrh-campaign/agents/audit/EFFICIENCY_MM0_STREAMING_PROOF_STATE_2026-11-11.md',
'work/qrh-campaign/agents/prime-estimates/EFFICIENCY_MM0_DIGIT_TABLES_2026-11-11.md',
'work/qrh-campaign/agents/prime-estimates/LEAN_MM0_COMPUTATION_COMPARISON_2026-11-11.md',
'work/formal-goldbach-bench/mm0/src/verifier.c',
'work/formal-goldbach-bench/mm0/src/verifier_types.c']
pins={p:hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper() for p in paths}
beta,n=256,18
school=5*n*n+2*n+1
tab=(n-1)*(4*n+1)+2*n-1
setup=2*((beta-1)*(2*n+5)+4)
gain=4*(school-tab)
assert (school,tab,setup,gain)==(1657,1276,20918,1524)
bands=[(512,220,6401),(1024,387,6400),(2048,720,12800),(4096,1720,38400),(8192,3387,38144)]
rows=[]
for h in [16,32,64,128,256]:
    prev=0; packs=updates=0
    for D,N,H in bands:
        X=(N+1)*D+1
        new=X-prev
        updates+=prev*H+new*(H-1)
        packs+=prev*((H+h-1)//h)+new*((H-1+h-1)//h)
        prev=X
    assert updates==1351497402624
    rows.append(dict(height_tile=h,table_pairs=packs,updates=updates,
      baseline_product_events=4*updates*school,
      table_product_and_setup_events=4*updates*tab+packs*setup,
      event_reduction=gain*updates-packs*setup,
      table_entries_generated=2*beta*packs,
      scope='unsigned macro skeleton only; excludes terms, bindings, signs, rounds, joins, I/O'))
out={'pins':pins,'beta':beta,'digits':n,'schoolbook_per_product':school,
 'table_horner_per_product':tab,'two_table_setup':setup,
 'strict_per_pack_break_even_updates':setup//gain+1,'rows':rows,
 'note':'No actual step values/tables, proof generation, checker execution or timings.'}
dest=Path(__file__).with_suffix('.json')
dest.write_text(json.dumps(out,indent=2)+'\n',encoding='utf8')
print(json.dumps({k:v for k,v in out.items() if k!='pins'},indent=2))
