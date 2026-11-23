"""Independent full-grid and changed-mesh audit of one xi Taylor disk."""
from pathlib import Path
from fractions import Fraction as Q
from math import factorial
import importlib.util,hashlib,json,time
from flint import arb,acb,ctx

HERE=Path(__file__).resolve().parent
helper=HERE/'review_principal_theta_modular_pilot_20261111.py'
assert hashlib.sha256(helper.read_bytes()).hexdigest().upper()=='60B92C3B84B988FC7AB2FB45AB114798C55A4F392A9282F6D7CDD26F1AD75E1C'
sp=importlib.util.spec_from_file_location('own_theta',helper)
H=importlib.util.module_from_spec(sp);sp.loader.exec_module(H)
ctx.prec=384
ar=H.ar;PI=H.PI;I=acb(0,1)
START=time.monotonic();b=PI/4-ar(Q(1,33));s=acb(ar(Q(1,10)),14)
S=2**128;DEG=12;rho=Q(1,64)

def guard():
    if time.monotonic()-START>500:raise RuntimeError('500-second bound')

def direct_node(v,N=64):
    """Original P, not modular theta, with an n-polynomial tail."""
    vv=ar(v);w=acb(vv,b);e2=(2*vv).exp()
    z=e2*acb((2*b).cos(),(2*b).sin())
    c4=8*PI**2*(9*w/2).exp();c2=-12*PI*(5*w/2).exp()
    ans=acb(0)
    for n in range(1,N+1):ans+=(c4*n**4+c2*n*n)*(-PI*z*n*n).exp()
    assert PI.lower()*(2*b).cos().lower()>ar(Q(9,50))
    alpha=ar(Q(9,50))*e2;u=arb(N+1)
    geom=(-alpha*u*u/2).exp()/(1-(-alpha*(2*u+1)/2).exp())
    tail=(abs(c4)*(4/alpha)**2+abs(c2)*2/alpha)*geom
    er=arb(0,tail.upper());return ans+acb(er,er)

def word_node(v,word):
    w=acb(ar(v),b);tau=(2*ar(v)).exp()*acb(-(ar(Q(2,33))).cos(),ar(Q(2,33)).sin())
    t=tau;ops=[]
    for step in word:
        if step[0]=='T':
            n=step[1];z=t-n
            assert abs(z.real).upper()<ar(Q(3,5)) and z.imag.lower()>0
            ops.append({'op':'T','n':n,'before':t,'after':z})
        else:
            assert step==['S'] and t.imag.upper()<ar(Q(1,2))
            z=-1/t
            assert z.imag.lower()>ar(Q(100,61))*t.imag.upper()
            ops.append({'op':'S','before':t,'after':z,'A':H.branch_A(t)})
        t=z
    assert t.imag.lower()>ar(Q(2,5))
    jets,_=H.theta_jets(t,32,Q(6,5));jets,_=H.unwind(jets,ops)
    return (w/2).exp()*(6*tau*jets[3][1]+4*tau*tau*jets[3][2])

def wc(center):return acb(ar(Q(int(center[0]),S)),ar(Q(int(center[1]),S)))

def analytic(h,T):
    kappa=r=Q(1,66);C=3*kappa;q=C/2;z0=3*C/2
    A=(2048/C**2+96/C)*(1+z0)/z0;M=A/q;D=A*(1/q+1/q**2)
    R=arb(8).exp();assert ar(q)*R>2
    den=(2*PI*ar(r/h)).exp()-1
    qe=[2*ar(M)*ar(T*r).exp()]+[2*ar(D)*ar((T+1)*r).exp()]*DEG
    qe=[x/den for x in qe]
    se=[ar(A/q)*(-ar(q)*R).exp()]+[ar(A)*(-ar(q)*R).exp()*(R/ar(q)+ar(1/q**2))]*DEG
    return qe,se,D,{'C':C,'q':q,'z0':z0,'A':A,'M':M,'D':D}

