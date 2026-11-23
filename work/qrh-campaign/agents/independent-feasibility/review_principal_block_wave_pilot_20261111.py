"""All 34 wave samples: exact recurrence replay and alternate direct Khat."""
from pathlib import Path
from fractions import Fraction as Q
import importlib.util,hashlib,json,time

HERE=Path(__file__).resolve().parent
BASE=HERE.parent/'prime-estimates'
START=time.monotonic()
PINS={
    'principal_block_wave_pilot_20261111.py':'A35976CBB906FA01A8F275C1C6262DD55835D442A179DEC1CEA22471FA132F34',
    'principal_block_wave_pilot_20261111.json':'B3C699860BBE37132305DD5C23AC5FDC1E82742AF85F97C3E75EA98FDC9BDA56',
    'principal_k0_point_certificates_20261111.py':'9A84F801745C8F9DD7CAD2F0E41F7633F8AFB850895C68845D4119E675543A22',
}
HELPER=HERE/'review_k0_point_certificates_20261111.py'
HELPER_HASH='97622AE1D4402C3BB73483C34438E493514570ED965C446A897419BEBE53BBCD'
assert hashlib.sha256(HELPER.read_bytes()).hexdigest().upper()==HELPER_HASH
spec=importlib.util.spec_from_file_location('alternate_direct_khat',HELPER)
E=importlib.util.module_from_spec(spec);spec.loader.exec_module(E)
D=1<<48
COUNTS={'containments':0,'initial_waves':0,'rotations':0,'updates':0,'samples':0,'direct_terms':0}


def limit():
    if time.monotonic()-START>550:raise RuntimeError('550-second bound')
