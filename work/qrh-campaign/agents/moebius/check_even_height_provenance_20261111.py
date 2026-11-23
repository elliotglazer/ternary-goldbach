"""Read-only pin and receipt linkage checks; no occupancy or value regeneration."""
from pathlib import Path
import hashlib,json
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
A='work/qrh-campaign/agents/'
pins={
 A+'prime-estimates/LARGE_RESIDUE_BUCKET_OCCUPANCY_2026-11-11.md':'99B76FC9277CA0297C9CF7301DF97FF9667CDE05C1AD0BBD8C5D32DF88D118C1',
 A+'prime-estimates/large_residue_bucket_occupancy_20261111.py':'549EDC2159B6843527DB1A45014571AEF46926835BA60DEC5CC8C8E5150A06B9',
 A+'prime-estimates/large_residue_bucket_occupancy_20261111.json':'19E0AC3EB1F860A38151F46F792595DEDE7BA7D0180A244425C6C969EFBF58DB',
 A+'major-constants/newton_cost_frontier_20261111.py':'3AD9E2B2C9A6F35649CB9CDA86A4876C40442B54C07E01B746854CBD3B5AFC4E',
 A+'major-constants/newton_cost_frontier_20261111.json':'81853F0B8E8994AA81ABC711667C9F29E2018C579A82860FEC97B35CAFF1DD3F',
 A+'moebius/review_large_residue_bucket_occupancy_20261111.py':'AC5E309CE539173DC2D1C8E5D979FE090C2E70FCD65C853350F501BC2547A66F',
 A+'moebius/review_large_residue_bucket_occupancy_20261111.json':'A451BC6F493D1EB6D23348DB8EAAD083045B0B2630855A720FE1B81A6A6B4D3E',
 A+'moebius/review_newton_cost_frontier_20261111.py':'F20E951CCE576235541CEE3F2C2DC0DDB1B973F7D51185A4972C1F91E842F5A8',
 A+'moebius/review_newton_cost_frontier_20261111.json':'9605F0E7667F6FD238ED5F306D037DD651CD1EC20FACDFB7E8FE464C248830AE',
 A+'major-constants/combined_odd_even_height_inventory_20261111.json':'BCBAA29AE9A963A46170C5B7B355C0399EE6A622EDBE355ECD24BFE92042C2EE',
 A+'major-constants/reconciled_nonprincipal_schedule_20261111.json':'0E83C9AB65725FBD34F0D34FC462E9EC805A040717DA92B1AB262CC7A9345397',
 'work/qrh-blueprint/minimal_theta_nonprincipal_schedule_20261111.json':'96483C8A5E47888AC9208A8B95CA1BD8261CBC9D42AFBCBAEE1A1ABF10AC9265'}
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
def read(p): return json.loads((ROOT/p).read_text(encoding='utf-8'))
for p,h in pins.items():ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
text=(ROOT/(A+'prime-estimates/LARGE_RESIDUE_BUCKET_OCCUPANCY_2026-11-11.md')).read_text(encoding='utf-8')
ck('d=531600/c and u=96/5 for odd c; d=1063200/c and u=191/10 for even c' in text)
combined=read(A+'major-constants/combined_odd_even_height_inventory_20261111.json')
reconciled=read(A+'major-constants/reconciled_nonprincipal_schedule_20261111.json')
minimal=read('work/qrh-blueprint/minimal_theta_nonprincipal_schedule_20261111.json')
occ=read(A+'prime-estimates/large_residue_bucket_occupancy_20261111.json')
review=read(A+'moebius/review_large_residue_bucket_occupancy_20261111.json')
fr=read(A+'major-constants/newton_cost_frontier_20261111.json')
frr=read(A+'moebius/review_newton_cost_frontier_20261111.json')
rows=[]
for c,r,m,o,v in zip(combined['scenarios'],reconciled['scenarios'],minimal['scenarios'],occ['scenarios'],review['summaries']):
 ck(c['extra_nodes']==r['extra_nodes']==m['extra_nodes']==o['extra_nodes']==v['extra'])
 ck(r['large']==m['large'])
 ck(c['residue_inputs']==m['large']['residue_inputs']==o['unit_residue_height_inputs']==v['unit_inputs'])
 ck(c['P20_Horner_stages']==m['large']['P20_Horner_stages']==o['old_Horner_stages']==19*v['unit_inputs'])
 for b,rb in zip(o['bands'],v['bands']):
  for z,zr in zip(b['cohorts'],rb['cohorts']):
   ck(z['conductor_parity']==zr['parity'])
   ck((z['unit_outputs'],z['nonempty_bucket_heights'],z['advance_steps'])==(zr['units'],zr['buckets'],zr['advances']))
 rows.append(dict(extra=o['extra_nodes'],unit_inputs=o['unit_residue_height_inputs'],horner_stages=o['old_Horner_stages']))
for row in frr['guard_cohorts']:
 sc=next(z for z in fr['scenarios'] if z['extra_nodes']==row['extra'])
 saved=sc['bands'][row['band']-1]['guard_cohorts'][row['tier']]
 ck(saved['active_conductors']==row['conductors'])
 ck(all(saved[k]==row[k] for k in ('R','B','A')))
out=dict(status='PASS_UNCHANGED_PARITY_PROVENANCE',checks=checks,pins=pins,rows=rows,
 scope='Correct even slope in frozen prose and all four inspected height implementations; saved receipt linkage only, no inventory rerun.')
with (HERE/'check_even_height_provenance_20261111.json').open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'status':out['status'],'checks':checks,'rows':rows}))
