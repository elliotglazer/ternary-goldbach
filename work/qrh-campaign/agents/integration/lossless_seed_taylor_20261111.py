"""Exact rational certificate for the sole seed of the frozen two-step packet.

No floating-point, Arb, pi, exp, sin, cos, or other numerical oracle is called.
The analytic meaning of the checked alternating sums is a paper proof, not Lean.
"""
from fractions import Fraction as Q
from math import factorial
from pathlib import Path
import copy
import hashlib
import json
import sys

HERE=Path(__file__).resolve().parent
SOURCE=HERE/'lossless_modular_two_step_20261111.json'
SOURCE_SHA='31DD05C2F85A02D29037E91BA63BE85AEC5C55063FED96010552C5BCF0034FBE'
ARGUMENT={'numerator':'2','denominator':'1000001'}
EXPRESSION='-cos(2/1000001)+i*sin(2/1000001); external generation only'


def qr(x):
    return {'numerator':str(x.numerator),'denominator':str(x.denominator)}


def readq(x):
    assert set(x)=={'numerator','denominator'}
    assert isinstance(x['numerator'],str) and isinstance(x['denominator'],str)
    assert int(x['denominator'])>0
    return Q(int(x['numerator']),int(x['denominator']))


def readd(x):
    assert set(x)=={'mantissa','exponent'} and type(x['exponent']) is int
    m,e=int(x['mantissa']),x['exponent']
    assert abs(m).bit_length()<=4096 and abs(e)<=4096
    return Q(m)*Q(2)**e


def seed():
    raw=SOURCE.read_bytes()
    assert hashlib.sha256(raw).hexdigest().upper()==SOURCE_SHA
    data=json.loads(raw)
    n=data['packet']['nodes'][0]
    assert (n['id'],n['op'],n['args'],n['expression'])==('tau','unproved_seed',[],EXPRESSION)
    out={}
    for k in ('re','im'):
        b=n['value'][k]
        mid,rad,lo,hi=(readd(b[t]) for t in ('mid','rad','lo','hi'))
        assert rad>=0 and lo==mid-rad and hi==mid+rad
        out[k]=(lo,hi)
    return out


def direct_term(x,a,k):
    return x**(2*k+a)/factorial(2*k+a)


def produce():
    x=readq(ARGUMENT)
    channels={}
    for name,a in (('cos',0),('sin',1)):
        # Recurrence generation; verification independently uses direct powers/factorials.
        terms=[Q(1) if a==0 else x]
        for k in range(6):
            terms.append(terms[-1]*x*x/((2*k+a+1)*(2*k+a+2)))
        lower=sum((-1)**k*terms[k] for k in range(6))
        upper=lower+terms[6]
        channels[name]={'parity':a,'lower_terms':6,'upper_terms':7,
                        'positive_terms':[qr(t) for t in terms],
                        'global_ratio_bound':qr(x*x/((a+1)*(a+2))),
                        'lower':qr(lower),'upper':qr(upper)}
    return {'format':'fixed-lossless-seed-alternating-taylor-v1','source_sha256':SOURCE_SHA,
            'source_node':'tau','T':1000000,'r':'0','argument':ARGUMENT,
            'expression':EXPRESSION,'channels':channels}


