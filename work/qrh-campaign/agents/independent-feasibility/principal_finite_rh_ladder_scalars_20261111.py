"""Exact rational/integer comparisons only; no prime, zero, or function evaluator."""
from fractions import Fraction as F
from math import factorial
import json

def run():
    checks = {}
    def ck(name, test):
        assert test, name
        checks[name] = True
    # Elementary e enclosure from its positive series and a geometric tail.
    es = sum((F(1, factorial(k)) for k in range(7)), F(0))
    ck('e_lower_series', es > F(2718,1000))
    ck('e_upper_series_tail', es + F(1,factorial(7))/(1-F(1,8)) < F(2719,1000))
    elo,ehi=F(2718,1000),F(2719,1000)
    N=10**27
    ck('log_N_gt_62', ehi**62 < N)
    ck('log_N_lt_62_2', elo**311 > 10**135)
    ck('loglog_N_gt_4_1', ehi**41 < 62**10)
    ck('sqrt_N_lt_3163e10', (3163*10**10)**2>N)
    ck('pi_archimedes_gt_3_14', F(223,71)>F(157,50))
    ck('exp_55_lt_1e24', ehi**55 < 10**24)
    ck('exp_60_lt_1_2e26', ehi**60 < 12*10**25)
    ck('log_599_lt_7', elo**7 > 599)
    ck('log_599_gt_6', ehi**6 < 599)
    ck('log_1e24_gt_48', ehi**48 < 10**24)
    ck('log_1e24_lt_56', elo**56 > 10**24)
    gap_sch = F(3163*10**10)*F(311,5)**2/(4*F(157,50))
    gap_small = F(10**12)*56**2/(4*F(157,50))
    ck('schoenfeld_gap_lt_9_75e15', gap_sch < 975*10**13)
    ck('schoenfeld_gap_lt_B1_minus4', gap_sch < 10**16-4)
    ck('johnston_height_9e12', F(453,50)**2*N/(62*F(41,10)**2) < (9*10**12)**2)
    ck('buthe_height_2e13', F(123,25)**2*N/62 < (2*10**13)**2)
    ck('buthe_small_height_3e12', F(123,25)**2*10**24/48 < (3*10**12)**2)
    ck('small_theta_gap_lt_B2_minus4', gap_small < 2*10**16-4)
    ck('small_lower_endpoint_patch', 10**16+1-gap_sch/2 > 599*7)
    d55,d60=10288400000,76918400000
    ck('CHL_middle_gap', F(12*10**25,d55) < 2*10**16-4)
    ck('CHL_top_gap', F(N,d60) < 2*10**16-4)
    ck('CHL_top_not_B1', F(N,d60) > 10**16)
    ck('coarse_a1_height_8e10', F(119,100)**2*N/62**3 < (8*10**10)**2)
    ck('coarse_a1_gap_B_2_5e17', 2*F(3163*10**10)*F(311,5)**2 < 25*10**16-4)
    return {'status':'PASS_EXACT_SCALAR_COMPARISONS','checks':checks,
            'two_endpoint_schoenfeld_upper':str(gap_sch),
            'CHL_middle_gap_upper':str(F(12*10**25,d55)),
            'CHL_top_gap_upper':str(F(N,d60)),
            'scope':'Scalar implications only; no RH, CHL parameter, prime, or formal checker certificate.'}

if __name__=='__main__':
    print(json.dumps(run(),sort_keys=True,indent=2))
