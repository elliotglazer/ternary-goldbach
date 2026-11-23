"""Exactly32 fixed-width tests; no fitting or complete boundary search."""
from pathlib import Path
from fractions import Fraction as F
import importlib.util
import hashlib
import json
import sys
import time

HERE=Path(__file__).parent
SOURCE=HERE/'c5_residual_taylor_panels_20261111.py'
PARENT=SOURCE.with_suffix('.json')
assert hashlib.sha256(SOURCE.read_bytes()).hexdigest()=='f1f91d5bc8b9daf5bca8b44fa55c1d333500662496157a453fb9e70cbd37fe4c'
assert hashlib.sha256(PARENT.read_bytes()).hexdigest()=='8801debf7956c20403b20a1a04819b61e5fafaf2a8fa39da10e3888132c28f8c'
spec=importlib.util.spec_from_file_location('accepted_c5_taylor',SOURCE)
t=importlib.util.module_from_spec(spec)
spec.loader.exec_module(t)
em=t.em
WIDTHS=[F(1,2048),F(1,1024),F(1,512),F(1,256),F(1,128),F(1,64),F(1,32),F(3,64)]
PATH=Path(__file__).with_suffix('.json')


def digest(co):
    return hashlib.sha256(json.dumps([[t.enc(x) for x in row] for row in co],sort_keys=True).encode()).hexdigest()