def full_source(data):
    assert data['degree']==DEG and int(data['center_scale'])==S
    expected={'T':'32','sigma':'3/5','t':'14','eta':'1/33','r':'1/66','kappa':'1/66','h':'1/512','K':'2048','V':'4','rho':'1/64'}
    assert data['parameters']==expected
    H.check_real(data['pi'],PI,'pi');H.check_real(data['b'],b,'b')
    assert b>0 and b+ar(Q(1,66))<PI/4 and ar(Q(1,66))<(2*(b+ar(Q(1,66)))).cos()
    h=Q(1,512);K=2048;acc=[[0,0] for _ in range(13)];we=[0]*13;ne=[arb(0) for _ in range(13)]
    finite=[acb(0) for _ in range(13)];inversions=0;weights=0
    assert len(data['nodes'])==K+1
    for k,row in enumerate(data['nodes']):
        if k%128==0:guard()
        assert row['k']==k;v=k*h
        p=direct_node(v);pm=word_node(v,row['word']);assert p.overlaps(pm)
        H.check_complex(row['P'],p,f'direct_node{k}')
        H.check_complex(row['P'],pm,f'word_node{k}')
        pc=list(map(int,row['center_radius']));px,py,pe=pc
        a,c=(Q(x)*S for x in row['P']['re']);d,f=(Q(x)*S for x in row['P']['im'])
        assert all(x.denominator==1 for x in (a,c,d,f))
        xx=(int(a)+int(c))//2;yy=(int(d)+int(f))//2
        ee=max(xx-int(a),int(c)-xx)+max(yy-int(d),int(f)-yy)
        assert pc==[xx,yy,ee]
        assert pe>=0 and abs(p-wc(pc)).upper()<=ar(Q(pe,S))
        inversions+=sum(z[0]=='S' for z in row['word'])
        assert [x['sign'] for x in row['signed_weights']]==([1] if k==0 else [1,-1])
        for item in row['signed_weights']:
            sign=item['sign'];vv=sign*v;pp=p if sign==1 else p.conjugate()
            cy=py*sign;ev=(s*ar(vv)).exp();en=ar(Q(1,10)*vv).exp()
            assert len(item['weights'])==13
            for j,c in enumerate(item['weights']):
                wx,wy,ee=map(int,c);exact=ar(h*vv**j/factorial(j))*ev
                assert ee>=0 and abs(exact-wc(c)).upper()<=ar(Q(ee,S))
                if k==0 and j>0:assert wx==wy==ee==0
                acc[j][0]+=wx*px-wy*cy;acc[j][1]+=wx*cy+wy*px
                we[j]+=ee*(abs(px)+abs(cy))
                ne[j]+=ar(h*Q(pe,S)*abs(vv)**j/factorial(j))*en
                finite[j]+=exact*pp;weights+=1
    assert inversions==data['total_inversions']
    qe,se,D,constants=analytic(h,Q(32))
    assert {k:Q(v) for k,v in data['constants'].items()}==constants
    H.check_real(data['q_exp_2V'],ar(constants['q'])*arb(8).exp(),'qR')
    H.check_real(data['denominator'],(2*PI*ar(Q(1,66)/h)).exp()-1,'denominator')
    ec=[]
    for j,c in enumerate(data['coefficients']):
        assert c['j']==j and list(map(int,c['center_numerators']))==acc[j] and int(c['center_denominator'])==S*S
        assert Q(c['summation_error'])==0 and Q(c['weight_error'])==Q(we[j],S*S)
        assert qe[j].upper()<=ar(Q(c['Q'])) and se[j].upper()<=ar(Q(c['S']))
        assert ne[j].upper()<=ar(Q(c['node_error']))
        assert Q(c['total_error'])==sum(Q(c[name]) for name in ['Q','S','node_error','weight_error','summation_error'])
        center=acb(ar(Q(acc[j][0],S*S)),ar(Q(acc[j][1],S*S)))
        assert abs(finite[j]-center).upper()<=ar(Q(c['node_error'])+Q(c['weight_error']))
        ec.append(center)
    disk=data['disk'];rem=D*rho**13/(1-rho)
    assert Q(disk['remainder'])==rem
    errors=rem+sum(Q(c['total_error'])*rho**j for j,c in enumerate(data['coefficients']))
    assert Q(disk['coefficient_error_plus_remainder'])==errors
    variation=sum((abs(ec[j])*ar(rho**j) for j in range(1,13)),arb(0))
    assert variation.upper()<=ar(Q(disk['polynomial_variation_upper']))
    assert ar(Q(disk['center_abs_lower']))<=abs(ec[0]).lower()
    radius=errors+Q(disk['polynomial_variation_upper'])
    assert radius==Q(disk['total_radius_about_constant'])
    margin=Q(disk['center_abs_lower'])-radius
    assert margin==Q(disk['nonvanishing_margin']) and margin>0 and disk['nonvanishing'] is True
    return {'nodes':K+1,'weights':weights,'inversions':inversions,'margin':str(margin)},ec

