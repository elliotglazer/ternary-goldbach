"""Independent exact audit of the proposed common-height major-arc certificate.

Reads producer files; writes only this review's JSON. No Lean or spectral check.
Primitive character counts are recomputed by divisor inversion of phi, and
cell tails use longer independently implemented positive Taylor sums.
"""
from fractions import Fraction as Q
from math import factorial, gcd
from pathlib import Path
import hashlib, json, time

start = time.time()
here = Path(__file__).resolve().parent
src = here.parent / 'major-constants'
stem = 'resume_common_height_major_20261111'
cells = json.loads((src / (stem+'_cells.json')).read_text())
expected = json.loads((src / (stem+'.json')).read_text())
assert expected['source_sha256'] == hashlib.sha256((src/(stem+'.py')).read_bytes()).hexdigest()
M = 300000
S = 10**18

def ceiling(x):
    return -(-x.numerator // x.denominator)

def round_up(x, denominator):
    return Q(ceiling(x*denominator), denominator)

def old_plus(c):
    return 200 + max(1000, ceiling(Q(704*1200000, 7*c*(2 if c%2 else 1))))

def old_star(c):
    return max(1000, ceiling(Q(704*1200000,343*c*(2 if c%2 else 1))))

def cutoff(c):
    return min(Q(100000000,c), Q(old_plus(c)))

E24 = sum((Q(1,factorial(j)) for j in range(25)), Q(0))

def exp_upper_negative(x):
    n = x.numerator//x.denominator
    r = x-n
    # This is an upper bound because both positive sums are BELOW exp.
    residue = sum((r**j/factorial(j) for j in range(21)), Q(0))
    return 1/(E24**n * residue)

def b_tail(t):
    t = min(t,Q(2000))
    assert t >= 50
    return Q(223,250)*t*exp_upper_negative(Q(799,5000)*t)

def a_tail(t,d):
    u = min(t/(Q(22,7)*d), Q(40))
    assert u >= 10
    return Q(147,250)*u*u*exp_upper_negative(Q(213,2000)*u*u)

tail = [None]*(M+1)
last = {True:-1,False:0}
for cell in cells:
    lo,hi,odd,t = (cell[k] for k in ('lo','hi','odd','tail_numerator'))
    step = 2 if odd else 4
    assert lo == last[odd]+step
    assert hi>=lo and (hi-lo)%step == 0
    assert hi <= (150000 if odd else M)
    d = Q(1200000,lo*(2 if odd else 1))
    h = cutoff(hi)
    assert h-200 >= 10*Q(22,7)*d and h-200 >= 50
    g = 3+Q(10,27)*d
    wa,wb = 800*g+106*g*g/h,2400+954/h
    candidate = (Q(7,2)*(b_tail(h-100)*wb+a_tail(h-100,d)*wa)
                 +Q(1,160)*(b_tail(h-200)*wb+a_tail(h-200,d)*wa))/2125
    assert candidate <= Q(t,S), (lo,hi)
    for c in range(lo,hi+1,step):
        assert tail[c] is None
        tail[c] = t
    last[odd] = hi
assert last == {True:149999,False:300000}
print('independent rational cell bounds PASS',len(cells),flush=True)

# Totients and Mobius values from a prime sieve; primitive character counts by
# the DIFFERENT recurrence phi(n)=sum_{d|n} a(d).
phi = list(range(M+1))
mu = [1]*(M+1)
for p in range(2,M+1):
    if phi[p] == p:
        for n in range(p,M+1,p):
            phi[n] -= phi[n]//p
            mu[n] *= -1
        for n in range(p*p,M+1,p*p):
            mu[n] = 0
primitive = phi.copy()
for d in range(1,M+1):
    for n in range(2*d,M+1,d):
        primitive[n] -= primitive[d]
assert all(n>=0 for n in primitive)

plus_numerator = [0]*(M+1)
star_numerator = [0]*(M+1)
gauss = [0]*(M+1)
active = []
for c in range(1,M+1):
    if primitive[c] == 0 or (c%2 and c>150000):
        continue
    active.append(c)
    assert tail[c] is not None
    assert old_star(c)<=old_plus(c)
    assert min(Q(old_star(c)),Q(100000000,c))<=cutoff(c)
    count = ceiling(400*(Q(50,87)*old_star(c)+2))
    for q in range(c,M+1,c):
        if q%2 and q>150000:
            continue
        r = q//c
        if abs(mu[r]) == 1 and gcd(c,r) == 1:
            w = c*primitive[c]
            gauss[q] += w
            plus_numerator[q] += w*tail[c]**2
            star_numerator[q] += w*count

nt = mix_coefficient = at = Q(0)
for q in range(1,M+1):
    if q%2 and q>150000:
        continue
    assert gauss[q] == phi[q]**2
    d = Q(1200000,q*(2 if q%2 else 1))
    et = Q(plus_numerator[q],phi[q]*S*S)
    es = Q(star_numerator[q],phi[q])
    nt += round_up(2*d*et,S)
    mix_coefficient += round_up(et*es,10**6)
    if mu[q]:
        at += round_up(min(Q('381.22'),2*d*Q('1.2534')**2)*et/phi[q]**2,10**30)
mix = mix_coefficient*(49*102000)*Q('5.625e-23')
for k,v in [('N_high_energy',nt),('mixed_high_low_energy',mix),('Aplus_high_energy',at)]:
    assert v == Q(expected[k]['rational']),k
assert len(active)==150000 and sum(primitive[c] for c in active)==5543640188
assert nt<Q('.025') and mix<Q('2.5e-8') and at<Q('1e-20')

# Independent short source-derived Fourier L1 argument. Avoids the separate
# H1-energy23.5 lemma: use Cg<=2.03 and second derivative L2 energy<=368.
assert Q('2.03')*3/Q('3.14') < Q('1.94')
assert Q(368)/(81*Q('3.14')) < Q('1.203')**2
assert Q('1.94')+Q('1.203') < Q('3.5')
assert Q(368)/(3*Q('3.141')*100**3) < Q('.00625')**2
assert 2125**8 < 49*10**25 and 1333**8 < 10**25
assert Q('5.625e-23')**4 * 10**89 > 1
hs,ds,gs = Q(1000,3),Q(12,49),Q(31,10)
star_tail = 2*(b_tail(hs)*(2400+954/hs)
               +a_tail(hs,ds)*(800*gs+106*gs*gs/hs))/1333
assert star_tail < Q('1e-18')
assert star_tail <= Q(expected['star_high_bound']['rational'])

d0,ds = Q('2e-15'),Q('2e-12')
extra = d0*55000+ds*25+ds*87+d0*ds*180000000000
assert extra == Q(expected['mixed_extra_norm']['rational'])
assert 87**2 > 300000*Q('.025')
assert Q('.00016')**2 > Q('2.5e-8')
cross = (Q('.0005')+Q('.00016')+extra)**2
assert cross == Q(expected['Cross_full']['rational'])
assert cross<Q('7e-7')
assert cross+Q(expected['Astar_full']['rational'])<Q('9.5e-7')
for key,cap in [('Aplus_full','5e-7'),('Astar_full','2.5e-7'),('N_full','1.23'),('Ep_full','1e-4')]:
    assert Q(expected[key]['rational'])<Q(cap)

paths=[src/(stem+'.py'),src/(stem+'.json'),src/(stem+'_cells.json')]
note=src/'RESUME_COMMON_HEIGHT_MAJOR_2026-11-11.md'
if note.exists(): paths.append(note)
out={'verdict':'PASS: conditional paper/scalar certificate only; no spectral or Lean certificate',
     'sha256':{str(p.relative_to(here.parent)):hashlib.sha256(p.read_bytes()).hexdigest() for p in paths},
     'cells_independently_rebounded':len(cells),'active_conductors':len(active),
     'primitive_characters':sum(primitive[c] for c in active),
     'N_high_energy':str(nt),'mixed_high_low_energy':str(mix),'Aplus_high_energy':str(at),
     'mixed_extra_norm':str(extra),'Cross_full':str(cross),
     'elapsed_seconds_diagnostic':time.time()-start}
here.joinpath('review_common_height_new_20261111.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
