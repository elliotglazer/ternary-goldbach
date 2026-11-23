"""Check the scale converting archived Hurwitz amplitudes to Gaussian repair data.

Compare native interval receipts at q=10004. At a midpoint, the experiment
uses only nearby Hurwitz coarse amplitudes as interpolation samples. The
rigorous derivative bound comes from the independent dyadic Fourier spectrum;
using it has a separate production cost. No new analytic theorem is assumed
proved in HOL4 by these numerical tests.
"""
import csv
from fractions import Fraction as F
from hashlib import sha256
import gzip
from math import factorial, prod
from pathlib import Path
import json

from flint import arb, ctx

from endpoint_policy import HERE, HOL, TEAM


def ball(x):
    x=F(x)
    return arb(x.numerator)/x.denominator


def lagrange(nodes,x):
    return [prod((x-u)/F(v-u) for u in nodes if v!=u) for v in nodes]


def main():
    ctx.prec,ctx.threads=256,1
    folder=TEAM/'q10004-gaussian'
    sources=HOL/'c10004-grid-repair'
    frozen=json.loads((TEAM/'q10004-freeze.json').read_bytes())
    meta=json.loads((folder/'spectrum.json').read_bytes())
    grid=json.loads((folder/'grid.json').read_bytes())
    phase=json.loads((folder/'crosscheck.json').read_bytes())['per_character_phase_sign_relative_to_frozen']
    q,n,theta,last=meta['q'],meta['N'],meta['theta'],meta['final']
    dt=F(5,64)
    omega=2*arb.pi()/(n*ball(dt))
    eps=ball(F(1,4*2**80*3**theta))
    analytic=3*eps/(4*omega)
    by_frequency={tuple(idx):(lab,a) for a,gr in enumerate(['even','odd'])
                  for idx,lab in zip(frozen[gr]['frequency'],frozen[gr]['labels'],strict=True)}
    halos=grid['halo']
    gaussian={}
    for row in grid['rows']:
        lab=row['label']
        data=(folder/f'grid-{lab}.txt').read_bytes()
        assert sha256(data).hexdigest()==row['grid_sha256']
        gaussian[lab]=list(map(int,data.splitlines()))

    def scale(lab,a,j):
        # exp(b*t - pi*t/4) = exp(-theta*j/last); k=(1+2a)/2.
        return phase[str(lab)]*(-theta*ball(j)/last).exp()*arb(q)**(-arb(1+2*a)/4)/omega

    orders=[8,12,16,24,32]
    # Integer moment sums avoid an interval calculation at every frequency.
    moments={lab:{r:0 for r in orders} for lab in meta['labels']}
    coeff=(folder/'coefficients.tsv').read_bytes()
    assert sha256(coeff).hexdigest()==meta['sha256']['coefficients.tsv']
    for line in coeff.splitlines():
        j,*values=map(int,line.split())
        if j==0: continue
        for r in orders:
            power=j**r
            for col,lab in enumerate(meta['labels']):
                moments[lab][r]+=power*(abs(values[2*col])+abs(values[2*col+1]))
    derivative={lab:{r:arb(value)*2*(2*arb.pi()/n)**r/(1<<meta['bits'])
                     for r,value in ms.items()} for lab,ms in moments.items()}
    cases=[]
    hashes={}
    for tag in ('low','high'):
        path=sources/f'{tag}-signs.tsv.gz'
        hashes[path.name]=sha256(path.read_bytes()).hexdigest()
        packets={lab:{} for lab in meta['labels']}
        relatives=[]
        with gzip.open(path,'rt',newline='') as stream:
            for row in csv.DictReader(stream,delimiter='\t'):
                freq=int(row['k41']),int(row['k61'])
                if freq not in by_frequency: continue
                lab,a=by_frequency[freq]
                j=int(row['j'])
                model=arb(row['scaled_value'])*scale(lab,a,j)
                target=arb((gaussian[lab][halos+j],-grid['bits']))
                margin=analytic+ball(F(2,2**grid['bits']))
                assert (model-target).abs_lower() <= margin
                assert model>0 or model<0
                # Interpolation operates on the exact finite polynomial. Its
                # value is within the analytic comparison radius of the scaled
                # true Hardy amplitude represented by the Hurwitz interval.
                packets[lab][j]=model+arb(0,analytic)
                relatives.append(float((model.rad()/abs(model).abs_lower()).upper()))
        passes=[]
        for lab,values in packets.items():
            for order in orders:
                lo,hi=min(values),max(values)
                off=list(range(1-order//2,1+order//2))
                ws=list(map(ball,lagrange(off,F(1,2))))
                rem=derivative[lab][order]*ball(abs(prod(F(1,2)-u for u in off))/factorial(order))
                tried=resolved=0
                for left in range(lo-min(off),hi-max(off)+1):
                    interp=sum((w*values[left+u] for w,u in zip(ws,off,strict=True)),arb(0))
                    interval=interp+arb(0,rem+analytic)
                    tried+=1
                    resolved+=int(interval>0 or interval<0)
                if tried:
                    passes.append(dict(label=lab,order=order,tried=tried,strict=resolved))
        cases.append(dict(tag=tag,coordinates=len(relatives),worst_relative_radius=max(relatives),
                          midpoint_tests=passes))
    result=dict(scope='Native conditional interval cross-check; absolute derivative moments use the independent Gaussian coefficient file.',
                script_sha256=sha256(Path(__file__).read_bytes()).hexdigest(),
                source_sha256=hashes,gaussian_spectrum_sha256=meta['sha256']['coefficients.tsv'],cases=cases)
    (HERE/'repair-amplitudes.json').write_text(json.dumps(result,indent=2)+'\n')
    for case in cases:
        print(case['tag'],case['coordinates'],case['worst_relative_radius'],
              [(r,sum(x['strict'] for x in case['midpoint_tests'] if x['order']==r),
                  sum(x['tried'] for x in case['midpoint_tests'] if x['order']==r)) for r in orders])


if __name__=='__main__':
    main()
