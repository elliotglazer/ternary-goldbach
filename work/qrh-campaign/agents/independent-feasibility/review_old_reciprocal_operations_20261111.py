"""Independent exact edge-range review of all old frozen reciprocal gates.

Original exported binary boxes are unchanged. No analytic values are generated.
"""
from pathlib import Path
from fractions import Fraction as F
from itertools import product
import hashlib
import json
import runpy
import sys
import re

sys.dont_write_bytecode = True
HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
PINS = {
    'prime-estimates/ORIGINAL_RECIPROCAL_EDGES_2026-11-11.md': '289A090FD9C0307B09B79A82AC42E03792A1CCF73977411E95EDB1C5E2B80E68',
    'prime-estimates/principal_theta_modular_pilot_20261111.json': 'C39982174CAC9C51E9F816275082BCE322CA2AD143D9FCE61081DF72E57B11EF',
    'prime-estimates/compact_reciprocal_rectangle_20261111.py': 'E32289AA8773520002804572C3F95B207850C41574A9BE45ECB178A8E632426F',
    'prime-estimates/original_reciprocal_edges_20261111.py': '1BF4CBF3EB3364FCABE7C19EB3B121228AF5F14884A005AFA944049B8449CF88',
    'prime-estimates/original_reciprocal_edges_20261111.json': '12E011FD7F68CE6FFEC8BD8BF5659FD13A9EA804D0C8EFA35ECA7F70F27C6078',
}
MAXIMA = {'input_mantissa_bits':0, 'absolute_input_exponent':0, 'fraction_numerator_bits':0, 'fraction_denominator_bits':0}


def wire(x):
    m, e = int(x['mantissa']), x['exponent']
    assert type(e) is int and abs(e) <= 4096 and abs(m).bit_length() <= 4096
    MAXIMA['input_mantissa_bits'] = max(MAXIMA['input_mantissa_bits'], abs(m).bit_length())
    MAXIMA['absolute_input_exponent'] = max(MAXIMA['absolute_input_exponent'], abs(e))
    return F(m*(1 << e)) if e >= 0 else F(m,1 << -e)


def box(x):
    v = tuple(tuple(wire(p) for p in x['binary_'+k]) for k in ('re','im'))
    assert all(len(r)==2 and r[0] <= r[1] for r in v)
    return v


def extrema(rect, sign):
    (xl,xu),(yl,yu) = rect
    assert not (xl<=0<=xu and yl<=0<=yu)
    candidates = set(product((xl,xu),(yl,yu)))
    for x in (xl,xu):
        candidates.update((x,y) for y in (F(0),x,-x) if yl<=y<=yu)
    for y in (yl,yu):
        candidates.update((x,y) for x in (F(0),y,-y) if xl<=x<=xu)
    values = []
    for x,y in sorted(candidates):
        d = x*x+y*y
        assert d>0
        values.append((x,y,sign*x/d,-sign*y/d))
    for row in values:
        for v in row:
            MAXIMA['fraction_numerator_bits'] = max(MAXIMA['fraction_numerator_bits'], abs(v.numerator).bit_length())
            MAXIMA['fraction_denominator_bits'] = max(MAXIMA['fraction_denominator_bits'], v.denominator.bit_length())
    return tuple((min(values,key=lambda r:r[c]),max(values,key=lambda r:r[c])) for c in (2,3)),len(values)


def replay_producer_traces(raw, independent):
    """Decode every candidate exactly and check it directly, without producer code."""
    data=json.loads((AGENTS/'prime-estimates/original_reciprocal_edges_20261111.json').read_text())
    def exact(d):
        m,e=int(d['mantissa']),d['exponent']
        assert type(e) is int and abs(e)<=4096 and abs(m).bit_length()<=4096
        return F(m*(1<<e)) if e>=0 else F(m,1<<-e)
    def sg(q):return (q>0)-(q<0)
    def qmin(a,b,I):
        candidates=list(I)
        if a>0 and I[0]<=-b/(2*a)<=I[1]:candidates.append(-b/(2*a))
        return min(a*v*v+b*v for v in candidates)
    expected={(r['point_index'],r['step_index'],'A' if r['operation']=='root_A' else r['operation']):r for r in independent}
    seen=set();row_count=candidate_count=negative_count=0
    for edge in data['edges']:
        key=(edge['point'],edge['step'],edge['gate'])
        assert key not in seen and key in expected
        seen.add(key)
        ours=expected[key]
        assert edge['passed']==ours['passed'] and edge['reciprocal_sign']==ours['sign']
        step=raw['points'][key[0]]['steps'][key[1]]
        if key[2]=='S_output': inp,out=box(step['input']),box(step['output'])
        else:inp,out=box(step['root_witness']['root']),box(step['root_witness']['A'])
        if ours['sign']==-1:out=tuple((-v[1],-v[0]) for v in out)
        X,Y=inp;(lr,ur),(li,ui)=out
        arguments=[(-lr,1,X,Y),(ur,-1,X,Y),(-li,-1,Y,X),(ui,1,Y,X)]
        assert len(edge['rows'])==4
        for i,(row,(a,b,active,inactive)) in enumerate(zip(edge['rows'],arguments)):
            assert exact(row['a'])==a and row['b']==b
            assert row['coordinate']==('real' if i<2 else 'imaginary')
            assert row['active_axis']==('x' if i<2 else 'y')
            side='lower' if i%2==0 else 'upper'
            assert row['normalized_side']==side
            if ours['sign']==-1:side='upper' if side=='lower' else 'lower'
            assert row['original_output_side']==side
            values=[]
            for cand in row['tested_candidates']:
                ac=cand['active_coordinate']
                if 'dyadic' in ac:x=exact(ac['dyadic'])
                else:
                    den=exact(ac['positive_denominator']);assert den>0
                    x=exact(ac['numerator'])/den
                y=exact(cand['inactive_coordinate'])
                assert active[0]<=x<=active[1] and inactive[0]<=y<=inactive[1]
                raw_value=a*(x*x+y*y)+b*x
                if cand['branch']=='convex_interior':
                    assert a>0 and active[0]<x<active[1] and x==-F(b)/(2*a)
                    multiplier=exact(cand['positive_multiplier']['dyadic'])
                    assert multiplier==4*a>0
                    target=(4*a*a*y*y,F(-1))
                else:
                    assert cand['positive_multiplier']=='1'
                    multiplier=F(1);target=(a*x*x,a*y*y,b*x)
                terms=tuple(map(exact,cand['residual_terms']))
                assert terms==target and sum(terms)==multiplier*raw_value
                assert cand['residual_sign']==sg(raw_value)
                if 'endpoint_slope_signs' in cand:
                    assert cand['endpoint_slope_signs']==[sg(2*a*v+b) for v in active]
                values.append(raw_value)
                candidate_count+=1;negative_count+=raw_value<0
            minimum=qmin(a,F(b),active)+qmin(a,F(0),inactive)
            assert min(values)==minimum
            assert row['passed']==(minimum>=0)
            assert row['violating_candidates']==[v for v in row['tested_candidates'] if v['residual_sign']<0]
            row_count+=1
    assert seen==set(expected)
    return {'rows':row_count,'candidates':candidate_count,'negative_candidates':negative_count,
            'all_stored_terms_and_multipliers_recomputed':True}