def vec(z):return tuple(map(Q,z))
def interval(a):return tuple(map(Q,a))
def rectangle(a):return tuple(map(interval,a))
def mul(z,w):return z[0]*w[0]-z[1]*w[1],z[0]*w[1]+z[1]*w[0]
def l1(z):return abs(z[0])+abs(z[1])
def roundq(q):
    r=q*D+Q(1,2);return Q(r.numerator//r.denominator,D)
def roundz(z):return tuple(map(roundq,z))
def box_center(a):return tuple(roundq((lo+hi)/2) for lo,hi in a)
def box_error(a,z):return sum((max(abs(v-lo),abs(v-hi)) for (lo,hi),v in zip(a,z)),Q(0))
def contains(a,b):
    lo,hi=map(Q,a);ll,hh=map(Q,b)
    assert lo<=ll<=hh<=hi,(a,b)
    COUNTS['containments']+=1
def contains_rect(a,b):
    for x,y in zip(a,b):contains(x,y)
def unit(arg):
    return E.cos_box(arg),E.cos_box(E.sub(arg,E.scale(Q(1,2),E.PI)))


def run():
    for name,pin in PINS.items():assert hashlib.sha256((BASE/name).read_bytes()).hexdigest().upper()==pin
    data=json.loads((BASE/'principal_block_wave_pilot_20261111.json').read_text())
    assert data['helper_sha256']==PINS['principal_k0_point_certificates_20261111.py']
    assert data['center_bits']==48 and data['elementary_bits']==128
    assert [b['M'] for b in data['blocks']]==[18,398]
    pi=interval(data['pi']);contains(pi,E.PI)
    for n in range(1,399):
        contains(data['logs'][str(n)],E.log_point(Q(n)))
        contains(data['square_roots'][str(n)],E.sqrt_integer(n))
    result=[]
    for block in data['blocks']:
        limit();m=block['M'];steps=block['B'];h=Q(block['h'])
        assert steps==16 and h==Q(1,64)
        k=block['k'];t0=Q(block['t0']);top=Q(block['top']);e=Q(block['e']);A=Q(block['A'])
        assert t0==Q(k-8,64) and top==t0+16*h and 1500<t0<top<1000000
        assert (128*m*m*pi[0]).numerator//(128*m*m*pi[0]).denominator==k
        assert (128*m*m*pi[1]).numerator//(128*m*m*pi[1]).denominator==k
        assert t0+8*h<2*m*m*pi[0]<=2*m*m*pi[1]<t0+9*h
        assert e==Q(19,1000)/top and 0<e<=1
        assert A>=1 and (A-1)**2>=4*m
        alloc={n:Q(v) for n,v in block['allocations'].items()}
        assert alloc['E0']==e/(64*m)
        assert alloc['delta']==min(Q(1,2*steps),e/(128*m*steps))
        assert alloc['eta']==e/(128*m*steps)
        wb=2*(alloc['E0']+steps*(alloc['delta']+alloc['eta']))
        assert wb==alloc['wave_bound']==e/(16*m) and steps*alloc['delta']<=Q(1,2)
        assert alloc['sum_rounding']==e/16 and alloc['phase']==e/(16*A)
        assert alloc['correction']==e/4 and alloc['final']==e/8
        initial=block['initial_and_rotation'];assert len(initial)==m
        centers=[];radii=[];rotations=[];deltas=[]
        for n,rec in enumerate(initial,1):
            assert rec['n']==n
            ln=E.log_point(Q(n));arg=E.scale(-t0,ln)
            ub=unit(arg);amp=E.inv(E.sqrt_integer(n))
            wave=tuple(E.mul(amp,v) for v in ub)
            contains(rec['wave_trig']['argument'],arg)
            contains_rect(rec['wave_trig']['output'],ub)
            contains_rect(rec['wave_box'],wave)
            v=vec(rec['center']);r=Q(rec['radius'])
            assert v==box_center(rectangle(rec['wave_box']))
            assert r==box_error(rectangle(rec['wave_box']),v) and 0<=r<=alloc['E0']
            rotarg=E.scale(-h,ln);rot=unit(rotarg)
            contains(rec['rotation_trig']['argument'],rotarg)
            contains_rect(rec['rotation_trig']['output'],rot)
            q=vec(rec['rotation_center']);dq=Q(rec['rotation_radius'])
            assert q==box_center(rectangle(rec['rotation_trig']['output']))
            assert dq==box_error(rectangle(rec['rotation_trig']['output']),q) and 0<=dq<=alloc['delta']
            centers.append(v);radii.append(r);rotations.append(q);deltas.append(dq)
            COUNTS['initial_waves']+=1;COUNTS['rotations']+=1
        assert len(block['states'])==len(block['samples'])==17 and len(block['update_summaries'])==16
        points=[];inconclusive=[]
        for j,(state,sample) in enumerate(zip(block['states'],block['samples'])):
            limit();assert state['j']==sample['j']==j
            assert [vec(v) for v in state['centers']]==centers
            assert list(map(Q,state['radii']))==radii and max(radii)<=wb
            t=t0+j*h;n=sample['N'];assert Q(sample['t'])==t and n==(m-1 if j<=8 else m)
            assert 2*pi[1]*n*n<t<2*pi[0]*(n+1)**2
            S=tuple(sum((v[d] for v in centers[:n]),Q(0)) for d in range(2))
            sr=sum(radii[:n],Q(0))
            assert vec(sample['active_sum_center'])==S and Q(sample['active_sum_radius'])==sr<=e/16
            assert Q(sample['sum_rounding_error'])==0
            own=E.evaluate(t);assert own['N']==n
            parts=sample['point_parts']
            for src,dst in [('a','a'),('z','z'),('theta','theta_hat'),('sqrt_a','sqrt_a'),('J','correction')]:
                contains(parts[src],own[dst])
            contains(parts['F_witness']['F'],own['F'])
            phase=unit(interval(own['theta_hat']))
            contains_rect(sample['phase_trig']['output'],phase)
            u=vec(sample['phase_center']);du=Q(sample['phase_radius'])
            assert u==box_center(rectangle(sample['phase_trig']['output']))
            assert du==box_error(rectangle(sample['phase_trig']['output']),u)<=e/(16*A)
            J=interval(parts['J']);jc=Q(sample['correction_center']);je=Q(sample['correction_radius'])
            assert jc==roundq((J[0]+J[1])/2) and je==max(abs(jc-J[0]),abs(jc-J[1]))<=e/4
            raw=2*mul(u,S)[0]+jc;kval=roundq(raw);fe=abs(kval-raw)
            assert Q(sample['final_unrounded'])==raw and Q(sample['center'])==kval
            assert Q(sample['final_rounding_error'])==fe<=e/8
            er=2*(sr+du*l1(S))+je+fe
            assert Q(sample['arithmetic_radius'])==er<=3*e/4
            assert interval(sample['Khat_wave'])==(kval-er,kval+er)
            contains(sample['Khat_wave'],own['Khat']);contains(sample['direct_Khat'],own['Khat'])
            assert len(sample['direct_terms'])==len(own['terms'])==n
            for idx,(term,iv) in enumerate(zip(sample['direct_terms'],own['terms']),1):
                assert term['n']==idx;contains(term['term'],iv);COUNTS['direct_terms']+=1
            hr=Q(sample['Hardy_radius'])
            assert hr>0 and hr**4*t**3>=Q(47,100)**4
            assert er**4*t**3<Q(19,1000)**4
            hi=(kval-hr,kval+hr);assert interval(sample['Hardy_interval'])==hi
            sign='positive' if hi[0]>0 else 'negative' if hi[1]<0 else 'inconclusive'
            assert sample['isolated_sign']==sign
            if sign=='inconclusive':inconclusive.append(j)
            points.append({'j':j,'t':str(t),'N':n,'direct_Khat':own['Khat'],
                           'wave_arithmetic_radius':str(er),'isolated_interval_sign':sign})
            COUNTS['samples']+=1
            if j<steps:
                updated=[];newr=[];errs=[]
                for v,r,q,dq in zip(centers,radii,rotations,deltas):
                    exact=mul(q,v);nv=roundz(exact);err=l1((nv[0]-exact[0],nv[1]-exact[1]))
                    assert err<=alloc['eta']
                    nr=r+dq*l1(v)+err;assert nr<=wb
                    updated.append(nv);newr.append(nr);errs.append(err);COUNTS['updates']+=1
                summary=block['update_summaries'][j]
                assert summary['from_j']==j and summary['count']==m
                assert Q(summary['maximum_rounding_l1'])==max(errs)
                assert Q(summary['sum_rounding_l1'])==sum(errs,Q(0))
                centers,radii=updated,newr
        assert block['inconclusive_j']==inconclusive
        result.append({'M':m,'t0':str(t0),'top':str(top),'e':str(e),'samples':points})
        print(json.dumps({'completed_M':m,'elapsed_seconds':time.monotonic()-START}),flush=True)
    limit()
    output={'status':'PASS_ALL_34_DIRECT_KHAT_AND_6656_WAVE_UPDATES',
            'producer_sha256':PINS,'independent_helper_sha256':HELPER_HASH,
            'direct_parameters':{'dyadic_bits':320,'Machin':[40,16],'log_terms':64,'cosine_degree':80,'sinc_terms':32},
            'counts':COUNTS,'blocks':result,'elapsed_seconds':time.monotonic()-START,
            'scope':'Isolated point/recurrence arithmetic only; no actual high-height EM, spectral coverage or Lean proof.',
            'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper()}
    dest=Path(__file__).with_suffix('.json');dest.write_text(json.dumps(output,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({'status':output['status'],'counts':COUNTS,'elapsed_seconds':output['elapsed_seconds'],
                      'script_sha256':output['script_sha256'],
                      'receipt_sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()}))


if __name__=='__main__':run()
