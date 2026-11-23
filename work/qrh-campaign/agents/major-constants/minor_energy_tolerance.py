"""Exact rational sensitivity of pinned minor-arc cell certificates.
No Lean compilation; source inequalities are reused, not numerically sampled.
"""
from fractions import Fraction as F
from pathlib import Path
import re,json
ROOT=Path(__file__).resolve().parents[3]/'ternary-goldbach'/'TernaryGoldbach'/'MinorArcs'
if not ROOT.exists():
    ROOT=Path.cwd()/'work'/'ternary-goldbach'/'TernaryGoldbach'/'MinorArcs'
text=(ROOT/'NumericsCells.lean').read_text(encoding='utf-8-sig')
a0=F('0.640208000017'); b=F('.021095'); target=F('1.037')
t=F('.0005'); extra=(1+1/t)*F('22.75')*F('8e-11')
expanded_target=(F('1.0376')-extra)/(1+t)
rows=[]
for i in range(9):
    cell=text.split('theorem cell'+str(i)+' ')[1].split('refine cell_bound ')[1]
    call=cell.split(' hx (by norm_num)')[0]
    vals={k:F(v) for k,v in re.findall(r'\((L₀|L₁|cl0|clt|G0|Gt|sD\x27|τ\x27|k) := ([0-9.e+-]+)\)',call)}
    lists=re.findall(r'\[([^\]]+)\]',call)
    assert len(lists)==3,(i,len(lists))
    P=[[F(z.strip()) for z in s.split(',')] for s in lists]
    points,G,ell=P
    assert len(G)==len(ell)==int(vals['k']) and len(points)==len(G)+1
    S=sum((g*l for g,l in zip(G,ell)),F(0))
    C=vals['G0']*vals['cl0']+S
    den=vals['L₀']/2-F('1.3066')
    tailfactor=1-vals['clt']/(vals['L₁']/2-F('1.3064'))
    slope=C*vals['L₀']/den+vals['Gt']*vals['L₁']*tailfactor
    intercept=-b*(C/den+vals['Gt']*tailfactor)-vals['G0']*F('8.6294')
    base=slope*a0+intercept
    old=vals['G0']*(vals['cl0']*vals["sD'"]-F('8.6294'))+vals["sD'"]*S+vals['Gt']*vals["τ'"]
    assert 0 < den and 0 <= tailfactor and 0 < slope
    assert base <= old <= target
    assert a0*F('1.3064') > b/2
    fixed_cap=min((vals["sD'"]*den+b)/vals['L₀'],(vals["τ'"]/tailfactor+b)/vals['L₁'])
    rows.append(dict(cell=i,vals=vals,sum_Gell=S,slope=slope,intercept=intercept,
      old_rounded_bound=old,exact_endpoint_bound_at_a0=base,
      cap_keep_rounded_auxiliary=fixed_cap,cap_keep_Mexpr1037=(target-intercept)/slope,
      cap_use_final_slack=(expanded_target-intercept)/slope,
      cap_zero_intercept=(target+vals['G0']*F('8.6294'))/slope))
# Same asymptotic ingredients; recompute only a-dependent scalar envelopes.
L0=F('234.14'); D=L0/2-F('1.3066'); G0=F('.0510741'); cl0=F('14.61155')
S=F('.165282706731081808')+F('.00084')+F('1.398')*F('1e-10')
T=F('2.3786')*F('.00014')+F('1.398')*F('1e-10')
aslope=(G0*cl0+S)*L0/D+T
aintercept=-(G0*cl0+S)*b/D-G0*F('8.6294')
asymp=dict(slope=aslope,intercept=aintercept,cap_keep_Mexpr1037=(target-aintercept)/aslope,
          cap_use_final_slack=(expanded_target-aintercept)/aslope,
          keep_sD_cap=(F('1.2947')*D+b)/L0,
          keep_tail_06403_cap=F('.6403'))
cap=min([r['cap_keep_Mexpr1037'] for r in rows]+[asymp['cap_keep_Mexpr1037']])
cap_final=min([r['cap_use_final_slack'] for r in rows]+[asymp['cap_use_final_slack']])
recommended=F('.65')
near_cap=F('.6527')
assert all(r['slope']*near_cap+r['intercept']<=target for r in rows)
assert aslope*near_cap+aintercept<=target
zero_asymp_cap=(target+G0*F('8.6294'))/aslope
zero_cap=min([r['cap_zero_intercept'] for r in rows]+[zero_asymp_cap])
assert aslope*F('.6523')-G0*F('8.6294')<=target
assert F('.6523')<zero_cap
for r in rows:
    r['bound_at_065']=r['slope']*recommended+r['intercept']
    r['bound_at_06527']=r['slope']*near_cap+r['intercept']
    r['slack_at_065']=target-r['bound_at_065']
assert all(r['slope']*recommended+r['intercept']<=target for r in rows)
assert aslope*recommended+aintercept<=target

def fmt(v):
    if isinstance(v,F): return {'fraction':str(v),'decimal':float(v)}
    if isinstance(v,dict):return {k:fmt(x) for k,x in v.items()}
    if isinstance(v,list):return list(map(fmt,v))
    return v
print(json.dumps(fmt(dict(a0=a0,extra=extra,expanded_Mexpr_target=expanded_target,
  cells=rows,asymptotic=asymp,global_cap_same_Mexpr=cap,global_cap_using_final_slack=cap_final,
  tested_safe_a=recommended,tested_near_cap=near_cap,global_zero_intercept_cap=zero_cap,
  note='Caps are exact for these fixed source envelopes after recomputing sD and tau. They are not a claimed optimal analytic coefficient.')),indent=2))
