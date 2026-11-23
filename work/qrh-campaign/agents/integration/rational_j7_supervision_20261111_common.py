"""Prepared strict wire/ownership layer. No worker import or native call."""
import ast
import hashlib
import json
import os
from math import gcd, isfinite
from pathlib import Path
import re

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
EXE = Path('C:/Users/glaze/AppData/Local/Python/pythoncore-3.14-64/python.exe')
EXE_SHA = '4942B86A6597E5AEE0128DAA00050ED79BC21F6E709A78EB19CBFEB0C2F39AC9'
RUNTIME = {'python314.dll':'0F9857FFDFE010FE6B99328D58C2E3C7472CE75F336BF9C2AD9BD5BCA3BCE700',
 'DLLs/_hashlib.pyd':'5933EF5EDA7C0BCA0B3874A6E2C5F13B91B8F2CFC29BC46160DF3212A1DBEE79',
 'Lib/hashlib.py':'271B00A30D27C3CDD99B7F70962680F8455D3057B3C103F028E2DA31141B91EE',
 'Lib/json/__init__.py':'27C55BB12498822E527294B61DB64BA44C79A18D4BAAD651B1660714A9785C4E',
 'Lib/pathlib/__init__.py':'208546AA566CA8DF4B8E1259F30209C0F803C3F920E6D080AE1B10D53D05BD72'}
PRODUCER = 'integration/rational_direct_g_j7_producer_20261111.py'
INDEPENDENT = 'moebius/rational_direct_g_j7_independent_20261111.py'
FIXED = {
 PRODUCER:'B633D322F0B696CDF59FEDB668CE62F4EE13E5BFAC28BC0959E9AF13E37315D7',
 INDEPENDENT:'4762265952B7DD4E5382BC0426205A84BB766EFA43A872DDD6E148EF15674FDC',
 'integration/small_em_batch_candidate_20261111_01.json':'2ADDFE3FE7D77B8CC10606886CC580D5C8103B30B0E4CD3BC9507AB27B198F7E',
 'audit/c8_supervisor_capability_preflight_20261111_v5.py':'882762361FC9E3AE2AF876CB604E6EA8CCDA2E6C2251872DD79B2593F0953A85',
 'audit/coordinator_c8_capability_run_20261111_v5.py':'00B5503D4C6E1B085A5B417AD432F985DFC60A4ADEEE318F133FB8DC437D2EA9',
 'integration/RATIONAL_J7_NUMERICAL_SUPERVISOR_DESIGN_2026-11-11.md':'E3FF0DD6DB600A42496767254CFE44322F1E92F5CE564EB97DC95150B6E60150',
 'moebius/REVIEW_RATIONAL_J7_NUMERICAL_SUPERVISOR_DESIGN_2026-11-11.md':'DC0A0E113DE9FF002C4710EB15865F7067DBAD2D5C7C902BBE81AA60DF769CA0',
}
CAP = 16*1024*1024
PREFIX = 'rational_j7_supervision_20261111'
MODULES = [PREFIX+'_common.py', PREFIX+'_native.py', PREFIX+'_managed.py', PREFIX+'_run.py']
CAPABILITY = {
 'outer':dict(path='audit/coordinator_c8_capability_20261111_v5.json',sha256='9B6F43898F34A97B974767FB1602F7F71B3DFCDEDC2DADE75B44E3694439416A'),
 'inner':dict(path='audit/c8_benign_attempt_20261111_v5/completion.json',sha256='86EA85EEE007381124664995342E86896E64C5378C1835E054E7129284858CA5'),
 'observed':dict(path='audit/coordinator_c8_capability_observed_result_20261111_v5.json',sha256='CDF1E06C9DEC5324CABCA91929162FC9DCA7B3926F3BF2F33BA674B712CDC407'),
 'review':dict(path='independent-feasibility/REVIEW_C8_DETACHED_V5_RESULT_2026-11-11.md',sha256='1CEC5660F630F4AE7AAC3B105B683E3705EC89C838416954E7A8032914FB61FE')}

def need(ok, reason):
    if not ok: raise RuntimeError(reason)

def exact(a,b):
    return type(a) is type(b) and (set(a)==set(b) and all(exact(a[k],b[k]) for k in a) if type(a) is dict
           else len(a)==len(b) and all(exact(x,y) for x,y in zip(a,b)) if type(a) is list else a==b)

def encode(x):
    return (json.dumps(x,ensure_ascii=True,allow_nan=False,sort_keys=True,separators=(',',':'))+'\n').encode('ascii')

def unique(pairs):
    d={}
    for k,v in pairs:
        need(k not in d,'duplicate JSON key'); d[k]=v
    return d

def read(path,cap=65536):
    need(path.stat().st_size<=cap,'input size cap')
    with path.open('rb') as f: data=f.read(cap+1)
    need(len(data)<=cap,'input grew beyond cap'); return data

def load(path,cap=65536):
    return json.loads(read(path,cap),object_pairs_hook=unique,
                      parse_constant=lambda x: (_ for _ in ()).throw(RuntimeError('nonfinite JSON')))

