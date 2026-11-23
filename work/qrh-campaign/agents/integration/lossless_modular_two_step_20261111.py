"""One T and one S/root step: lossless export and exact set-containment replay.

Generation uses external Arb; verify() uses only exact bounded-size fractions.
The transcendental input is an explicitly unproved seed, not an acceptance axiom.
"""
from pathlib import Path
from fractions import Fraction as Q
from collections import Counter
import copy
import hashlib
import importlib.util
import json
import sys

sys.dont_write_bytecode = True
HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
PINS = {
    'prime-estimates/principal_theta_modular_pilot_20261111.py':
    'EAFAC6A19BE3947CBF6D4BA6F900FE3E8BAB58E1C1963E0C1DC35A61A6F55B14',
    'prime-estimates/principal_theta_modular_pilot_20261111.json':
    'C39982174CAC9C51E9F816275082BCE322CA2AD143D9FCE61081DF72E57B11EF',
    'mellin/modular_endpoint_export_diagnosis_20261111.json':
    '6CEA85CA705494E5DD20751722FF620CB6F7AF72EE898EE8C3D680F77DE4011F',
}
LIMIT = 4096
STATS = Counter()
RECIPE = [
    ('tau','complex','unproved_seed',[],{}),
    ('translated','complex','translate',['tau'],{'integer':1}),
    ('S_output','complex','complex_reciprocal',['translated'],{'sign':-1}),
    ('root_argument','complex','rotate_minus_i',['translated'],{}),
    ('root_x','real','projection',['root_argument'],{'coordinate':0}),
    ('root_y','real','projection',['root_argument'],{'coordinate':1}),
    ('root_x_square','real','square',['root_x'],{}),
    ('root_y_square','real','square',['root_y'],{}),
    ('root_norm_square','real','add',['root_x_square','root_y_square'],{}),
    ('root_norm','real','sqrt_nonnegative',['root_norm_square'],{}),
    ('root_u_sum','real','add',['root_norm','root_x'],{}),
    ('root_u_half','real','scale',['root_u_sum'],{'scale':{'mantissa':'1','exponent':-1}}),
    ('root_u','real','sqrt_nonnegative',['root_u_half'],{}),
    ('root_v_denominator','real','scale',['root_u'],{'scale':{'mantissa':'1','exponent':1}}),
    ('root_v','real','divide',['root_y','root_v_denominator'],{}),
    ('root','complex','assemble',['root_u','root_v'],{}),
    ('A','complex','complex_reciprocal',['root'],{'sign':1}),
]


def pins():
    for name, expected in PINS.items():
        assert hashlib.sha256((AGENTS/name).read_bytes()).hexdigest().upper() == expected, name


def dyadic(q):
    q = Q(q)
    assert q.denominator & (q.denominator-1) == 0
    m, e = q.numerator, -(q.denominator.bit_length()-1)
    if not m:
        e = 0
    else:
        z = (abs(m) & -abs(m)).bit_length()-1
        m >>= z
        e += z
    return {'mantissa':str(m), 'exponent':e}


def rational(q):
    return {'numerator':str(q.numerator), 'denominator':str(q.denominator)}


def read_dyadic(d):
    assert set(d) == {'mantissa','exponent'}
    assert isinstance(d['mantissa'],str) and type(d['exponent']) is int
    m, e = int(d['mantissa']), d['exponent']
    assert abs(m).bit_length() <= LIMIT and abs(e) <= LIMIT
    STATS['max_input_mantissa_bits'] = max(STATS['max_input_mantissa_bits'],abs(m).bit_length())
    STATS['max_absolute_input_exponent'] = max(STATS['max_absolute_input_exponent'],abs(e))
    STATS['dyadics_read'] += 1
    return Q(m)*(Q(2)**e)


def ball(d):
    assert set(d) == {'mid','rad','lo','hi'}
    m,r,lo,hi = (read_dyadic(d[k]) for k in ('mid','rad','lo','hi'))
    assert r >= 0 and lo == m-r and hi == m+r
    return lo,hi


def contains(outer,inner):
    return outer[0] <= inner[0] <= inner[1] <= outer[1]


def product(a,b):
    v = [x*y for x in a for y in b]
    return min(v),max(v)


def square(a):
    lo,hi = a
    return (Q(0) if lo <= 0 <= hi else min(lo*lo,hi*hi)),max(lo*lo,hi*hi)


