"""Exact scalar and saved-metadata audit; no function or transform values."""
from pathlib import Path
from fractions import Fraction as F
import json,hashlib
A=Path(__file__).resolve().parents[1]
pins={
'integration/SMALL_THETA_OUTPUT_INTERPOLATION_AUDIT_2026-11-11.md':'19E411982E0D504C52F604145D6404ACB3BEBA51B662CB7BB1CDBD5D31E83081',
'moebius/REVIEW_SMALL_THETA_OUTPUT_INTERPOLATION_AUDIT_2026-11-11.md':'B815BBEEF96C0E8D1259A915E8BB0F3BEB98BBD1CFB9473B038E0B3D64F3A38F',
'prime-estimates/small_family_theta_inventory_final_20261111.json':'26ED3C86420123A7629DB41C07999990A53A4DAAA4C7146C3FC64D527B578B69',
'prime-estimates/NONPRINCIPAL_SMALL_CONDUCTOR_BACKEND_COST_2026-11-11.md':'6AA4F11AD9103A1176F24BDF045CDF798193B726B1B3A925B8540476E6823043',
'integration/SMALL_CONDUCTOR_SHARED_ELEMENTARY_CIRCUIT_2026-11-11.md':'A8AC4A3B594C8671476FCC92C67A45DCF42EFF0060F522023F929BA440835A4B',
'zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md':'4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4',
'audit/REVIEW_MINIMAL_THETA_AT_FIXED_TIME_LENGTH_2026-11-11.md':'58215EA3A0D697D229AD746F6FCE340DE913165D63599DC197798E705392308B',
'zero-sum/SELECTED_SIGN_CHECKER_COST_SUPPLEMENT_2026-11-11.md':'D4507C3C7F7B513621240AC2BB4B0142B371465FC7AFD5892C2993F0404F4C41'}
checks=0
def ck(x):
 global checks
 checks+=1
 assert x,checks
for f,h in pins.items():ck(hashlib.sha256((A/f).read_bytes()).hexdigest().upper()==h)
data=json.loads((A/'prime-estimates/small_family_theta_inventory_final_20261111.json').read_text())
# Rational upper bounds for Ubar times raw coefficient mass and its center.
mass_ratio=F(44,7)*(F(10,3)+F(3,6))
ck(mass_ratio==F(506,21) and mass_ratio<44)
ck(mass_ratio+F(44,42)<45) # B>=1 implies Ubar*(Mraw+1)<=44B+1
ck(F(44,7*2700)<1)
# Three further bits suffice for intrinsic time-FFT error after dropping scale.
ck(F(44,7*56*8)<F(1,64))
ck(F(1,56*8)<F(7,64*44))
ck(F(3,4)/6+F(3,16)*F(7,44)==F(109,704))
ck(F(109,704)<F(5,32))
ck(F(44,7)*F(109,704)==F(109,112)<1)
ck(F(44,7)*F(5,32)==F(55,56)<1)
ck(F(3,4)+F(3,16)==F(15,16))
M=44*(2*1250000**2+1)
eps=F(1,2**82*3**128)
ck(M*F(605,1344)**340<eps/16)
rows=[]
for extra in [0,167,320,640]:
 d=next(x['totals'] for x in data['scenarios'] if x['theta']==128 and x['extra_nodes']==extra)
 baseline=next(x['totals'] for x in data['scenarios'] if x['theta']==64 and x['extra_nodes']==extra)
 Q=d['primitive_grid_outputs'];n=d['primitive_labels'];U=d['positive_scale_real_updates']
 ck(Q==d['omega_complex_scalings']==d['final_Y_real_products'])
 ck(Q==baseline['primitive_grid_outputs'] and U==baseline['positive_scale_real_updates'])
 ck(d['real_exp_seed_certificates']==2*d['conductors']==14998)
 ck(d['time_dft_complex_outputs']>=Q)
 noncoarse=7*(Q-n);dense=Q+noncoarse
 ck(dense==8*Q-7*n)
 rows.append(dict(extra=extra,coarse_outputs=Q,removed_coarse_omega_scalings=Q,removed_coarse_Y_products=Q,removed_shared_positive_updates=U,removed_positive_exp_seeds=d['conductors'],retained_radial_exp_seeds=d['conductors'],full_time_outputs=d['time_dft_complex_outputs'],dense_new_eighth_points=noncoarse,dense_all_eighth_points=dense,dense_direct_interpolation_terms=340*noncoarse))
out=dict(status='PASS exact rational bounds and saved-count deductions only',checks=checks,pins=pins,raw_threshold_over_epsP='109/704',loose_threshold_over_epsP='5/32',physical_error_ratio_upper='109/112',rows=rows)
with Path(__file__).with_suffix('.json').open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps(out,indent=2))
