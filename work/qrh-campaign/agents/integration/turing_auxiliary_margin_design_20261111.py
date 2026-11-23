"""Exact conditional auxiliary-height witnesses, not spectral evidence."""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json

HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent
PINS={
    'integration/ELEMENTARY_TURING_PAPER_ASSEMBLY_2026-11-11.md':'72275b5cba95fdd4f933c2150399c214b2509d9ef91d08a494104466dc8d597c',
    'mellin/REVIEW_ELEMENTARY_TURING_PAPER_ASSEMBLY_2026-11-11.md':'2238e4c56b808f9034dce86eca834a785ba5df4e09f2f68935c287bd9ca5aae3',
    'zero-sum/FAMILY_CHARACTER_MANIFEST_PROOF_PLAN_2026-11-11.md':'53d6de424680957e9467fe5cf608578bb356de08c57979e7494e4f1e387d4d54',
    'zero-sum/FAMILY_PRODUCTION_ENDPOINT_ADDENDUM_2026-11-11.md':'6759192eed071a69b064d793ca307fd563bcb436accfb28238c77c5ab74e87f4',
    'zero-sum/REVIEW_AUXILIARY_FOURIER_PARAMETERS_2026-11-11.md':'5eb56e2f86c5ce05cca3491c237fe66f4c0053f656ad1401211a47406833da21',
}
digest=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
assert all(digest(AGENTS/path)==pin for path,pin in PINS.items())

def ceil(q):
    return -((-q.numerator)//q.denominator)

def selected_height(c):
    assert (c%2==1 and c<=150000) or (c%4==0 and c<=300000)
    tilde=c if c%2==0 else 2*c
    Hp=200+max(1000,ceil(F(704*1200000,7*tilde)))
    T=min(F(Hp),F(100000000,c))
    assert T>50
    return Hp,T

rows=[]
for c in [3,4,40,101,1000,10000,150000,300000]:
    Hp,T=selected_height(c)
    for rho in [F(1,4),F(1,2),F(3,4)]:
        # exp(1)>8/3 implies exp(k)>(8/3)^k for k>=1.
        # pi>3 then proves log(c*(T+h)/(2*pi))<k below.
        for k in range(1,101):
            b=42+F(693,100)*k
            threshold=F(9,8)*2*b/rho
            h=threshold.numerator//threshold.denominator+1
            H=T+h
            if F(8,3)**k >= c*H/6:
                break
        else:
            raise AssertionError('No bounded witness found')
        Abar=2*b/h
        assert Abar<F(8,9)*rho
        assert (1-rho)+Abar<1
        assert rho-Abar>rho/9
        assert h>0 and H>T
        rows.append({
            'conductor':c,'old_Hp':Hp,'T_Hcert':str(T),
            'rho':str(rho),'h':h,'H_evaluator':str(H),
            'log_upper_integer':k,'per_channel_B_upper':str(b),
            'two_channel_allowance_over_h_upper':str(Abar),
            'conditional_measured_D_ceiling':str(1-rho),
            'guaranteed_margin_floor':str(rho/9),
            'strict_saturation_margin_at_D_ceiling':str(rho-Abar),
            'h_over_T':str(F(h)/T),'c_times_T':str(c*T),
            'c_times_H':str(c*H),
            'exceeds_old_product_cap':c*H>100000000,
            'exp_log_witness_slack':str(F(8,3)**k-c*H/6),
            'measured_D_supplied':False,
            'certified_gamma_integral_supplied':False,
            'certified_main_or_auxiliary_signs_supplied':False,
        })

# Exact coefficient check for the consumer's measured data:
# U-K = (GammaUpper-W-h*K)/h + 2*BUpper/h, exactly.
# Written as coefficients in [GammaUpper,W,K,BUpper].
for h in [1,17,1024]:
    lhs=[F(1,h),F(-1,h),F(-1),F(2,h)]
    rhs=[F(1,h),F(-1,h),F(-h,h),F(2,h)]
    assert lhs==rhs

assert all(digest(AGENTS/path)==pin for path,pin in PINS.items())
receipt={
    'status':'PASS_EXACT_CONDITIONAL_HEIGHT_WITNESSES_ONLY',
    'script_sha256':digest(Path(__file__)), 'input_pins':PINS,
    'method':'For k=1..100, h=floor((9/8)*2*(42+693*k/100)/rho)+1; accept (8/3)^k>=c*(T+h)/6',
    'rows':rows,
    'scope':'No L values, zeros, Gamma integrals, FFTs, measured count deficits or saturation certificates computed.',
}
Path(__file__).with_suffix('.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(json.dumps({k:v for k,v in receipt.items() if k!='rows'},indent=2))
for row in rows:
    if row['rho']=='1/2':
        print(json.dumps(row))
