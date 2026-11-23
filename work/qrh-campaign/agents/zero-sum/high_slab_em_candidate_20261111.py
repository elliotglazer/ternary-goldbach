"""PREPARED ONLY: fixed high slab, six old EM jets and seven new jets.

Nothing executes on import. A coordinator authorization file is mandatory.
No builtin zeta/Hurwitz/Gamma/RS. Never import the eager old top producer.
"""
from fractions import Fraction as F
from pathlib import Path
from math import comb, factorial
import argparse, ctypes, hashlib, json, os, sys, time

HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent
T=1000000; N=333334; B=N+1; M=32; LENGTH=24
LEFT=F(629,1250); RIGHT=F(2); BOTTOM=F(T)-F(1,8); TOP=F(T)
RADIUS=F(1,8); LEFT_RADIUS=F(1,16); OUTER=F(1); PRECISION=192
SECONDS=180; MEMORY_BYTES=512*1024**2; MAX_VISITS=256; MAX_DEPTH=12
CENTERS=[F(j,8) for j in range(5,16,2)]
ERROR_EM=F(1,2**38)
ERROR_TAYLOR=F(2**48)*RADIUS**LENGTH/(1-RADIUS)
ERROR_TAYLOR_LEFT=F(2**48)*LEFT_RADIUS**LENGTH/(1-LEFT_RADIUS)
PINS={
 'zero-sum/em_top_horizontal_20261111.json':'9F8D349077CEA0598C50C61377C80A0098FFBB0EF723A0A68D85A18FC73AEC26',
 'zero-sum/em_top_horizontal_20261111.py':'F0F7B331D8C3515C88845DB08A735AF9A071CC9A3D3025A46919C400FEE03D10',
 'independent-feasibility/REVIEW_EM_TOP_HORIZONTAL_2026-11-11.md':'6E2E1C0F3283F62CF68FCCC8E90AB67F5626288353E7B9A6921BCE695425CA4E',
 'major-constants/POLYGON_CROSSING_PROOF_2026-11-11.md':'21ACEA6753546CB2D22E8BE2949FA02A3D6A030B21960C6A024731514F09E08B',
 'mellin/HIGH_SLAB_ZETA_SOURCE_ADAPTER_2026-11-11.md':'C9C4CD0156CA987D5200DA3F4AACCF3C8F1B64BD0FEADCC3F6F12F5F10ED9ED5',
 'moebius/PRINCIPAL_HIGH_ENDPOINT_SLAB_DESIGN_2026-11-11.md':'5163C4208A5FC6F670FF0EDBC149A43C38FA5246F1D6CA567C75E055DD7EA2C8',
 'major-constants/HIGH_PRINCIPAL_SLAB_SCALAR_SUPPORT_2026-11-11.md':'5176DAF690017CF8889BF14F22A882CF93B713B76D126983AAB7359BA8ECB060',
 'major-constants/check_high_slab_scalars_20261111.py':'E4D3AC6451D16F8DBFC460112F63AA667DF4A85672D3A41D42458F6321E0E499',
 'major-constants/check_high_slab_scalars_20261111.json':'3E23393B1DBD5EEFB186F8D0D6C624E71F12E3433B184A10EEBB218FA6E11E17',
}
TARGET={
 'function':'zeta(s) represented by finite entire g(s) plus EM error, divided by s-1',
 'rectangle':{'left':str(LEFT),'right':str(RIGHT),'bottom':str(BOTTOM),'top':str(TOP)},
 'T':T,'N':N,'B':B,'M':M,'Taylor_length':LENGTH,'Taylor_degree':LENGTH-1,
 'outer_radius':str(OUTER),'target_radius':str(RADIUS),'precision_bits':PRECISION,
 'new_models':7,'reused_top_models':6,'new_real_centers':[str(c) for c in CENTERS],
 'left_model_center':[str(LEFT),str(F(T)-F(1,16))],
 'left_model_radius':str(LEFT_RADIUS),
 'EM_zetaF_error_upper':str(ERROR_EM),'finite_g_outer_upper':str(2**48),
 'finite_g_Taylor_error_upper':str(ERROR_TAYLOR),
 'left_finite_g_Taylor_error_upper':str(ERROR_TAYLOR_LEFT),
 'seconds_cap':SECONDS,'memory_bytes_cap':MEMORY_BYTES,'panel_visit_cap':MAX_VISITS,'dyadic_depth_cap':MAX_DEPTH,
}