def run():
    for rel,pin in PINS.items():
        assert hashlib.sha256((AGENTS/rel).read_bytes()).hexdigest().upper()==pin
    raw = json.loads((AGENTS/'prime-estimates/principal_theta_modular_pilot_20261111.json').read_text())
    formula = runpy.run_path(str(AGENTS/'prime-estimates/compact_reciprocal_rectangle_20261111.py'))
    D = formula['D']
    def db(rect):
        def dy(q):
            assert q.denominator & (q.denominator-1)==0
            return D(q.numerator,-(q.denominator.bit_length()-1))
        return tuple(tuple(dy(q) for q in r) for r in rect)
    results=[]
    for pi,pt in enumerate(raw['points']):
        for si,step in enumerate(pt['steps']):
            if step['kind']!='S':continue
            rw=step['root_witness']
            for label,inp,out,sign in [('S_output',step['input'],step['output'],-1),('root_A',rw['root'],rw['A'],1)]:
                a,b=box(inp),box(out)
                ranges,n=extrema(a,sign)
                violations=[]
                for c,pair in enumerate(ranges):
                    for side,w in enumerate(pair):
                        value=w[c+2];bound=b[c][side]
                        gap = bound-value if side==0 else value-bound
                        if gap>0:
                            # Directly recheck the retained witness belongs to the entire input box
                            # and violates precisely this claimed output coordinate bound.
                            x,y=w[:2]
                            assert a[0][0]<=x<=a[0][1] and a[1][0]<=y<=a[1][1]
                            actual=(sign*x/(x*x+y*y),-sign*y/(x*x+y*y))[c]
                            assert actual==value
                            k=gap.numerator.bit_length()-gap.denominator.bit_length()
                            if gap<F(2)**k:k-=1
                            assert F(2)**k<=gap<F(2)**(k+1)
                            violations.append({'coordinate':('re','im')[c], 'side':('lower','upper')[side],
                                'x':str(x),'y':str(y),'value':str(value),'claimed_bound':str(bound),'positive_gap':str(gap),
                                'gap_binary_bin':[k,k+1],
                                'input_endpoint_labels':['lower' if v==r[0] else 'upper' if v==r[1] else 'interior' for v,r in zip((x,y),a)]})
                passed=not violations
                assert formula['accept'](db(a),db(b),sign)==passed
                results.append({'point_index':pi,'T':pt['T'],'r':pt['r'],'step_index':si,'operation':label,
                                'sign':sign,'passed':passed,'candidate_points':n,
                                'exact_coordinate_ranges':[[str(w[c+2]) for w in pair] for c,pair in enumerate(ranges)],
                                'violations':violations})
    assert len(results)==24
    trace_review=replay_producer_traces(raw,results)
    printed=re.findall(r'D\((-?\d+), (-?\d+)\)',(AGENTS/'prime-estimates/ORIGINAL_RECIPROCAL_EDGES_2026-11-11.md').read_text())
    assert len(printed)==6
    for i,r in enumerate(v for v in results if not v['passed']):
        assert len(r['violations'])==1
        v=r['violations'][0]
        claimed=[wire({'mantissa':m,'exponent':int(e)}) for m,e in printed[3*i:3*i+3]]
        assert claimed==list(map(F,[v['x'],v['y'],v['claimed_bound']]))
    trace_review['all_six_printed_witness_values_checked']=True
    for rel,pin in PINS.items():
        assert hashlib.sha256((AGENTS/rel).read_bytes()).hexdigest().upper()==pin
    return {'status':'COMPLETE independent full-box reciprocal classification','pins':PINS,
            'operation_count':len(results),'passed':sum(r['passed'] for r in results),
            'failed':sum(not r['passed'] for r in results),
            'violating_coordinate_bounds':sum(len(r['violations']) for r in results),
            'maxima':MAXIMA,'operations':results,
            'producer_trace_review':trace_review,
            'scope':'Unchanged exported endpoints only; no conclusion that intended analytic point values are false.'}


if __name__=='__main__':
    result=run()
    result['script_sha256']=hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper()
    Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2,sort_keys=True)+'\n',encoding='utf8')
    print(json.dumps({k:v for k,v in result.items() if k!='operations'},indent=2))
