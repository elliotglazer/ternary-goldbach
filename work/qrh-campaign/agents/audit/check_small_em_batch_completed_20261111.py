"""Saved-data-only independent rational audit. No evaluator imports or transcendental calls."""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json
from math import factorial

BASE = Path(__file__).resolve().parent.parent
P = 'integration/small_em_batch_candidate_20261111_01.json'
I = 'independent-feasibility/small_em_batch_independent_replay_20261111_01.json'
EXPECTED = {P:'2ADDFE3FE7D77B8CC10606886CC580D5C8103B30B0E4CD3BC9507AB27B198F7E', I:'2D0CF58A1825978455B029ABE3A73382745955D7EE1A74106A8FF98116A3EE80'}
pins = {}
def sha(path): return hashlib.sha256(path.read_bytes()).hexdigest().upper()
def load(name):
    path=BASE/name
    pins[name]=sha(path)
    def unique(pairs):
        d={}
        for k,v in pairs:
            assert k not in d
            d[k]=v
        return d
    return json.loads(path.read_text(encoding='utf-8'),object_pairs_hook=unique)
def q(x):
    assert set(x)=={'numerator','denominator'}
    assert int(x['denominator'])>0
    return F(int(x['numerator']),int(x['denominator']))
def d(x):
    assert set(x)=={'mantissa','exponent'} and type(x['exponent']) is int
    m,e=int(x['mantissa']),x['exponent']
    assert abs(e)<=8192 and abs(m).bit_length()<=4096
    assert (m==0 and e==0) or m%2
    return F(m)*F(2)**e
def rb(x):
    m,r=d(x['mid']),d(x['rad']);assert r>=0
    return m-r,m+r
def box(x): return rb(x['re']),rb(x['im'])
def center(x): return d(x['re']),d(x['im'])
def rect(x):
    r=tuple((q(x[a]['lo']),q(x[a]['hi'])) for a in ('re','im'))
    assert all(lo<=hi for lo,hi in r)
    return r
def encloses(a,b): return all(a[k][0]<=b[k][0]<=b[k][1]<=a[k][1] for k in (0,1))
def interval_add(a,b): return a[0]+b[0],a[1]+b[1]
def interval_neg(a): return -a[1],-a[0]
def interval_mul(a,b):
    v=[x*y for x in a for y in b];return min(v),max(v)
def cadd(a,b): return tuple(interval_add(a[k],b[k]) for k in (0,1))
def cmul(a,b):
    return (interval_add(interval_mul(a[0],b[0]),interval_neg(interval_mul(a[1],b[1]))),
            interval_add(interval_mul(a[0],b[1]),interval_mul(a[1],b[0])))
def sq(a): return (F(0) if a[0]<=0<=a[1] else min(x*x for x in a),max(x*x for x in a))
def cinv(z):
    den=interval_add(sq(z[0]),sq(z[1]));assert den[0]>2**20
    inv=1/den[1],1/den[0]
    return interval_mul(z[0],inv),interval_mul(interval_neg(z[1]),inv)
def image(coeffs,j,lo,hi,pad):
    t=F(31999,16)-F(j,8);z=((F(0),F(0)),(lo-t,hi-t))
    val=coeffs[-1]
    for c in coeffs[-2::-1]: val=cadd(cmul(val,z),c)
    val=cadd(val,((-pad,pad),(-pad,pad)))
    return cmul(val,cinv(((F(629,1250)-1,)*2,(lo,hi))))
def checkpins(mapping):
    for name,value in mapping.items():
        assert sha(BASE/name)==value
        pins[name]=value

