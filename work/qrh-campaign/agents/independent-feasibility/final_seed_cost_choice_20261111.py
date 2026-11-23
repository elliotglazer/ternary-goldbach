"""Category-price frontier for three reviewed seeds; exact metadata only."""
from pathlib import Path
import hashlib,json
HERE=Path(__file__).resolve().parent
A=HERE.parent
pins={
 HERE/'RETUNED_FINAL_SHARED_SEED_BAND_2026-11-11.md':'8F08560DDB2BDFEBEABA0D4D5A44FCBCC625BFD43D1027AF05BF62233863FD9B',
 A/'prime-estimates/REVIEW_RETUNED_FINAL_SHARED_SEED_BAND_2026-11-11.md':'6D5AA23A7050AC5C54E103AFD9C33BBAF5AF84836FCB7DD05FDD50CA9853BCFF',
 A/'zero-sum/QUARTER_MESH_P28_SHARED_SEED_2026-11-11.md':'A0CD531E1FD20280E49B1EC0AE95E32809C7965222C40916BD4712F7F3A5EA19',
 A/'prime-estimates/REVIEW_QUARTER_MESH_P28_SHARED_SEED_2026-11-11.md':'8D50DDB6C7398D10930F8437ABE9B3E0C672F9AD1F85851D040EF1BD6D385B6A',
 A/'major-constants/FINAL_SEED_HEAD_CORRECTION_TRADEOFF_2026-11-11.md':'3B760B39986F6A80C1ADB71BCABDEFDE28947964225383AF1073E6601162DE4F',
 HERE/'REVIEW_FINAL_SEED_HEAD_CORRECTION_TRADEOFF_2026-11-11.md':'7BB25BC96EE9C27FE03038968EFC9E9F52A4B3064D9F0986865CF68AC8E77365',
 HERE/'REVIEW_COMBINED_ODD_EVEN_HEIGHT_CONDITIONAL_COST_2026-11-11.md':'F32FABEF789BEF16B64D16040C1FE48D324F0D84DDBA1FF47F0D30DE2C3A6EAA',
}
for p,h in pins.items():assert hashlib.sha256(p.read_bytes()).hexdigest().upper()==h
H=20839;J=84840
assert H==J-64001 and 5*(J-1)<7000*64
def row(n,d,p,m,endpoint,shifts):
 K=p*d+endpoint
 return dict(head_scales=n*((p-1)*d+endpoint-1),head_adds=n*K,
  gamma_scales=m*K,gamma_adds=m*K,E_stages=(p+2*m-2)*d+endpoint+2*m-2,
  source_slots=K,coarse_anchors=d+1,R_stages=p-1,shift_updates=shifts,
  normalization_scales=327700 if d==4096 else 0,normalization_rounds=327700 if d==4096 else 0,
  argument_pairs=(n+1)*d+1)
rows=dict(B=row(2387,8192,27,64,20,8192*330),
          Q=row(2387,4096,28,64,28,3*4096*350),
          C=row(1500,8192,27,256,20,8192*330))
setups=dict(B=dict(union=19562497,introduced=12513280,log_stages=410791416,anchors=1001,new_gamma=0),
 Q=dict(union=9781249,introduced=2732032,log_stages=205385187,anchors=1002,new_gamma=0),
 C=dict(union=13197313,introduced=6148096,log_stages=296046954,anchors=959,new_gamma=192))
totals={}
for key,r in rows.items():
 totals[key]={k:H*v for k,v in r.items()}
 totals[key]['fine_state_updates']=H*r['argument_pairs']-setups[key]['introduced']
 assert setups[key]['union']==7049217+setups[key]['introduced']
gains={}
for old,new in [('B','Q'),('B','C'),('C','Q')]:
 gains[old+'-to-'+new]=dict(per_height={k:rows[old][k]-rows[new][k] for k in rows[old]},
  fixed={k:setups[old][k]-setups[new][k] for k in setups[old]},
  totals={k:totals[old][k]-totals[new][k] for k in totals[old]})
q=json.loads((A/'zero-sum/quarter_mesh_p28_seed_20261111.json').read_text())
c=json.loads((A/'major-constants/seed_head_correction_tradeoff_20261111.json').read_text())
for r in q['scenarios']:
 h=r['final_heights'];f=r['new_final_band']
 for x,y in [('head_scales','head_reciprocal_scales'),('head_adds','head_accumulator_additions'),('E_stages','E_contracting_complex_stages'),('source_slots','independent_P27_source_coefficients')]:assert h*rows['Q'][x]==f[y]
 assert h*rows['Q']['argument_pairs']-setups['Q']['introduced']==f['fine_state_complex_updates']
for x,y in [('head_scales','head_scales'),('head_adds','head_additions'),('gamma_scales','Bernoulli_terms'),('E_stages','E_complex_stages')]:assert rows['C'][x]==c['new_per_height'][y]
for p in (A/'zero-sum/quarter_mesh_p28_seed_20261111.json',A/'major-constants/seed_head_correction_tradeoff_20261111.json'):
 pins[p]=hashlib.sha256(p.read_bytes()).hexdigest().upper()
out=dict(scope='Conditional common-price model, no values or runtime estimates',prefix=dict(J=J,H=H,last_height_numerator=5*(J-1),last_height_denominator=64),
 pins={str(p):h for p,h in pins.items()},per_height=rows,setup=setups,totals=totals,gains=gains)
with Path(__file__).with_suffix('.json').open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps(dict(per_height=rows,setup=setups,gains={k:dict(per_height=v['per_height'],fixed=v['fixed']) for k,v in gains.items()}),indent=2))
