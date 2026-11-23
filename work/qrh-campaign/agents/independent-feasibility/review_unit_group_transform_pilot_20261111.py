"""Independent residue-character and Hurwitz EM checks; no L/zeta oracle."""
from pathlib import Path
from fractions import Fraction as Q
from itertools import product
from math import gcd,factorial
import hashlib,json,time
from flint import arb,acb,ctx

ctx.prec=256
HERE=Path(__file__).resolve().parent
START=time.monotonic()
N=96
P=28
ROOTS=[(1,0),(0,1),(-1,0),(0,-1)]


def limit():
    if time.monotonic()-START>560: raise RuntimeError('560-second bound')


def ar(q):
    q=Q(q); return arb(str(q.numerator))/q.denominator


def enc_real(x): return [str(x.lower().fmpq()),str(x.upper().fmpq())]
def enc(x): return {'re':enc_real(x.real),'im':enc_real(x.imag)}
def cmul(z,w): return z[0]*w[0]-z[1]*w[1],z[0]*w[1]+z[1]*w[0]


def coords(c,a):
    assert c in (40,120) and 1<=a<c and gcd(c,a)==1
    e,f={1:(0,0),5:(0,1),7:(1,0),3:(1,1)}[a%8]
    g={1:0,2:1,4:2,3:3}[a%5]
    return (e,f,g) if c==40 else (e,f,0 if a%3==1 else 1,g)


def chi(c,label,a):
    if gcd(c,a)!=1: return (0,0)
    x=coords(c,a%c)
    return ROOTS[sum((2 if i<len(x)-1 else 1)*r*t
                     for i,(r,t) in enumerate(zip(label,x)))%4]


def selected(c):
    return [(e,1,g) if c==40 else (e,1,1,g)
            for e in range(2) for g in (1,2,3)]


def character_checks(c):
    units=[a for a in range(1,c) if gcd(a,c)==1]
    dims=(2,2,4) if c==40 else (2,2,2,4)
    assert len({coords(c,a) for a in units})==len(units)
    assert set(coords(c,a) for a in units)==set(product(*(range(d) for d in dims)))
    for a in units:
        for b in units:
            assert coords(c,a*b%c)==tuple((x+y)%d for x,y,d in zip(coords(c,a),coords(c,b),dims))
    classified=[]
    for label in product(*(range(d) for d in dims)):
        factors=False
        for d in range(1,c):
            if c%d: continue
            grouped={}
            for a in units:grouped.setdefault(a%d,set()).add(chi(c,label,a))
            assert set(grouped)=={a for a in range(d) if gcd(a,d)==1}
            if all(len(v)==1 for v in grouped.values()):
                factors=True;break
        if not factors:classified.append(label)
    assert classified==selected(c)
    checks=[]
    for label in selected(c):
        values={a:chi(c,label,a) for a in units}
        assert values[1]==(1,0)
        assert tuple(map(sum,zip(*values.values())))==(0,0)
        for a in units:
            for b in units:
                assert cmul(values[a],values[b])==values[a*b%c]
        witnesses={}
        for d in range(1,c):
            if c%d: continue
            witness=next(((a,b) for a in units for b in units
                          if a%d==b%d and values[a]!=values[b]),None)
            assert witness is not None,(c,label,d)
            witnesses[str(d)]=list(witness)
        parity=values[c-1]
        expected=(-1)**(label[0]+label[-1]+(label[2] if c==120 else 0))
        assert parity==(expected,0)
        inverse=tuple((-r)%d for r,d in zip(label,dims))
        for a in units:
            z=values[a]
            assert chi(c,inverse,a)==(z[0],-z[1])
        checks.append({'label':label,'parity':expected,
                       'proper_divisor_nonfactor_witnesses':witnesses})
    return units,checks


def corruption_checks(c):
    units=[a for a in range(1,c) if gcd(a,c)==1]
    generator5=next(a for a in units if a%8==1 and a%5==2 and (c==40 or a%3==1))
    label=(0,1,1) if c==40 else (0,1,1,1)
    true=chi(c,label,generator5)
    assert true==(0,1) and true!=(0,-1)
    # A delta input at this actual residue distinguishes positive from negative
    # exponents, and a normalized transform cannot preserve its modulus one.
    assert Q(1,len(units))!=1
    sign_generator=next(a for a in units if a%8==7 and a%5==1 and (c==40 or a%3==1))
    swapped=(1,0,1) if c==40 else (1,0,1,1)
    assert chi(c,label,sign_generator)!=chi(c,swapped,sign_generator)
    # Changing the five-power generator to 1 collapses the two f coordinates.
    wrong_coords={(a%8 in (3,7),0,a%5,a%3 if c==120 else 0) for a in units}
    assert len(wrong_coords)<len(units)
    imprimitive=(0,0,1) if c==40 else (0,0,1,1)
    d=c//2
    assert all(chi(c,imprimitive,a)==chi(c,imprimitive,b)
               for a in units for b in units if a%d==b%d)
    return {'c':c,'positive_exponent_delta_residue':generator5,
            'axis_swap_delta_residue':sign_generator,
            'normalization_rejected':True,'collapsed_generator_rejected':True,
            'imprimitive_mutation_factors_through':d}