class Incomplete(Exception):pass

def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest().upper()
def point(x,y):return [str(F(x)),str(F(y))]
def pair(p):return F(p[0]),F(p[1])
def add(a,b):return (a[0]+b[0],a[1]+b[1])
def conj(a):return (a[0],-a[1])
def realproduct(a,b):return a[0]*b[0]-a[1]*b[1]
ROTATIONS={'1':(F(1),F(0)),'-1':(F(-1),F(0)),'i':(F(0),F(1)),'-i':(F(0),F(-1))}

def crossing(a,b):
 det=a[0]*b[1]-a[1]*b[0]
 if a[1]<=0<b[1] and det>0:return 1
 if b[1]<=0<a[1] and det<0:return -1
 return 0

def initial_panels():
 horizontal=[(max(LEFT,c-RADIUS),c+RADIUS) for c in CENTERS]
 out=[]
 for i,(lo,hi) in enumerate(horizontal):
  out.append({'id':f'b{i}','side':'bottom','model':f'bottom_{i}','start':point(lo,BOTTOM),'end':point(hi,BOTTOM),'depth':0})
 out.append({'id':'r','side':'right','model':None,'start':point(RIGHT,BOTTOM),'end':point(RIGHT,TOP),'depth':0})
 for i in range(5,-1,-1):
  lo,hi=horizontal[i]
  out.append({'id':f't{i}','side':'top','model':f'top_{i}','start':point(hi,TOP),'end':point(lo,TOP),'depth':0})
 out.append({'id':'l','side':'left','model':'left','start':point(LEFT,TOP),'end':point(LEFT,BOTTOM),'depth':0})
 return out

def geometry(panels):
 if not panels:raise ValueError('empty boundary')
 expected={'bottom':RIGHT-LEFT,'right':TOP-BOTTOM,'top':RIGHT-LEFT,'left':TOP-BOTTOM}
 lengths={k:F(0) for k in expected};side_order=[]
 for i,p in enumerate(panels):
  a,b=pair(p['start']),pair(p['end'])
  if p['end']!=panels[(i+1)%len(panels)]['start']:raise ValueError('boundary gap or duplicated traversal')
  s=p['side']
  if not side_order or side_order[-1]!=s:side_order.append(s)
  if s=='bottom':ok=a[1]==b[1]==BOTTOM and LEFT<=a[0]<b[0]<=RIGHT;length=b[0]-a[0]
  elif s=='right':ok=a[0]==b[0]==RIGHT and BOTTOM<=a[1]<b[1]<=TOP;length=b[1]-a[1]
  elif s=='top':ok=a[1]==b[1]==TOP and LEFT<=b[0]<a[0]<=RIGHT;length=a[0]-b[0]
  elif s=='left':ok=a[0]==b[0]==LEFT and BOTTOM<=b[1]<a[1]<=TOP;length=a[1]-b[1]
  else:raise ValueError('unknown side')
  if not ok:raise ValueError('invalid CCW side segment')
  lengths[s]+=length
 if lengths!=expected or side_order!=['bottom','right','top','left']:raise ValueError('not one complete CCW boundary')
 if panels[0]['start']!=point(LEFT,BOTTOM):raise ValueError('wrong initial corner')
 return {k:str(v) for k,v in lengths.items()}

def check_disk(p,center,radius):
 cx,cy=pair(center)
 for ep in ('start','end'):
  x,y=pair(p[ep])
  if (x-cx)**2+(y-cy)**2>radius**2:raise ValueError('panel outside original fixed-model disk')
 # A disk is convex, so both endpoint inequalities cover the full segment.

