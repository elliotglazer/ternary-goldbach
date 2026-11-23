import json,math
from pathlib import Path
p=Path(__file__).with_name('uniform_conductor_results.json')
d=json.loads(p.read_text(encoding='utf-8-sig'))
# Execute the base model silently to access conductor-resolved arrays.
import contextlib,io,runpy
with contextlib.redirect_stdout(io.StringIO()): ns=runpy.run_path(str(Path(__file__).with_name('uniform_conductor_model.py')))
W=ns['weights']['source_upper']; G=ns['weights']['geometry']; A=ns['A']; xp=ns['xp']; r=ns['rho']; tailconst=ns['tailconst']
models={}
for profile in ['constant','log_2c']:
    f=lambda c:1 if profile=='constant' else math.log(2*c)
    ws={c:w*f(c)**2 for c,w in W.items()}; gs={c:g*f(c)**2 for c,g in G.items()}
    total=sum(ws.values());geom=sum(gs.values()); rows=[]
    for C in [.01,.03,.1,.25,.5,1,2,5,10,25]:
        outside=total;cut=None;inside=None
        for c,w in sorted(ws.items()):
            outside-=w
            if xp*C*C*outside<=A/4:
                cut=c;inside=total-outside;break
        D=(4*xp*C*C*geom*tailconst/A)**(1/3)
        a=min(.005,.28/(1+D))
        allowed=math.sqrt(A/(2*xp*C*C*inside))
        fraction=(allowed-r)/(1-r)
        T=None if fraction<=0 else max(0,-math.log(min(1,fraction))/a)
        rows.append({'C_prefactor':C,'Q_certificate':cut,'twist_cutoff':D,'height_certificate':T,
                     'A_outside_Q':xp*C*C*outside,'A_inside_Q_if_height_infinite':xp*C*C*r*r*inside})
    models[profile]={'weighted_source_total':total,'weighted_geometry_total':geom,
        'C_prefactor_cap_without_certificate':math.sqrt(A/(xp*total)),
        'conditional_sufficient_joint_cutoffs':rows}
print(json.dumps({'warning':'All cutoffs are conditional sensitivity calculations. Requires strong uniform total zero-envelope and relative tail premise stated in notes. Not a certified zero computation.', 'models':models},indent=2))
