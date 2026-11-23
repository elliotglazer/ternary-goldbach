"""Summarize saved measurements only; no Lean execution or new fixtures."""
from pathlib import Path
import hashlib,json,os,platform
H=Path(__file__).resolve().parent
def pin(p):
 b=p.read_bytes();return dict(path=str(p),bytes=len(b),sha256=hashlib.sha256(b).hexdigest().upper())
runs=[]
for label in ('complete_r1','complete_r2'):
 r=json.loads((H/(label+'.json')).read_text());assert r['exit_code']==0 and r['stop'] is None
 parts=[];controls=[]
 for l in (H/(label+'.log')).read_text().splitlines():
  if l.startswith('PART,'):
   _,group,p,f,reps,decls,accepted,ns=l.split(',')
   assert int(accepted)==int(reps)*int(decls)
   parts.append(dict(group=group,p=int(p),fixture=int(f),declarations=int(decls),ms_per_replay=int(ns)/int(reps)/1e6))
  if l.startswith('CONTROL,'):
   assert l.endswith('product_plus_one=true,round_plus_one=true,no_fixture_refs=true');controls.append(l)
 assert len(parts)==16 and len(controls)==4
 for row in r['rows']:
  assert row['accepted']==2100 and row['declarations_per_bundle']==21 and row['repetitions']==100 and row['corrupt_rejected']
  row['ms_per_bundle']=row['kernel_bundle_wall_ns']/row['repetitions']/1e6
 r['parts']=parts;r['controls']=controls;runs.append(r)
assert runs[0]['artifacts'][0]==runs[1]['artifacts'][0]
assert runs[0]['artifacts'][2]['sha256']==runs[1]['artifacts'][2]['sha256']
axioms=(H/'axiom_complete_r1.log').read_text().splitlines()
assert len(axioms)==4 and all(x.endswith('[propext, Classical.choice, Quot.sound]') for x in axioms)
fixtures=json.loads((H/'complete_fixture_metadata.json').read_text())['fixtures']
for f in fixtures:
 p=f['p'];s=1<<p;a,b,c,d=map(int,(f['a'],f['b'],f['c'],f['d']))
 rr,ii=a*c-b*d,a*d+b*c
 assert (rr,ii)==(int(f['real']),int(f['imag']))
 for n,q,r in ((rr,int(f['qr']),int(f['tr'])),(ii,int(f['qi']),int(f['ti']))):
  assert n+s//2==q*s+r and 0<=r<s and -s<=2*(n-q*s)<s
 f['capacity_bytes']={k:(f[k]+7)//8 for k in ('input_signed_capacity','coefficient_signed_capacity','raw_signed_capacity','output_signed_capacity')}
 f['actual_operand_magnitude_bits']={k:abs(int(f[k])).bit_length() for k in ('a','b','c','d','real','imag','qr','qi')}
paths=['ArithmeticComplete.lean','AxiomComplete.lean','generate_calibration.py','run_calibration.py','summarize_calibration.py','complete_fixture_metadata.json','complete_r1.json','complete_r2.json','complete_r1.log','complete_r2.log','complete_r1.olean','axiom_complete_r1.json','axiom_complete_r1.log','axiom_complete_r1.olean','baseline_r1.json','Baseline.lean','arithmetic_r1.json','small_r1.json']
out=dict(scope='Saved calibration measurements and fixed integer metadata; not spectral values or production cost',machine=dict(platform=platform.platform(),processor=os.environ.get('PROCESSOR_IDENTIFIER'),logical_processors=os.cpu_count()),runs=runs,fixtures=fixtures,axioms=axioms,pins=[pin(H/p) for p in paths],lean_executable=pin(Path('C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe')))
with (H/'calibration_summary.json').open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps(dict(summary=pin(H/'calibration_summary.json'),machine=out['machine'],final_checks='PASS'),indent=2))
