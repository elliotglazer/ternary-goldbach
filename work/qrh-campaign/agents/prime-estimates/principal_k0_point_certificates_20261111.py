"""Five complete Khat enclosures using exact rational elementary witnesses.

No zeta/Gamma/HardyZ/RS library call. This is external arithmetic evidence,
not a kernel proof. The paper interval plan supplies the soundness arguments.
"""
from fractions import Fraction as Q
from math import factorial, isqrt
from pathlib import Path
from decimal import Decimal, localcontext
from time import monotonic, process_time
import json

BITS = 128
SCALE = 2**BITS
LOG_N = 48
COS_N = 48
SINC_M = 16
START = monotonic()


def limit():
    if monotonic()-START > 590:
        raise RuntimeError('Stopped before the ten-minute computation limit')


def floorq(x):
    return x.numerator // x.denominator


def ceilq(x):
    return -floorq(-x)


def rounded(x):
    assert x[0] <= x[1]
    out = Q(floorq(x[0]*SCALE), SCALE), Q(ceilq(x[1]*SCALE), SCALE)
    assert out[0] <= x[0] <= x[1] <= out[1]
    return out


def pt(x):
    x = Q(x)
    return x,x


def add(x,y):
    return rounded((x[0]+y[0],x[1]+y[1]))


def neg(x):
    return -x[1],-x[0]


def sub(x,y):
    return add(x,neg(y))


def mul(x,y):
    c = [a*b for a in x for b in y]
    return rounded((min(c),max(c)))


def scale(c,x):
    return mul(pt(c),x)


def div(x,y):
    assert 0 < y[0] <= y[1]
    return mul(x,(1/y[1],1/y[0]))


def square(x):
    lo = Q(0) if x[0] <= 0 <= x[1] else min(t*t for t in x)
    return rounded((lo,max(t*t for t in x)))


def absolute(x):
    lo = Q(0) if x[0] <= 0 <= x[1] else min(abs(t) for t in x)
    return lo,max(abs(t) for t in x)