def polygon(panels):
 # Rational vertices need not equal actual endpoint images. They must lie
 # in both adjacent certified half-planes; this explicit choice is checked.
 rotations=[ROTATIONS[p['rotation']] for p in panels]
 vertices=[]
 for j,u in enumerate(rotations):
  v=add(conj(rotations[j-1]),conj(u))
  if realproduct(rotations[j-1],v)<=0 or realproduct(u,v)<=0:
   raise ValueError('adjacent half-planes lack this rational shared vertex')
  vertices.append(v)
 vertices.append(vertices[0])
 crosses=[crossing(vertices[j],vertices[j+1]) for j in range(len(panels))]
 return {'vertices':[point(*v) for v in vertices],'crossings':crosses,'winding':sum(crosses)}

def read_box(box):
 for key in ('re','im'):
  if len(box[key])!=2 or F(box[key][0])>F(box[key][1]):raise ValueError('invalid rational box')
 return box

class Runtime:
 def __init__(self):
  self.started=time.perf_counter();self.peak=0
  from ctypes import wintypes
  class PM(ctypes.Structure):
   _fields_=[('cb',wintypes.DWORD),('PageFaultCount',wintypes.DWORD)]+[(n,ctypes.c_size_t) for n in
    ['PeakWorkingSetSize','WorkingSetSize','QuotaPeakPagedPoolUsage','QuotaPagedPoolUsage',
     'QuotaPeakNonPagedPoolUsage','QuotaNonPagedPoolUsage','PagefileUsage','PeakPagefileUsage']]
  self.PM=PM;kernel=ctypes.WinDLL('kernel32');kernel.GetCurrentProcess.restype=wintypes.HANDLE
  self.handle=kernel.GetCurrentProcess();self.getmem=ctypes.WinDLL('psapi').GetProcessMemoryInfo
  self.getmem.argtypes=[wintypes.HANDLE,ctypes.POINTER(PM),wintypes.DWORD];self.getmem.restype=wintypes.BOOL
 def guard(self):
  if time.perf_counter()-self.started>SECONDS:raise Incomplete('180-second computation cap')
  p=self.PM();p.cb=ctypes.sizeof(p)
  if not self.getmem(self.handle,ctypes.byref(p),p.cb):raise Incomplete('memory counter unavailable')
  self.peak=max(self.peak,p.PeakWorkingSetSize)
  if self.peak>MEMORY_BYTES:raise Incomplete('512-MiB peak-working-set cap')

