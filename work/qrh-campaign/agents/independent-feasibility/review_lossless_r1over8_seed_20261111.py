"""Rational-only independent seed enclosure, using longer direct-power sums.

No transcendental function or numerical interval library is imported.
"""
from fractions import Fraction as F
from pathlib import Path
from math import factorial
import hashlib
import json

HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent
TARGET='integration/lossless_modular_word_20261111.json'
TARGET_SHA='E60FCABF3A3A71F7FBDD39CDD58A00495973B0A3B2D2245F91A317F46D6C6910'
PINS={
    'prime-estimates/R1OVER8_SEED_RATIONAL_2026-11-11.md':'5C2B846B4BF1983CE8448FCDBF78FE7860B68C57030598E72D6649831BD37C16',
    'prime-estimates/r1over8_seed_rational_20261111.py':'099E38BEAF5C184234FA35D30C896C996FC166CBE5E0002B532692D4F298C173',
    'prime-estimates/r1over8_seed_rational_20261111.json':'E4EFD292003D1216EDA8E4BD9BFF7921050874F9378222C34A5A71EC39974E89',
}


def wire(d):
    m,e=int(d['mantissa']),d['exponent']
    assert type(e) is int and abs(e)<=4096 and abs(m).bit_length()<=4096
    return F(m*(1<<e)) if e>=0 else F(m,1<<-e)


def products(a,b):
    values=[x*y for x in a for y in b]
    return min(values),max(values)


def binade(x):
    assert x>0
    k=x.numerator.bit_length()-x.denominator.bit_length()
    if x<F(2)**k:k-=1
    assert F(2)**k<=x<F(2)**(k+1)
    return [k,k+1]


def check_producer(target, independent):
    """Reconstruct every producer finite coefficient by integer powers/factorials."""
    data=json.loads((AGENTS/'prime-estimates/r1over8_seed_rational_20261111.json').read_text())
    c,v=data['certificate'],data['verification']
    def fq(q):
        assert set(q)=={'numerator','denominator'}
        n,d=int(q['numerator']),int(q['denominator'])
        assert d>0
        return F(n,d)
    assert c['source_sha256']==TARGET_SHA and c['source_node']=='tau'
    assert c['format']=='r1over8-seed-rational-taylor-v1'
    assert c['T']==1000000 and c['r']=='1/8'
    assert c['expression']=='exp(1/4)*(-cos(2/1000001)+i*sin(2/1000001))'
    assert fq(c['x'])==F(2,1000001) and fq(c['u'])==F(1,4)
    assert c['trig_lower_terms']==6 and c['trig_upper_terms']==7
    trig=[];checked=0
    for name,a in [('cos',0),('sin',1)]:
        record=c['trig'][name]
        terms=[F(2**(2*k+a),1000001**(2*k+a)*factorial(2*k+a)) for k in range(7)]
        assert list(map(fq,record['terms']))==terms
        lo=sum((-1)**k*terms[k] for k in range(6));hi=lo+terms[6]
        assert 0<lo<hi
        assert fq(record['lower'])==lo and fq(record['upper'])==hi
        assert fq(record['ratio'])==F(4,1000001**2*(a+1)*(a+2))
        trig.append((lo,hi));checked+=len(terms)
    e=c['exp'];assert e['N']==48
    terms=[F(1,4**k*factorial(k)) for k in range(49)]
    assert list(map(fq,e['terms']))==terms
    ratio=F(1,196);tail=terms[48]/(1-ratio)
    elo=sum(terms[:48]);ehi=elo+tail
    assert fq(e['tail_ratio'])==ratio and fq(e['tail_bound'])==tail
    assert fq(e['lower'])==elo and fq(e['upper'])==ehi
    checked+=len(terms)
    cos,sin=trig
    result=(products((elo,ehi),(-cos[1],-cos[0])),products((elo,ehi),sin))
    margins=[]
    for axis,dest,ours,bounds in zip(('re','im'),target,independent,result):
        assert bounds==tuple(map(fq,v['seed_enclosure'][axis]))
        assert bounds[0]<=ours[0]<=ours[1]<=bounds[1]
        actual=(bounds[0]-dest[0],dest[1]-bounds[1])
        assert min(actual)>0 and tuple(map(fq,v['strict_margins'][axis]))==actual
        for m,p in zip(actual,v['margin_exceeds_power_of_two'][axis]):assert F(2)**p<m
        margins.append({'axis':axis,'margins':list(map(str,actual)),'binades':list(map(binade,actual))})
    assert v['positive_terms_checked']==checked==63
    assert fq(v['exp_tail'])==tail and fq(v['exp_tail_ratio'])==ratio
    assert v['target_sha256']==TARGET_SHA and v['no_numerical_oracle'] and not v['lean_checked']
    def collect(obj):
        if isinstance(obj,dict):
            if set(obj)=={'numerator','denominator'}:return [fq(obj)]
            return sum((collect(w) for w in obj.values()),[])
        if isinstance(obj,list):return sum((collect(w) for w in obj),[])
        return []
    bits=max(max(abs(q.numerator).bit_length(),q.denominator.bit_length()) for q in collect(data))
    assert bits==v['maximum_integer_bits']==743
    return {'all_positive_terms_recomputed':checked,'exp_first_omitted_index':48,
            'exp_all_index_tail_ratio':str(ratio),'product_bounds_recomputed':True,
            'longer_enclosure_nested_inside_producer':True,'maximum_producer_fraction_integer_bits':bits,'strict_margins':margins}


