"""Bounded receipt tests: full rational consistency, actual node-zero replay only."""
from pathlib import Path
from fractions import Fraction as Q
import copy, hashlib, json, subprocess, sys, time

HERE=Path(__file__).resolve().parent
SRC=HERE.parent/'integration'
CANDIDATE=SRC/'rational_xi_panel_candidate_20261111_01.json'
BACKEND=SRC/'rational_xi_panel_backend_20261111.py'
EXPECTED_CANDIDATE='1B55E8A2665EF872056DE9747670E6F47017863A49D9E2C9A2D6604B6F74D09F'
EXPECTED_BACKEND='DEE8AC9AA39F25023C77003BC2AAA5970388A016207AD5A8EE0DF8F6D912F84A'
OUT=HERE/'rational_xi_adversarial_20261111'
OUT.mkdir(exist_ok=True)
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest().upper()
def write(p,d):p.write_text(json.dumps(d,indent=2)+'\n',encoding='utf8')
assert sha(CANDIDATE)==EXPECTED_CANDIDATE and sha(BACKEND)==EXPECTED_BACKEND
d=json.loads(CANDIDATE.read_text(encoding='utf8'))
TARGET=dict(T_input=32,T_work=14,eta='1/33',center_re='3/5',center_im='14',rho='1/64',
 h='1/256',K=928,degree=6,b_expression='pi/4-1/33',a='1/66',kappa='1/66',V='29/8',
 rectangle_re=['379/640','389/640'],rectangle_im=['1791/128','1793/128'],
 ccw_vertices=[['379/640','1791/128'],['389/640','1791/128'],['389/640','1793/128'],
 ['379/640','1793/128'],['379/640','1791/128']],node_grid_bits=32,weight_grid_bits=64,
 node_radius='1/16777216',weight_radius='1/281474976710656')

def structural(x):
    assert x['target']==TARGET,'exact target'
    assert x['backend_sha256']==EXPECTED_BACKEND,'backend pin'
    ns=x['nodes']; ass=x['assembly']
    assert [n['k'] for n in ns]==list(range(929)),'complete unique nodes'
    for n in ns:
        box=[list(map(Q,n['P_box'][part])) for part in ('re','im')]
        assert all(l<=h for l,h in box),'ordered P box'
        assert len(n['center'])==2 and all(type(c) is int for c in n['center'])
        canonical=[((l+h)/2*(1<<32)).__floor__() for l,h in box]
        assert n['center']==canonical,'node center from P box'
        radius=sum(max(abs(l-Q(c,1<<32)),abs(h-Q(c,1<<32))) for (l,h),c in zip(box,canonical))
        assert Q(n['radius'])==radius and 0<=radius<=Q(1,1<<24),'node radius from P box'
        assert sum(c*c for c in canonical)<1<<118,'node norm'
    ws=ass['weights']
    assert [w['k'] for w in ws]==list(range(-928,929)),'complete unique signed weights'
    coeff=[[0,0] for _ in range(7)]
    for row in ws:
        k=row['k']; weights=row['weights']
        assert len(weights)==7,'seven orders per signed weight'
        pr,pi=ns[abs(k)]['center']
        if k<0:pi=-pi
        for j,w in enumerate(weights):
            assert len(w['center'])==2 and all(type(v) is int for v in w['center'])
            assert 0<=Q(w['radius'])<=Q(1,1<<48),'claimed weight radius range only'
            wr,wi=w['center']
            if k==0:
                assert w==dict(center=([1<<56,0] if j==0 else [0,0]),radius='0')
            coeff[j][0]+=pr*wr-pi*wi
            coeff[j][1]+=pr*wi+pi*wr
    assert ass['coefficients_grid_bits']==96
    assert ass['coefficients']==coeff,'exact signed center sums'
    U=sum(Q(abs(r)+abs(i),(1<<96)*64**j) for j,(r,i) in enumerate(coeff) if j)
    margin=Q(coeff[0][0],1<<96)-U
    assert Q(ass['nonconstant_norm_upper'])==U and Q(ass['real_margin'])==margin,'variation/margin'
    assert Q(ass['total_disk_error_upper'])==Q(91500568239,10**12)<Q(1,10)
    assert margin>Q(1,10) and ass['strict_positive_real'] is True
    assert ass['constant_image_polygon']==[[1,0]]*5 and ass['edge_crossings']==[0]*4 and ass['winding']==0
    assert ass['status']==x['status']=='POSITIVE_REAL_DISK'
    return dict(nodes=len(ns),signed_weights=len(ws),products=len(ws)*7,
                real_margin=str(margin),nonconstant_norm_upper=str(U))

full=structural(d)
tests=[]
def mutate(label,getter,change,setter):
    old=copy.deepcopy(getter())
    try:
        change()
        try:structural(d)
        except (AssertionError,KeyError,ValueError,IndexError) as e:
            tests.append(dict(name=label,rejected=True,reason=str(e)))
        else:raise RuntimeError('mutation accepted: '+label)
    finally:setter(old)

