"""p307 fixed-grid Bluestein for one actual conductor-10000 Gauss-sum axis."""
import csv
import json
from pathlib import Path
from time import perf_counter,process_time
from flint import acb, arb, ctx

ctx.prec=416
ctx.threads=1
here=Path(__file__).resolve().parent
n,P=500,1024
S=1<<307
times={}
def begin():
    return perf_counter(),process_time()
def end(name,pair):
    times[name]=dict(wall=perf_counter()-pair[0],cpu=process_time()-pair[1])


def quantize(z):
    result=[]
    for a in (z.real,z.imag):
        x=a*S
        m=(x+arb(1)/2).floor().unique_fmpz()
        assert m is not None and abs(x-m)<arb(1)/2
        result.append(int(m))
    return tuple(result)


def cached(z):
    a,b=z
    return a,b,a+b,b-a


def multiply(c,z):
    a,b,ap,bm=c
    x,y=z
    t=a*(x+y)
    return (t-y*ap+S//2)//S,(t+x*bm+S//2)//S


def fft(values,roots):
    out=[(0,0)]*P
    for j,z in enumerate(values):
        out[int(f'{j:010b}'[::-1],2)]=z
    width=2
    while width<=P:
        for base in range(0,P,width):
            for j in range(width//2):
                i=base+j
                a,b=out[i]
                c,d=multiply(roots[j*(P//width)],out[i+width//2])
                out[i]=(a+c,b+d)
                out[i+width//2]=(a-c,b-d)
        width*=2
    return out


def apply(xs,chirps,positive,negative,kernel):
    t=begin()
    inputs=[multiply(chirps[j],x) for j,x in enumerate(xs)]+[(0,0)]*(P-n)
    end('prechirp',t)
    t=begin()
    forward=fft(inputs,positive)
    end('positive_fft',t)
    t=begin()
    product=[multiply(c,z) for c,z in zip(kernel,forward)]
    end('normalized_pointwise',t)
    t=begin()
    backward=fft(product,negative)
    end('negative_fft_no_divide',t)
    t=begin()
    ys=[multiply(chirps[j],backward[j]) for j in range(n)]
    end('postchirp',t)
    return ys


def run():
    t=begin()
    # Fix both mod-16 coordinates to zero (unit residue 1), vary 2^j mod625.
    residues=[1+16*((pow(2,j,625)-1)*pow(16,-1,625)%625) for j in range(n)]
    assert len(set(residues))==n
    exact=[acb.exp_pi_i(acb(2*r)/10000) for r in residues]
    xs=[quantize(z) for z in exact]
    end('gauss_axis_input',t)
    t=begin()
    chirp=[acb.exp_pi_i(acb((j*j)%(2*n))/n) for j in range(n)]
    chirps=[cached(quantize(z)) for z in chirp]
    positive=[cached(quantize(acb.exp_pi_i(acb(2*j)/P))) for j in range(P//2)]
    negative=[cached((a,-b)) for a,b,*_ in positive]
    end('chirps_and_fft_roots',t)
    t=begin()
    b=[acb(0) for _ in range(P)]
    for j,z in enumerate(chirp):
        b[j]=z.conjugate()
        if j:
            b[P-j]=z.conjugate()
    # FLINT inverse DFT is positive-exponent and already divides by P.
    norm=acb.dft(b,inverse=True)
    assert norm[1].overlaps(sum((z*acb.exp_pi_i(acb(2*j)/P) for j,z in enumerate(b)),acb(0))/P)
    kernel=[cached(quantize(z)) for z in norm]
    end('normalized_kernel_and_one_direct_slot_check',t)
    with (here/'kernel.tsv').open('w',newline='') as f:
        writer=csv.writer(f,delimiter='\t',lineterminator='\n')
        writer.writerow(('index','re','im','re_plus_im','im_minus_re'))
        writer.writerows((j,*z) for j,z in enumerate(kernel))
    t=begin()
    ys=apply(xs,chirps,positive,negative,kernel)
    end('warm_apply',t)
    t=begin()
    ang=[acb.exp_pi_i(acb(2*j)/n) for j in range(n)]
    worst=0
    with (here/'outputs.tsv').open('w',newline='') as f:
        writer=csv.writer(f,delimiter='\t',lineterminator='\n')
        writer.writerow(('index','re','im','absolute_error_grid_units'))
        for k,(a,b) in enumerate(ys):
            ref=sum((z*ang[(j*k)%n] for j,z in enumerate(exact)),acb(0))
            err=abs(acb(a,b)-S*ref)
            bound=int(err.upper().ceil().unique_fmpz())
            worst=max(worst,bound)
            writer.writerow((k,a,b,bound))
    end('independent_500_direct_ball_dots',t)
    print(json.dumps(dict(n=n,P=P,p=307,reference_precision=ctx.prec,max_abs_error_grid_units=worst,
        root_and_kernel_each_abs_error_less_than='2^-307',time=times),indent=2))


if __name__=='__main__':
    run()