BERN=[Q(1)]
for n in range(1,2*P+1):
    BERN.append(-sum((BERN[k]/factorial(n+1-k) for k in range(n)),Q(0)))
assert BERN[2]==Q(1,12) and BERN[4]==Q(-1,720)


def finite_hurwitz(alpha,sigma,t,truncation=N,order=P):
    """Ordinary Hurwitz at s!=1, ordinary finite part at s=1."""
    limit(); s=acb(ar(sigma),ar(t)); q=Q(truncation)+alpha
    logs=[ar(Q(n)+alpha).log() for n in range(truncation)]
    head=sum(((-s*l).exp() for l in logs),acb(0)); value=head
    logq=ar(q).log(); qp=(-s*logq).exp()
    if sigma==1 and t==0:
        pole=-acb(logq)
    else:
        pole=((acb(1)-s)*logq).exp()/(s-1)
    value+=pole+qp/2
    corrections=[]
    rising=acb(1); normprod=arb(1)
    for j in range(2*order):
        rising*=s+j
        normprod*=(ar(sigma+j)**2+ar(t)**2).sqrt()
        if j%2==0:
            k=(j+2)//2
            correction=qp*rising*ar(BERN[2*k])*ar(q**(1-2*k))
            corrections.append(correction); value+=correction
    error=4*normprod*((1-ar(sigma)-2*order)*logq).exp()/(6**(2*order)*ar(sigma+2*order-1))
    e=arb(0,error.upper()); value+=acb(e,e)
    if sigma==1 and t==0:
        value=acb(value.real,0); deflated=value; pole_difference=pole
    else:
        deflated=value-1/(s-1); pole_difference=pole-1/(s-1)
    details={'head':head,'B_minus_s':qp,'half':qp/2,
             'corrections':corrections,'pole_difference':pole_difference,
             'deflated':deflated}
    return value,error,details


def independent_case(c,sigma,t):
    units,checks=character_checks(c)
    raw={};errors={}
    for a in units:
        raw[a],errors[a],_=finite_hurwitz(Q(a,c),sigma,t)
    centered={a:(acb(0) if a==1 else raw[a]-raw[1]) for a in units}
    factor=(-acb(ar(sigma),ar(t))*arb(c).log()).exp()
    rows=[]
    for label in selected(c):
        total=acb(0)
        for a in units:
            re,im=chi(c,label,a)
            total+=acb(re,im)*raw[a]
        rows.append({'label':list(label),'L':enc(factor*total)})
    return {'c':c,'sigma':str(sigma),'t':str(t),
            'parameters':{'N':N,'P':P,'bits':ctx.prec},
            'all_primitive_labels_independently_classified':selected(c),
            'characters':checks,'factor':enc(factor),
            'coefficients':[{'a':a,'coords':list(coords(c,a)),
                             'D':enc(centered[a]),'raw_error':enc_real(errors[a])}
                            for a in units], 'rows':rows}