def sha(path):
    h=hashlib.sha256()
    with path.open('rb') as f:
        for b in iter(lambda:f.read(65536),b''): h.update(b)
    return h.hexdigest().upper()

def clean(path):
    path=Path(path).absolute()
    need(path==path.resolve(),'noncanonical path')
    for p in (path,*path.parents):
        if p.exists():
            need(not p.is_symlink() and not (p.lstat().st_file_attributes & 0x400),'reparse path')
    return path

def relative(s):
    need(type(s) is str and '\\' not in s and not Path(s).is_absolute(),'relative wire path')
    p=clean(AGENTS/s)
    need(p.is_relative_to(AGENTS) and p.relative_to(AGENTS).as_posix()==s,'canonical relative path')
    return p

def ref(r,cap=CAP):
    need(type(r) is dict and set(r)=={'path','sha256'},'reference fields')
    need(type(r['sha256']) is str and re.fullmatch('[A-F0-9]{64}',r['sha256']),'reference digest')
    p=relative(r['path']); need(p.is_file() and p.stat().st_size<=cap,'reference size/type')
    need(sha(p)==r['sha256'],'reference hash'); return p

def literal_pins():
    # Parse only a hash-pinned literal; never import/execute the worker.
    path=relative(PRODUCER); need(sha(path)==FIXED[PRODUCER],'producer pin')
    tree=ast.parse(read(path,128*1024).decode('utf-8-sig'))
    matches=[n.value for n in tree.body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='PINS' for t in n.targets)]
    need(len(matches)==1,'single PINS literal'); pins=ast.literal_eval(matches[0])
    need(type(pins) is dict and len(pins)==12,'twelve pinned sources'); return pins

def parameters():
    q=lambda n,d=1:dict(numerator=str(n),denominator=str(d))
    return dict(N=1024,B=1025,M=16,K=16,j=7,center=dict(re=q(629,1250),im=q(31985,16)),outer_radius=q(1),panel_radius=q(1,16))

def recipe():
    return dict(name='horner-j7-v1',rounding='floor(x*2^g+1/2); ties toward +infinity',
        inner_grid=1041,canonical_grid=1025,outer_grid=513,log_terms=512,atan_terms=256,exp_terms=513,
        real_squarings=4,raw_log2_cache=True,log_order='n ascending; all512 updates except n1',
        head_order='n ascending',normalization='complex-s derivative / h!',period='floor(theta/(2*pi_hat)+1/2)',
        digest='sha256 real-gate (g,p,q,m,remainder) decimal lines',finite_g_rounds=['completed head','completed full correction','assembled g'])

PRODUCER_CONTROLS=['changed j index','changed center','endpoint owner','omitted n1024','changed signed Bernoulli',
 'omitted B pole polynomial coefficient','shifted elementary center','invalid signed tie rounding witness',
 'omitted analytic Taylor tail','changed immutable endpoint image']
INDEPENDENT_CONTROLS=['changed_center','changed_index','wrong_endpoint_owner','omitted_n1024','signed_bernoulli',
 'omitted_B_pole_term','shifted_elementary_center','invalid_rounding_witness','omitted_Taylor_tail','changed_immutable_endpoint']

def validate_authorization(path):
    path=clean(path); m=load(path)
    need(set(m)=={'schema','authorize','phase','token','sources','worker_review','worker_preparation',
                 'capability','host_capability','static_review','host_contract','host_source','host_review','host_source_sha256','host_start_ns','prior','output_name'},'authorization keys')
    need(m['schema']=='rational-j7-supervision-1' and m['authorize']=='ONE_REVIEWED_NUMERICAL_PHASE','authorization')
    need(m['phase'] in ('producer','independent') and type(m['token']) is str and re.fullmatch('[a-f0-9]{32}',m['token']),'phase/token')
    need(type(m['host_start_ns']) is int and m['host_start_ns']>0,'host precreation clock')
    need(type(m['host_source_sha256']) is str and re.fullmatch('[A-F0-9]{64}',m['host_source_sha256']),'reviewed host source hash')
    need(ref(m['host_source'],131072).suffix=='.py' and m['host_source']['sha256']==m['host_source_sha256'],'host source reference')
    need(ref(m['host_review'],512*1024).suffix=='.md','host source review')
    host_capability(m['host_capability'])
    need(m['output_name']=='rational_j7_'+m['phase']+'_'+m['token']+'.json','fixed output name')
    need(set(m['sources'])==set(MODULES),'complete supervisor sources')
    for name,h in m['sources'].items(): need(sha(clean(HERE/name))==h,'supervisor source pin')
    for name,h in {**FIXED,**literal_pins()}.items(): need(sha(relative(name))==h,'fixed source '+name)
    need(sha(clean(EXE))==EXE_SHA,'interpreter pin')
    for name,h in RUNTIME.items(): need(sha(clean(EXE.parent/name))==h,'runtime pin '+name)
    for k in ('worker_review','worker_preparation','static_review','host_contract'): ref(m[k],512*1024)
    cap=m['capability']; need(exact(cap,CAPABILITY),'exact accepted capability packet')
    files={k:ref(v,4*1024*1024) for k,v in cap.items()}
    outer,inner,observed=(load(files[k],4*1024*1024) for k in ('outer','inner','observed'))
    need(outer.get('status')=='PASS' and inner.get('status')=='PASS','capability still failed/unavailable')
    # The observation's historical pending-review status is superseded by the
    # exact independently reviewed packet above; do not edit the old observation.
    need(type(observed.get('observed_outer_exit_code')) is int and observed['observed_outer_exit_code']==0
         and observed.get('outer_record_sha256')==cap['outer']['sha256']
         and observed.get('inner_record_sha256')==cap['inner']['sha256'],'capability observed exit/bindings')
    need(outer.get('completion_sha256')==cap['inner']['sha256'],'capability inner/outer binding')
    if m['phase']=='producer': need(m['prior'] is None,'producer has no prior phase')
    else:
        need(type(m['prior']) is dict and set(m['prior'])=={'authorization','r_seal','host','candidate'},'prior chain')
        need(validate_host_chain(m['prior'])['phase']=='producer','independent needs a producer prior')
    return m

