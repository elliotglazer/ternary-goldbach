"""Fixed-target external rational pilot. No numerical oracle; no Lean claim.

Execution needs an explicit coordinator authorization JSON, separate from this
implementation. Replaying a packet recomputes it; stored success flags are not
arithmetic evidence. See RATIONAL_XI_PANEL_BACKEND_2026-11-11.md.
"""
from fractions import Fraction as Q
from math import factorial, isqrt
from pathlib import Path
import argparse, hashlib, importlib.util, json, sys, time

sys.dont_write_bytecode = True
if sys.flags.optimize:
    raise RuntimeError('run without -O: checked assertions must remain enabled')
HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
PINS = {
    'integration/r1over8_p_node_exact_20261111.py':
        '4EE532C9698CCD8B462D40A1D102CE6DAD35741173C7D43F911C3AE7B2F15286',
    'integration/lossless_modular_two_step_20261111.py':
        '9A0EFE7074098764FDE27273836158B343F67FF300352B37F6E01B9ED74DE7E6',
    'prime-estimates/NEXT_RATIONAL_XI_PANEL_SPEC_2026-11-11.md':
        '92E778B5D9C767D18461CD0B239F94FD38B15023B13576FFBBC2EFFE8D00E957',
    'major-constants/THETA_JET_TAIL_TWO_FIFTHS_2026-11-11.md':
        '478DEDD2DC613670A5B2E6ECA18317733006D82CDE06860719302301B80FFE88',
    'zero-sum/REVIEW_NEXT_RATIONAL_XI_PANEL_SPEC_2026-11-11.md':
        '2F05928D57B1E76F513095FE5CCA4D5930EF314EB658EE748016E52FBE84CC97',
    'mellin/REVIEW_THETA_JET_TAIL_TWO_FIFTHS_2026-11-11.md':
        '8C81655B87AA6855AEE4A28D34A8713FFEC95CABEEE8F538E82888A0409304CD',
    'prime-estimates/rational_panel_budget_20261111.py':
        '7F6BBFA8DA690593121F287EB21BEADFA37D9C5EE6132744C5808687904AC013',
    'prime-estimates/rational_panel_budget_20261111.json':
        'B344780B1A7DD6D58C33BC73E9B49AD6FAB1AF70966123F70130977B756A59EF',
}
TARGET = dict(T_input=32, T_work=14, eta='1/33', center_re='3/5',
              center_im='14', rho='1/64', h='1/256', K=928, degree=6,
              b_expression='pi/4-1/33', a='1/66', kappa='1/66', V='29/8',
              rectangle_re=['379/640','389/640'],
              rectangle_im=['1791/128','1793/128'],
              ccw_vertices=[['379/640','1791/128'],['389/640','1791/128'],
                            ['389/640','1793/128'],['379/640','1793/128'],
                            ['379/640','1791/128']],
              node_grid_bits=32, weight_grid_bits=64,
              node_radius='1/16777216', weight_radius='1/281474976710656')


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest().upper()