def execute(output,authorization,check_receipt=None):
 if sys.flags.optimize:raise ValueError('Python -O is rejected')
 source_sha=sha(Path(__file__))
 for rel,h in PINS.items():
  if sha(AGENTS/rel)!=h:raise ValueError('changed pinned input: '+rel)
 auth=json.loads(authorization.read_text())
 if auth.get('coordinator_authorized') is not True or auth.get('target')!=TARGET or auth.get('producer_sha256')!=source_sha:
  raise ValueError('missing exact coordinator authorization')
 if check_receipt is None and output.exists():raise ValueError('output exists; no overwrite or continuation mode')
 if output.parent.resolve()!=HERE.resolve():raise ValueError('output must be in owned zero-sum directory')
 if check_receipt is not None:
  prior=json.loads(check_receipt.read_text())
  if prior.get('source_sha256')!=source_sha or prior.get('target')!=TARGET:raise ValueError('replay target/hash mismatch')
 rt=Runtime()
 state={'status':'INCOMPLETE_PREPARATION','reason':'initializing','target':TARGET,'source_sha256':source_sha,
        'input_pins':PINS,'authorization_sha256':sha(authorization),'models':{},'attempts':[],
        'accepted_panels':[],'pending_panels':initial_panels(),'geometry':None,'polygon':None,
        'counts':{'new_model_builds':0,'imported_top_models':0,'main_sum_series_exponentials':0,
         'other_series_exponentials':0,'logarithms':0,'bernoulli_corrections':0,'pochhammer_updates':0,
         'panel_visits':0,'analytic_right_visits':0,'Horner_multiplications':0,'Horner_additions':0,
        'panel_quotients':0,'failed_halfplane_attempts':0,'model_reuse_panel_visits':0},'model_seconds':{},'output_bytes':0,
        'stage':'importing frozen top jets','active_model':None,'active_main_sum_terms':0}
 def save():
  state['elapsed_seconds']=time.perf_counter()-rt.started;state['peak_working_set_bytes']=rt.peak
  if check_receipt is not None:return
  for _ in range(8):
   payload=json.dumps(state,indent=2,sort_keys=True)+'\n';size=len(payload.encode('utf8'))
   if state['output_bytes']==size:break
   state['output_bytes']=size
  payload=json.dumps(state,indent=2,sort_keys=True)+'\n'
  tmp=output.with_suffix(output.suffix+'.tmp');tmp.write_text(payload,encoding='utf8');os.replace(tmp,output)
 try:
  # Heavy numerical library and all evaluation are strictly after authorization.
  from flint import arb,acb,acb_series,ctx
  ctx.prec=PRECISION;ctx.cap=LENGTH
  def ar(q):
   q=F(q);return arb(str(q.numerator))/q.denominator
  def rb(a):return [str(a.lower().fmpq()),str(a.upper().fmpq())]
  def cb(z):return {'re':rb(z.real),'im':rb(z.imag)}
  def ri(bounds):
   lo,hi=map(F,bounds)
   if lo>hi:raise ValueError('reversed exact interval')
   value=arb(ar((lo+hi)/2),ar((hi-lo)/2).upper())
   actual=list(map(F,rb(value)))
   if not(actual[0]<=lo<=hi<=actual[1]):raise ValueError('rational re-import narrowed interval')
   return value
  def ci(box):
   read_box(box);return acb(ri(box['re']),ri(box['im']))
  imported=json.loads((AGENTS/'zero-sum/em_top_horizontal_20261111.json').read_text())
  if imported['status']!='PASS_EXPLICIT_EM_TOP_PATH' or (imported['T'],imported['N'],imported['M'],imported['K'])!=(T,N,M,LENGTH):
   raise ValueError('wrong top receipt contract')
  if F(imported['outer_radius'])!=OUTER or F(imported['target_radius'])!=RADIUS or len(imported['blocks'])!=6:
   raise ValueError('wrong top disk geometry')
  if imported['script_sha256'].upper()!=PINS['zero-sum/em_top_horizontal_20261111.py']:
   raise ValueError('top receipt producer pin mismatch')
  jets={}
  for i,(c,row) in enumerate(zip(CENTERS,imported['blocks'])):
   rt.guard()
   if F(row['center'])!=c or len(row['coefficients_zetaF'])!=LENGTH:raise ValueError('wrong top coefficient indexing')
   if F(row['left'])!=c-RADIUS or F(row['right'])!=c+RADIUS:raise ValueError('wrong source top block')
   if F(row['EM_error_zetaF'][1])>ERROR_EM or F(row['Taylor_error_zetaF'][1])>ERROR_TAYLOR:
    raise ValueError('uniform imported error budget does not enclose source error')
   name=f'top_{i}';coeffs=[ci(z) for z in row['coefficients_zetaF']]
   jets[name]=coeffs
   state['models'][name]={'center':point(c,TOP),'origin':'immutable reviewed top coefficient boxes',
    'source_block':i,'coefficients_zetaF':[cb(z) for z in coeffs],
    'source_EM_error_zetaF':row['EM_error_zetaF'],'source_Taylor_error_zetaF':row['Taylor_error_zetaF'],
    'EM_upper':str(ERROR_EM),'Taylor_upper':str(ERROR_TAYLOR),'radius':str(RADIUS),'outer_radius':'1'}
   state['counts']['imported_top_models']+=1
  save();rt.guard()
  state['stage']='initializing finite-EM constants';logs=[]
  for n in range(1,N+1):
   logs.append(ar(n).log());state['counts']['logarithms']+=1
   if n%4096==0:rt.guard()
  lb=ar(B).log();state['counts']['logarithms']+=1
  bern=[F(1)]
  for n in range(1,2*M+1):bern.append(-sum(F(comb(n+1,k))*bern[k] for k in range(n))/F(n+1))
  coeff=[ar(bern[2*k]/factorial(2*k)) for k in range(1,M+1)]
  powers=[ar(B)**(1-2*k) for k in range(1,M+1)]
  specifications=[(f'bottom_{i}',c,BOTTOM) for i,c in enumerate(CENTERS)]+[('left',LEFT,F(T)-F(1,16))]
  for name,c,t in specifications:
   rt.guard();begin=time.perf_counter()
   state['stage']='building fixed new model';state['active_model']=name;state['active_main_sum_terms']=0
   if state['counts']['new_model_builds']>=7:raise ValueError('unexpected extra model')
   s=acb_series([acb(ar(c),ar(t)),1],prec=LENGTH);v=acb_series([0],prec=LENGTH)
   for j,l in enumerate(logs):
    v+=(-s*l).exp();state['counts']['main_sum_series_exponentials']+=1
    state['active_main_sum_terms']=j+1
    if j%2048==0:rt.guard()
   bp=(-s*lb).exp();state['counts']['other_series_exponentials']+=1
   v+=bp/2;poch=acb_series([1],prec=LENGTH);terms=acb_series([0],prec=LENGTH)
   for j in range(1,2*M):
    poch*=s+j-1;state['counts']['pochhammer_updates']+=1
    if j%2==1:
     k=(j+1)//2;terms+=coeff[k-1]*poch*powers[k-1];state['counts']['bernoulli_corrections']+=1
   v=(s-1)*(v+bp*terms)+((1-s)*lb).exp();state['counts']['other_series_exponentials']+=1
   jet=[v[j] for j in range(LENGTH)]
   radius=LEFT_RADIUS if name=='left' else RADIUS
   etay=ERROR_TAYLOR_LEFT if name=='left' else ERROR_TAYLOR
   jets[name]=jet;state['models'][name]={'center':point(c,t),'origin':'new finite entire g EM Taylor model',
    'coefficients_zetaF':[cb(z) for z in jet],'EM_upper':str(ERROR_EM),'Taylor_upper':str(etay),
    'radius':str(radius),'outer_radius':'1'}
   state['counts']['new_model_builds']+=1;state['model_seconds'][name]=time.perf_counter()-begin
   state['active_model']=None;state['active_main_sum_terms']=0
   save();rt.guard()
  state['stage']='covering closed boundary'
  visited_models=set()
  while state['pending_panels']:
   rt.guard()
   if state['counts']['panel_visits']>=MAX_VISITS:raise Incomplete('256 panel-visit cap')
   p=state['pending_panels'][0];record=dict(p);state['counts']['panel_visits']+=1
   if p['side']=='right':
    state['counts']['analytic_right_visits']+=1
    record.update({'accepted':True,'rotation':'1','strict_margin_lower':'1/4',
     'proof':'Re(zeta(2+it))>=2-zeta(2)>1/4 by absolute series; no numerical right model'})
   else:
    name=p['model'];model=state['models'][name];check_disk(p,model['center'],F(model['radius']))
    if name in visited_models:state['counts']['model_reuse_panel_visits']+=1
    visited_models.add(name)
    ax,ay=pair(p['start']);bx,by=pair(p['end']);cx,cy=pair(model['center'])
    if min(ax,bx)<LEFT or max(ax,bx)>RIGHT or min(ay,by)<BOTTOM or max(ay,by)>TOP:
     raise ValueError('panel outside actual-region EM domain')
    ss=acb(ri([str(min(ax,bx)),str(max(ax,bx))]),ri([str(min(ay,by)),str(max(ay,by))]))
    zz=acb(ri([str(min(ax,bx)-cx),str(max(ax,bx)-cx)]),ri([str(min(ay,by)-cy),str(max(ay,by)-cy)]))
    value=jets[name][-1]
    for a in reversed(jets[name][:-1]):
     value=value*zz+a;state['counts']['Horner_multiplications']+=1;state['counts']['Horner_additions']+=1
    den=ss-1
    error=arb(0,ar(F(model['EM_upper'])+F(model['Taylor_upper'])).upper());errorbox=acb(error,error)
    # Imaginary lower bound excludes zero on every complete rectangle input.
    if F(rb(den.imag)[0])<=0:raise ValueError('quotient denominator may contain zero')
    value=(value+errorbox)/den;state['counts']['panel_quotients']+=1
    box=cb(value);read_box(box)
    lower={'1':F(box['re'][0]),'-1':-F(box['re'][1]),'i':-F(box['im'][1]),'-i':F(box['im'][0])}
    rotation=max(lower,key=lower.get);margin=lower[rotation]
    record.update({'image_zeta':box,'rotation':rotation,'strict_margin_lower':str(margin),'accepted':margin>0})
   state['attempts'].append(record)
   if record['accepted']:
    state['accepted_panels'].append(record);state['pending_panels'].pop(0)
   else:
    state['counts']['failed_halfplane_attempts']+=1
    if p['depth']>=MAX_DEPTH:raise Incomplete('dyadic depth-12 cap; failing panel retained')
    a,b=pair(p['start']),pair(p['end']);mid=point((a[0]+b[0])/2,(a[1]+b[1])/2)
    child0=dict(p,id=p['id']+'0',end=mid,depth=p['depth']+1)
    child1=dict(p,id=p['id']+'1',start=mid,depth=p['depth']+1)
    state['pending_panels'][0:1]=[child0,child1]
   if state['counts']['panel_visits']%8==0:save()
  state['geometry']=geometry(state['accepted_panels'])
  state['polygon']=polygon(state['accepted_panels'])
  if (state['counts']['new_model_builds'],state['counts']['imported_top_models'])!=(7,6):raise ValueError('incomplete model manifest')
  if state['polygon']['winding']==0:
   state['status']='PASS_EXTERNAL_HIGH_SLAB_WINDING_ZERO';state['reason']='complete closed boundary; every full panel certified; exact CCW winding zero'
  else:
   state['status']='COMPLETE_BOUNDARY_NONZERO_WINDING';state['reason']='boundary certified but zero-exclusion target not established'
  state['stage']='complete'
  rt.guard()
 except Incomplete as exc:
  state['status']='INCOMPLETE_CAP';state['reason']=str(exc)
 except (AssertionError,ValueError,ArithmeticError,RuntimeError) as exc:
  state['status']='INCOMPLETE_VALIDATION_FAILURE';state['reason']=type(exc).__name__+': '+str(exc)
 finally:save()
 if check_receipt is not None:
  keys=('status','reason','target','source_sha256','input_pins','models','attempts','accepted_panels','pending_panels','geometry','polygon','counts')
  for key in keys:
   if state[key]!=prior[key]:raise ValueError('exact replay differs at '+key)
 print(json.dumps({k:state[k] for k in ('status','reason','counts','elapsed_seconds','peak_working_set_bytes','output_bytes')}))
 return 0 if state['status']=='PASS_EXTERNAL_HIGH_SLAB_WINDING_ZERO' else 2

def main():
 parser=argparse.ArgumentParser(description=__doc__)
 parser.add_argument('--authorize',type=Path,required=True)
 parser.add_argument('--output',type=Path,required=True)
 parser.add_argument('--check',type=Path)
 args=parser.parse_args()
 return execute(args.output,args.authorize,args.check)

if __name__=='__main__':sys.exit(main())
