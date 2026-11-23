"""Rational guard/constant certificate for one actual principal P-kernel node.

Analytic theta identities and series inequalities are proved in the companion
paper note. This script calls no numerical special-function implementation.
"""
from pathlib import Path
from fractions import Fraction as Q
import copy
import hashlib
import importlib.util
import json
import sys

sys.dont_write_bytecode=True
HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent
PINS={
    'integration/lossless_modular_two_step_20261111.py':'9A0EFE7074098764FDE27273836158B343F67FF300352B37F6E01B9ED74DE7E6',
    'integration/lossless_modular_two_step_20261111.json':'31DD05C2F85A02D29037E91BA63BE85AEC5C55063FED96010552C5BCF0034FBE',
    'integration/lossless_seed_taylor_20261111.py':'3000DB601B1206E1A128438774D0C33DF7FB3EA27AEAECD65CECD81E63CD2137',
    'integration/lossless_seed_taylor_20261111.json':'6C3EE4AE09014B64541899F276405C607624A5DABF70DFBA3AEE5EF654E82C3F',
    'integration/PRINCIPAL_THETA_MODULAR_ACCELERATION_2026-11-11.md':'C64EDFEB89B0F15B8B225241248BC7A751C385247843CE3AFEBF8FCF0382E84D',
    'audit/REVIEW_PRINCIPAL_THETA_MODULAR_ACCELERATION_2026-11-11.md':'9C2C4348EC29A5C3B4ACD6221CFE96F011C191395877E3654FC69DD81C7987ED',
    'integration/PRINCIPAL_XI_FOURIER_EVALUATOR_2026-11-11.md':'6920406603A615022B7277407BF12FE3837C54B053BBB131DA23CC8C35387F99',
}


def qr(q):
    return {'numerator':str(q.numerator),'denominator':str(q.denominator)}


def load(name,path):
    spec=importlib.util.spec_from_file_location(name,path)
    module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)
    return module


def proposal():
    return {'T':1000000,'real_node':'0','word':[['T',-1],['S'],['T',0]],
            'theta_types':['theta3','theta4','theta2'],
            'inverse_t_bound_exponent':20,'A_bound_exponent':10,
            'tau_norm_upper':2,'reduced_imag_lower':1024,
            'jet_bound_exponent':-505,'first_derivative_exponent':51,
            'second_derivative_exponent':92,'P_amplification_exponent':97,
            'P_radius_exponent':-408,'requested_radius_exponent':-128}


