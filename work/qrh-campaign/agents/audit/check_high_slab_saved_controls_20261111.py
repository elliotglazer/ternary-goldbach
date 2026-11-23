"""Saved rational data only; no author imports, analytic evaluation or Lean."""
from fractions import Fraction as F
from pathlib import Path
import ast, copy, hashlib, json

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
SOURCE = AGENTS/'zero-sum/high_slab_em_candidate_20261111.py'
DATA = AGENTS/'zero-sum/high_slab_em_candidate_20261111_01.json'
SOURCE_SHA = 'AA4496B7EE84D4BCA497B5BDFFC237A6DC0949F45C5F9E134B29498C5B58D084'
DATA_SHA = 'CF90E96C7531F57E455ABCE70D8D71FB06596E9E1490FADDBAFA6DE64FCB0B09'
def digest(p): return hashlib.sha256(p.read_bytes()).hexdigest().upper()
def need(ok, label):
    if not ok: raise ValueError(label)
def pt(p): return tuple(map(F,p))
def box(z):
    need(set(z)=={'re','im'}, 'complex box keys')
    for a in ('re','im'):
        need(len(z[a])==2 and F(z[a][0])<=F(z[a][1]), 'ordered box')
    return tuple(F(z[a][j]) for a in ('re','im') for j in (0,1))

L,R,Y,T=F(629,1250),F(2),F(7999999,8),F(1000000)
CENTERS=[F(j,8) for j in range(5,16,2)]
TARGET={
 'function':'zeta(s) represented by finite entire g(s) plus EM error, divided by s-1',
 'rectangle':{'left':str(L),'right':str(R),'bottom':str(Y),'top':str(T)},
 'T':1000000,'N':333334,'B':333335,'M':32,'Taylor_length':24,'Taylor_degree':23,
 'outer_radius':'1','target_radius':'1/8','precision_bits':192,'new_models':7,
 'reused_top_models':6,'new_real_centers':list(map(str,CENTERS)),
 'left_model_center':[str(L),'15999999/16'],'left_model_radius':'1/16',
 'EM_zetaF_error_upper':str(F(1,2**38)),'finite_g_outer_upper':str(2**48),
 'finite_g_Taylor_error_upper':str(F(1,7*2**21)),
 'left_finite_g_Taylor_error_upper':str(F(1,15*2**44)),
 'seconds_cap':180,'memory_bytes_cap':512*1024**2,'panel_visit_cap':256,'dyadic_depth_cap':12}
ROT={'1':(F(1),F(0)),'-1':(F(-1),F(0)),'i':(F(0),F(1)),'-i':(F(0),F(-1))}
def product_real(u,v): return u[0]*v[0]-u[1]*v[1]
def cross(a,b):
    # Solve for the real coordinate of the intersection with Im=0.
    if a[1]<=0<b[1]:
        x=(a[0]*b[1]-b[0]*a[1])/(b[1]-a[1])
        return int(x>0)
    if b[1]<=0<a[1]:
        x=(a[0]*b[1]-b[0]*a[1])/(b[1]-a[1])
        return -int(x>0)
    return 0