def run():
    for rel,pin in PINS.items():assert hashlib.sha256((AGENTS/rel).read_bytes()).hexdigest().upper()==pin
    path=AGENTS/TARGET
    assert hashlib.sha256(path.read_bytes()).hexdigest().upper()==TARGET_SHA
    packet=json.loads(path.read_text())['packet']
    assert packet['format']=='lossless-modular-word-r1over8-v1'
    assert packet['T']==1000000 and packet['r']=='1/8'
    assert packet['seed_expression']=='exp(1/4)*(-cos(2/1000001)+i*sin(2/1000001))'
    node=packet['nodes'][0]
    assert (node['id'],node['kind'],node['op'],node['args'])==('tau','complex','unproved_seed',[])
    target=[]
    for axis in ('re','im'):
        r={k:wire(v) for k,v in node['value'][axis].items()}
        assert r['rad']>=0 and r['lo']==r['mid']-r['rad'] and r['hi']==r['mid']+r['rad']
        target.append((r['lo'],r['hi']))
    x=F(2,packet['T']+1); z=2*F(packet['r'])
    assert x==F(2,1000001) and 0<x<1 and z==F(1,4)
    # 64 terms, first omitted term n=64; all later ratios <= z/65.
    eterms=[z**n/factorial(n) for n in range(65)]
    elo=sum(eterms[:64]); ratio=z/65
    assert 0<ratio<1
    tail=eterms[64]/(1-ratio)
    exp=(elo,elo+tail)
    trig=[]; trig_terms=[]
    for a in (0,1):
        ts=[x**(2*n+a)/factorial(2*n+a) for n in range(9)]
        lo=sum((-1)**n*ts[n] for n in range(8))
        hi=lo+ts[8]
        assert 0<lo<hi
        trig.append((lo,hi));trig_terms.append(ts)
    cos,sin=trig
    result=(products(exp,(-cos[1],-cos[0])),products(exp,sin))
    margins=[]
    for rect,expected in zip(result,target):
        lo,hi=rect[0]-expected[0],expected[1]-rect[1]
        assert lo>0 and hi>0
        margins.append({'lower':str(lo),'upper':str(hi),'lower_binade':binade(lo),'upper_binade':binade(hi)})
    producer_review=check_producer(target,result)
    assert hashlib.sha256(path.read_bytes()).hexdigest().upper()==TARGET_SHA
    for rel,pin in PINS.items():assert hashlib.sha256((AGENTS/rel).read_bytes()).hexdigest().upper()==pin
    return {'status':'PASS independent rational seed containment',
            'producer_pins':PINS,'producer_review':producer_review,
            'target':TARGET,'target_sha256':TARGET_SHA,
            'seed_payload_sha256':hashlib.sha256(json.dumps(node,sort_keys=True,separators=(',',':')).encode()).hexdigest().upper(),
            'T':packet['T'],'r':packet['r'],'expression':packet['seed_expression'],
            'trig_argument':str(x),'exp_argument':str(z),
            'exp':{'terms_used':64,'terms':list(map(str,eterms)),'tail_ratio':str(ratio),'tail':str(tail),'bounds':list(map(str,exp))},
            'trig':{'even_terms':8,'odd_terms':9,'cos_terms':list(map(str,trig_terms[0])),'sin_terms':list(map(str,trig_terms[1])),
                    'cos':list(map(str,cos)),'sin':list(map(str,sin))},
            'result_bounds':[[str(v) for v in p] for p in result],
            'strict_margins':margins,
            'scope':'One fixed seed, paper series proof plus exact external rational arithmetic. No Lean proof or whole-word evaluation.'}


if __name__=='__main__':
    out=run();out['script_sha256']=hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper()
    Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2,sort_keys=True)+'\n',encoding='utf8')
    print(json.dumps({'status':out['status'],'script_sha256':out['script_sha256'],
                      'margin_binades':[[x['lower_binade'],x['upper_binade']] for x in out['strict_margins']]}))
