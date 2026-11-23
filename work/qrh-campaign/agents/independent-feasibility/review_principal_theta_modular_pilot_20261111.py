"""Independent theta-jet reduction and explicit Gaussian kernel checks."""
from pathlib import Path
from fractions import Fraction as Q
import hashlib,json,time
from math import isqrt
from flint import arb,acb,ctx

ctx.prec=384
HERE=Path(__file__).resolve().parent
START=time.monotonic()


def limit():
    if time.monotonic()-START>550:raise RuntimeError('550-second computation bound')
def ar(q):
    q=Q(q);return arb(str(q.numerator))/q.denominator
def atan_interval(x,n):
    s=sum(((-1)**j*x**(2*j+1)/(2*j+1) for j in range(n)),Q(0))
    e=x**(2*n+1)/(2*n+1)
    return s,s+e
def ball(lo,hi):return ar((lo+hi)/2)+arb(0,ar((hi-lo)/2).upper())
p5=atan_interval(Q(1,5),100);p239=atan_interval(Q(1,239),40)
PI=ball(16*p5[0]-4*p239[1],16*p5[1]-4*p239[0])
I=acb(0,1)


def enc_real(x):
    # Safe absolute coarsening prevents huge denominators for exp(-millions).
    e=ar(Q(1,2**384))
    if abs(x).upper()<e:
        return [str(-Q(1,2**384)),str(Q(1,2**384))]
    return [str(x.lower().fmpq()),str(x.upper().fmpq())]
def enc(z):return {'re':enc_real(z.real),'im':enc_real(z.imag)}
def center_floor(x):
    q=Q(str(x.mid().fmpq()))+Q(1,2)
    return q.numerator//q.denominator
def root8(n):
    v=(ar(Q(1,2))).sqrt()
    return [acb(1),acb(v,v),I,acb(-v,v),acb(-1),acb(-v,-v),-I,acb(v,-v)][n%8]


def initial(T,r):
    eta=ar(Q(1,T+1)); rr=ar(r)
    w=acb(rr,PI/4-eta)
    tau=acb(-(2*eta).cos(),(2*eta).sin())*(2*rr).exp()
    assert tau.imag.lower()>0
    return w,tau


def branch_A(tau):
    z=-I*tau
    assert z.real.lower()>0
    u=((abs(z)+z.real)/2).sqrt();assert u.lower()>0
    v=z.imag/(2*u)
    return 1/acb(u,v)


def reduce(tau):
    word=[];t=tau
    for _ in range(200):
        limit();n=center_floor(t.real);z=t-n
        assert abs(z.real).upper()<ar(Q(51,100))
        word.append({'op':'T','n':n,'before':t,'after':z});t=z
        if t.imag.lower()>ar(Q(3,4)):return t,word
        assert t.imag.upper()<ar(Q(4,5))
        v=-1/t
        word.append({'op':'S','before':t,'after':v,'A':branch_A(t)});t=v
    raise AssertionError('independent reduction iteration bound')


def theta_jets(tau,N=24,alpha=Q(2)):
    assert PI.lower()*tau.imag.lower()>ar(alpha)
    jets={2:[acb(0),acb(0),acb(0)],3:[acb(1),acb(0),acb(0)],4:[acb(1),acb(0),acb(0)]}
    for kind in (2,3,4):
        for n in (range(N) if kind==2 else range(1,N+1)):
            x=Q(2*n+1,2) if kind==2 else Q(n)
            c=PI*I*ar(x*x);v=(c*tau).exp()
            factor=-2 if kind==4 and n%2 else 2
            for j in range(3):jets[kind][j]+=factor*c**j*v
    u=ar(Q(2*N+1,2));tail=[]
    for j in range(3):
        aa=ar(alpha);mj=1 if j==0 else (2*j/aa)**j
        e=2*4**j*mj*(-aa*u*u/2).exp()/(1-(-aa*(2*u+1)/2).exp())
        tail.append(e)
        for kind in jets:
            eb=arb(0,e.upper());jets[kind][j]+=acb(eb,eb)
    return jets,tail


