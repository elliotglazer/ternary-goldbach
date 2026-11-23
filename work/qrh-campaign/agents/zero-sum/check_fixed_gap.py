from fractions import Fraction as Q
checks = {
    'low_height_multiplier': Q('0.18') * Q('2.39')**2 >= 1,
    'half_digamma_constant': Q('0.6932')/2 + Q('0.18')/4 <= Q('0.4'),
    'reciprocal_two': 2/Q('2.39')**2 <= Q('0.351'),
    'reciprocal_eleven': 11/Q('2.39')**2 <= Q('1.926'),
    'log_height_certificate': Q('2.7182818283')**20 >= 400000000,
}
kappa = Q('0.514')/Q('1.1181')
checks.update({
    'kappa_range': Q('0.45') <= kappa <= Q('0.46'),
    'digamma_difference': kappa/2*(Q('0.20604')+Q('1.926')) <= Q('0.491'),
    'real_comparison': kappa*Q('1.2857') <= Q('0.592'),
    'uniform_term': Q('0.351')+Q('0.55')*Q('9.83')+Q('0.491')+Q('0.592') <= Q('6.85'),
    'negative_reciprocals': kappa*(Q('1.618')+Q('0.62')) <= Q('1.03'),
    'zero_contribution': Q(500,9)+Q('0.98')-Q('1.03') >= Q('55.5'),
})
margin = 18*Q(500,7)+54*Q('6.85')-30*Q('55.5')
checks['contradiction_margin'] = margin == -Q(657,70)
assert all(checks.values()), checks
for name, passed in checks.items():
    print(f'{name}: {passed}')
print(f'final upper bound: {margin}')
