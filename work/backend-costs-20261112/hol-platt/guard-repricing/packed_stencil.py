"""Test signed Kronecker substitution on the actual twelve-node dot products."""
from hashlib import sha256
from pathlib import Path
import json

HERE=Path(__file__).resolve().parent
ORDER=12
BASE=1<<48


def pack(values):
    return sum(v*BASE**i for i,v in enumerate(values))


def dot_from_product(v,w):
    product=pack(v)*pack(reversed(w))
    # In the polynomial product every coefficient is bounded by this
    # quantity, including partial overlaps at the ends.
    limit=ORDER*max(map(abs,v))*max(map(abs,w))
    assert 2*limit<BASE-1
    place=BASE**(ORDER-1)
    nearest=(product+place//2)//place
    centered=(nearest+BASE//2)%BASE-BASE//2
    return centered


def main():
    wtable={}
    counts={}
    for name in ('stress','holdout'):
        raw=(HERE/f'strip-repair-packets-{name}.tsv').read_bytes()
        rows,passed,passed_coarse=0,0,0
        for line in raw.splitlines():
            q,label,tick,sub,exp,bits,err,sign,*a=map(int,line.split())
            v,w=a[:ORDER],a[ORDER:]
            assert len(v)==len(w)==ORDER
            d=dot_from_product(v,w)
            assert d==sum(x*y for x,y in zip(v,w))
            assert dot_from_product([-v0 for v0 in v],w)==-d
            true_threshold=2*err+2*sum(map(abs,w))+sum(map(abs,v))+ORDER
            # One universal coefficient-rounding allowance removes the need
            # to export or recompute sum |v_i| per row in this application.
            simple_threshold=2*err+2*sum(map(abs,w))+ORDER*((1<<16)+1)
            passed+=int(2*sign*d>true_threshold)
            passed_coarse+=int(2*sign*d>simple_threshold)
            k=pack(reversed(w))
            if k in wtable:
                assert wtable[k]==w
            wtable[k]=w
            rows+=1
        counts[name]=dict(sha256=sha256(raw).hexdigest(),rows=rows,signs=passed,
                          signals_after_uniform_sample_bound=passed_coarse)
    out=dict(scope='Exact native arithmetic on authentic short packets; formal proof of the packed representation, source projection, and timing in HOL4 are separate.',base=BASE,
             rows=counts,distinct_packed_weights=len(wtable),
             max_packed_weight_bits=max(abs(k).bit_length() for k in wtable))
    (HERE/'packed-stencil.json').write_text(json.dumps(out,indent=2)+'\n')
    print(out)


if __name__=='__main__':
    main()
