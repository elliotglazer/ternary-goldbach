"""Independent exact cyclotomic-ring Bluestein diagnostic; no L-function data."""
import json, math
from fractions import Fraction as F
from pathlib import Path


def trim(a):
    while len(a) > 1 and a[-1] == 0:
        a.pop()
    return a


def divexact(a, b):
    a = a[:]
    q = [0] * (len(a) - len(b) + 1)
    while len(a) >= len(b):
        k = len(a) - len(b)
        c = a[-1]
        assert b[-1] == 1
        q[k] = c
        for j, v in enumerate(b):
            a[k+j] -= c*v
        trim(a)
        if a == [0]:
            break
    assert not any(a)
    return trim(q)


cache = {}
def cyclo(n):
    if n not in cache:
        a = [-1] + [0]*(n-1) + [1]
        for d in range(1, n):
            if n % d == 0:
                a = divexact(a, cyclo(d))
        cache[n] = a
    return cache[n]


class Ring:
    def __init__(self, order):
        self.order = order
        self.mod = cyclo(order)
        self.deg = len(self.mod)-1
        self.zero = (0,)*self.deg
        self.one = (1,) + (0,)*(self.deg-1)
        self.powers = [self.reduce([0]*j+[1]) for j in range(order)]

    def reduce(self, a):
        a = list(a)
        for k in range(len(a)-1, self.deg-1, -1):
            c = a[k]
            if c:
                for j in range(self.deg+1):
                    a[k-self.deg+j] -= c*self.mod[j]
        a = a[:self.deg] + [0]*max(0, self.deg-len(a))
        return tuple(a)

    def add(self, a, b):
        return tuple(x+y for x,y in zip(a,b))

    def scale(self, a, n):
        return tuple(x*n for x in a)

    def mul(self, a, b):
        p = [0]*(2*self.deg-1)
        for i, x in enumerate(a):
            for j, y in enumerate(b):
                p[i+j] += x*y
        return self.reduce(p)

    def root(self, e):
        return self.powers[e % self.order]

    def total(self, seq):
        out = self.zero
        for a in seq:
            out = self.add(out,a)
        return out


def fft_positive(r, a):
    n = len(a)
    assert n & (n-1) == 0
    if n == 1:
        return a[:]
    even = fft_positive(r, a[::2])
    odd = fft_positive(r, a[1::2])
    out = [None]*n
    for k in range(n//2):
        z = r.mul(r.root((r.order//n)*k),odd[k])
        out[k] = r.add(even[k],z)
        out[k+n//2] = r.add(even[k],r.scale(z,-1))
    return out


def check(m):
    n = 1
    while n < 2*m-1:
        n *= 2
    order = math.lcm(2*m,n,4)
    r = Ring(order)
    imag = r.root(order//4)
    x = [r.add(r.scale(r.one,j+1),r.scale(imag,1-j)) for j in range(m)]
    chirp = lambda j: r.root((order//(2*m))*j*j)
    a = [r.zero]*n
    b = [r.zero]*n
    signed_indices = {}
    for j in range(m):
        a[j] = r.mul(x[j],chirp(j))
    for h in range(1-m,m):
        assert h % n not in signed_indices
        signed_indices[h % n] = h
        b[h % n] = r.root(-(order//(2*m))*h*h)
    direct = [r.total(r.mul(x[j],r.root((order//m)*j*k)) for j in range(m)) for k in range(m)]
    conv = [r.total(r.mul(a[j],b[(k-j)%n]) for j in range(n)) for k in range(n)]
    via_conv = [r.mul(chirp(k),conv[k]) for k in range(m)]
    assert via_conv == direct
    fa, fb = fft_positive(r,a), fft_positive(r,b)
    third = fft_positive(r,[r.mul(u,v) for u,v in zip(fa,fb)])
    # Normalized P has three factors 1/n; multiplying by n^2 leaves third/n.
    via_fft_times_n = [r.mul(chirp(k),third[(-k)%n]) for k in range(m)]
    assert via_fft_times_n == [r.scale(z,n) for z in direct]
    direct_fa = [r.total(r.mul(a[j],r.root((order//n)*j*k)) for j in range(n)) for k in range(n)]
    assert fa == direct_fa
    for k in range(m):
        for j in range(m):
            assert signed_indices[(k-j)%n] == k-j
            assert (k*k+j*j-(k-j)**2-2*k*j) % (2*m) == 0
    wrong_scaling_rejected = n == 1 or via_fft_times_n != direct
    wrong_reversal_rejected = m <= 2 or [r.mul(chirp(k),third[k]) for k in range(m)] != [r.scale(z,n) for z in direct]
    assert wrong_scaling_rejected and wrong_reversal_rejected
    return {'m':m,'padding_n':n,'cyclotomic_order':order,'ring_degree':r.deg,
            'direct_chirp_fft_equal':True,'all_signed_indices_checked':m*m,
            'wrong_n_scaling_rejected':n>1,
            'wrong_output_reversal_rejected':m>2}


def scalar_checks():
    count = 0
    for m, d in [(1,0),(1,8),(2,3),(3,3),(5,5),(17,7),(63,8)]:
        n = 2**d
        assert n >= 2*m-1
        for B in [F(0),F(2,7),F(13),F(1000)]:
            for q in [F(1,d+1),F(1,2**30)]:
                # Iterate the actual accepted recurrence rather than its geometric sum.
                def R(M):
                    e = F(0)
                    for _ in range(d):
                        e = (1+q/2)*e+q*M/2+q
                    return e
                ea = q*(B+1)
                ealpha, ebeta = ea+R(B+ea), q+R(1+q)
                A,D = F(m,n)*B,F(2*m-1,n)
                ep = D*ealpha+A*ebeta+ealpha*ebeta+q
                ew = ep+R(A*D+ep)
                final = (1+q)*n*n*ew+q*m*B+q
                a1 = B+1+d*(2*B+3)
                b1 = 1+4*d
                p1 = a1+B*b1+a1*b1+1
                w1 = p1+d*(B+p1+2)
                K = 2*n*n*w1+m*B+1
                assert ealpha <= q*a1 and ebeta <= q*b1
                assert ep <= q*p1 and ew <= q*w1 and final <= q*K
                count += 1
    return {'cases':count,'method':'Exact recurrence iteration, includes nonminimal padding and q=1/(d+1).','all_pass':True}


if __name__ == '__main__':
    result = {'method':'Exact integer arithmetic in Q[zeta_lcm(2m,n,4)]; independent recursive positive radix-two FFT, no producer imports, no floating point.',
              'cases':[check(m) for m in [1,2,3,5,7,8]],
              'scalar_checks':scalar_checks(),
              'scope':'Tiny algebra/index diagnostics only; not a proof of the general algorithm or any L-value.'}
    out = Path(__file__).with_suffix('.json')
    out.write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
    print(json.dumps(result,indent=2))