def reciprocal_rectangle(a):
    """Exact extrema of 1/(x+iy) over a rational rectangle avoiding zero.

    There are no interior stationary points of either component off zero.
    Edge stationary points are y=0, x=+-y for x/(x*x+y*y),
    and x=0, y=+-x for -y/(x*x+y*y). All are rational.
    """
    (xl,xu),(yl,yu) = a
    assert not (xl <= 0 <= xu and yl <= 0 <= yu)
    corners = {(x,y) for x in (xl,xu) for y in (yl,yu)}
    real_points = set(corners)
    imag_points = set(corners)
    for x in (xl,xu):
        if yl <= 0 <= yu:
            real_points.add((x,Q(0)))
        for y in (x,-x):
            if yl <= y <= yu:
                imag_points.add((x,y))
    for y in (yl,yu):
        if xl <= 0 <= xu:
            imag_points.add((Q(0),y))
        for x in (y,-y):
            if xl <= x <= xu:
                real_points.add((x,y))
    rv = [x/(x*x+y*y) for x,y in real_points]
    iv = [-y/(x*x+y*y) for x,y in imag_points]
    STATS['reciprocal_extremum_candidates'] += len(rv)+len(iv)
    for q in rv+iv:
        STATS['max_candidate_numerator_bits'] = max(STATS['max_candidate_numerator_bits'],abs(q.numerator).bit_length())
        STATS['max_candidate_denominator_bits'] = max(STATS['max_candidate_denominator_bits'],q.denominator.bit_length())
    return ((min(rv),max(rv)),(min(iv),max(iv)))


def verify(packet):
    """Conditional replay: seeds are returned as obligations, never proved."""
    STATS.clear()
    assert packet['format']=='lossless-dyadic-mid-radius-operation-graph-v1'
    assert len(packet['nodes'])==len(RECIPE)
    vals,results,seeds = {},[],[]
    for node,recipe in zip(packet['nodes'],RECIPE):
        key,kind,op = node['id'],node['kind'],node['op']
        assert (key,kind,op,node['args'])==recipe[:4]
        assert all(node.get(k)==v for k,v in recipe[4].items())
        assert key not in vals
        value = ball(node['value']) if kind == 'real' else tuple(ball(node['value'][k]) for k in ('re','im'))
        args = [vals[k] for k in node['args']]  # requires prior declared operands
        ok,detail = True,None
        if op == 'unproved_seed':
            assert kind == 'complex' and not args
            seeds.append(key)
        elif op == 'translate':
            assert kind == 'complex' and len(args)==1
            t = Q(node['integer'])
            target = ((args[0][0][0]+t,args[0][0][1]+t),args[0][1])
            ok = all(contains(x,y) for x,y in zip(value,target))
        elif op == 'rotate_minus_i':
            assert kind == 'complex' and len(args)==1
            target = (args[0][1],(-args[0][0][1],-args[0][0][0]))
            ok = all(contains(x,y) for x,y in zip(value,target))
        elif op == 'projection':
            assert kind == 'real' and len(args)==1
            ok = value == args[0][node['coordinate']]
        elif op == 'square':
            assert kind == 'real' and len(args)==1
            ok = contains(value,square(args[0]))
            detail = {'independent_product_also_contained':contains(value,product(args[0],args[0]))}
        elif op == 'add':
            assert kind == 'real' and len(args)==2
            ok = contains(value,(args[0][0]+args[1][0],args[0][1]+args[1][1]))
        elif op == 'scale':
            assert kind == 'real' and len(args)==1
            scale = read_dyadic(node['scale'])
            ok = contains(value,product(args[0],(scale,scale)))
        elif op == 'sqrt_nonnegative':
            assert kind == 'real' and len(args)==1
            ok = args[0][0]>=0 and value[0]>=0 and value[0]**2<=args[0][0] and args[0][1]<=value[1]**2
        elif op == 'divide':
            assert kind == 'real' and len(args)==2
            a,b = args
            if b[0]<=0<=b[1]:
                ok=False
            else:
                q=[x/y for x in a for y in b]
                ok=contains(value,(min(q),max(q)))
        elif op == 'assemble':
            assert kind == 'complex' and len(args)==2
            ok=value==tuple(args)
        elif op == 'complex_reciprocal':
            assert kind == 'complex' and len(args)==1 and node['sign'] in (-1,1)
            a=args[0]
            if a[0][0]<=0<=a[0][1] and a[1][0]<=0<=a[1][1]:
                ok=False
            else:
                target=reciprocal_rectangle(a)
                if node['sign']==-1:
                    target=tuple((-x[1],-x[0]) for x in target)
                ok=all(contains(x,y) for x,y in zip(value,target))
                detail={'exact_rectangle_image_component_ranges':[
                    [rational(x) for x in part] for part in target]}
        else:
            raise ValueError('unknown operation '+op)
        results.append({'id':key,'op':op,'full_input_set_containment':ok,
                        'detail':detail,'status':'unproved_seed' if op=='unproved_seed' else ('pass' if ok else 'FAIL')})
        vals[key]=value
    domains={'S_input_imag_positive':vals['translated'][1][0]>0,
             'root_argument_real_positive':vals['root_x'][0]>0,
             'root_norm_nonnegative':vals['root_norm'][0]>=0,
             'root_u_positive':vals['root_u'][0]>0,
             'root_divisor_positive':vals['root_v_denominator'][0]>0,
             'A_input_real_positive':vals['root'][0][0]>0}
    return {'all_arithmetic_gates_pass':all(r['full_input_set_containment'] for r in results) and all(domains.values()),
            'unproved_seed_ids':seeds,'results':results,'domain_gates':domains,'stats':dict(STATS)}