mutate('target_T_input',lambda:d['target'],lambda:d['target'].update(T_input=14),lambda v:d.update(target=v))
mutate('missing_node',lambda:d['nodes'],lambda:d['nodes'].pop(),lambda v:d.update(nodes=v))
mutate('duplicate_node',lambda:d['nodes'][1],lambda:d['nodes'].__setitem__(1,d['nodes'][0]),lambda v:d['nodes'].__setitem__(1,v))
mutate('missing_signed_weight',lambda:d['assembly']['weights'],lambda:d['assembly']['weights'].pop(),lambda v:d['assembly'].update(weights=v))
mutate('duplicate_signed_weight',lambda:d['assembly']['weights'][1],lambda:d['assembly']['weights'].__setitem__(1,d['assembly']['weights'][0]),lambda v:d['assembly']['weights'].__setitem__(1,v))
mutate('node_center_changed',lambda:d['nodes'][0]['center'],lambda:d['nodes'][0]['center'].__setitem__(0,d['nodes'][0]['center'][0]+1),lambda v:d['nodes'][0].update(center=v))
mutate('node_radius_zero',lambda:d['nodes'][0]['radius'],lambda:d['nodes'][0].update(radius='0'),lambda v:d['nodes'][0].update(radius=v))
mutate('weight_center_changed',lambda:d['assembly']['weights'][0]['weights'][0]['center'],lambda:d['assembly']['weights'][0]['weights'][0]['center'].__setitem__(0,d['assembly']['weights'][0]['weights'][0]['center'][0]+1),lambda v:d['assembly']['weights'][0]['weights'][0].update(center=v))
mutate('coefficient_changed',lambda:d['assembly']['coefficients'],lambda:d['assembly']['coefficients'][0].__setitem__(0,d['assembly']['coefficients'][0][0]+1),lambda v:d['assembly'].update(coefficients=v))
assert structural(d)==full

auth=OUT/'authorization_copy.json';write(auth,d['authorization'])
prefix={k:copy.deepcopy(v) for k,v in d.items() if k not in ('nodes','assembly')}
prefix['nodes']=[copy.deepcopy(d['nodes'][0])];prefix['status']='PARTIAL'
cases=[('valid_one_node_PARTIAL',None,True),
       ('target_T_input',lambda z:z['target'].update(T_input=14),False),
       ('word_integer',lambda z:z['nodes'][0]['word'][0].update(n=0),False),
       ('missing_theta_tail',lambda z:z['nodes'][0].update(theta_tail='0'),False),
       ('false_P_box',lambda z:z['nodes'][0]['P_box'].update(re=['0/1','0/1']),False),
       ('changed_node_center',lambda z:z['nodes'][0]['center'].__setitem__(0,z['nodes'][0]['center'][0]+1),False),
       ('false_node_radius',lambda z:z['nodes'][0].update(radius='0'),False)]
replays=[]
for label,mutation,should_pass in cases:
    packet=copy.deepcopy(prefix)
    if mutation:mutation(packet)
    p=OUT/(label+'.json');write(p,packet)
    start=time.monotonic()
    run=subprocess.run([sys.executable,'-X','utf8',str(BACKEND),'--authorize',str(auth),
                         '--output',str(p),'--check','--seconds','90'],
                        capture_output=True,text=True,encoding='utf8',timeout=100)
    elapsed=time.monotonic()-start
    log=OUT/(label+'.log');log.write_text(run.stdout+run.stderr,encoding='utf8')
    assert (run.returncode==0)==should_pass,(label,run.returncode,run.stdout,run.stderr)
    if should_pass:
        msg=json.loads(run.stdout)
        assert msg==dict(replay='MATCH',nodes=1,status='PARTIAL')
    else:
        # Rejecting a timeout or infrastructure error is not the intended control.
        assert 'AssertionError' in run.stderr and 'TimeoutError' not in run.stderr
        if label!='target_T_input':assert 'replay node mismatch 0' in run.stderr
    replays.append(dict(name=label,exit_code=run.returncode,expected_acceptance=should_pass,
                        wall_seconds=elapsed,packet_sha256=sha(p),log_sha256=sha(log),
                        maximum_node_index_evaluated=(None if label=='target_T_input' else 0)))
    print(label,run.returncode,round(elapsed,3),flush=True)
assert sha(CANDIDATE)==EXPECTED_CANDIDATE and sha(BACKEND)==EXPECTED_BACKEND
result=dict(scope='Full receipt arithmetic/structure plus actual backend node-zero replay; no independent analytic soundness claim',
            candidate_sha256=EXPECTED_CANDIDATE,backend_sha256=EXPECTED_BACKEND,
            structural_positive=full,structural_mutations=tests,backend_replays=replays,
            author_receipt_unchanged=True,no_new_grid_points=True,
            independently_checked_weight_radius_truth=False,
            full_grid_analytic_replay=False,pass_all=True)
write(Path(__file__).with_suffix('.json'),result)
print(json.dumps(dict(pass_all=True,structure_negative=len(tests),backend_cases=len(replays))))
