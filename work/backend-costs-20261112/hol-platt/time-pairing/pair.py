"""Count same-conductor, same-precision pairs and check two independent Hermitian lanes."""
import hashlib
import json
import sys
from collections import Counter
from fractions import Fraction as Q
from pathlib import Path
from random import Random
from flint import acb, arb, ctx

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE.parent / "time-pruning"))
from count_time_fft import SOURCE, operation_counts, primitive_count


def check_native():
    ctx.prec = 192
    ctx.threads = 1
    n, j, p = 64, 9, 48
    rng = Random(140373)
    scale = 1 << p
    root = [acb.exp_pi_i(acb(2*i)/n) for i in range(n)]

    def rounded(z):
        def coord(x):
            return arb(int((x*scale + arb(1)/2).mid().floor().unique_fmpz()))/scale
        r = acb(coord(z.real),coord(z.imag))
        assert abs(r-z) < arb(1)/scale
        return r

    def lane():
        a = [acb(0) for _ in range(n)]
        a[0] = rng.randrange(-11,12)
        for i in range(1,j+1):
            a[i] = acb(arb(rng.randrange(-110,111))/8,arb(rng.randrange(-110,111))/8)
            a[-i] = a[i].conjugate()
        return a

    def fft(a):
        if len(a)==1:
            return a
        l,r = fft(a[::2]),fft(a[1::2])
        prod = [rounded(rounded(root[i*n//len(a)])*v) for i,v in enumerate(r)]
        return [rounded((x+sgn*y)/2) for sgn in (1,-1) for x,y in zip(l,prod)]

    a,b = lane(),lane()
    packed = fft([rounded(x+acb(0,1)*y) for x,y in zip(a,b)])
    worst = 0.
    for k,z in enumerate(packed):
        for x,component in [(a,z.real),(b,z.imag)]:
            exact = sum((v*root[(i*k)%n] for i,v in enumerate(x)),acb(0))
            assert exact.imag.contains(0)
            error = abs(n*component-exact.real)
            assert error < arb(n*(2+(n.bit_length()-1)*(2*20+4)))/scale
            worst = max(worst,float(error.upper()))
    return dict(length=n,per_lane_support=j,fractional_bits=p,max_observed_raw_error=worst)


def count():
    data = SOURCE.read_bytes()
    row = json.loads(data)["scenarios"][0]["small_sign_only_conditional_candidate"]
    tilts = dict(row["conductor_theta"])
    totals, alternatives, strata = Counter(), {}, Counter()
    for c,m,n,p,_ in row["raw_metadata"]:
        chars = primitive_count(c)
        pairs,alone = divmod(chars,2)
        k,j = n.bit_length()-1,(25*n+191)//192
        theta = tilts[c]
        B = 2*Q(40_000_000 if c%2 else 80_000_000,theta)**2+1
        eps = Q(1,2**82 * 3**theta)
        u = Q(1,2**p)
        assert B > k and n*(2+k*(2*B+4))*u < 7*eps*n*Q(5,64)/2816
        for key,value in dict(conductors=1,characters=chars,pairs=pairs,
                              singles=alone,pack_real_adds=4*j*pairs,
                              packed_complex_slots=(2*j+1)*pairs,
                              half_lane_pre_rotations=j*chars,
                              half_lane_pack_real_adds=4*j*chars).items():
            totals[key] += value
        strata[(p,n)] += pairs
        for tag,length,outputs,transforms in [
            ("separate_full",n,m+1,chars),("paired_full",n,m+1,pairs+alone),
            ("separate_half",n//2,(m+2)//2,chars)]:
            out = alternatives.setdefault(tag,Counter())
            for key,value in operation_counts(length,j,outputs).items():
                out[key] += transforms*value
    return dict(source_sha256=hashlib.sha256(data).hexdigest(), totals=totals,
                schedule_counts=alternatives, by_precision_length=[
                    dict(bits=p,length=n,pairs=v) for (p,n),v in sorted(strata.items())],
                native_check=check_native())


if __name__ == "__main__":
    (HERE/"counts.json").write_text(json.dumps(count(),indent=2)+"\n")
