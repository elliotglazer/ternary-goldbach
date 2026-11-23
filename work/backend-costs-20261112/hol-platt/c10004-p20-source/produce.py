"""Band-1 P27 finite EM, rounded midpoint translation, and K20/b94 replay inputs."""
from pathlib import Path
from math import factorial
from time import process_time,perf_counter
import hashlib,json
from flint import arb,acb,fmpq,ctx

HERE=Path(__file__).resolve().parent
D,N,P,Q=512,220,27,10004
UNIT=1<<122
GRIDS=[94,94,94,94,91,89,89,89,83,81,81,81,75,73,73,73,65,65,65,65]
ctx.prec=200
ctx.threads=1
S=acb(arb(1)/2,arb(5)/64)


def nearest(a,b):
    return (2*a+b)//(2*b)


def pair_times(z,re,im,den):
    x,y=z
    return nearest(x*re-y*im,den),nearest(x*im+y*re,den)


def plus(x,y):
    return (x[0]+y[0],x[1]+y[1])


def dyadic(z,p):
    result=[]
    for x in (z.real,z.imag):
        scaled=x*(1<<p)
        v=(scaled+arb(1)/2).floor().unique_fmpz()
        assert v is not None and abs(scaled-v)<arb(1)/2
        result.append(int(v))
    return tuple(result)


def to_ball(z,p):
    return acb(arb(z[0])/(1<<p),arb(z[1])/(1<<p))


def coarse(i,rising,lambdas,gammas):
    length=P if i<D else 20
    z=D+i
    b=z+N*D
    sums=[(0,0)]*length
    for n in range(N+1):
        x=z+n*D
        term=dyadic((arb(x)/D)**(-S),122)
        if n==N:
            endpoint=term
            break
        for k in range(length):
            sums[k]=plus(sums[k],term)
            if k+1<length:
                term=pair_times(term,D,0,x)
    E=[(UNIT,0)]
    for ell in range(length+126):
        E.append(pair_times(E[-1],D*(32+64*ell),D*5,64*6*b))
    values=[]
    for k in range(length):
        correction=(0,0)
        for r,g in enumerate(gammas,1):
            correction=plus(correction,pair_times(E[k+2*r-1],g,0,UNIT))
        v=64*k-32
        Z=plus(pair_times(E[k],b*64*v,-b*64*5,D*(v*v+25)),
               plus(pair_times(E[k],1,0,2),pair_times(correction,1,0,6)))
        F=pair_times(Z,lambdas[k],0,UNIT)
        values.append(plus(pair_times(sums[k],*rising[k],UNIT),
                           pair_times(endpoint,*F,UNIT)))
    return values


def shifted(coef):
    a=coef.copy()
    gates=0
    for i in range(25,-1,-1):
        for j in range(i,min(25,i+19)+1):
            a[j]=tuple(nearest(2*x+y,2<<12)<<12 for x,y in zip(a[j],a[j+1]))
            gates+=1
    assert gates==330
    return a[:20]


def emit(name,data):
    path=HERE/name
    path.write_bytes((json.dumps(data,separators=(",",":"))+"\n").encode())
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    start=perf_counter(),process_time()
    rising=[(UNIT,0)]
    lambdas=[UNIT]
    truth=[acb(1)]
    for k in range(P-1):
        rising.append(pair_times(rising[-1],-(32+64*k),-5,D*64*(k+1)))
        lambdas.append(nearest(-6*lambdas[-1],D*(k+1)))
        truth.append(-truth[-1]*(S+k)/(D*(k+1)))
    gammas=[]
    for r in range(1,65):
        g=fmpq.bernoulli(2*r)*6**(2*r)/factorial(2*r)
        gammas.append(nearest(int(g.p)*UNIT,int(g.q)))
    original,mixed,seeds={},{},{}
    max_seed=0.
    for i in range(D+1):
        values=coarse(i,rising,lambdas,gammas)
        seeds[i]=values
        for k,z in enumerate(values):
            err=abs(to_ball(z,122)-truth[k]*(S+k).zeta(1+arb(i)/D))
            assert err < arb(1)/2**102
            max_seed=max(max_seed,float(err.upper()))
        anchors=[(2*i,values[:20])]
        if i<D:
            anchors.append((2*i+1,shifted(values)))
        for j,row in anchors:
            original[j]=row
            mixed[j]=[[nearest(x,1<<(122-b)) for x in z] for b,z in zip(GRIDS,row)]
    hashes={name:emit(name,obj) for name,obj in [
        ("h1-coarse-grid122.json",seeds),("h1-p20-grid122.json",original),("h1-mixed.json",mixed)]}
    worst=0.
    results=[]
    for idx in range(4800):
        a=(2501*(1+2*(idx%2))+4880*pow(6,(idx//2)%40,41)+2624*pow(2,idx//80,61))%Q
        j=(2048*a+10003)//20008
        num=1024*a-j*Q
        den=2*Q
        assert 4*abs(num)<=den
        v=mixed[j][-1]
        for k in range(18,-1,-1):
            factor=num*(1<<(GRIDS[k]-GRIDS[k+1]))
            v=plus(mixed[j][k],pair_times(v,factor,0,den))
        err=abs(to_ball(v,94)-S.zeta(1+arb(a)/Q))
        assert 633*err < arb(1)/2**82
        worst=max(worst,float(err.upper()))
        results.append([idx,a,j,*v])
    hashes["h1-horner.json"]=emit("h1-horner.json",results)
    emit("receipt.json",dict(generator_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
         hashes=hashes,coarse_coefficients=512*27+20,midpoint_updates=512*330,
         max_coarse_error=max_seed,max_local_endpoint_error=worst,
         wall_seconds=perf_counter()-start[0],cpu_seconds=process_time()-start[1]))


if __name__=="__main__":
    main()
