"""Independently recompute every truncation and roundoff allowance from the saved plan."""
from fractions import Fraction as F
from hashlib import sha256
from math import factorial, prod
import json
from produce import HERE, S, OUT, bernoulli, envelope


def bernoulli_check(bs):
    n=2*len(bs)
    D=2*factorial(n+1)**2
    a=[D,-D//2]
    for x in bs:
        v,rem=divmod(D*x.numerator,x.denominator)
        assert not rem
        a.extend([v,0])
    for order in range(1,n+1):
        value=a[order]
        for k in reversed(range(order)):
            value=a[k]+(order+1-k)*value
        assert not value


def main():
    path=HERE/"integer.json"
    src=json.loads(path.read_bytes())
    out=[]
    for row in src["bands"]:
        hi,f,tasks=row["hi"]-1,row["grid"],row["tasks"]
        h=1+(5*hi+63)//64
        fac=F(1)
        worst=F(0)
        for m,(n,l) in enumerate(tasks):
            x=1+n
            if l:
                bound=F(4*prod(range(h+m,h+m+2*l)),6**(2*l)*x**(m+2*l-1))
            else:
                assert m>=1
                bound=F(1,x**m)*(1+F(2*x,2*m-1))
            worst=max(worst,fac*bound*OUT)
            fac*=F(2*(h+m),f*(m+1))
        numeric=envelope(f,hi,tasks)
        assert worst<F(1,32) and numeric<F(1,64)
        # Two coordinates are independently rounded to the final dyadic grid.
        # Their joint rounding costs sqrt(1/2), bounded above by 3/4.
        total=F(3,4)+worst+numeric
        assert total<1
        bernoulli_check(bernoulli(max(l for _,l in tasks))[1:])
        out.append(dict(band=row["band"],degrees=len(tasks),truncation_ulps=float(worst),
                        arithmetic_ulps=float(numeric),total_ulps=float(total),
                        phase_error_power_of_two=(4*(2*hi+1)).bit_length()-384))
    report=dict(bands=out,source_sha256=sha256(path.read_bytes()).hexdigest(),
                totals={"degrees":sum(b["degrees"] for b in out),
                        "max_total_ulps":max(b["total_ulps"] for b in out)},
                assumptions="Euler–Maclaurin with the even periodic Bernoulli remainder, the standard absolute-series bound, and the documented elementary log/phase error estimates. The saved plans are independently rechecked with exact rational inequalities.")
    (HERE/"bounds-audit.json").write_text(json.dumps(report,indent=2)+"\n")
    print(report["totals"])


if __name__=="__main__":
    main()