def validate(d, old, pins):
    need(d['target']==TARGET,'exact target')
    need(d['source_sha256']==SOURCE_SHA and d['input_pins']==pins,'source/input pins')
    need(d['status']=='PASS_EXTERNAL_HIGH_SLAB_WINDING_ZERO' and d['stage']=='complete','success status')
    need(d['pending_panels']==[],'remaining coverage')
    models=d['models']
    names={f'{side}_{j}' for side in ('bottom','top') for j in range(6)}|{'left'}
    need(set(models)==names,'exact model set')
    for name,m in models.items():
        left=name=='left'; side=name.split('_')[0]
        c=L if left else CENTERS[int(name.split('_')[1])]
        y=(T-F(1,16)) if left else Y if side=='bottom' else T
        radius=F(1,16) if left else F(1,8)
        need(pt(m['center'])==(c,y),'model center')
        need(F(m['radius'])==radius and F(m['outer_radius'])==1,'model radius')
        need(F(m['EM_upper'])==F(1,2**38),'model EM allowance')
        need(F(m['Taylor_upper'])==F(2**48)*radius**24/(1-radius),'model Taylor allowance')
        need(len(m['coefficients_zetaF'])==24,'coefficient length')
        for z in m['coefficients_zetaF']: box(z)
        if side=='top':
            j=int(name.split('_')[1]); orig=old['blocks'][j]
            for z,oz in zip(m['coefficients_zetaF'],orig['coefficients_zetaF']):
                a,b,c,e=box(z); aa,bb,cc,ee=box(oz)
                need(a<=aa<=bb<=b and c<=cc<=ee<=e,'full old coefficient containment')
            need(F(orig['EM_error_zetaF'][1])<=F(m['EM_upper']) and
                 F(orig['Taylor_error_zetaF'][1])<=F(m['Taylor_upper']),'old error containment')
    ps=d['accepted_panels']
    need(len(ps)==14 and d['attempts']==ps,'fourteen successful initial attempts')
    expected=[]
    for j,c in enumerate(CENTERS): expected.append(('bottom',f'bottom_{j}',(max(L,c-F(1,8)),Y),(c+F(1,8),Y)))
    expected.append(('right',None,(R,Y),(R,T)))
    for j in reversed(range(6)):
        c=CENTERS[j]; expected.append(('top',f'top_{j}',(c+F(1,8),T),(max(L,c-F(1,8)),T)))
    expected.append(('left','left',(L,T),(L,Y)))
    lengths={k:F(0) for k in ('bottom','right','top','left')}; area2=F(0); margins=[]
    for j,(p,(side,model,a,b)) in enumerate(zip(ps,expected)):
        need(p['side']==side and p['model']==model,'side/model association')
        need(pt(p['start'])==a and pt(p['end'])==b,'oriented panel endpoints')
        need(pt(p['end'])==pt(ps[(j+1)%14]['start']),'closed adjacency')
        need(p['accepted'] is True and p['depth']==0,'initial panel accepted')
        lengths[side]+=abs(b[0]-a[0])+abs(b[1]-a[1]); area2+=a[0]*b[1]-a[1]*b[0]
        if model is not None:
            m=models[model]; c=pt(m['center']); rad=F(m['radius'])
            for e in (a,b): need(sum((e[k]-c[k])**2 for k in (0,1))<=rad**2,'model disk membership')
            lo,hi,il,ih=box(p['image_zeta'])
            lowers={'1':lo,'-1':-hi,'i':-ih,'-i':il}
            need(p['rotation'] in lowers,'known rotation')
            margin=lowers[p['rotation']]
            need(margin==max(lowers.values()),'chosen signed coordinate')
        else:
            need(p['rotation']=='1' and 'image_zeta' not in p,'analytic right edge')
            need(p['proof']=='Re(zeta(2+it))>=2-zeta(2)>1/4 by absolute series; no numerical right model','right edge analytic leaf')
            margin=F(1,4)
        need(F(p['strict_margin_lower'])==margin and margin>0,'strict whole-box margin')
        margins.append(margin)
    need(area2==2*(R-L)*(T-Y)>0,'CCW exact area')
    need(lengths=={'bottom':R-L,'right':T-Y,'top':R-L,'left':T-Y},'complete side lengths')
    need(d['geometry']=={k:str(v) for k,v in lengths.items()},'saved geometry')
    vs=list(map(pt,d['polygon']['vertices']))
    need(len(vs)==15 and vs[0]==vs[-1],'one closed vertex list')
    for j,p in enumerate(ps):
        u=ROT[p['rotation']]; prev=ROT[ps[j-1]['rotation']]
        need(vs[j]==(u[0]+prev[0],-u[1]-prev[1]),'shared vertex recipe')
        need(product_real(u,vs[j])>0 and product_real(u,vs[j+1])>0,'both shared vertices in panel halfplane')
    cs=[cross(vs[j],vs[j+1]) for j in range(14)]
    need(cs==d['polygon']['crossings'],'exact crossing list')
    need(sum(cs)==d['polygon']['winding']==0,'exact winding zero')
    for k,v in {'new_model_builds':7,'imported_top_models':6,'panel_visits':14,
                'failed_halfplane_attempts':0,'analytic_right_visits':1}.items():
        need(d['counts'][k]==v,'model/panel counters')
    return {'panels':14,'models':13,'coefficient_boxes':312,'old_coefficient_containments':144,
            'side_lengths':{k:str(v) for k,v in lengths.items()},'twice_area':str(area2),
            'minimum_saved_margin':str(min(margins)),'crossings':cs,'winding':sum(cs)}