def generate():
    pins()
    helper=AGENTS/'prime-estimates/principal_theta_modular_pilot_20261111.py'
    spec=importlib.util.spec_from_file_location('lossless_two_step_helper',helper)
    m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
    m.ctx.prec=256
    nodes=[]
    def exact(x):
        mant,e=x.man_exp()
        return read_dyadic({'mantissa':str(mant),'exponent':int(e)})
    def snap(x):
        assert x.is_finite()
        mid,rad=exact(x.mid()),exact(x.rad())
        assert rad>=0
        return {'mid':dyadic(mid),'rad':dyadic(rad),'lo':dyadic(mid-rad),'hi':dyadic(mid+rad)}
    def add(key,x,kind,op,args=(),**kw):
        value=snap(x) if kind=='real' else {'re':snap(x.real),'im':snap(x.imag)}
        nodes.append(dict(id=key,kind=kind,op=op,args=list(args),value=value,**kw))
        return x
    eta=m.ar(Q(1,1000001));er=(2*m.ar(Q(0))).exp()
    tau=add('tau',m.acb(-er*(2*eta).cos(),er*(2*eta).sin()),'complex','unproved_seed',
            expression='-cos(2/1000001)+i*sin(2/1000001); external generation only')
    trans=add('translated',tau-(-1),'complex','translate',['tau'],integer=1)
    inv=add('S_output',-1/trans,'complex','complex_reciprocal',['translated'],sign=-1)
    z=add('root_argument',-m.I*trans,'complex','rotate_minus_i',['translated'])
    x=add('root_x',z.real,'real','projection',['root_argument'],coordinate=0)
    y=add('root_y',z.imag,'real','projection',['root_argument'],coordinate=1)
    xx=add('root_x_square',x*x,'real','square',['root_x'])
    yy=add('root_y_square',y*y,'real','square',['root_y'])
    sumsq=add('root_norm_square',xx+yy,'real','add',['root_x_square','root_y_square'])
    norm=add('root_norm',sumsq.sqrt(),'real','sqrt_nonnegative',['root_norm_square'])
    usum=add('root_u_sum',norm+x,'real','add',['root_norm','root_x'])
    uhalf=add('root_u_half',usum/2,'real','scale',['root_u_sum'],scale=dyadic(Q(1,2)))
    u=add('root_u',uhalf.sqrt(),'real','sqrt_nonnegative',['root_u_half'])
    denom=add('root_v_denominator',2*u,'real','scale',['root_u'],scale=dyadic(Q(2)))
    v=add('root_v',y/denom,'real','divide',['root_y','root_v_denominator'])
    root=add('root',m.acb(u,v),'complex','assemble',['root_u','root_v'])
    A=add('A',1/root,'complex','complex_reciprocal',['root'],sign=1)
    original=json.loads(helper.with_suffix('.json').read_text())['points'][0]
    pairs=[('tau',tau,original['steps'][0]['input']),
           ('translated',trans,original['steps'][0]['output']),
           ('S_output',inv,original['steps'][1]['output']),
           ('root_argument',z,original['steps'][1]['root_witness']['z']),
           ('root',root,original['steps'][1]['root_witness']['root']),
           ('A',A,original['steps'][1]['root_witness']['A'])]
    matches=[]
    for key,val,frozen in pairs:
        assert m.binary(val.real)==frozen['binary_re'] and m.binary(val.imag)==frozen['binary_im']
        matches.append(key)
    for key,val in [('norm',norm),('u',u),('v',v)]:
        assert m.binary(val)==original['steps'][1]['root_witness']['binary_'+key]
        matches.append('root_'+key)
    packet={'format':'lossless-dyadic-mid-radius-operation-graph-v1',
            'scope':'T=1000000,r=0: initial translation and first inversion/root only',
            'precision_bits':256,'pins':PINS,'nodes':nodes,
            'original_export_matches':matches,
            'acceptance_boundary':'All arithmetic checks are conditional on the unproved transcendental seed. No analytic acceptance.'}
    return packet