def worker_paths(m):
    folder=HERE if m['phase']=='producer' else AGENTS/'moebius'
    p=clean(folder/m['output_name'])
    suffixes=['.json','.pending','.attempt.json','.failure.json','.completion.json'] if m['phase']=='producer' else ['.json','.attempt.json']
    return [p.with_suffix(s) for s in suffixes]

def worker_manifest(m,pid):
    base=dict(runtime_authorized=True,pins=literal_pins(),output=m['output_name'],
              caps=dict(seconds=600 if m['phase']=='producer' else 900,peak_working_set_bytes=512*1024**2,aggregate_bytes=CAP),
              static_review=m['worker_review'],preparation=m['worker_preparation'],
              supervision=dict(protocol='external-retained-handle-v1',supervisor_pid=pid,post_exit_seal_required=True,no_children=True))
    if m['phase']=='producer': base.update(producer_code_sha256=FIXED[PRODUCER],parameters=parameters())
    else: base.update(independent_code_sha256=FIXED[INDEPENDENT],producer_code=PRODUCER,
              producer_code_sha256=FIXED[PRODUCER],producer_receipt=m['prior']['candidate']['path'],
              producer_receipt_sha256=m['prior']['candidate']['sha256'])
    return base

class Ownership:
    def __init__(self,m,authorization):
        self.m=m; self.directory=clean(HERE/(PREFIX+'_'+m['token']))
        self.worker=worker_paths(m); self.authorization=clean(authorization)
    def inventory(self):
        files=[self.authorization]
        expected=set(self.worker)
        for p in self.worker[0].parent.glob(self.worker[0].stem+'.*'):
            need(clean(p) in expected and p.is_file(),'unexpected worker-family entry')
        if self.directory.exists():
            for p in self.directory.iterdir():
                names={'r_attempt.json','r_ticket.json','s_attempt.json','s_startup.json','worker_manifest.json',
                       's_seal.json','r_seal.json','s_failure.json','r_failure.json','host.json','host_failure.json',
                       's.stdout','s.stderr','w.stdout','w.stderr','host.stdout','host.stderr'}
                clean(p); need(p.is_file() and (p.name in names or p.name.endswith('.pending') and p.name[:-8] in names),'unexpected owned entry'); files.append(p)
        files += [p for p in self.worker if p.exists()]
        return [dict(path=p.relative_to(AGENTS).as_posix(),bytes=p.stat().st_size) for p in files]
    def guard(self,reserve=65536):
        inv=self.inventory(); need(sum(x['bytes'] for x in inv)+reserve<=CAP,'phase aggregate cap/reserve')
        streams=sum(x['bytes'] for x in inv if x['path'].endswith(('.stdout','.stderr')))
        need(streams<=65536,'shared stdout/stderr cap')
        metadata=sum(x['bytes'] for x in inv if not x['path'].endswith(('.stdout','.stderr')) and x['path']!=self.worker[0].relative_to(AGENTS).as_posix()
                     and not x['path'].endswith(('.pending','.failure.json')))
        need(metadata<=131072,'metadata cap'); return inv
    def publish(self,name,data,cap=32768):
        need(re.fullmatch(r'[a-z_]+\.json',name),'owned record name')
        raw=encode(data); need(len(raw)<=cap,'record reservation')
        self.guard(len(raw)+65536)
        dest=self.directory/name; tmp=self.directory/(name+'.pending')
        need(not dest.exists() and not tmp.exists(),'no overwrite')
        with tmp.open('xb') as f: f.write(raw); f.flush(); os.fsync(f.fileno())
        need(not dest.exists(),'destination appeared'); os.rename(tmp,dest)
        self.guard(); return dest