def main():
    p,i=load(P),load(I)
    assert all(pins[n]==h for n,h in EXPECTED.items())
    pm=load('integration/coordinator_small_em_batch_run_20261111_01.json')
    pc=load('integration/coordinator_small_em_batch_completion_20261111_01.json')
    im=load('independent-feasibility/coordinator_small_em_batch_review_20261111_01.json')
    ic=load('independent-feasibility/coordinator_small_em_batch_completion_20261111_01.json')
    attempt=load('integration/small_em_batch_candidate_20261111_01.attempt.json')
    assert pm['runtime_authorized'] is True and im['authorize']=='RUN_ONE_SMALL_EM_BATCH_REVIEW'
    assert pm['pins']==p['pins'] and im['pins']==i['pins'] and im==i['manifest']
    checkpins(p['pins']);checkpins(i['pins'])
    checkpins({im['static_review']['path']:im['static_review']['sha256']})
    assert pm['static_review']==im['static_review']==p['software']['static_review']
    assert p['producer_code_sha256']==pm['producer_code_sha256']==im['producer_code']['sha256']
    assert p['producer_code_sha256']==sha(BASE/im['producer_code']['path'])
    assert im['independent_code_sha256']==sha(BASE/'independent-feasibility/review_small_em_batch_prepared_20261111.py')
    pins['independent-feasibility/review_small_em_batch_prepared_20261111.py']=im['independent_code_sha256']
    assert p['software']['run_manifest_sha256']==attempt['run_manifest_sha256']==pins['integration/coordinator_small_em_batch_run_20261111_01.json']
    assert attempt['one_attempt'] is True and attempt['parameters']==pm['parameters']==p['parameters']
    assert attempt['caps']==pm['caps']=={'seconds':180,'peak_working_set_bytes':536870912,'receipt_bytes':67108864}
    assert pc['exit_code']==ic['exit_code']==0
    assert pc['candidate_sha256']==im['candidate']['sha256']==EXPECTED[P]
    assert ic['final_console']['receipt_sha256']==EXPECTED[I]
    assert ic['final_console']['candidate_sha256']==EXPECTED[P]
    assert ic['final_console']['independent_code_sha256']==im['independent_code_sha256']
    assert p['status']==pc['final_console']['status']=='PASS'
    assert i['status']==ic['final_console']['status']=='PASS_INDEPENDENT_SMALL_EM_BATCH'
    assert i['precision_bits']==224 and p['parameters']['precision_bits']==192
    for name,r,c,cap in ((P,p,pc,180),(I,i,ic,360)):
        assert (BASE/name).stat().st_size<67108864
        assert 0<=r['telemetry']['elapsed_seconds']<=c['final_console']['telemetry']['elapsed_seconds']<cap
        assert 0<r['telemetry']['peak_working_set_bytes']<=c['final_console']['telemetry']['peak_working_set_bytes']<536870912
        assert c['tool_wall_seconds']<cap
    assert pc['final_console']['bytes']==(BASE/P).stat().st_size==8058388
    assert ic['receipt_bytes']==(BASE/I).stat().st_size==6155890
    assert p['telemetry']['children_spawned']==0
    params=p['parameters']
    assert {k:params[k] for k in ('N','B','M','K','p','J','L')}==dict(N=1024,B=1025,M=16,K=16,p=24,J=8,L=32)
    for key,value in {'sigma':F(629,1250),'t0':F(31999,16),'Delta':F(-1,8),'outer_radius':F(1),'panel_radius':F(1,16)}.items():assert q(params[key])==value
    assert len(p['bins'])==len(i['bin_checks'])==1024
    for n,(a,b) in enumerate(zip(p['bins'],i['bin_checks']),1):
        assert a['n']==b['n']==n and a['q']==b['q'] and a['k']==b['k']==a['q']%32
        lo,hi=q(a['x']['lo']),q(a['x']['hi']);mid=q(a['mid'])
        assert lo<=hi and hi-lo<=F(1,4) and mid==(lo+hi)/2 and a['q']==(mid+F(1,2)).__floor__() and -5<=a['q']<=0
        x=rb(b['x']);r=rb(b['residual']);claimed=rb(a['residual'])
        assert lo<=x[0]<=x[1]<=hi and claimed[0]<=r[0]<=r[1]<=claimed[1]
        assert max(abs(t) for t in r)<F(55,56)
    eps=F(1,2**110)
    for name,width,total in [('moments',32,12288),('transforms',8,3072)]:
        assert len(p[name])==len(i[name])==total
        for pos,(a,b) in enumerate(zip(p[name],i[name])):
            h,rem=divmod(pos,24*width);m,k=divmod(rem,width)
            assert (a['h'],a['m'],a['k' if name=='moments' else 'j'])==(h,m,k)
            if name=='transforms':assert a['index']==(-k)%32
            c,r=center(a['center']),d(a['radius']);assert r in (0,eps)
            if not r:assert c==(0,0)
            for payload in (a['computed'],b['box']):
                z=box(payload);dist=sum(max(abs(v-c[k]) for v in z[k]) for k in (0,1));assert dist<=r
                if payload is b['box']:assert dist==q(b['L1_distance_upper']) and r==q(b['claimed_radius'])
    assert len(p['g_jets'])==len(i['direct_g'])==8
    jets=[]
    for j,(a,b) in enumerate(zip(p['g_jets'],i['direct_g'])):
        assert a['j']==b['j']==j and q(a['center']['re'])==F(629,1250) and q(a['center']['im'])==F(31999,16)-F(j,8)
        assert len(a['coefficients'])==len(b['coefficients'])==16
        jets.append([box(v) for v in a['coefficients']])
        for aa,bb in zip(a['coefficients'],b['coefficients']):
            assert all(d(aa[k]['rad'])==F(1,2**52) for k in ('re','im')) and encloses(box(aa),box(bb))
    budget=p['analytical_budget'];em=F(4*2003*33)*F(2,63)*F(2034,6150)**32;tay=F(1,15*2**33)
    assert q(budget['EM'])==em< F(1,2**38) and q(budget['Taylor'])==tay
    assert q(budget['outer_finite_g_bound'])==2**27 and q(budget['exact_image_rounding'])==0 and budget['coefficient_padding_added_twice'] is False
    assert q(budget['full_quotient_error_budget'])==F(1540133,92233720368547758080)<F(1,2**44)
    for kind,count in [('panels',8),('endpoints',9)]:
        assert len(p[kind])==len(i['images'][kind])==count
        for n,(a,b) in enumerate(zip(p[kind],i['images'][kind])):
            owner=n if kind=='panels' else min(n,7)
            assert a['index']==b['index']==n and a['owner']==owner
            if kind=='panels':
                hi,lo=F(2000)-F(n,8),F(2000)-F(n+1,8)
                assert q(a['top'])==hi and q(a['bottom'])==lo
            else:
                hi=lo=F(2000)-F(n,8);assert q(a['height'])==hi and b['owner']==owner
            assert image(jets[owner],owner,lo,hi,em+tay)==rect(a['image'])==rect(b['image'])
    # Independently recompute exact diagnostic contractions, keeping their narrower scope explicit.
    assert len(p['main_jets'])==16
    for h,row in enumerate(p['main_jets']):
        assert row['h']==h and len(row['values'])==8
        for j,a in enumerate(row['values']):
            assert a['j']==j
            y=F(j,8);z=[F(0),F(0)];se=F(0);te=F(0)
            for m in range(24):
                t=p['transforms'][(h*24+m)*8+j];c=center(t['center'])
                for axis in (0,1):z[axis]+=32*y**m*c[axis]
                se+=y**m*sum(d(v['radius']) for v in p['moments'][(h*24+m)*32:(h*24+m+1)*32])
                te+=32*y**m*d(t['radius'])
            zbox=box(a['contraction']);c=center(a['center']);ce=q(a['contraction_error'])
            assert all(zbox[k][0]<=z[k]<=zbox[k][1] for k in (0,1))
            assert sum(max(abs(v-c[k]) for v in zbox[k]) for k in (0,1))<=ce<=F(1,2**100)
            re=F(64*7**h,factorial(h)*factorial(24))
            assert q(a['source_input_error'])==se and q(a['transform_error'])==te and q(a['residual_taylor_error'])==re
            assert q(a['total_error'])==se+te+ce+re and se+te+ce<F(1,2**98)
    counts={'bin_witnesses':1024,'moments':12288,'direct_normalized_transforms':3072,'direct_g_jets':128,'panels':8,'endpoints':9}
    assert i['counts']==ic['counts']==counts
    assert pc['counts']==dict(bins=1024,moments=12288,transforms=3072,g_jets=8,panels=8,endpoints=9)
    result={'status':'PASS_SAVED_DATA_EXACT_AUDIT','scope':'No evaluator imports, transcendental calls, numerical reruns, or Lean. Exact stored-box containment and image reconstruction only; genuine interval-evaluation provenance is the separately completed frozen independent process.', 'counts':counts,'producer_computed_box_checks':15360,'independent_box_disk_checks':15360,'direct_g_coordinate_checks':256,'exact_main_contractions':128,'exact_image_equalities':17,'input_pins':pins,'script_sha256':sha(Path(__file__)),'producer_file_bytes':(BASE/P).stat().st_size,'independent_file_bytes':(BASE/I).stat().st_size,'completion_records':'Both saved coordinator exit0 observations and final records verified; no independent OS observation by this saved-data script.'}
    out=Path(__file__).with_suffix('.json');out.write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
    print(result['status'],counts)
if __name__=='__main__':main()