def main():
    need(digest(SOURCE)==SOURCE_SHA and digest(DATA)==DATA_SHA,'frozen input hashes')
    # Extract only a literal hash table. No producer import or execution.
    tree=ast.parse(SOURCE.read_text())
    assignment=next(n for n in tree.body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='PINS' for t in n.targets))
    pins=ast.literal_eval(assignment.value)
    for path,h in pins.items(): need(digest(AGENTS/path)==h,'pinned source dependency')
    old=json.loads((AGENTS/'zero-sum/em_top_horizontal_20261111.json').read_text())
    d=json.loads(DATA.read_text()); baseline=validate(d,old,pins)
    def both(x,j,key,value):
        x['accepted_panels'][j][key]=copy.deepcopy(value)
        x['attempts'][j][key]=copy.deepcopy(value)
    mutations=[
        ('target',lambda x:x['target']['rectangle'].__setitem__('left','1/2')),
        ('gap',lambda x:both(x,0,'end',['749/1000',str(Y)])),
        ('orientation',lambda x:both(x,6,'start',[str(R),str(T)])),
        ('wrong_model',lambda x:both(x,0,'model','top_0')),
        ('model_center',lambda x:x['models']['left'].__setitem__('center',['1/2','15999999/16'])),
        ('model_radius',lambda x:x['models']['left'].__setitem__('radius','1/8')),
        ('lost_positive_image',lambda x:both(x,0,'image_zeta',{'re':['-1','1'],'im':['-1','1']})),
        ('false_margin',lambda x:both(x,0,'strict_margin_lower','1')),
        ('wrong_rotation',lambda x:both(x,0,'rotation','i')),
        ('zero_vertex',lambda x:x['polygon']['vertices'].__setitem__(1,['0','0'])),
        ('crossing',lambda x:x['polygon']['crossings'].__setitem__(0,1)),
        ('winding',lambda x:x['polygon'].__setitem__('winding',1)),
        ('old_box_narrowing',lambda x:x['models']['top_0']['coefficients_zetaF'].__setitem__(0,{'re':['0','0'],'im':['0','0']})),
    ]
    controls=[]
    for name,mutate in mutations:
        changed=copy.deepcopy(d); mutate(changed)
        try: validate(changed,old,pins)
        except ValueError as ex: controls.append({'case':name,'rejected':True,'reason':str(ex)})
        else: raise AssertionError('corruption accepted: '+name)
    result={'status':'PASS_SAVED_DATA_CONSISTENCY_ONLY','receipt_sha256':DATA_SHA,
            'producer_sha256':SOURCE_SHA,'review_script_sha256':digest(Path(__file__)),
            'baseline':baseline,'negative_controls':controls,
            'actual_file_bytes':DATA.stat().st_size,'saved_output_bytes':d['output_bytes'],
            'scope':'No analytic model recomputation; new coefficient and image true-value containment remains separate.'}
    out=HERE/'check_high_slab_saved_controls_20261111.json'
    out.write_text(json.dumps(result,indent=2)+'\n',encoding='utf8',newline='\n')
    print(json.dumps(result,indent=2))

if __name__=='__main__':main()