def output_summary(m):
    p=worker_paths(m)[0]; r=load(p,CAP)
    need(not p.with_suffix('.pending').exists() and not p.with_suffix('.failure.json').exists(),'failed/partial worker publication')
    wire_bounds(r)
    need(r.get('status')==('CANDIDATE' if m['phase']=='producer' else 'ARITHMETIC_CANDIDATE'),'worker status')
    if m['phase']=='producer':
        need(r.get('schema')=='rational-direct-g-j7-v1' and r.get('producer_code_sha256')==FIXED[PRODUCER],'producer binding')
        need(exact(r.get('parameters'),parameters()) and exact(r.get('pins'),literal_pins()),'target/source binding')
        need(exact(r.get('recipe'),recipe()),'exact deterministic recipe')
        for field,count in [('logs',1025),('phases',1025),('head',16),('correction',16),('g',16)]:
            need(type(r.get(field)) is list and len(r[field])==count,'complete '+field)
            label='n' if count==1025 else 'h'; start=1 if count==1025 else 0
            for i,row in enumerate(r[field],start): need(type(row) is dict and type(row.get(label)) is int and row[label]==i,'ordered labels')
        old=load(relative('integration/small_em_batch_candidate_20261111_01.json'),CAP)
        target=r.get('target',{})
        keys(target,['sha256','g_jets','panel','endpoints','analytical_budget'])
        need(target.get('sha256')==FIXED['integration/small_em_batch_candidate_20261111_01.json'],'target receipt hash')
        need(exact(target.get('g_jets'),old['g_jets'][7]) and exact(target.get('panel'),old['panels'][7])
             and exact(target.get('endpoints'),old['endpoints'][7:9]),'all immutable target components')
        need(exact(target.get('analytical_budget'),{k:old['analytical_budget'][k] for k in ('EM','Taylor')}),'fixed analytic pads')
        need(exact(r.get('images'),dict(panel=old['panels'][7],endpoints=old['endpoints'][7:9])),'all three immutable images')
        comp=load(p.with_suffix('.completion.json'))
        keys(comp,['status','sha256','bytes','telemetry','external_post_exit_seal_required','independent_acceptance_required'])
        need(comp.get('status')=='CANDIDATE' and comp.get('sha256')==sha(p) and type(comp.get('bytes')) is int
             and comp['bytes']==p.stat().st_size,'producer completion binding')
        worker_telemetry(comp['telemetry'],'producer')
        need(comp.get('external_post_exit_seal_required') is True and comp.get('independent_acceptance_required') is True,'completion scope')
        controls=r.get('negative_controls')
        need(type(controls) is list and len(controls)==10 and all(type(x) is dict and x.get('rejected') is True for x in controls)
             and [x.get('name') for x in controls]==PRODUCER_CONTROLS,'producer control identities')
    else:
        need(r.get('schema')=='rational-direct-g-j7-independent-v1','independent schema')
        need(r.get('producer_receipt_sha256')==m['prior']['candidate']['sha256'] and r.get('independent_source_sha256')==FIXED[INDEPENDENT],'independent binding')
        need(r.get('producer_source_sha256')==FIXED[PRODUCER] and r.get('target_sha256')==FIXED['integration/small_em_batch_candidate_20261111_01.json']
             and r.get('spec_sha256')==literal_pins()['major-constants/RATIONAL_DIRECT_G_J7_PILOT_SPECIFICATION_2026-11-11.md'],'independent target/spec')
        need(exact(r.get('counts'),dict(producer_logs=1025,producer_phases=1025,independent_logs=1025,independent_phases=1025,independent_g=16,images=3)),'independent coverage')
        need(len(r.get('independent_leaves',[]))==1025 and len(r.get('independent_g',[]))==16 and len(r.get('negative_controls',[]))==10,'independent arrays')
        for field,count,label,start in [('independent_leaves',1025,'n',1),('independent_g',16,'h',0)]:
            for i,row in enumerate(r[field],start): need(type(row.get(label)) is int and row[label]==i,'independent labels')
        need(exact(r.get('negative_controls'),INDEPENDENT_CONTROLS),'independent control identities')
    structured_output(r,m['phase'])
    return dict(path=p.relative_to(AGENTS).as_posix(),sha256=sha(p))

def keys(x,expected):
    need(type(x) is dict and set(x)==set(expected),'exact record keys')

def qshape(x):
    keys(x,['numerator','denominator']); n,d=decimal(x['numerator']),decimal(x['denominator'])
    need(d>0 and gcd(n,d)==1,'rational canonical form')

def dshape(x,exponent=None,zero=False):
    keys(x,['mantissa','exponent']); n=decimal(x['mantissa']); e=x['exponent']
    need(type(e) is int and abs(e)<=32768 and (n%2!=0 or n==0 and e==0),'dyadic canonical form')
    need(n.bit_length()+max(e,0)<=65536,'expanded numerator bound')
    if exponent is not None: need(exact(x,dict(mantissa='0',exponent=0) if zero else dict(mantissa='1',exponent=exponent)),'fixed radius')

def zshape(z,kind=dshape):
    keys(z,['re','im']); kind(z['re']); kind(z['im'])

def trace_shape(t,count=None):
    keys(t,['count','sha256'])
    need(type(t['count']) is int and t['count']>=0 and (count is None or t['count']==count),'trace count')
    need(type(t['sha256']) is str and re.fullmatch('[A-F0-9]{64}',t['sha256']),'trace hash')

