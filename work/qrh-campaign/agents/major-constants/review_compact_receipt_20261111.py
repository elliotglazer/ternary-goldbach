"""Independent sparse-bit checks of recorded dyadics; no analytic evaluations."""
import hashlib
import json
from pathlib import Path

HERE=Path(__file__).resolve().parent
SOURCE=HERE.parent/'prime-estimates'/'principal_theta_modular_pilot_20261111.json'
COUNTS={}
TRANSLATION_FAILURES=[]
QUOTIENT_FAILURES=[]
MAX_BITS=0

def bump(k,n=1): COUNTS[k]=COUNTS.get(k,0)+n

def dyad(d):
    assert isinstance(d,dict) and set(d)=={'mantissa','exponent'}
    assert type(d['exponent']) is int and isinstance(d['mantissa'],str)
    m=int(d['mantissa']); assert str(m)==d['mantissa']
    return m,d['exponent']

def neg(a): return -a[0],a[1]
def mul(a,b): return a[0]*b[0],a[1]+b[1]
def scale(a,n): return a[0]*n,a[1]

def sparse_sign(terms):
    """Carry signed mantissa bits in two sets; no exponent-gap shifts."""
    global MAX_BITS
    pos,negative=set(),set()
    for m,e in terms:
        target=pos if m>=0 else negative
        bits=bin(abs(m))[2:]
        MAX_BITS=max(MAX_BITS,len(bits))
        for offset,char in enumerate(reversed(bits)):
            if char=='0': continue
            at=e+offset
            while at in target:
                target.remove(at); at+=1
            target.add(at)
    difference=pos.symmetric_difference(negative)
    return 0 if not difference else (1 if max(difference) in pos else -1)

def cmp(a,b): return sparse_sign([a,neg(b)])
def rational(s):
    a,b=map(int,s.split('/'))
    assert b>0 and b&(b-1)==0
    return a,-(b.bit_length()-1)

def grid_round(a,g):
    m,e=a
    above=[];below=False
    for j,b in enumerate(reversed(bin(abs(m))[2:])):
        if b=='1':
            if e+j>=g:above.append(e+j-g)
            else:below=True
    assert not above or max(above)<512
    q=sum(1<<j for j in above)
    return ((q,g),(q+below,g)) if m>=0 else ((-q-below,g),(-q,g))

def check_pairs(raw,display,path):
    if len(raw)==2 and all(isinstance(v,dict) and 'mantissa'in v for v in raw):
        lo,hi=map(dyad,raw); dlo,dhi=map(rational,display)
        assert cmp(lo,hi)<=0,('reversed',path)
        assert cmp(dlo,lo)<=0 and cmp(hi,dhi)<=0,('display',path)
        assert cmp(grid_round(lo,-128)[0],dlo)==0 and cmp(grid_round(hi,-128)[1],dhi)==0
        bump('ordered_raw_intervals');bump('display_containments')
        bump('display_directed_rounding')
    else:
        assert len(raw)==len(display)
        for i,(r,d) in enumerate(zip(raw,display)):check_pairs(r,d,path+f'[{i}]')

def walk(x,path='$'):
    if isinstance(x,dict):
        for k,v in x.items():
            if k.startswith('binary_'):
                check_pairs(v,x[k[7:]],path+'.'+k)
            walk(v,path+'.'+k)
    elif isinstance(x,list):
        for i,v in enumerate(x):walk(v,path+f'[{i}]')

def interval(box,coord):return list(map(dyad,box['binary_'+coord]))
def samebox(a,b):
    for coord in ['re','im']:
        assert all(cmp(x,y)==0 for x,y in zip(interval(a,coord),interval(b,coord)))
    bump('shared_box_equalities')
def greater_ratio(a,num,den):return sparse_sign([scale(a,den),(-num,0)])>0
def less_ratio(a,num,den):return sparse_sign([scale(a,den),(-num,0)])<0

def record(category,truth):bump(category+('_pass' if truth else '_fail'))

def squares(pair):
    l,u=pair
    a,b=mul(l,l),mul(u,u)
    lo=(0,0) if l[0]<=0<=u[0] else (a if cmp(a,b)<=0 else b)
    hi=a if cmp(a,b)>=0 else b
    return lo,hi