def verify(c):
    assert c['format']=='fixed-lossless-seed-alternating-taylor-v1'
    assert c['source_sha256']==SOURCE_SHA and c['source_node']=='tau'
    assert type(c['T']) is int and c['T']==1000000 and c['r']=='0'
    assert c['argument']==ARGUMENT and c['expression']==EXPRESSION
    target=seed()
    x=readq(c['argument'])
    assert 0<x<1
    assert set(c['channels'])=={'sin','cos'}
    intervals={}
    widths={}
    ratios={}
    maximum=0
    for name,a in (('cos',0),('sin',1)):
        ch=c['channels'][name]
        N=ch['lower_terms']
        assert ch['parity']==a and type(N) is int and 0<N<=32 and N%2==0
        assert ch['upper_terms']==N+1 and len(ch['positive_terms'])==N+1
        terms=[readq(t) for t in ch['positive_terms']]
        assert all(t==direct_term(x,a,k) for k,t in enumerate(terms))
        ratio=readq(ch['global_ratio_bound'])
        assert ratio==x*x/((a+1)*(a+2)) and 0<ratio<1
        # The global denominator inequality for arbitrary k is in the paper proof.
        # These checks also establish every supplied recurrence and finite monotonicity.
        for k in range(N):
            assert terms[k+1]*(2*k+a+1)*(2*k+a+2)==terms[k]*x*x
            assert 0<terms[k+1]<=ratio*terms[k]<terms[k]
        low=readq(ch['lower']);high=readq(ch['upper'])
        assert low==sum((-1)**k*terms[k] for k in range(N))
        assert high==sum((-1)**k*terms[k] for k in range(N+1))
        assert high-low==terms[N] and low<high
        intervals[name]=(low,high);widths[name]=qr(terms[N]);ratios[name]=qr(ratio)
        for q in terms+[low,high,ratio]:
            maximum=max(maximum,abs(q.numerator).bit_length(),q.denominator.bit_length())
    tau={'re':(-intervals['cos'][1],-intervals['cos'][0]),'im':intervals['sin']}
    margins={};dyadic_lower={}
    for part in ('re','im'):
        assert target[part][0]<tau[part][0]<tau[part][1]<target[part][1]
        ms=(tau[part][0]-target[part][0],target[part][1]-tau[part][1])
        margins[part]=[qr(q) for q in ms]
        powers=[]
        for q in ms:
            B=1
            while Q(1,2**B)>=q:
                B+=1
                assert B<=4096
            assert Q(1,2**B)<q
            powers.append(-B)
            maximum=max(maximum,abs(q.numerator).bit_length(),q.denominator.bit_length())
        dyadic_lower[part]=powers
    return {'status':'PASS exact rational seed enclosure; analytic soundness is the stated paper argument',
            'source_sha256':SOURCE_SHA,'argument':ARGUMENT,'positive_terms_checked':14,
            'global_ratio_bounds':ratios,'first_omitted_terms':widths,
            'tau_enclosure':{k:[qr(q) for q in v] for k,v in tau.items()},
            'strict_containment_margins':margins,
            'margin_strictly_exceeds_power_of_two':dyadic_lower,
            'maximum_integer_bits':maximum,
            'no_numerical_oracle':True,'lean_checked':False}


def controls(c):
    outcomes={}
    def test(label,mutate):
        bad=copy.deepcopy(c);mutate(bad)
        try:
            verify(bad);outcomes[label]=False
        except (AssertionError,ValueError,KeyError):outcomes[label]=True
    test('wrong_argument',lambda b:b['argument'].update(denominator='1000000'))
    test('wrong_height',lambda b:b.update(T=1000001))
    test('wrong_real_node',lambda b:b.update(r='1/8'))
    test('wrong_source_hash',lambda b:b.update(source_sha256='0'*64))
    test('wrong_seed_id',lambda b:b.update(source_node='translated'))
    test('odd_lower_truncation',lambda b:b['channels']['sin'].update(lower_terms=5))
    test('false_cosine_term',lambda b:b['channels']['cos']['positive_terms'][1].update(numerator='0'))
    test('false_lower_bound',lambda b:b['channels']['sin'].update(lower=qr(Q(0))))
    assert all(outcomes.values())
    return outcomes


if __name__=='__main__':
    if len(sys.argv)>1 and sys.argv[1]=='--check':
        data=json.loads(Path(sys.argv[2]).read_text())
        result=verify(data['certificate'])
        assert result==data['verification']
        assert controls(data['certificate'])==data['corruption_controls']
        print(json.dumps({'status':result['status'],'margins':result['margin_strictly_exceeds_power_of_two']},indent=2))
    else:
        cert=produce();result=verify(cert)
        out={'certificate':cert,'verification':result,'corruption_controls':controls(cert),
             'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper()}
        dest=Path(__file__).with_suffix('.json')
        dest.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
        print(json.dumps({'status':result['status'],'margins':result['margin_strictly_exceeds_power_of_two'],
                          'maximum_integer_bits':result['maximum_integer_bits'],
                          'receipt_sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()},indent=2))