def structured_output(r,phase):
    """Closed structural schema; arithmetic truth remains the executed worker's claim."""
    if phase=='producer':
        keys(r,['schema','status','producer_code_sha256','pins','parameters','target','recipe','scalar_checks','shared',
                'logs','phases','bernoulli','head','correction','g','images','negative_controls','counters','telemetry'])
        keys(r['shared'],['log2_raw','pi','gate_summary']); dshape(r['shared']['log2_raw']); dshape(r['shared']['pi']); trace_shape(r['shared']['gate_summary'],1028)
        sc=r['scalar_checks']; keys(sc,['checks','log_tail','pi_tail','real_exp_error','cis_error','eta','epsilon','delta','actual_phase_radius','g_error_bound','g_radius'])
        names=['log_tail_lt_eta_16','pi_tail_lt_eta_16','log_total_lt_eta','pi_total_lt_eta','real_exp_lt_eta',
               'all_real_square_errors_lt_one','complex_exp_lt_2p16_eta','primitive_lt_epsilon','actual_phase_lt_2p13_epsilon',
               'head_bound','correction_bound','g_bound','g_declared_radius']
        keys(sc['checks'],names); need(all(sc['checks'][k] is True for k in names),'named scalar checks')
        for k in ('log_tail','pi_tail','real_exp_error','cis_error'): qshape(sc[k])
        for k,e in [('eta',-1024),('epsilon',-512),('delta',-1040),('actual_phase_radius',-499),('g_error_bound',-428),('g_radius',-420)]: dshape(sc[k],e)
        c=r['counters']; keys(c,['rounding_coordinate_gates','observed_rounding_integer_bits','logs','phases','normalized_g_coefficients','whole_panels','endpoints','scope'])
        fixed=dict(logs=1025,phases=1025,normalized_g_coefficients=16,whole_panels=1,endpoints=2)
        # 1028 shared + 1024*(514+1542) + 96 final coordinate gates.
        fixed['rounding_coordinate_gates']=1028+1024*(514+1542)+96
        for k,v in fixed.items(): need(type(c[k]) is int and c[k]==v,'fixed counter')
        need(type(c['observed_rounding_integer_bits']) is int and 0<c['observed_rounding_integer_bits']<=65536,'counter bit bound')
        need(c['scope']=='rounding observed sizes only; not all arithmetic temporary allocations','counter scope')
        for n,(a,b) in enumerate(zip(r['logs'],r['phases']),1):
            keys(a,['n','k','t','center','radius','gates']); keys(b,['n','input','period','reduced','center','radius','gates'])
            need(type(a['k']) is int and a['k']==n.bit_length()-1,'log reduction index')
            qshape(a['t']); dshape(a['center']); dshape(a['radius'],-1024,n==1); trace_shape(a['gates'],0 if n==1 else 514)
            need(type(b['period']) is int and abs(b['period'])<4096,'period bound')
            zshape(b['input'],qshape); qshape(b['reduced']); zshape(b['center']); dshape(b['radius'],-499,n==1); trace_shape(b['gates'],0 if n==1 else 1542)
        need(type(r['bernoulli']) is list and len(r['bernoulli'])==33,'Bernoulli coverage')
        for q in r['bernoulli']: qshape(q)
        for field,e in [('head',-442),('correction',-434),('g',-420)]:
            for row in r[field]:
                keys(row,['h','center','radius','gates']+(['old_containment'] if field=='g' else []))
                zshape(row['center']); dshape(row['radius'],e); trace_shape(row['gates'],2)
                if field=='g':
                    keys(row['old_containment'],['re','im'])
                    for axis in ('re','im'):
                        keys(row['old_containment'][axis],['lower_margin','upper_margin'])
                        for q in row['old_containment'][axis].values(): qshape(q); need(decimal(q['numerator'])>=0,'nonnegative containment margin')
        for c in r['negative_controls']:
            keys(c,['name','rejected','reason']); need(type(c['reason']) is str,'control reason')
    else:
        keys(r,['schema','status','target_sha256','spec_sha256','producer_source_sha256','producer_receipt_sha256',
                'independent_source_sha256','counts','independent_pi','independent_leaves','independent_g','negative_controls','telemetry'])
        keys(r['independent_pi'],['center','radius']); dshape(r['independent_pi']['center']); dshape(r['independent_pi']['radius'],-1056)
        for n,row in enumerate(r['independent_leaves'],1):
            keys(row,['n','log','log_radius','log_center_distance','phase','phase_radius','phase_center_l1_distance'])
            dshape(row['log']); dshape(row['log_radius'],-1056,n==1); qshape(row['log_center_distance'])
            zshape(row['phase']); dshape(row['phase_radius'],-531,n==1); qshape(row['phase_center_l1_distance'])
            need(decimal(row['log_center_distance']['numerator'])>=0 and decimal(row['phase_center_l1_distance']['numerator'])>=0,'nonnegative distance')
        for row in r['independent_g']:
            keys(row,['h','center','radius']); zshape(row['center']); dshape(row['radius'],-450)
    worker_telemetry(r['telemetry'],phase)