def sqrt_point(x):
    assert x >= 0
    k = isqrt((x.numerator*SCALE*SCALE)//x.denominator)
    ans = Q(k,SCALE),Q(k+1,SCALE)
    assert ans[0] >= 0 and ans[0]**2 <= x <= ans[1]**2
    return ans


def sqrt_interval(x):
    assert 0 <= x[0] <= x[1]
    ans = sqrt_point(x[0])[0],sqrt_point(x[1])[1]
    assert ans[0]**2 <= x[0] and x[1] <= ans[1]**2
    return ans


def atan_point(x,n):
    assert 0 < x < 1 and n > 0 and n%2 == 0
    s = sum(((-1)**j*x**(2*j+1)/(2*j+1) for j in range(n)),Q(0))
    return rounded((s,s+x**(2*n+1)/(2*n+1)))


PI = sub(scale(16,atan_point(Q(1,5),24)),scale(4,atan_point(Q(1,239),8)))
assert 3 < PI[0] < PI[1] < Q(22,7)


def log_scaled_point(y):
    assert 1 <= y <= 2
    v = (y-1)/(y+1)
    s = 2*sum((v**(2*j+1)/(2*j+1) for j in range(LOG_N)),Q(0))
    tail = 2*v**(2*LOG_N+1)/((2*LOG_N+1)*(1-v*v))
    return rounded((s,s+tail))


LOG2 = log_scaled_point(Q(2))


def log_point(x):
    limit()
    assert x > 0
    y,k = x,0
    while y < 1:
        y *= 2
        k -= 1
    while y > 2:
        y /= 2
        k += 1
    assert x == Q(2)**k*y
    return add(scale(k,LOG2),log_scaled_point(y))


def log_interval(x):
    assert 0 < x[0] <= x[1]
    return log_point(x[0])[0],log_point(x[1])[1]


COS_TAIL = Q(2*4**COS_N,factorial(COS_N))
SINC_TAIL = Q(2*2**(2*SINC_M),factorial(2*SINC_M+1))


def cosine(x):
    limit()
    center = (x[0]+x[1])/2
    pi_mid = (PI[0]+PI[1])/2
    k = floorq(center/(2*pi_mid)+Q(1,2))
    red = sub(x,scale(2*k,PI))
    assert -4 <= red[0] <= red[1] <= 4
    c,r = (red[0]+red[1])/2,(red[1]-red[0])/2
    p = sum(((-1)**j*c**(2*j)/factorial(2*j)
             for j in range(COS_N//2)),Q(0))
    err = COS_TAIL+r
    out = rounded((p-err,p+err))
    # The elementary |cos|<=1 bound can safely sharpen the interval.
    out = max(out[0],Q(-1)),min(out[1],Q(1))
    assert out[0] <= out[1]
    return out,{'period_integer':k,'reduced':red,'midpoint':c,
                'input_radius':r,'tail':COS_TAIL,'output':out}


def sinc(x):
    assert -2 <= x[0] <= x[1] <= 2
    c,r = (x[0]+x[1])/2,(x[1]-x[0])/2
    p = sum(((-1)**j*c**(2*j)/factorial(2*j+1)
             for j in range(SINC_M)),Q(0))
    err = SINC_TAIL+r/2
    out = rounded((p-err,p+err))
    return out,{'midpoint':c,'input_radius':r,'tail':SINC_TAIL,'output':out}


def coefficient(z):
    w = absolute(z)
    w = max(w[0],Q(0)),min(w[1],Q(1))
    assert w[0] <= w[1]
    a = scale(Q(1,2),mul(PI,sub(square(w),pt(Q(1,4)))))
    b = mul(PI,sub(w,pt(Q(1,2))))
    sa,da = sinc(a)
    sb,db = sinc(b)
    assert sb[0] > Q(1,2)
    pre = scale(Q(1,2),add(w,pt(Q(1,2))))
    f = div(mul(pre,sa),sb)
    return f,{'w':w,'A':a,'B':b,'sinc_A':da,'sinc_B':db,
              'prefactor':pre,'F':f}


LOGS = {n:log_point(Q(n)) for n in range(1,19)}
ROOTS = {n:sqrt_point(Q(n)) for n in range(1,19)}


def evaluate(name,t):
    limit()
    assert t >= 1500
    a = sqrt_interval(div(pt(t),scale(2,PI)))
    nmax = floorq(a[0])
    assert 2*PI[1]*nmax**2 < t < 2*PI[0]*(nmax+1)**2
    assert nmax < a[0] <= a[1] < nmax+1
    z = sub(pt(1),scale(2,sub(a,pt(nmax))))
    logarg = div(pt(t),scale(2,PI))
    logval = log_interval(logarg)
    theta = add(sub(sub(scale(t/2,logval),pt(t/2)),scale(Q(1,8),PI)),pt(1/(48*t)))
    f,fw = coefficient(z)
    root_a = sqrt_interval(a)
    sigma = -(-1)**nmax
    correction = scale(sigma,div(f,root_a))
    terms = []
    total = pt(0)
    eta = Q(19,1000)/t
    for n in range(1,nmax+1):
        arg = sub(theta,scale(t,LOGS[n]))
        cosval,cosw = cosine(arg)
        term = div(scale(2,cosval),ROOTS[n])
        assert term[1]-term[0] < eta/(nmax+1)
        total = add(total,term)
        terms.append({'n':n,'log_n':LOGS[n],'sqrt_n':ROOTS[n],
                      'argument':arg,'cosine':cosw,'term':term})
    assert correction[1]-correction[0] < eta/(nmax+1)
    total = add(total,correction)
    mid,rad = (total[0]+total[1])/2,(total[1]-total[0])/2
    assert rad <= eta
    # Build a rational upper bound for .47*t^(-3/4).
    power = sqrt_interval(sqrt_interval(pt(t**3)))
    radius = Q(ceilq((Q(47,100)/power[0])*SCALE),SCALE)
    assert radius > 0 and radius**4*t**3 >= Q(47,100)**4
    assert rad**4*t**3 <= Q(19,1000)**4
    hardy = mid-radius,mid+radius
    return {'name':name,'t':t,'N':nmax,'a':a,'z':z,
            'theta_log_argument':logarg,'theta_log':logval,'theta_hat':theta,
            'coefficient':fw,'sqrt_a':root_a,'sigma':sigma,
            'terms':terms,'correction':correction,'Khat':total,
            'midpoint':mid,'arithmetic_radius':rad,'arithmetic_budget':eta,
            't_three_quarters':power,'HardyZ_radius':radius,'HardyZ':hardy}


def encode(x):
    if isinstance(x,Q): return f'{x.numerator}/{x.denominator}'
    if isinstance(x,dict): return {k:encode(v) for k,v in x.items()}
    if isinstance(x,(list,tuple)): return [encode(v) for v in x]
    return x


def dec(x):
    with localcontext() as ctx:
        ctx.prec = 20
        return str(Decimal(x.numerator)/Decimal(x.denominator))


def run():
    cpu = process_time()
    d = 10**12
    below = Q(floorq(512*PI[0]*d),d)
    above = Q(ceilq(512*PI[1]*d),d)
    removable = Q(floorq((Q(4225,8)*(PI[0]+PI[1])/2)*d+Q(1,2)),d)
    points = [('1500',Q(1500)),('2000',Q(2000)),
              ('near_F_removable',removable),('below_a16',below),('above_a16',above)]
    rows = [evaluate(name,t) for name,t in points]
    assert rows[3]['N']==15 and rows[4]['N']==16
    assert abs((rows[2]['z'][0]+rows[2]['z'][1])/2-Q(1,2)) < Q(1,10**10)
    return {'status':'PASS external exact rational interval calculations',
            'scope':'Five isolated point enclosures; no sign chain or zero conclusion',
            'parameters':{'bits':BITS,'atan_1_5_terms':24,'atan_1_239_terms':8,
                          'log_terms':LOG_N,'cos_degree_cutoff':COS_N,'sinc_terms':SINC_M},
            'pi':PI,'log2':LOG2,'points':rows,
            'summary':[{'name':r['name'],'t_decimal':dec(r['t']),'N':r['N'],
                        'Khat_midpoint_decimal':dec(r['midpoint']),
                        'arithmetic_radius_decimal':dec(r['arithmetic_radius']),
                        'HardyZ_radius_decimal':dec(r['HardyZ_radius'])} for r in rows],
            'resources':{'wall_seconds':monotonic()-START,'cpu_seconds':process_time()-cpu}}


if __name__=='__main__':
    data=run()
    out=Path(__file__).with_suffix('.json')
    out.write_text(json.dumps(encode(data),indent=2)+'\n',encoding='utf-8')
    print(json.dumps({'status':data['status'],'points':len(data['points']),
                      'resources':data['resources'],'summary':data['summary'],'output':str(out)}))