def rb(a):
    lo,hi=a; d=1<<128
    ll=(lo*d).numerator//(lo*d).denominator
    q=-hi*d; hh=-(q.numerator//q.denominator)
    assert Q(ll,d)<=lo<=hi<=Q(hh,d)
    return Q(ll,d),Q(hh,d)
def ra(a,b): return rb((a[0]+b[0],a[1]+b[1]))
def rn(a): return -a[1],-a[0]
def rm(a,b):
    v=[x*y for x in a for y in b];return rb((min(v),max(v)))
def za(z,w): return ra(z[0],w[0]),ra(z[1],w[1])
def zn(z):return rn(z[0]),rn(z[1])
def zm(z,w):return ra(rm(z[0],w[0]),rn(rm(z[1],w[1]))),ra(rm(z[0],w[1]),rm(z[1],w[0]))
def zp(k,z):
    k%=4
    if k==0:return z
    if k==1:return rn(z[1]),z[0]
    if k==2:return zn(z)
    return z[1],rn(z[0])
Z=((Q(0),Q(0)),(Q(0),Q(0)))
def decode(z):return tuple(tuple(map(Q,v)) for v in z)
def disjoint(z,w):return any(max(a[0],b[0])>min(a[1],b[1]) for a,b in zip(z,w))


def exact_tensor(data,axes,dims,sign=1):
    current=dict(zip(axes,data)); stages=[]
    for axis,m in enumerate(dims):
        new={}
        for out in axes:
            terms=[]
            for j in range(m):
                ix=list(out);ix[axis]=j
                terms.append(zp(sign*out[axis]*j*(4//m),current[tuple(ix)]))
            value=Z
            for v in terms:value=za(value,v)
            new[out]=value
        current=new; stages.append([current[ix] for ix in axes])
    return stages


def run():
    base=HERE.parent/'prime-estimates'
    pins={
        'UNIT_GROUP_TRANSFORM_PILOT_2026-11-11.md':'9857F80EA37AAD0134A0C588841CD22D82424B201DFF980ED7C6B4AE01812225',
        'unit_group_transform_pilot_20261111.py':'9C0739E966109EC71A251182668A4A6670174C2248CADE3C3D271033CD2E2800',
        'unit_group_transform_pilot_20261111.json':'0630A8FBCB5C20A191D4DA8AEF5FE367F6FBE090FE8463C5CD0A4E2D5987EFEC',
        'principal_k0_point_certificates_20261111.py':'9A84F801745C8F9DD7CAD2F0E41F7633F8AFB850895C68845D4119E675543A22',
    }
    for name,pin in pins.items():assert hashlib.sha256((base/name).read_bytes()).hexdigest().upper()==pin
    source=json.loads((base/'unit_group_transform_pilot_20261111.json').read_text())
    assert source['helper_sha256']==pins['principal_k0_point_certificates_20261111.py']
    assert [Q(x) for x in source['bernoulli_numbers']]==[BERN[j]*factorial(j) for j in range(25)]
    assert [(v['c'],v['sample']) for v in source['runs']]==[(40,'one'),(40,'half_plus_10i'),(120,'one'),(120,'half_plus_10i')]
    counts={'component_containments':0,'exact_rational_values':0,'tensor_stage_entries':0,'selected_rows':0,'coefficients':0,'mutation_cases':0}
    def contains(outer,inner):
        if isinstance(inner,dict):inner=[inner['re'],inner['im']]
        elif isinstance(inner,acb):inner=[enc_real(inner.real),enc_real(inner.imag)]
        for o,i in zip(outer,inner):
            lo,hi=map(Q,o); ll,hh=map(Q,i)
            assert lo<=ll<=hh<=hi,(outer,inner)
        counts['component_containments']+=1
    results=[];max_widths={'one':Q(0),'half_plus_10i':Q(0)}
    for src in source['runs']:
        c=src['c']; sigma,t=map(Q,src['s'])
        assert (sigma,t)==((Q(1),Q(0)) if src['sample']=='one' else (Q(1,2),Q(10)))
        product_bound=Q(1)
        for j in range(24):product_bound*=sigma+j+abs(t)
        uniform=4*product_bound*(Q(1) if sigma==1 else Q(8))/(64**24*6**24*(sigma+23))
        assert Q(source['uniform_EM_errors'][src['sample']])==uniform
        own=independent_case(c,sigma,t)
        dims=tuple(src['dimensions']);expected_dims=(2,2,4) if c==40 else (2,2,2,4)
        assert dims==expected_dims
        axes=[tuple(x) for x in src['coordinates']]
        assert axes==list(product(*(range(m) for m in dims)))
        residues=src['residues'];assert len(residues)==len(axes)
        assert [coords(c,a) for a in residues]==axes and residues[0]==1
        moduli=(8,5) if c==40 else (8,3,5)
        for e,q in zip(src['crt_idempotents'],moduli):
            assert e%q==1 and all(e%r==0 for r in moduli if r!=q)
        own_coeff={r['a']:r for r in own['coefficients']}
        H=[];D=[]
        for a,wit,dsrc in zip(residues,src['coefficient_witnesses'],src['centered_coefficients']):
            assert Q(wit['q'])==Q(a,c) and Q(wit['B'])==64+Q(a,c)
            assert Q(wit['remainder_norm_bound'])==uniform
            _,error,details=finite_hurwitz(Q(a,c),sigma,t,64,12)
            assert Q(str(error.upper().fmpq()))<=Q(wit['remainder_norm_bound'])
            for key in ('head','B_minus_s','half','pole_difference','deflated'):
                if sigma==1 and t==0 and key=='B_minus_s':
                    v=1/(Q(64)+Q(a,c))
                    assert decode(wit[key])==((v,v),(Q(0),Q(0)))
                    counts['exact_rational_values']+=1
                else: contains(wit[key],details[key])
            assert len(wit['corrections'])==12
            for outer,inner in zip(wit['corrections'],details['corrections']):contains(outer,inner)
            contains(dsrc,own_coeff[a]['D'])
            H.append(decode(wit['deflated']));D.append(decode(dsrc))
            counts['coefficients']+=1
        assert D==[Z]+[za(h,zn(H[0])) for h in H[1:]]
        stages=exact_tensor(D,axes,dims)
        assert len(stages)==len(src['tensor_stages'])
        for calc,saved in zip(stages,src['tensor_stages']):
            assert calc==list(map(decode,saved));counts['tensor_stage_entries']+=len(calc)
        outputs=stages[-1]
        assert outputs==list(map(decode,src['all_centered_transform_outputs']))
        p=decode(src['c_minus_s'])
        if sigma==1 and t==0:
            assert p==((Q(1,c),Q(1,c)),(Q(0),Q(0)))
            counts['exact_rational_values']+=1
        else: contains(src['c_minus_s'],own['factor'])
        assert [tuple(r['label']) for r in src['selected_rows']]==selected(c)
        own_rows={tuple(r['label']):r for r in own['rows']}
        raw_by_a=dict(zip(residues,H));directs={}
        for row in src['selected_rows']:
            label=tuple(row['label']);ix=axes.index(label)
            assert row['index']==ix
            assert row['parity']==(label[0]+label[-1]+(label[2] if c==120 else 0))%2
            assert row['inverse_label']==[(-r)%m for r,m in zip(label,dims)]
            total=Z
            for a in sorted(residues):total=za(total,zp(ROOTS.index(chi(c,label,a)),raw_by_a[a]))
            direct=zm(p,total);directs[label]=direct
            assert direct==decode(row['direct_raw_deflated_L'])
            assert zm(p,outputs[ix])==decode(row['tensor_L'])
            assert max(hi-lo for lo,hi in decode(row['tensor_L']))<Q(1,10**20)
            max_widths[src['sample']]=max(max_widths[src['sample']],max(hi-lo for lo,hi in decode(row['tensor_L'])))
            contains(row['tensor_L'],own_rows[label]['L'])
            contains(row['direct_raw_deflated_L'],own_rows[label]['L'])
            counts['selected_rows']+=1
        negative=exact_tensor(D,axes,dims,-1)[-1]
        rejected=[list(r) for r in selected(c) if disjoint(zm(p,negative[axes.index(r)]),directs[r])]
        assert rejected==src['mutations']['negative_sign_rejected_labels'] and rejected
        bad=residues[:];bad[1],bad[2]=bad[2],bad[1]
        assert any(coords(c,a)!=x for x,a in zip(axes,bad))
        swapped=exact_tensor([D[residues.index(a)] for a in bad],axes,dims)[-1]
        rejected=[list(r) for r in selected(c) if disjoint(zm(p,swapped[axes.index(r)]),directs[r])]
        assert rejected==src['mutations']['swapped_digits_disjoint_selected_labels'] and rejected
        assert src['mutations']['swapped_digits_rejected_by_exact_character_test'] is True
        badlabel=tuple(src['mutations']['nonprimitive_label_rejected'])
        assert badlabel[1]==0 and badlabel not in selected(c)
        own['independent_corruptions']=corruption_checks(c)
        counts['mutation_cases']+=1
        results.append(own)
    limit()
    assert max_widths['one']<Q(2,10**37)
    assert max_widths['half_plus_10i']<Q(1367,10**32)
    result={'status':'PASS_ALL_96_COEFFICIENTS_24_SELECTED_ROWS_AND_TRANSFORM_STAGES',
            'producer_sha256':pins,'counts':counts,'runs':results,
            'max_source_coordinate_width':{k:str(v) for k,v in max_widths.items()},
            'scope':'External arithmetic and source-semantic review only; no contour, zeros, or Lean proof.',
            'elapsed_seconds':time.monotonic()-START,
            'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper()}
    out=Path(__file__).with_suffix('.json');out.write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({'status':result['status'],'counts':counts,'elapsed_seconds':result['elapsed_seconds'],
                     'script_sha256':result['script_sha256'],
                     'receipt_sha256':hashlib.sha256(out.read_bytes()).hexdigest().upper()}))


if __name__=='__main__':run()