def main():
    start=time.perf_counter()
    saved=json.loads(PARENT.read_text())
    assert saved['all_four_new_tests_pass'] and saved['full_rectangle_certified'] is False
    assert saved['candidate_sha256']==hashlib.sha256(t.old.CANDIDATE.read_bytes()).hexdigest()
    ii=em.acb(0,1)
    results=[]
    preparation=0.0
    evaluation=0.0
    calls=0
    for prior in saved['panels']:
        stamp=time.perf_counter()
        center=tuple(map(F,prior['center']))
        assert center[0] in (em.LEFT,em.RIGHT)
        geometric_limit=em.T-abs(center[1])
        s0=em.acb(em.ar(center[0]),em.ar(center[1]))
        gj=t.finite_l_jets(center)
        bj,_,md=t.rational_jets(center,WIDTHS[0])
        M,Eouter=t.controls(center,t.R)
        residual=[]
        for k in range(3):
            co=[-x for x in t.polynomial_product(gj[k],bj[k])]
            co[0]+=1
            residual.append(co)
        pole_weights=[]
        for p,row in zip(t.old.acbp,t.old.data['coefficients'][1:]):
            d=abs(s0-p).lower()
            weights=[]
            for z in row:
                w=em.acb(em.ar(F(z[0])),em.ar(F(z[1])))
                weights.append(abs(w).upper()/d**(t.D+1))
            pole_weights.append((d,weights))
        prep_elapsed=time.perf_counter()-stamp
        preparation+=prep_elapsed
        rec={'attempt_index':prior['attempt_index'],'center':list(map(str,center)),
             'geometric_half_width_limit':str(geometric_limit),
             'pole_distance_lower':t.encu(md),'control_radius':str(t.R),
             'control_sigma_floor':str(center[0]-t.R),
             'finite_g_outer_bound':t.encu(M),'actual_L_minus_g_outer_bound':t.encu(Eouter),
             'g_coefficients_sha256':digest(gj),'B_coefficients_sha256':digest(bj),
             'residual_coefficients_sha256':digest(residual),'widths':[]}
        for rho in WIDTHS:
            stamp=time.perf_counter()
            calls+=1
            assert calls<=32 and rho<=geometric_limit and rho<t.R and em.ar(rho)<md
            rr=em.ar(rho)
            be=[em.arb(0) for _ in range(3)]
            for d,weights in pole_weights:
                for k in range(3):be[k]+=weights[k]*rr**(t.D+1)/(d-rr)
            be=list(map(t.upper,be))
            _,Epanel=t.controls(center,rho)
            ratio=em.ar(rho/t.R)
            gtail=t.upper(M*ratio**(t.D+1)/(1-ratio))
            le=t.upper(Epanel+gtail)
            scalar=[]
            errors=[]
            z=em.box((F(0),-rho),(F(0),rho))
            for k in range(3):
                gp=t.poly_norm(gj[k],rho)
                bp=t.poly_norm(bj[k],rho)
                err=t.upper(le*(bp+be[k])+gp*be[k])
                errors.append(err)
                scalar.append(t.eval_poly(residual[k],z)+em.eb(err))
            group=[sum((scalar[k-1]*ii**((-k*j)%4) for k in (1,2,3)),em.acb(0))/4
                   for j in range(4)]
            q1=t.upper(sum((t.upper(abs(x)) for x in group),em.arb(0)))
            power=group
            for _ in range(4):power=t.old.convolution(power,power)
            q16=t.upper(4*sum((t.upper(abs(x))*t.upper(abs(x)) for x in power),em.arb(0)))
            if center[0]==em.LEFT:
                a,b=(center[0],center[1]+rho),(center[0],center[1]-rho)
            else:
                a,b=(center[0],center[1]-rho),(center[0],center[1]+rho)
            rec['widths'].append({'half_width':str(rho),'full_width':str(2*rho),
                'a':list(map(str,a)),'b':list(map(str,b)),
                'domain_admissible':True,'actual_L_minus_g_panel_bound':t.encu(Epanel),
                'finite_g_Taylor_tail':t.encu(gtail),'rational_Taylor_tails':list(map(t.encu,be)),
                'residual_analytic_errors':list(map(t.encu,errors)),
                'l1_upper':t.encu(q1),'T16_upper':t.encu(q16),
                'l1_pass':bool(q1<1),'T16_pass':bool(q16<1),
                'group_residual_boxes':list(map(t.enc,group))})
            evaluation+=time.perf_counter()-stamp
        results.append(rec)
    assert calls==32
    result={'status':'FIXED_32_PANEL_WIDTH_EXPERIMENT','full_rectangle_certified':False,
            'source_sha256':hashlib.sha256(SOURCE.read_bytes()).hexdigest(),
            'parent_receipt_sha256':hashlib.sha256(PARENT.read_bytes()).hexdigest(),
            'candidate_sha256':saved['candidate_sha256'],
            'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
            'half_width_ladder':list(map(str,WIDTHS)),'panel_evaluations':calls,
            'centers':results,'degree':t.D,'precision_bits':em.ctx.prec,
            'preparation_seconds':preparation,'evaluation_seconds':evaluation,
            'elapsed_seconds':time.perf_counter()-start,
            'cost_counts':{'finite_g_jet_builds':4,'rational_jet_builds':4,
                'cached_residual_polynomial_builds':4,'finite_series_exponentials':4*262,
                'rational_jet_coefficient_products':4*385*(t.D+1)*3,
                'rational_power_updates':4*385*(t.D+1),
                'residual_polynomial_products':4*3*(t.D+1)**2,
                'initial_discarded_rational_tail_evaluations':4,
                'outer_control_bounds':4,'panel_control_bounds':32,
                'width_specific_rational_tail_evaluations':32,
                'width_specific_rational_tail_summands':32*385*3,
                'group_convolutions':32*4,'group_convolution_products':32*4*16,
                'extra_actual_L_point_calls':0,'old_bound_calls':0}}
    if '--recompute' in sys.argv:
        prev=json.loads(PATH.read_text())
        for k in ('preparation_seconds','evaluation_seconds','elapsed_seconds'):
            prev.pop(k)
        comp=dict(result)
        for k in ('preparation_seconds','evaluation_seconds','elapsed_seconds'):
            comp.pop(k)
        assert prev==comp
    else:PATH.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({k:v for k,v in result.items() if k!='centers'},indent=2))
    for row in results:
        print(json.dumps({'index':row['attempt_index'],'tests':[{
            'rho':r['half_width'],'l1':float(F(r['l1_upper'])),'l1_pass':r['l1_pass'],
            'T16_pass':r['T16_pass']} for r in row['widths']]}))


if __name__=='__main__':main()