def load(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


def verify_inputs(auth):
    for p, h in PINS.items():
        if sha(AGENTS / p) != h:
            raise ValueError('changed pinned input: ' + p)
    # This is an operational run gate, not a mathematical premise.
    a = json.loads(Path(auth).read_text())
    if a.get('target') != TARGET or a.get('coordinator_authorized') is not True:
        raise ValueError('missing exact-target coordinator authorization')
    for key in ('spec_review', 'general_tail_review'):
        entry = a[key]
        if sha(AGENTS / entry['path']) != entry['sha256']:
            raise ValueError('review pin mismatch: ' + key)
    if a.get('sixteen_mode_bound_accepted') is not True:
        raise ValueError('this backend requires the separately reviewed 16-mode bound')
    return a


def scalar_budget():
    """Read-only exact replay; does not call the planning module's main writer."""
    for name in ('prime-estimates/rational_panel_budget_20261111.py',
                 'prime-estimates/rational_panel_budget_20261111.json'):
        assert sha(AGENTS/name)==PINS[name], name
    name='prime-estimates/rational_panel_budget_20261111.py'
    got=load('fixed_panel_scalar_plan',AGENTS/name).run()
    got['script_sha256']=PINS[name]
    saved=json.loads((AGENTS/'prime-estimates/rational_panel_budget_20261111.json').read_text())
    assert got==saved, 'scalar budget replay mismatch'
    selected=got['selected']
    for key in ('h','K','V','degree','rho','T_work'):
        assert Q(selected[key])==Q(TARGET[key]), key
    assert Q(selected['complete_disk_error_upper_rounded'])<Q(1,10)
    vertices=[tuple(map(Q,v)) for v in TARGET['ccw_vertices']]
    distances=[(x-Q(3,5))**2+(y-14)**2 for x,y in vertices]
    assert all(d<=Q(1,64)**2 for d in distances)
    assert vertices[0]==vertices[-1]
    assert all((vertices[i+1][0]-vertices[i][0])*(vertices[(i+2)%4][1]-vertices[i+1][1])-
               (vertices[i+1][1]-vertices[i][1])*(vertices[(i+2)%4][0]-vertices[i+1][0])>0
               for i in range(4))
    return dict(selected=selected,vertex_squared_distances=list(map(str,distances)),
                rectangle_in_closed_disk=True,ccw=True)


class Backend:
    def __init__(self, bits, deadline):
        if bits not in (320, 512):
            raise ValueError('unsupported precision')
        self.bits, self.deadline = bits, deadline
        self.a = load('pilot_exact_base', HERE / 'r1over8_p_node_exact_20261111.py')
        self.r = load('pilot_exact_ranges', HERE / 'lossless_modular_two_step_20261111.py')
        a = self.a
        a.BITS, a.SCALE = bits, 1 << bits
        original_round = a.rnd

        def checked_round(lo, hi):
            if a.OPS['outward_roundings'] % 1024 == 0:
                self.clock()
            return original_round(lo, hi)

        a.rnd = checked_round
        old_exp = a.exp_point

        def exp_endpoint(x):
            # Monotone endpoints are handled separately. In particular an
            # interval crossing -384 must not have its larger value discarded.
            if x <= -384:
                a.EVENTS.append(dict(kind='small_exp_endpoint', input=str(x),
                                     upper='1/' + str(1 << 384)))
                return a.rnd(Q(0), Q(1, 1 << 384))
            return old_exp(x)

        a.exp_point = exp_endpoint
        self.pi = a.make_pi()

    def clock(self):
        if time.monotonic() > self.deadline:
            raise TimeoutError('fixed pilot wall cap reached')

    def sqrt(self, x):
        a = self.a
        if x[0] < 0:
            raise ValueError('negative square-root domain')
        def one(t):
            n = isqrt((t.numerator << (2*self.bits)) // t.denominator)
            lo = Q(n, a.SCALE)
            hi = lo if lo*lo == t else Q(n+1, a.SCALE)
            assert lo >= 0 and lo*lo <= t <= hi*hi
            return lo, hi
        return one(x[0])[0], one(x[1])[1]

    def square(self, x):
        lo = 0 if x[0] <= 0 <= x[1] else min(x[0]**2, x[1]**2)
        return self.a.rnd(lo, max(x[0]**2, x[1]**2))

    def inv(self, z):
        # Exact coordinate extrema, not independent x / (x*x+y*y) bounds.
        v = self.r.reciprocal_rectangle(z)
        return tuple(self.a.rnd(*x) for x in v)

    def root_factor(self, t):
        a = self.a
        z = (t[1], a.neg(t[0]))  # -i*t; Re(z)>0 fixes principal root
        assert z[0][0] > 0
        modulus = self.sqrt(a.add(self.square(z[0]), self.square(z[1])))
        u = self.sqrt(a.scale(a.add(modulus, z[0]), Q(1, 2)))
        assert u[0] > 0
        v = a.div(z[1], a.scale(u, 2))
        root = (u, v)
        return self.inv(root), dict(argument=a.cw(z), modulus=a.wire(modulus),
                                    root=a.cw(root))

    def phase(self, n):
        a = self.a
        z, o = a.ZERO, a.ONE
        d = self.sqrt(a.pt(Q(1, 2)))
        table = ((o,z),(d,d),(z,o),(a.neg(d),d),(a.neg(o),z),
                 (a.neg(d),a.neg(d)),(z,a.neg(o)),(d,a.neg(d)))
        return table[n % 8]

    def word(self, tau):
        a = self.a
        t, kind, count, stages = tau, 3, 0, []
        while True:
            self.clock()
            n = a.floorq(sum(t[0])/2 + Q(1, 2))
            v = (a.sub(t[0], a.pt(n)), t[1])  # ALWAYS subtract n
            assert max(abs(v[0][0]), abs(v[0][1])) < Q(3, 5)
            assert max(abs(t[0][0]-sum(t[0])/2),
                       abs(t[0][1]-sum(t[0])/2)) < Q(1, 10)
            after_t = kind if kind == 2 or n % 2 == 0 else 7-kind
            phase = self.phase(n) if kind == 2 else (a.ONE, a.ZERO)
            rec = dict(n=n, input_type=kind, translated_type=after_t,
                       input=a.cw(t), translated=a.cw(v), phase=a.cw(phase))
            if v[1][0] >= Q(2, 5):
                rec['S'] = False
                stages.append((rec, v, phase, None))
                return v, after_t, stages
            # Stop has priority in the overlap. At the cap, failure requests a
            # higher-precision retry; a fifth S is never silently permitted.
            if count >= 4 or v[1][1] >= Q(1, 2) or v[1][0] <= 0:
                raise ValueError('stop/S domain undecided or four-S cap reached')
            A, root = self.root_factor(v)
            t = a.cneg(self.inv(v))
            kind = {2:4, 3:3, 4:2}[after_t]
            count += 1
            rec.update(S=True, root=root, A=a.cw(A), output=a.cw(t),
                       output_type=kind)
            stages.append((rec, v, phase, A))

    def terminal(self, v, kind):
        a = self.a
        assert v[1][0] >= Q(2, 5) and kind in (2,3,4)
        g = [(a.ZERO,a.ZERO) for _ in range(3)]
        if kind != 2:
            g[0] = (a.ONE,a.ZERO)
        for n in range(16):
            self.clock()
            mode = Q(2*n+1,2) if kind == 2 else Q(n+1)
            z = (a.ZERO, a.scale(self.pi, mode*mode))
            sign = -1 if kind == 4 and (n+1) % 2 else 1
            term = a.cscale(a.cexp(a.cmul(z,v),self.pi),2*sign)
            for j in range(3):
                g[j] = a.cadd(g[j],term)
                term = a.cmul(term,z)
        tail = Q(1,1 << 277)
        return [(a.widen(x[0],tail),a.widen(x[1],tail)) for x in g]

    def node(self, k):
        if not 0 <= k <= 928:
            raise ValueError('node outside fixed grid')
        a = self.a
        a.EVENTS.clear(); a.OPS.clear()
        r = Q(k,256)
        er = a.exp_interval(a.pt(2*r))
        trig = a.cis(a.pt(Q(2,33)),self.pi)
        tau = (a.neg(a.mul(er,trig[0])),a.mul(er,trig[1]))
        assert tau[1][0] > Q(3,50)
        v, kind, stages = self.word(tau)
        g = self.terminal(v,kind)
        terminal = list(map(a.cw,g))
        for rec,t,phase,A in reversed(stages):
            if A is not None:
                B = self.inv(t); B2=a.cmul(B,B); B3=a.cmul(B2,B); B4=a.cmul(B2,B2)
                g0,g1,g2=g
                g=[a.cmul(A,g0),
                   a.cmul(A,a.cadd(a.cscale(a.cmul(g0,B),Q(-1,2)),a.cmul(g1,B2))),
                   a.cmul(A,a.cadd(a.cadd(a.cscale(a.cmul(g0,B2),Q(3,4)),
                                         a.cscale(a.cmul(g1,B3),-3)),a.cmul(g2,B4)))]
            g=[a.cmul(phase,x) for x in g]
        pref_trig=a.cis(a.sub(a.scale(self.pi,Q(1,8)),a.pt(Q(1,66))),self.pi)
        pref_exp=a.exp_interval(a.pt(r/2))
        pref=tuple(a.mul(pref_exp,x) for x in pref_trig)
        P=a.cmul(pref,a.cadd(a.cscale(a.cmul(tau,g[1]),6),
                            a.cscale(a.cmul(a.cmul(tau,tau),g[2]),4)))
        center,radius=self.center(P,32)
        assert radius <= Q(1,1 << 24), 'node radius budget exceeded'
        assert sum(x*x for x in center) < (1 << (54+64)), 'node center norm budget'
        return dict(k=k, bits=self.bits, seed=a.cw(tau),
                    word=[x[0] for x in stages], terminal_type=kind,
                    terminal_jet=terminal, theta_tail='1/'+str(1 << 277),
                    P_box=a.cw(P), center=center, radius=str(radius),
                    counts=dict(a.OPS), elementary_events=list(a.EVENTS))

    def center(self, z, bits):
        den=1 << bits
        ints=[self.a.floorq(sum(x)/2*den) for x in z]
        radius=sum(max(abs(x[0]-Q(c,den)),abs(x[1]-Q(c,den))) for x,c in zip(z,ints))
        return ints,radius

    def weights(self, k):
        a=self.a; v=Q(k,256)
        if k == 0:
            return [dict(center=[1 << 56,0],radius='0')]+[dict(center=[0,0],radius='0') for _ in range(6)]
        e=a.cexp((a.pt(v/10),a.pt(14*v)),self.pi)
        out=[]
        for j in range(7):
            z=a.cscale(e,Q(1,256)*v**j/factorial(j))
            c,r=self.center(z,64)
            assert r <= Q(1,1 << 48), 'weight radius budget exceeded'
            out.append(dict(center=c,radius=str(r)))
        return out


def assemble(nodes, backend, budget):
    if [x['k'] for x in nodes] != list(range(929)):
        raise ValueError('full ordered positive grid required')
    coeff=[[0,0] for _ in range(7)]; weights=[]
    for k in range(-928,929):
        backend.clock()
        p=nodes[abs(k)]['center']
        pr,pi=p[0],p[1] if k >= 0 else -p[1]
        row=backend.weights(k);weights.append(dict(k=k,weights=row))
        for j,w in enumerate(row):
            wr,wi=w['center']
            coeff[j][0]+=pr*wr-pi*wi
            coeff[j][1]+=pr*wi+pi*wr
    den=1 << 96
    U=sum(Q(abs(x)+abs(y),den*64**j) for j,(x,y) in enumerate(coeff) if j)
    margin=Q(coeff[0][0],den)-U
    passed=margin>Q(1,10)
    return dict(coefficients_grid_bits=96,coefficients=coeff,weights=weights,
                nonconstant_norm_upper=str(U),real_margin=str(margin),
                total_disk_error_upper=budget['selected']['complete_disk_error_upper_rounded'],
                acceptance_threshold='1/10',strict_positive_real=passed,
                geometry=budget,
                constant_image_polygon=([[1,0]]*5 if passed else None),
                edge_crossings=([0]*4 if passed else None),
                winding=(0 if passed else None),
                status='POSITIVE_REAL_DISK' if passed else 'INCONCLUSIVE')


def write(path, data):
    path=Path(path); tmp=path.with_suffix(path.suffix+'.partial')
    tmp.write_text(json.dumps(data,indent=2)+'\n',encoding='utf-8');tmp.replace(path)


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--authorize',required=True)
    p.add_argument('--output',required=True)
    p.add_argument('--max-nodes',type=int,default=929)
    p.add_argument('--seconds',type=int,default=1800)
    p.add_argument('--check',action='store_true')
    p.add_argument('--resume',action='store_true')
    args=p.parse_args()
    if not 1 <= args.max_nodes <= 929 or not 1 <= args.seconds <= 7200:
        p.error('fixed grid and bounded wall time required')
    auth=verify_inputs(args.authorize)
    deadline=time.monotonic()+args.seconds
    budget=scalar_budget()
    path=Path(args.output)
    if args.check or args.resume:
        saved=json.loads(path.read_text())
        assert saved['target']==TARGET and saved['source_pins']==PINS
        assert saved['backend_sha256']==sha(Path(__file__))
        assert saved['authorization']==auth
        if args.resume and len(saved['nodes'])>args.max_nodes:
            raise ValueError('resume must not truncate the saved prefix')
    else:
        if path.exists():
            raise ValueError('refusing to overwrite existing output without --resume')
        saved=None
    result=dict(target=TARGET,source_pins=PINS,backend_sha256=sha(Path(__file__)),
                authorization=auth,scalar_budget=budget,nodes=[],status='PARTIAL',
                arithmetic_scope='external rational replay')
    # Resume deliberately replays old nodes instead of trusting stored flags.
    count=len(saved['nodes']) if args.check else args.max_nodes
    try:
        for k in range(count):
            errors=[]
            for bits in (320,512):
                try:
                    record=Backend(bits,deadline).node(k)
                    break
                except (AssertionError,ValueError) as e:
                    errors.append(dict(bits=bits,reason=str(e)))
            else:
                raise ValueError('node '+str(k)+' rejected: '+json.dumps(errors))
            record['prior_precision_rejections']=errors
            if saved is not None and k < len(saved['nodes']):
                assert record==saved['nodes'][k], 'replay node mismatch '+str(k)
            result['nodes'].append(record)
            if not args.check and ((k+1)%16==0 or k+1==count):
                write(path,result)
        if count==929:
            result['assembly']=assemble(result['nodes'],Backend(320,deadline),budget)
            result['status']=result['assembly']['status']
        if args.check:
            assert result['nodes']==saved['nodes']
            assert result.get('assembly')==saved.get('assembly'), 'assembly replay mismatch'
            assert result['status']==saved['status'], 'status replay mismatch'
            assert result['scalar_budget']==saved['scalar_budget'], 'scalar/geometry replay mismatch'
            print(json.dumps(dict(replay='MATCH',nodes=count,status=result['status'])))
        else:
            write(path,result)
            print(json.dumps(dict(nodes=count,status=result['status'])))
    except (AssertionError,ValueError,TimeoutError) as e:
        if not args.check:
            result['failure']=dict(kind=type(e).__name__,reason=str(e),next_k=len(result['nodes']))
            write(path,result)
        raise


if __name__=='__main__':
    main()