def worker_telemetry(t,phase):
    if phase=='producer':
        keys(t,['worker_elapsed_seconds','peak_working_set_bytes','samples','children_spawned','scope'])
        need(type(t['samples']) is int and t['samples']>0 and t['scope']=='worker observation only; external post-exit seal required','producer telemetry')
        elapsed=t['worker_elapsed_seconds']; cap=600
    else:
        keys(t,['peak_working_set_bytes','elapsed_seconds','integer_rational_operations','children_spawned','scope'])
        need(type(t['integer_rational_operations']) is int and t['integer_rational_operations']>0
             and t['scope']=='worker_prepublication_requires_external_lifetime_seal','independent telemetry')
        elapsed=t['elapsed_seconds']; cap=900
    need(type(elapsed) in (int,float) and isfinite(elapsed) and 0<=elapsed<=cap,'worker local duration')
    need(type(t['peak_working_set_bytes']) is int and 0<t['peak_working_set_bytes']<=512*1024**2
         and type(t['children_spawned']) is int and t['children_spawned']==0,'worker local memory/children')

def wire_bounds(value,depth=0,telemetry=False):
    need(depth<=64,'JSON nesting bound')
    if type(value) is dict:
        if 'mantissa' in value or 'exponent' in value:
            keys(value,['mantissa','exponent'])
            n=decimal(value['mantissa']); e=value['exponent']
            need(type(e) is int and abs(e)<=32768 and (n%2!=0 or n==0 and e==0),'canonical dyadic')
            need(n.bit_length()+max(e,0)<=65536,'expanded dyadic bound')
        elif 'numerator' in value or 'denominator' in value:
            keys(value,['numerator','denominator'])
            n,d=decimal(value['numerator']),decimal(value['denominator'])
            need(d>0 and gcd(n,d)==1,'canonical rational')
        else:
            for k,v in value.items(): wire_bounds(v,depth+1,telemetry or k=='telemetry')
    elif type(value) is list:
        need(len(value)<=16384,'array bound')
        for v in value: wire_bounds(v,depth+1,telemetry)
    elif type(value) is str: need(len(value)<=21000,'string bound')
    elif type(value) is int: need(value.bit_length()<=65536,'integer bound')
    elif type(value) is bool: pass
    elif type(value) is float: need(telemetry and isfinite(value),'unexpected/nonfinite float')
    else: need(False,'unsupported JSON value')

def decimal(s):
    need(type(s) is str and len(s)<=19730 and re.fullmatch(r'0|-?[1-9][0-9]*',s),'decimal syntax/length')
    n=int(s); need(n.bit_length()<=65536,'decimal bits'); return n

def identity_valid(i):
    need(type(i) is dict and i.get('valid') is True and type(i.get('pid')) is int and i['pid']>0
         and type(i.get('creation_filetime')) is int and i['creation_filetime']>0
         and i.get('times_success') is True and i.get('image',{}).get('complete') is True,'original identity')
    need(Path(i['image']['path']).resolve()==EXE.resolve(),'identity executable')

def managed_valid(r,role,total,seconds,cap,creator):
    need(r.get('status')=='MANAGED_EXIT_VALIDATED' and r.get('role')==role,'managed result')
    need(all(r.get(k) is True for k in ('created','assigned','resumed')),'managed lifecycle')
    need(type(r.get('creator_pid')) is int and r['creator_pid']==creator,'creation relationship')
    need(type(r.get('exit_code')) is int and r['exit_code']==0 and type(r.get('flags')) is int and r['flags']==0x8000C,'exit/flags')
    start,end=r.get('started_ns'),r.get('observed_exit_ns')
    need(type(start) is int and type(end) is int and 0<end-start<seconds*10**9,'managed whole deadline')
    identity_valid(r['identity']); identity_valid(r['postexit_identity'])
    for key in ('pid','creation_filetime','image'): need(exact(r['identity'][key],r['postexit_identity'][key]),'retained identity')
    mem=r['postexit_memory']; prior=r['peak_samples_max']
    need(type(prior) is int and prior>0 and mem.get('success') is True and type(mem.get('peak')) is int
         and type(mem.get('working_set')) is int and 0<=mem['working_set']<=mem['peak']<=cap and mem['peak']>=prior,'full lifetime peak')
    acc=r['final_accounting']
    need(type(acc.get('TotalProcesses')) is int and acc['TotalProcesses']==total
         and type(acc.get('TotalTerminatedProcesses')) is int and acc['TotalTerminatedProcesses']==0,'lifetime job counts')
    accounting_valid(r.get('accounting'),total,acc,r['identity']['pid'])

