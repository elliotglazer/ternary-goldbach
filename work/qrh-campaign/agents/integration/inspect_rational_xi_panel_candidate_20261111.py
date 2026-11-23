"""Read-only structural and rational-sum checks; no node/weight evaluation."""
from pathlib import Path
from fractions import Fraction as Q
from collections import Counter
import hashlib,json

HERE=Path(__file__).resolve().parent
PIN='1B55E8A2665EF872056DE9747670E6F47017863A49D9E2C9A2D6604B6F74D09F'

def run():
    path=HERE/'rational_xi_panel_candidate_20261111_01.json'
    raw=path.read_bytes()
    assert hashlib.sha256(raw).hexdigest().upper()==PIN
    p=json.loads(raw)
    assert p['status']==p['assembly']['status']=='POSITIVE_REAL_DISK'
    assert [n['k'] for n in p['nodes']]==list(range(929))
    assert p['target']['T_input']==32 and p['target']['T_work']==14
    assert p['target']['b_expression']=='pi/4-1/33'
    for name,pin in p['source_pins'].items():
        assert hashlib.sha256((HERE.parent/name).read_bytes()).hexdigest().upper()==pin
    assert hashlib.sha256((HERE/'rational_xi_panel_backend_20261111.py').read_bytes()).hexdigest().upper()==p['backend_sha256']
    types=Counter();steps=Counter();bits=Counter();max_nr=Q(0);max_wr=Q(0)
    for n in p['nodes']:
        bits[n['bits']]+=1;types[n['terminal_type']]+=1
        steps[sum(w['S'] for w in n['word'])]+=1
        assert sum(w['S'] for w in n['word'])<=4
        assert n['word'][0]['input_type']==3
        assert not n['word'][-1]['S']
        assert Q(n['word'][-1]['translated']['im'][0])>=Q(2,5)
        assert Q(n['theta_tail'])==Q(1,2**277)
        center=n['center'];radius=Q(n['radius'])
        assert len(center)==2 and all(type(x) is int for x in center)
        assert sum(x*x for x in center)<2**118
        assert 0<=radius<=Q(1,2**24)
        max_nr=max(max_nr,radius)
        box=[tuple(map(Q,n['P_box'][component])) for component in ('re','im')]
        assert all(lo<=hi for lo,hi in box)
        actual=sum(max(abs(lo-Q(c,2**32)),abs(hi-Q(c,2**32))) for (lo,hi),c in zip(box,center))
        assert actual==radius
    a=p['assembly']; assert [r['k'] for r in a['weights']]==list(range(-928,929))
    sums=[[0,0] for _ in range(7)]
    for row in a['weights']:
        k=row['k'];assert len(row['weights'])==7
        pr,pi=p['nodes'][abs(k)]['center']
        if k<0:pi=-pi
        for j,w in enumerate(row['weights']):
            wr,wi=w['center'];radius=Q(w['radius'])
            assert type(wr) is int and type(wi) is int
            assert 0<=radius<=Q(1,2**48);max_wr=max(max_wr,radius)
            if k==0:
                assert [wr,wi]==([2**56,0] if j==0 else [0,0]) and radius==0
            sums[j][0]+=pr*wr-pi*wi
            sums[j][1]+=pr*wi+pi*wr
    assert sums==a['coefficients'] and a['coefficients_grid_bits']==96
    U=sum(Q(abs(x)+abs(y),2**96*64**j) for j,(x,y) in enumerate(sums) if j)
    margin=Q(sums[0][0],2**96)-U
    assert U==Q(a['nonconstant_norm_upper']) and margin==Q(a['real_margin'])
    error=Q(a['total_disk_error_upper'])
    assert error==Q(91500568239,10**12)<Q(1,10)<margin
    assert a['strict_positive_real'] is True
    assert a['constant_image_polygon']==[[1,0]]*5 and a['edge_crossings']==[0]*4 and a['winding']==0
    vertices=[tuple(map(Q,v)) for v in p['target']['ccw_vertices']]
    distances=[(x-Q(3,5))**2+(y-14)**2 for x,y in vertices]
    assert all(x<=Q(1,64)**2 for x in distances)
    assert list(map(str,distances))==p['scalar_budget']['vertex_squared_distances']
    assert a['geometry']==p['scalar_budget']
    return dict(status='PASS inspection only; independent analytic replay pending',
                candidate_sha256=PIN,candidate_bytes=len(raw),nodes=929,
                signed_positions=1857,weight_records=12999,
                precision_distribution=dict(bits),terminal_type_distribution=dict(types),
                S_step_distribution=dict(steps),maximum_node_radius=str(max_nr),
                maximum_weight_radius=str(max_wr),coefficients=sums,
                nonconstant_L1_bound=str(U),real_margin=str(margin),
                real_margin_lower_decimal=str(Q((margin*10000).__floor__(),10000)),
                disk_error=str(error),real_function_lower_bound=str(margin-error),
                real_function_lower_decimal=str(Q(((margin-error)*10**6).__floor__(),10**6)),
                node_evaluations=0,weight_evaluations=0,
                scope='Stored P-box radius consistency, allocations, geometry and exact signed sums; no independent transcendental enclosures')

if __name__=='__main__':
    result=run()
    result['inspection_script_sha256']=hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper()
    Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({k:result[k] for k in ('status','precision_distribution','terminal_type_distribution','S_step_distribution','real_margin_lower_decimal','real_function_lower_decimal')}))