def coarse_inverse(inp,out):
    x2,y2=squares(inp[0]),squares(inp[1])
    if sparse_sign([x2[0],y2[0]])<=0:return False
    for numerator,candidate in zip((inp[0],[neg(inp[1][1]),neg(inp[1][0])]),out):
        for a in numerator:
            for j in [0,1]:
                if sparse_sign([a,neg(mul(candidate[0],x2[j])),neg(mul(candidate[0],y2[j]))])<0:return False
                if sparse_sign([mul(candidate[1],x2[j]),mul(candidate[1],y2[j]),neg(a)])<0:return False
    return True

def run():
    assert hashlib.sha256(SOURCE.read_bytes()).hexdigest().upper()=='C39982174CAC9C51E9F816275082BCE322CA2AD143D9FCE61081DF72E57B11EF'
    d=json.loads(SOURCE.read_text())
    walk(d)
    exponents=[]
    def exps(x):
        if isinstance(x,dict):
            if set(x)=={'mantissa','exponent'}:exponents.append(dyad(x)[1])
            for v in x.values():exps(v)
        elif isinstance(x,list):
            for v in x:exps(v)
    exps(d)
    for point_index,p in enumerate(d['points']):
        previous=p['initial_tau']
        for i,step in enumerate(p['steps']):
            samebox(previous,step['input']);previous=step['output']
            for box in [step['input'],step['output']]:
                assert greater_ratio(interval(box,'im')[0],0,1);bump('upper_halfplane')
            if step['kind']=='T':
                re=interval(step['output'],'re');im=interval(step['output'],'im')
                assert greater_ratio(re[0],-3,5) and less_ratio(re[1],3,5)
                signs=[sparse_sign([actual,neg(original),(step['n'],0)])
                       for actual,original in zip(re,interval(step['input'],'re'))]
                if signs[0]<=0 and signs[1]>=0:bump('translation_raw_arithmetic_enclosures_pass')
                else:
                    bump('translation_raw_arithmetic_enclosures_fail')
                    TRANSLATION_FAILURES.append({'point':point_index,'step':i,'n':step['n'],'signs':signs})
                assert all(cmp(a,b)==0 for a,b in zip(im,interval(step['input'],'im')))
                if i+1<len(p['steps']):assert less_ratio(im[1],1,2)
                else:assert greater_ratio(im[0],2,5)
                bump('translation_domains')
            else:
                w=step['root_witness'];x,y=interval(w['z'],'re'),interval(w['z'],'im')
                ti=interval(step['input'],'im');tr=interval(step['input'],'re')
                assert cmp(x[0],ti[0])<=0 and cmp(ti[1],x[1])<=0
                assert cmp(y[0],neg(tr[1]))<=0 and cmp(neg(tr[0]),y[1])<=0
                u=list(map(dyad,w['binary_u']));v=list(map(dyad,w['binary_v']))
                assert greater_ratio(x[0],0,1) and greater_ratio(u[0],0,1)
                assert all(cmp(a,b)==0 for a,b in zip(u,interval(w['root'],'re')))
                assert all(cmp(a,b)==0 for a,b in zip(v,interval(w['root'],'im')))
                bump('root_domain_rotation_component_checks')
                record('root_argument_exact',all(cmp(a,b)==0 for a,b in zip(x,ti)) and all(cmp(a,b)==0 for a,b in zip(y,[neg(tr[1]),neg(tr[0])])))
                norm=list(map(dyad,w['binary_norm']));xx,yy=squares(x),squares(y)
                record('root_norm_square',sparse_sign([xx[0],yy[0],neg(mul(norm[0],norm[0]))])>=0 and sparse_sign([mul(norm[1],norm[1]),neg(xx[1]),neg(yy[1])])>=0)
                record('root_u_square',sparse_sign([norm[0],x[0],scale(mul(u[0],u[0]),-2)])>=0 and sparse_sign([scale(mul(u[1],u[1]),2),neg(norm[1]),neg(x[1])])>=0)
                record('root_v_quotient',all(sparse_sign([a,scale(mul(v[0],b),-2)])>=0 and sparse_sign([scale(mul(v[1],b),2),neg(a)])>=0 for a in y for b in u))
                for yi,a in enumerate(y):
                    for ui,b in enumerate(u):
                        signs=[sparse_sign([a,scale(mul(v[0],b),-2)]),sparse_sign([scale(mul(v[1],b),2),neg(a)])]
                        if min(signs)<0:QUOTIENT_FAILURES.append({'point':point_index,'step':i,'y_endpoint':yi,'u_endpoint':ui,'signs':signs,'y':a,'u':b,'v':v})
                record('coarse_inverse',coarse_inverse([u,v],[interval(w['A'],'re'),interval(w['A'],'im')]))
                record('coarse_inverse',coarse_inverse([tr,ti],[[neg(t) for t in reversed(interval(step['output'],c))] for c in ['re','im']]))
                assert sparse_sign([scale(interval(step['output'],'im')[0],61),scale(interval(step['input'],'im')[1],-100)])>0
                bump('inversion_imaginary_growth')
        samebox(previous,p['reduced_tau'])
    # Deliberately false endpoint comparisons and symbolic enormous gaps.
    assert cmp((1,-10**100),(0,0))>0
    assert sparse_sign([(1,0),(1,-10**100),(-1,0)])>0
    assert sparse_sign([(1,0),(-1,-10**100),(-1,0)])<0
    bad=json.loads(json.dumps(d['binary_pi']));bad.reverse()
    try:check_pairs(bad,d['pi'],'bad-reversed')
    except AssertionError:bump('rejected_mutations')
    else:raise AssertionError('reversed interval accepted')
    bad_display=['0/1','0/1']
    try:check_pairs(d['binary_pi'],bad_display,'bad-display')
    except AssertionError:bump('rejected_mutations')
    else:raise AssertionError('false display accepted')
    for bad in [{'mantissa':'1','exponent':True},{'mantissa':'1','exponent':'-1'},
                {'mantissa':'1.0','exponent':0},{'mantissa':'1','exponent':0,'extra':0}]:
        try:dyad(bad)
        except (AssertionError,ValueError):bump('rejected_mutations')
        else:raise AssertionError('malformed endpoint accepted')
    # These conditions would be required by the deliberately false claims.
    false_claims=[sparse_sign([(1,0),(1,-10**100),(-1,0)])<=0,
                  cmp(mul((3,0),(4,0)),(11,0))==0,
                  cmp(mul((1,0),(3,0)),(1,0))<=0,
                  cmp(mul((1,0),(1,0)),(2,0))>=0]
    assert not any(false_claims)
    bump('rejected_false_arithmetic_claims',len(false_claims))
    first=d['points'][0]['steps'][0]
    for j,delta in enumerate([(133693435,-283),(-133693435,-283)]):
        assert sparse_sign([dyad(first['output']['binary_re'][j]),neg(dyad(first['input']['binary_re'][j])),(first['n'],0),neg(delta)])==0
    first_diagnostic={'point':0,'T':1000000,'r':'0','step':0,'n':first['n'],
                      'recorded_input_binary_re':first['input']['binary_re'],
                      'recorded_output_binary_re':first['output']['binary_re'],
                      'output_minus_input_plus_n':[[133693435,-283],[-133693435,-283]]}
    output={'scope':'Independent sparse-bit arithmetic and recorded branch checks only',
            'source_sha256':hashlib.sha256(SOURCE.read_bytes()).hexdigest().upper(),
            'counts':COUNTS,'binary_endpoint_occurrences':len(exponents),
            'raw_translation_witness_failures':TRANSLATION_FAILURES,
            'raw_quotient_witness_failures':QUOTIENT_FAILURES,
            'first_translation_exact_diagnostic':first_diagnostic,
            'min_exponent':min(exponents),'max_exponent':max(exponents),
            'maximum_working_term_mantissa_bits_encountered':MAX_BITS,'diagnostic_completed':True}
    HERE.joinpath('review_compact_receipt_20261111.json').write_text(json.dumps(output,indent=2)+'\n')
    print(json.dumps(output))

if __name__=='__main__':run()