def unwind(jets,word):
    current={k:v[:] for k,v in jets.items()};history=[]
    for op in reversed(word):
        old={}
        if op['op']=='T':
            n=op['n'];old[2]=[root8(n)*v for v in current[2]]
            old[3]=current[4 if n%2 else 3][:]
            old[4]=current[3 if n%2 else 4][:]
        else:
            t=op['before'];A=op['A']
            for kind,target in ((2,4),(3,3),(4,2)):
                g0,g1,g2=current[target]
                old[kind]=[A*g0,A*(-g0/(2*t)+g1/t**2),
                           A*(3*g0/(4*t**2)-3*g1/t**3+g2/t**4)]
        current=old;history.append({k:v[:] for k,v in current.items()})
    return current,history


def modular(T,r):
    w,tau=initial(T,r);reduced,word=reduce(tau)
    jets,tails=theta_jets(reduced)
    original,history=unwind(jets,word)
    value=(w/2).exp()*(6*tau*original[3][1]+4*tau*tau*original[3][2])
    return {'T':T,'r':str(r),'w':w,'tau':tau,'reduced':reduced,'word':word,
            'reduced_jets':jets,'tails':tails,'original_jets':original,'history':history,'P':value}


def direct_gaussian(T,r,N=None):
    """Original untransformed P sum, with a separate n-polynomial tail."""
    assert T in (1000000,60343058) and 0<=r<=Q(1,8)
    x=Q(9,16)
    assert 1+x+x*x/2+x**3/6/(1-x/4)<2
    assert PI.upper()<4
    if N is None:N=isqrt((400*(T+1)+5)//6)+51
    w,_=initial(T,r);ex=(2*w).exp()
    c4=8*PI**2*(9*w/2).exp();c2=-12*PI*(5*w/2).exp()
    value=acb(0)
    for n in range(1,N+1):
        if n%1024==0:limit()
        value+=(c4*n**4+c2*n*n)*(-PI*n*n*ex).exp()
    alpha=Q(6,T+1)
    # pi>3.14 and sin(2eta)>=2eta-(2eta)^3/6 prove the lower Gaussian rate.
    assert Q(314,100)*(2-Q(4,3*(T+1)**2))>6
    aa=ar(alpha);u=arb(N+1)
    geometric=(-aa*u*u/2).exp()/(1-(-aa*(2*u+1)/2).exp())
    error=(4096/aa**2+192/aa)*geometric
    e=arb(0,error.upper());value+=acb(e,e)
    return value,error


CHECKS=0
BINARY_CHECKS=0
def check_binary(box,x,label):
    global BINARY_CHECKS
    vals=[arb(int(b['mantissa']))*arb(2)**int(b['exponent']) for b in box]
    assert vals[0]<=x.lower() and x.upper()<=vals[1],label
    BINARY_CHECKS+=1
def check_real(box,x,label):
    global CHECKS
    lo,hi=map(Q,box)
    assert lo<=hi,label
    assert x.lower()>=ar(lo) and x.upper()<=ar(hi),label
    CHECKS+=1
def check_complex(box,z,label,binary=True):
    check_real(box['re'],z.real,label+'.re');check_real(box['im'],z.imag,label+'.im')
    if binary and 'binary_re' in box:
        check_binary(box['binary_re'],z.real,label+'.binary_re')
        check_binary(box['binary_im'],z.imag,label+'.binary_im')
def check_jets(box,jets,label):
    for i,k in enumerate((2,3,4)):
        for j in range(3):check_complex(box[i][j],jets[k][j],f'{label}.{k}.{j}')
def source_tail(alpha,u,j):
    aa=ar(alpha);uu=ar(u);m=1 if j==0 else (2*j/aa)**j
    return 2*4**j*m*(-aa*uu*uu/2).exp()/(1-(-aa*(2*uu+1)/2).exp())
def review_row(row):
    T=row['T'];r=Q(row['r']);w,t=initial(T,r)
    check_complex(row['w'],w,'w');check_complex(row['initial_tau'],t,'tau')
    ops=[]
    for i,s in enumerate(row['steps']):
        check_complex(s['input'],t,f'input{i}')
        if s['kind']=='T':
            n=s['n'];v=t-n
            assert abs(v.real).upper()<ar(Q(3,5)) and v.imag.lower()>0
            check_complex(s['phase8'],root8(n),f'phase{i}')
            ops.append({'op':'T','n':n,'before':t,'after':v})
        else:
            assert s['kind']=='S' and 0<t.imag.lower() and t.imag.upper()<ar(Q(1,2))
            v=-1/t;A=branch_A(t);z=-I*t;norm=abs(z)
            u=((norm+z.real)/2).sqrt();vv=z.imag/(2*u)
            rw=s['root_witness']
            for key,val in [('z',z),('root',acb(u,vv)),('A',A)]:
                check_complex(rw[key],val,f'root{i}.{key}')
            for key,val in [('norm',norm),('u',u),('v',vv)]:
                check_real(rw[key],val,f'root{i}.{key}')
                if 'binary_'+key in rw:check_binary(rw['binary_'+key],val,f'root{i}.binary_{key}')
            assert v.imag.lower()>ar(Q(100,61))*t.imag.upper()
            ops.append({'op':'S','before':t,'after':v,'A':A})
        check_complex(s['output'],v,f'output{i}');t=v
    assert sum(s['op']=='S' for s in ops)==row['inversions']
    assert t.imag.lower()>ar(Q(2,5))
    check_complex(row['reduced_tau'],t,'reduced')
    finite={2:[acb(0) for _ in range(3)],3:[acb(1),acb(0),acb(0)],4:[acb(1),acb(0),acb(0)]}
    terms=row['reduced_series']['terms'];assert len(terms)==40
    integers=[];halves=[]
    for s in terms:
        if 'integer_n' in s:
            n=s['integer_n'];integers.append(n);x=Q(n);targets=[(3,1),(4,(-1)**n)]
        else:
            n=s['half_index'];halves.append(n);x=Q(2*n+1,2);targets=[(2,1)]
        c=PI*I*ar(x*x);e=(c*t).exp()
        for j in range(3):
            value=2*c**j*e;check_complex(s['jet_term'][j],value,'term')
            for k,sgn in targets:finite[k][j]+=sgn*value
    assert sorted(integers)==list(range(1,21)) and sorted(halves)==list(range(20))
    check_jets(row['reduced_series']['finite_jets'],finite,'finite')
    for j in range(3):
        tail=source_tail(Q(6,5),Q(41,2),j)
        check_real(row['reduced_series']['tail_bounds'][j],tail,'tail')
        check_binary(row['reduced_series']['binary_tail_bounds'][j],tail,'binary_tail')
    actual,tails=theta_jets(t,32,Q(6,5))
    check_jets(row['reduced_series']['enclosed_jets'],actual,'reduced_true')
    original,history=unwind(actual,ops)
    assert len(history)==len(row['unwind_trace'])
    for i,(a,s) in enumerate(zip(history,row['unwind_trace'])):
        assert s['kind']==ops[-1-i]['op']
        check_jets(s['jets'],a,f'unwind{i}')
    check_jets(row['original_jets'],original,'original')
    _,tau=initial(T,r)
    P=(w/2).exp()*(6*tau*original[3][1]+4*tau*tau*original[3][2])
    check_complex(row['P'],P,'P')
    alt=modular(T,r)
    check_complex(row['P'],alt['P'],'alternate_P')
    for j in range(3):check_complex(row['original_jets'][1][j],alt['original_jets'][3][j],'alternate_jet')
    start=time.monotonic();d,err=direct_gaussian(T,r)
    assert d.overlaps(P) and d.overlaps(alt['P']),'independent direct comparison'
    # The direct-tail bound is wider than the raw modular interval at r=0.
    # It fits the display box; the independently enclosed true modular value
    # above also belongs to the raw binary interval and overlaps this direct sum.
    check_complex(row['P'],d,'direct_P_in_modular_display_box',False)
    dw=row['direct'];assert dw['status']=='completed'
    check_complex(dw['P'],P,'source_direct_box')
    check_complex(dw['raw_kernel_P'],P,'source_raw_box')
    for j in range(3):
        check_complex(dw['jets'][j],original[3][j],'source_direct_jet')
        tail=source_tail(Q(dw['alpha']),Q(dw['N']+1),j)
        check_real(dw['jet_tails'][j],tail,'direct_tail')
        check_binary(dw['binary_jet_tails'][j],tail,'binary_direct_tail')
    assert 0<ar(Q(dw['alpha']))<PI.lower()*tau.imag.lower()
    return {'T':T,'r':str(r),'source_word':[(s['op'],s.get('n')) for s in ops],
            'alternate_word':[(s['op'],s.get('n')) for s in alt['word']],
            'P':enc(P),'alternate_P':enc(alt['P']),'direct_P':enc(d),
            'direct_N':isqrt((400*(T+1)+5)//6)+51,
            'direct_error':enc_real(err),'direct_seconds':time.monotonic()-start}


def main():
    source=HERE.parent/'prime-estimates'
    names=['principal_theta_modular_pilot_20261111.py','principal_theta_modular_pilot_20261111.json',
           'PRINCIPAL_THETA_MODULAR_PILOT_2026-11-11.md']
    hashes={n:hashlib.sha256((source/n).read_bytes()).hexdigest().upper() for n in names}
    assert hashes[names[0]]=='EAFAC6A19BE3947CBF6D4BA6F900FE3E8BAB58E1C1963E0C1DC35A61A6F55B14'
    assert hashes[names[1]]=='C39982174CAC9C51E9F816275082BCE322CA2AD143D9FCE61081DF72E57B11EF'
    assert hashes[names[2]]=='F0833712D50FBE36BDC8E29173A277CCBDC2C0CBAF4A1F7CA86F4F80B28E752D'
    dependencies={
        'integration/PRINCIPAL_THETA_MODULAR_ACCELERATION_2026-11-11.md':'C64EDFEB89B0F15B8B225241248BC7A751C385247843CE3AFEBF8FCF0382E84D',
        'audit/REVIEW_PRINCIPAL_THETA_MODULAR_ACCELERATION_2026-11-11.md':'9C2C4348EC29A5C3B4ACD6221CFE96F011C191395877E3654FC69DD81C7987ED'}
    for name,pin in dependencies.items():assert hashlib.sha256((HERE.parent/name).read_bytes()).hexdigest().upper()==pin
    data=json.loads((source/names[1]).read_text())
    assert [(p['T'],Q(p['r'])) for p in data['points']]==[(T,r) for T in (1000000,60343058) for r in (Q(0),Q(1,8))]
    check_real(data['pi'],PI,'pi_from_Machin')
    if 'binary_pi' in data:check_binary(data['binary_pi'],PI,'binary_pi_from_Machin')
    rows=[review_row(row) for row in data['points']]
    # Negative controls concern branch and derivative semantics, not only hashes.
    test=data['points'][1];a=modular(1000000,Q(1,8));controls=[]
    for label,box,wrong in [
        ('negated_P',test['P'],-a['P']),
        ('swapped_derivative',test['original_jets'][1][1],a['original_jets'][3][2])]:
        try:check_complex(box,wrong,label)
        except AssertionError:controls.append(label)
        else:raise AssertionError('negative control accepted: '+label)
    firstS=next(s for s in test['steps'] if s['kind']=='S')
    _,tau=initial(1000000,Q(1,8));wrong=-branch_A(tau+1)
    try:check_complex(firstS['root_witness']['A'],wrong,'negative_root')
    except AssertionError:controls.append('negative_root')
    else:raise AssertionError('negative root accepted')
    out={'status':'PASS all four coefficients and all retained transformation/jet records',
         'source_hashes':hashes,'precision_bits':ctx.prec,'scalar_containments':CHECKS,
         'binary_containments':BINARY_CHECKS,'points':rows,'negative_controls_rejected':controls,
         'dependency_hashes':dependencies,
         'wall_seconds':time.monotonic()-START,
         'scope':'External interval evidence with reviewed identities; not a kernel-certified checker or spectral result'}
    path=HERE/'review_principal_theta_modular_pilot_20261111.json'
    path.write_text(json.dumps(out,indent=2)+'\n')
    print(json.dumps({k:v for k,v in out.items() if k!='points'}))
if __name__=='__main__':main()