def verify(c):
    assert c==proposal(), 'fixed node and bounds required'
    for name,pin in PINS.items():
        assert hashlib.sha256((AGENTS/name).read_bytes()).hexdigest().upper()==pin,name
    graph=load('p_node_graph',HERE/'lossless_modular_two_step_20261111.py')
    seed=load('p_node_seed',HERE/'lossless_seed_taylor_20261111.py')
    graph_data=json.loads((HERE/'lossless_modular_two_step_20261111.json').read_text())
    seed_data=json.loads((HERE/'lossless_seed_taylor_20261111.json').read_text())
    gr=graph.verify(graph_data['packet'])
    sr=seed.verify(seed_data['certificate'])
    assert gr==graph_data['verification'] and gr['all_arithmetic_gates_pass']
    assert sr==seed_data['verification'] and gr['unproved_seed_ids']==['tau']
    nodes={n['id']:n for n in graph_data['packet']['nodes']}
    def b(key):
        return tuple(graph.ball(nodes[key]['value'][part]) for part in ('re','im'))
    tau,t,v,A=map(b,('tau','translated','S_output','A'))
    def norm2hi(z):return sum(max(a*a,b*b) for a,b in z)
    guards={
        'T_minus1_real_domain':-Q(3,5)<t[0][0]<=t[0][1]<Q(3,5),
        'S_input_domain':0<t[1][0]<=t[1][1]<Q(1,2),
        'T_zero_terminal_real_domain':-Q(3,5)<v[0][0]<=v[0][1]<Q(3,5),
        'terminal_imag_domain':v[1][0]>Q(2,5),
        'reduced_Y_at_least_1024':v[1][0]>=1024,
        't_imag_at_least_2pow_minus20':t[1][0]>=Q(1,2**20),
        'tau_norm_at_most2':norm2hi(tau)<=4,
        'A_norm_at_most2pow10':norm2hi(A)<=2**20,
        'b_inside_kernel_strip':0<Q(1,1000001)<Q(3,4),
    }
    assert all(guards.values())
    E=Q(2**20);Ab=Q(2**10);tauB=Q(2)
    d1=Ab*(E/2+E**2)
    d2=Ab*(3*E**2/4+3*E**3+E**4)
    amp=6*tauB*2**51+4*tauB**2*2**92
    scalars={
        'Y_ge_one':Q(c['reduced_imag_lower'])>=1,
        'twoY_le_threeY_minus_one':2*1024<=3*1024-1,
        'geometric_sum_cap':Q(1)/(1-Q(1,4))<=2,
        'theta_jet_prefactor':32*2*2==2**7,
        'half_Y_lower':1024//2==512,
        'jet_exponent':7-512==c['jet_bound_exponent'],
        'first_derivative_bound':d1<=2**c['first_derivative_exponent'],
        'second_derivative_bound':d2<=2**c['second_derivative_exponent'],
        'P_amplification_bound':amp<=2**c['P_amplification_exponent'],
        'P_exponent_sum':c['P_amplification_exponent']+c['jet_bound_exponent']==c['P_radius_exponent'],
        'requested_radius_strict':c['P_radius_exponent']<c['requested_radius_exponent'],
    }
    assert all(scalars.values())
    return {'status':'PASS exact guard and scalar replay for one P node',
            'seed_exact_replay':True,'sixteen_gate_replay':True,'guards':guards,'scalar_checks':scalars,
            'recorded_bounds':{'Y_lower':qr(v[1][0]),'t_imag_lower':qr(t[1][0]),
                               'tau_norm_squared_upper':qr(norm2hi(tau)),
                               'A_norm_squared_upper':qr(norm2hi(A)),
                               'first_derivative_amplification':qr(d1),
                               'second_derivative_amplification':qr(d2),
                               'P_coarse_amplification':qr(amp)},
            'output':{'center':{'real':0,'imag':0},'absolute_radius':{'mantissa':'1','exponent':-408},
                      'meaning':'norm(P(i*(pi/4-1/1000001))) <= 2^(-408), by companion analytic proof'},
            'scope':'One exact node only; paper plus exact external arithmetic, no Lean or spectral assertion'}


def controls(c):
    out={}
    for label,key,value in [('wrong_node','real_node','1/8'),('wrong_height','T',60343058),
                            ('wrong_theta_type','theta_types',['theta3','theta4','theta3']),
                            ('wrong_radius','P_radius_exponent',-1000)]:
        bad=copy.deepcopy(c);bad[key]=value
        try:verify(bad);out[label]=False
        except AssertionError:out[label]=True
    assert all(out.values())
    return out


if __name__=='__main__':
    if len(sys.argv)>1 and sys.argv[1]=='--check':
        data=json.loads(Path(sys.argv[2]).read_text())
        r=verify(data['certificate']);assert r==data['verification']
        assert controls(data['certificate'])==data['corruption_controls']
        print(json.dumps({'status':r['status'],'output':r['output']},indent=2))
    else:
        c=proposal();r=verify(c)
        out={'pins':PINS,'certificate':c,'verification':r,'corruption_controls':controls(c),
             'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper()}
        dest=Path(__file__).with_suffix('.json');dest.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
        print(json.dumps({'status':r['status'],'guards':r['guards'],'scalars':r['scalar_checks'],
                          'output':r['output'],'receipt_sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()},indent=2))
