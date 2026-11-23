"""What a weighted high-conductor corollary of the explicit large sieve would need."""
import contextlib,io,runpy,json
from pathlib import Path
with contextlib.redirect_stdout(io.StringIO()): n=runpy.run_path(str(Path(__file__).with_name('uniform_conductor_model.py')))
phi=n['phi'];prim=n['prim'];data=n['weights']['geometry']; A=n['A'];rows=[]
for D in [3,10,100,1000,10000,20000,50000,75000,100000,125000,140000]:
    vals=[(v*phi[c]/(c*prim[c]),c) for c,v in data.items() if c>=D]
    K,att=max(vals)
    I=min(381.22,1.2e6/D*1.2534**2)
    rows.append({'D':D,'K_max':K,'K_attained_at_conductor':att,'I_bound':I,
        'coefficient_for_normalized_large_sieve_energy':K*I,
        'normalized_energy_allowed_if_all_A_budget':A/(K*I),
        'A_if_normalized_energy_40':40*K*I,'A_if_normalized_energy_100':100*K*I})
print(json.dumps({'warning':'Finite combinatorial model only; no smoothed-prime coefficient energy theorem or coprime correction transfer established here. Maxima evaluated in floating point.','rows':rows},indent=2))