def accounting_valid(records,total,acc,original_pid):
    need(type(original_pid) is int and original_pid>0,'original created PID')
    need(type(records) is list and len(records)==3,'three accounting checkpoints')
    names=['TotalUserTime','TotalKernelTime','ThisPeriodTotalUserTime','ThisPeriodTotalKernelTime',
           'TotalPageFaultCount','TotalProcesses','ActiveProcesses','TotalTerminatedProcesses']
    for item,stage,count in zip(records,['empty','assigned_before_resume','postexit'],[0,1,total]):
        need(item.get('stage')==stage and item.get('success') is True and item.get('returned_length')==48,'raw accounting checkpoint')
        raw=bytes.fromhex(item['raw_hex']); need(len(raw)==48,'raw accounting size')
        vals=[int.from_bytes(raw[i*8:(i+1)*8],'little',signed=True) for i in range(4)]
        vals += [int.from_bytes(raw[32+i*4:36+i*4],'little') for i in range(4)]
        decoded=dict(zip(names,vals)); need(exact(decoded,item['decoded']),'raw accounting equality')
        need(decoded['TotalProcesses']==count and decoded['TotalTerminatedProcesses']==0,'checkpoint counts')
        ids=item['pid_list']; rawids=bytes.fromhex(ids['raw_hex'])
        need(ids['success'] is True and len(rawids)==72,'raw PID checkpoint')
        assigned=int.from_bytes(rawids[:4],'little'); listed=int.from_bytes(rawids[4:8],'little')
        need(all(type(ids[k]) is int for k in ('assigned','listed','returned_length')),'PID integer fields')
        need(assigned==listed<=8 and ids['assigned']==assigned and ids['listed']==listed
             and 8+8*listed<=ids['returned_length']<=72,'PID count equality')
        need(ids['pids']==[int.from_bytes(rawids[8+8*i:16+8*i],'little') for i in range(listed)],'raw PID equality')
        need(all(type(pid) is int and pid>0 for pid in ids['pids']) and len(set(ids['pids']))==len(ids['pids']),'positive unique PID list')
        if stage=='empty': need(ids['pids']==[],'empty job PID list')
        if stage=='assigned_before_resume': need(ids['pids']==[original_pid],'assigned original PID singleton')
    need(exact(records[-1]['decoded'],acc),'final accounting linkage')

def host_capability(packet):
    keys(packet,['evidence','review']); proof=load(ref(packet['evidence'],4*1024*1024),4*1024*1024)
    need(ref(packet['review'],512*1024).suffix=='.md','host containment review')
    for k,v in dict(schema='rational-j7-host-containment-capability-1',status='PASS',
                    topology=['H','R','S','W'],active_limits=[3,2,1],detached=True,suspended_assignment=True).items():
        need(exact(proof.get(k),v),'additional containment capability '+k)