def alternate_mesh(data,centers):
    h=Q(1,640);K=2560;finite=[acb(0) for _ in range(13)]
    for k in range(K+1):
        if k%128==0:guard()
        v=k*h;p=direct_node(v)
        for sign in ([1] if k==0 else [1,-1]):
            vv=sign*v;pp=p if sign==1 else p.conjugate();term=ar(h)*(s*ar(vv)).exp()*pp
            for j in range(13):
                finite[j]+=term;term*=ar(vv)/arb(j+1)
    qe,se,D,_=analytic(h,Q(14));errors=[qe[j]+se[j] for j in range(13)]
    for j in range(13):
        assert (abs(finite[j]-centers[j])+errors[j]).upper()<=ar(Q(data['coefficients'][j]['total_error']))
    rem=ar(D*rho**13/(1-rho))
    radius=rem+sum((errors[j]*ar(rho**j) for j in range(13)),arb(0))
    radius+=sum((abs(finite[j])*ar(rho**j) for j in range(1,13)),arb(0))
    margin=abs(finite[0]).lower()-radius.upper();assert margin>0
    return {'h':str(h),'K':K,'N_per_node':64,'analytic_work_height':14,
            'coefficient_finite_intervals':[H.enc(x) for x in finite],
            'coefficient_analytic_errors':[H.enc_real(x) for x in errors],
            'disk_margin':H.enc_real(margin)}

def main():
    source=HERE.parent/'prime-estimates'
    names=['PRINCIPAL_MODULAR_XI_PANEL_PILOT_2026-11-11.md','principal_modular_xi_panel_pilot_20261111.py','principal_modular_xi_panel_pilot_20261111.json']
    pins={n:hashlib.sha256((source/n).read_bytes()).hexdigest().upper() for n in names}
    assert pins[names[0]]=='85EDD45B5DEB8E96AEC957AA956E90AEBEC4B9B0C9BE31C7D06FA52DAE6E2D49'
    assert pins[names[1]]=='626A931E23A0B3585C0803D34D920BE759E792B230638BDD0E48155874203416'
    assert pins[names[2]]=='0B01EC0CA4A0102816CFB22DE51AE5751975288AC1544F5ABBABCA84BF4A8608'
    dependencies={
        'integration/PRINCIPAL_MODULAR_NODE_SUBSTITUTION_2026-11-11.md':'5950604713D39C0A60194D58453D72E74E947120CB110252739D728BFCF1E571',
        'major-constants/REVIEW_PRINCIPAL_MODULAR_NODE_SUBSTITUTION_2026-11-11.md':'FB75E5919ECFD5F7800290C64DD1C0DFFCA7EA4FDFAE4B5FB4BFBBF4B3B27DAD'}
    for name,pin in dependencies.items():assert hashlib.sha256((HERE.parent/name).read_bytes()).hexdigest().upper()==pin
    data=json.loads((source/names[2]).read_text());summary,centers=full_source(data)
    alternate=alternate_mesh(data,centers)
    out={'status':'PASS complete single-disk independent review','producer_hashes':pins,
         'precision_bits':384,'source_replay':summary,'alternate_mesh':alternate,'dependency_hashes':dependencies,
         'node_scalar_containments':H.CHECKS,'node_binary_containments':H.BINARY_CHECKS,
         'wall_seconds':time.monotonic()-START,'scope':'One external closed-disk certificate, no Lean or spectral count'}
    path=HERE/'review_principal_modular_xi_panel_pilot_20261111.json'
    path.write_text(json.dumps(out,indent=2)+'\n')
    print(json.dumps({k:v for k,v in out.items() if k!='alternate_mesh'}))

if __name__=='__main__':main()