def corruptions(packet):
    out={}
    def test(label,mutate):
        p=copy.deepcopy(packet);mutate(p)
        try:
            out[label]=not verify(p)['all_arithmetic_gates_pass']
        except (AssertionError,KeyError,ValueError):
            out[label]=True
    zero={'mid':dyadic(Q(0)),'rad':dyadic(Q(0)),'lo':dyadic(Q(0)),'hi':dyadic(Q(0))}
    test('false_translation',lambda p:p['nodes'][1].update(integer=2))
    test('false_S_zero_output',lambda p:p['nodes'][2]['value'].update(re=copy.deepcopy(zero),im=copy.deepcopy(zero)))
    test('wrong_rotation_operand',lambda p:p['nodes'][3].update(args=['tau']))
    test('wrong_division_operand',lambda p:p['nodes'][14].update(args=['root_x','root_v_denominator']))
    def negate_u(p):
        d=p['nodes'][12]['value']
        mid,rad=read_dyadic(d['mid']),read_dyadic(d['rad'])
        d.update(mid=dyadic(-mid),lo=dyadic(-mid-rad),hi=dyadic(-mid+rad))
    test('negative_sqrt_branch',negate_u)
    def bad_rad(p):p['nodes'][1]['value']['re']['rad']=dyadic(Q(-1))
    test('negative_radius',bad_rad)
    test('forward_reference',lambda p:p['nodes'][1].update(args=['A']))
    assert all(out.values())
    return out


def reciprocal_regression():
    cases=[
        (((Q(-2),Q(2)),(Q(1),Q(2))),((Q(-1,2),Q(1,2)),(Q(-1),Q(-1,5)))),
        (((Q(1),Q(2)),(Q(-2),Q(2))),((Q(1,5),Q(1)),(Q(-1,2),Q(1,2)))),
    ]
    for box,expected in cases:
        assert reciprocal_rectangle(box)==expected
    try:
        reciprocal_rectangle(((Q(-1),Q(1)),(Q(-1),Q(1))))
        raise RuntimeError('rectangle containing pole accepted')
    except AssertionError:
        pass
    return {'exact_edge_stationary_cases':2,'pole_rectangle_rejected':True}


if __name__=='__main__':
    regression=reciprocal_regression()
    if len(sys.argv)>1 and sys.argv[1]=='--check':
        packet=json.loads(Path(sys.argv[2]).read_text())['packet']
        result=verify(packet)
        print(json.dumps(result,indent=2))
        sys.exit(0 if result['all_arithmetic_gates_pass'] else 1)
    packet=generate()
    result=verify(packet)
    controls=corruptions(packet)
    out={'status':'PASS conditional arithmetic only' if result['all_arithmetic_gates_pass'] else 'PARTIAL arithmetic replay',
         'packet':packet,'verification':result,'corruption_controls':controls,
         'reciprocal_regression':regression,
         'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper()}
    dest=Path(__file__).with_suffix('.json')
    dest.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({'status':out['status'],'gates':[(r['id'],r['status']) for r in result['results']],
                      'stats':result['stats'],'corruption_controls':controls,
                      'receipt_sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()},indent=2))