def validate_host_chain(chain):
    """Pure final-chain gate; the separately reviewed host must produce these observations."""
    files={k:ref(v,CAP) for k,v in chain.items()}
    host=load(files['host']); seal=load(files['r_seal']); auth=load(files['authorization'])
    need(auth.get('phase') in ('producer','independent') and auth.get('authorize')=='ONE_REVIEWED_NUMERICAL_PHASE','prior authorization')
    need(set(auth.get('sources',{}))==set(MODULES),'prior source set')
    for name,h in auth['sources'].items(): need(sha(clean(HERE/name))==h,'prior supervisor source unchanged')
    need(ref(auth['host_source'],131072).suffix=='.py' and auth['host_source']['sha256']==auth['host_source_sha256'],'prior host source')
    ref(auth['host_review'],512*1024); ref(auth['host_contract'],512*1024)
    need(set(host)=={'schema','status','authorization','r_seal','r_identity','original_handle_exit_observed',
         'exit_code','elapsed_ns','aggregate_bytes','host_contract','host_source_sha256',
         'host_started_ns','r_observed_exit_ns','r_launch','r_postexit_identity','host_job','streams','containment_capability'},'host record schema')
    need(host.get('schema')=='rational-j7-host-1' and host.get('status')=='HOST_OBSERVED_COMPLETE','host completion missing')
    need(host.get('r_seal')==chain['r_seal'] and host.get('authorization')==chain['authorization'],'host hash binding')
    need(type(host.get('exit_code')) is int and host['exit_code']==0 and host.get('original_handle_exit_observed') is True,'host actual exit')
    limit=750 if auth.get('phase')=='producer' else 1050
    need(type(host.get('elapsed_ns')) is int and 0<host['elapsed_ns']<limit*10**9,'host deadline')
    need(type(host['host_started_ns']) is int and host['host_started_ns']==auth['host_start_ns']
         and type(host['r_observed_exit_ns']) is int and 0<host['r_observed_exit_ns']-host['host_started_ns']<=host['elapsed_ns'],'host complete clock binding')
    need(seal.get('status')=='R_PROVISIONAL' and seal.get('candidate')==chain['candidate'],'R candidate binding')
    need(seal.get('authorization_sha256')==chain['authorization']['sha256'],'R authorization binding')
    need(type(host.get('aggregate_bytes')) is int and 0<host['aggregate_bytes']<=CAP,'host final aggregate')
    identity_valid(host['r_identity']); identity_valid(seal['startup'])
    identity_valid(host['r_postexit_identity'])
    for k in ('pid','creation_filetime','image'): need(exact(host['r_identity'][k],seal['startup'][k]),'host retained R identity')
    for k in ('pid','creation_filetime','image'): need(exact(host['r_identity'][k],host['r_postexit_identity'][k]),'host postexit R identity')
    launch=host['r_launch']; keys(launch,['argv','cwd','flags','creator_pid','assigned_before_resume'])
    need(type(launch['flags']) is int and launch['flags']==0x8000C and type(launch['creator_pid']) is int
         and launch['creator_pid']>0 and launch['assigned_before_resume'] is True,'host R launch fields')
    need(exact(launch['argv'],[str(EXE),'-I','-S','-B',str(HERE/(PREFIX+'_run.py')),'--role','R','--authorization',str(files['authorization'])])
         and launch['cwd']==str(HERE),'exact R launch')
    job=host['host_job']; keys(job,['active_limit','limit_flags','assigned','accounting','final_accounting'])
    need(type(job['active_limit']) is int and job['active_limit']==3 and type(job['limit_flags']) is int
         and job['limit_flags']==8200 and job['assigned'] is True,'host containment limits')
    accounting_valid(job['accounting'],3,job['final_accounting'],host['r_identity']['pid'])
    need(exact(host['containment_capability'],auth['host_capability']),'host capability binding'); host_capability(auth['host_capability'])
    need(host['host_contract']==auth['host_contract'],'host contract binding')
    need(host['host_source_sha256']==auth['host_source_sha256'],'host implementation source')
    managed_valid(seal['s_record'],'s',2,limit-60,256*1024**2,seal['startup']['pid'])
    sp=files['r_seal'].parent/'s_seal.json'; need(sha(sp)==seal['s_seal_sha256'],'S seal hash')
    sub=load(sp); need(sub.get('status')=='S_PROVISIONAL' and sub.get('authorization_sha256')==chain['authorization']['sha256'],'S authorization')
    for observation in (seal,sub):
        entries=observation.get('sealed_files'); need(type(entries) is list and 0<len(entries)<=32,'bounded sealed inventory')
        need(len({e['path'] for e in entries})==len(entries),'unique sealed paths')
        for entry in entries:
            keys(entry,['path','bytes','sha256']); p=relative(entry['path'])
            need(type(entry['bytes']) is int and entry['bytes']==p.stat().st_size and sha(p)==entry['sha256'],'sealed file changed')
    identity_valid(sub['startup'])
    for k in ('pid','creation_filetime','image'): need(exact(sub['startup'][k],seal['s_record']['identity'][k]),'R retained S identity')
    managed_valid(sub['worker'],'w',1,600 if auth['phase']=='producer' else 900,512*1024**2,sub['startup']['pid'])
    need(exact(sub.get('candidate'),chain['candidate']),'S candidate binding')
    need(type(seal.get('s_exit_code')) is int and seal['s_exit_code']==0 and type(seal.get('outer_total')) is int
         and seal['outer_total']==2 and type(seal.get('outer_terminated')) is int and seal['outer_terminated']==0,'R final predicates')
    owner=Ownership(auth,files['authorization'])
    keys(host['streams'],['stdout','stderr'])
    for name in ('stdout','stderr'):
        item=host['streams'][name]; keys(item,['bytes','sha256']); path=owner.directory/('host.'+name)
        need(type(item['bytes']) is int and item['bytes']==path.stat().st_size==0 and item['sha256']==sha(path),'exact empty R output stream')
    need(files['r_seal']==owner.directory/'r_seal.json' and files['host']==owner.directory/'host.json','owned host/R records')
    need(files['candidate']==owner.worker[0],'owned candidate')
    wm=owner.directory/'worker_manifest.json'
    need(sha(wm)==sub['worker_manifest_sha256'] and exact(load(wm),worker_manifest(auth,sub['startup']['pid'])),'actual worker manifest binding')
    script=relative(PRODUCER if auth['phase']=='producer' else INDEPENDENT)
    need(exact(sub['worker']['argv'],[str(EXE),'-I','-S','-B',str(script),'--manifest',str(wm)])
         and sub['worker']['cwd']==str(script.parent),'exact worker launch')
    need(exact(seal['s_record']['argv'],[str(EXE),'-I','-S','-B',str(HERE/(PREFIX+'_run.py')),'--role','S','--authorization',str(files['authorization'])])
         and seal['s_record']['cwd']==str(HERE),'exact S launch')
    marker=load(owner.worker[0].with_suffix('.attempt.json'))
    need(marker.get('manifest_sha256')==sha(wm),'worker attempt binding')
    need(not owner.worker[0].with_suffix('.pending').exists() and not owner.worker[0].with_suffix('.failure.json').exists(),'worker failure forbids final acceptance')
    need(host['aggregate_bytes']==sum(x['bytes'] for x in owner.guard(0)),'fresh post-host byte accounting')
    for name in ('r_failure.json','s_failure.json','host_failure.json'):
        need(not (owner.directory/name).exists(),'failure record forbids acceptance')
    need(not any(p.name.endswith('.pending') for p in owner.directory.iterdir()),'incomplete observer publication')
    return dict(status='EXTERNAL_PHASE_ACCEPTED',phase=auth['phase'],candidate=chain['candidate'])
