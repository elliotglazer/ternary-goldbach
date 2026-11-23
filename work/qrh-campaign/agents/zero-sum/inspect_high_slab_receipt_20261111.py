"""Read-only exact receipt inspection. No producer import/model evaluation."""
from fractions import Fraction as F
from pathlib import Path
import hashlib,json
HERE=Path(__file__).resolve().parent
PATH=HERE/'high_slab_em_candidate_20261111_01.json'
PIN='CF90E96C7531F57E455ABCE70D8D71FB06596E9E1490FADDBAFA6DE64FCB0B09'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest().upper()
def box(b):
 for k in ('re','im'):assert len(b[k])==2 and F(b[k][0])<=F(b[k][1])
def pt(p):return tuple(map(F,p))
def rp(u,v):return u[0]*v[0]-u[1]*v[1]
def cross(a,b):
 det=a[0]*b[1]-a[1]*b[0]
 if a[1]<=0<b[1] and det>0:return 1
 if b[1]<=0<a[1] and det<0:return -1
 return 0
def main():
 assert sha(PATH)==PIN
 d=json.loads(PATH.read_text());ags=HERE.parent
 assert d['source_sha256']==sha(HERE/'high_slab_em_candidate_20261111.py')
 for p,h in d['input_pins'].items():assert sha(ags/p)==h
 assert sha(HERE/'coordinator_high_slab_run_20261111_01.json')==d['authorization_sha256']
 assert d['status']=='PASS_EXTERNAL_HIGH_SLAB_WINDING_ZERO' and d['stage']=='complete'
 assert not d['pending_panels'] and d['active_model'] is None and d['active_main_sum_terms']==0
 assert len(d['models'])==13 and len(d['accepted_panels'])==len(d['attempts'])==14
 assert d['attempts']==d['accepted_panels']
 N=333334;length=24;T=F(1000000);L=F(629,1250);B=T-F(1,8);R=F(2)
 old=json.loads((HERE/'em_top_horizontal_20261111.json').read_text())
 for i in range(6):
  center=F(5+2*i,8)
  for prefix,y in [('top',T),('bottom',B)]:
   m=d['models'][f'{prefix}_{i}'];assert pt(m['center'])==(center,y)
   assert F(m['radius'])==F(1,8) and F(m['outer_radius'])==1 and len(m['coefficients_zetaF'])==length
   for z in m['coefficients_zetaF']:box(z)
  for z,w in zip(d['models'][f'top_{i}']['coefficients_zetaF'],old['blocks'][i]['coefficients_zetaF']):
   for k in ('re','im'):assert F(z[k][0])<=F(w[k][0])<=F(w[k][1])<=F(z[k][1])
 m=d['models']['left'];assert pt(m['center'])==(L,T-F(1,16)) and F(m['radius'])==F(1,16)
 assert len(m['coefficients_zetaF'])==length
 for z in m['coefficients_zetaF']:box(z)
 for name,m in d['models'].items():
  assert F(m['EM_upper'])==F(1,2**38)
  assert F(m['Taylor_upper'])==(F(1,15*2**44) if name=='left' else F(1,7*2**21))
 rot={'1':(F(1),F(0)),'-1':(F(-1),F(0)),'i':(F(0),F(1)),'-i':(F(0),F(-1))}
 lengths={s:F(0) for s in ['bottom','right','top','left']};margins=[];hist={}
 panels=d['accepted_panels'];sides=[]
 for j,p in enumerate(panels):
  assert p['accepted'] and p['depth']==0 and p['end']==panels[(j+1)%14]['start']
  a,b=pt(p['start']),pt(p['end']);side=p['side']
  if not sides or sides[-1]!=side:sides.append(side)
  if side=='bottom':assert a[1]==b[1]==B and L<=a[0]<b[0]<=R;ell=b[0]-a[0]
  elif side=='right':assert a[0]==b[0]==R and B<=a[1]<b[1]<=T;ell=b[1]-a[1]
  elif side=='top':assert a[1]==b[1]==T and L<=b[0]<a[0]<=R;ell=a[0]-b[0]
  else:assert side=='left' and a[0]==b[0]==L and B<=b[1]<a[1]<=T;ell=a[1]-b[1]
  lengths[side]+=ell;hist[p['rotation']]=hist.get(p['rotation'],0)+1
  if side=='right':assert p['model'] is None and p['rotation']=='1' and F(p['strict_margin_lower'])==F(1,4)
  else:
   model=d['models'][p['model']];c=pt(model['center']);rr=F(model['radius'])
   for ep in (a,b):assert sum((ep[k]-c[k])**2 for k in (0,1))<=rr**2
   z=p['image_zeta'];box(z)
   lows={'1':F(z['re'][0]),'-1':-F(z['re'][1]),'i':-F(z['im'][1]),'-i':F(z['im'][0])}
   assert lows[p['rotation']]==F(p['strict_margin_lower'])
  margins.append((F(p['strict_margin_lower']),p['id']))
  assert margins[-1][0]>0
 assert sides==['bottom','right','top','left'] and pt(panels[0]['start'])==(L,B)
 assert lengths=={'bottom':R-L,'right':T-B,'top':R-L,'left':T-B}
 assert {k:str(v) for k,v in lengths.items()}==d['geometry']
 vertices=list(map(pt,d['polygon']['vertices']));assert len(vertices)==15 and vertices[0]==vertices[-1]
 for j,p in enumerate(panels):
  u=rot[p['rotation']];assert rp(u,vertices[j])>0 and rp(u,vertices[j+1])>0
 crossings=[cross(vertices[j],vertices[j+1]) for j in range(14)]
 assert crossings==d['polygon']['crossings'] and sum(crossings)==d['polygon']['winding']==0
 expected={'new_model_builds':7,'imported_top_models':6,'main_sum_series_exponentials':7*N,
 'other_series_exponentials':14,'logarithms':N+1,'bernoulli_corrections':224,'pochhammer_updates':441,
 'panel_visits':14,'analytic_right_visits':1,'Horner_multiplications':13*23,'Horner_additions':13*23,
 'panel_quotients':13,'failed_halfplane_attempts':0,'model_reuse_panel_visits':0}
 assert d['counts']==expected
 assert d['elapsed_seconds']<180 and d['peak_working_set_bytes']<512*1024**2
 margin,idx=min(margins);floor=F((margin*10**12).__floor__(),10**12)
 out={'status':'PASS_SAVED_DATA_INSPECTION_ONLY','receipt_sha256':PIN,'producer_sha256':d['source_sha256'],
 'actual_file_bytes':len(PATH.read_bytes()),'reported_LF_payload_bytes':d['output_bytes'],
 'minimum_margin':str(margin),'minimum_margin_panel':idx,'minimum_margin_decimal_strict_lower':str(floor),
 'rotation_counts':hist,'exact_crossings':crossings,'winding':0,'counts':expected,
 'elapsed_seconds_recorded':d['elapsed_seconds'],'peak_working_set_bytes_recorded':d['peak_working_set_bytes'],
 'scope':'Checks stored boxes/margins, enclosing imports, geometry and exact arithmetic only. Does not independently establish new EM coefficients or image enclosures.',
 'script_sha256':sha(Path(__file__))}
 Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2,sort_keys=True)+'\n',newline='\n')
 print(json.dumps(out,indent=2))
if __name__=='__main__':main()
