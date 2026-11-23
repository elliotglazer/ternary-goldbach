"""Rational scalar implications only: NO zeta evaluation or spectral certificate."""
from fractions import Fraction as Q
from math import factorial

def elo(x, n=160):
    x=Q(x); assert x>=0
    t=s=Q(1)
    for j in range(1,n+1):
        t*=x/j; s+=t
    return s

def eup(x,n=160):
    x=Q(x); assert 0<=x<n+2
    t=s=Q(1)
    for j in range(1,n+1):
        t*=x/j; s+=t
    return s+t*x/Q(n+1)/(1-x/Q(n+2))

def atan_bounds(x,n=80):
    x=Q(x); s=sum(((-1)**j*x**(2*j+1)/Q(2*j+1) for j in range(n)), Q(0))
    t=(-1)**n*x**(2*n+1)/Q(2*n+1)
    return min(s,s+t),max(s,s+t)

# Machin identity pi=16 atan(1/5)-4 atan(1/239), an analytic replay obligation.
a,b=atan_bounds(Q(1,5)); c,d=atan_bounds(Q(1,239))
pl=Q('3.1415926'); pu=Q('3.1415927')
assert pl<16*a-4*d and 16*b-4*c<pu
logs={14:('2.639057','2.639058'),1500:('7.313220','7.313221'),
      10**6:('13.815510','13.815511')}
for x,(l,u) in logs.items():
    assert eup(Q(l))<x<elo(Q(u))
cl=Q('1.837877'); cu=Q('1.837878')
assert eup(cl)<2*pl and 2*pu<elo(cu)
assert elo(1)>Q(logs[14][1])
assert elo(2)>Q(logs[1500][1])

def positive_tail_bound(a, loglog_upper):
    al,au=map(Q,logs[a]); tl,tu=map(Q,logs[10**6])
    # F(T)/T + int_a^T F(t)/t^2 dt, plus an upper bound for R contribution.
    # Both squared log arguments are positive. The linear term may be negative
    # at a=14, so choose the denominator according to its sign.
    linear=au-cl-1
    denom=2*pl if linear>=0 else 2*pu
    main=((tu-cl)**2-(al-cu)**2)/(4*pl)+linear/denom+Q(7,8*a)
    r=Q('.137')*au+Q('.448')*loglog_upper+Q('1.588')
    error=(r+Q('.137')+Q('.448')/al)/a
    return main+error

gap=2*positive_tail_bound(14,Q(1))
assert gap<Q('23.18')
paired=(1+eup(Q('.035')))/2
assert Q('23.18')*paired<Q('23.594')<24
tail=positive_tail_bound(1500,Q(2))
assert tail<Q('9.747')
# Head certificate is sum_{0<gamma<=1500} m*(1/gamma-1/1500)<=2.
head_route=2*(2+Q('9.747'))*paired
assert head_route<Q('23.913')<24
assert Q('23.18')*(1+elo(Q('.35')))/2>28

for k,v in [('gap14_count_only_bound',gap),('tail1500_bound',tail),
            ('paired_head_route_bound',head_route)]:
    scale=10**12
    ceiling=(v.numerator*scale+v.denominator-1)//v.denominator
    print(k, str(Q(ceiling,scale)), 'upper')
print('PASS: scalar implications only; all finite zero data and analytic count proof remain tasks.')
