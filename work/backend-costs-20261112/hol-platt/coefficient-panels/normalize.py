"""Test a unit-radius coordinate to lower the absolute precision required of Taylor seeds."""
from fractions import Fraction
from math import comb
from pathlib import Path
import json

from flint import acb,arb,ctx
from panel import HERE,ORDER,OUTPUT_BITS,nearest,seed


def parameters(f,last,group):
    radius=group//2
    height=1+(5*last+63)//64
    for degree in range(32,401,4):
        m=degree+1
        size=Fraction(2)
        # Bound the first omitted coefficient of zeta(s,a+R*u/f) on |u|<=1.
        for j in range(m):
            size*=Fraction(radius*(height+j),f*(j+1))
        tail=Fraction(0)
        amplify=Fraction(0)
        for k in range(ORDER):
            ratio=Fraction(radius*(height+m),f*(m+1-k))
            if ratio>=1:
                break
            scale=Fraction(2,radius)**k
            tail=max(tail,size*comb(m,k)*scale/(1-ratio))
            amplify=max(amplify,comb(m,k+1)*scale)
        else:
            if tail>=Fraction(1,1<<111):
                continue
            p=111
            while amplify >= Fraction(1<<(p-111)):
                p+=1
            assert tail+amplify/(1<<p) < Fraction(1,1<<110)
            return degree,p,float((tail+amplify/(1<<p))*(1<<OUTPUT_BITS))
    raise ArithmeticError((f,last,group))


def supplied(f,center,j,r,degree,p):
    s=acb(arb(1)/2,arb(j*5)/64)
    a=1+arb(center)/f
    factor=acb(1)
    coeff=[]
    for k in range(degree+1):
        z=factor*(s+k).zeta(a)
        x,y=nearest(z.real,p),nearest(z.imag,p)
        assert abs(z*(1<<p)-acb(x,y))<1
        coeff.append((x,y))
        factor*=-(s+k)*r/(f*(k+1))
    return coeff


def translated(coeff,r,d,p):
    degree=len(coeff)-1
    denominator=(1<<(p-OUTPUT_BITS))*r**degree
    ans=[]
    for k in range(ORDER):
        ws=[comb(m,k)*d**(m-k)*(1<<k)*r**(degree-m) for m in range(k,degree+1)]
        ans.append(tuple((sum(w*z[part] for w,z in zip(ws,coeff[k:],strict=True))+denominator//2)//denominator
                         for part in (0,1)))
    return ans


def main():
    ctx.prec,ctx.threads=440,1
    bands=json.loads((HERE/"panels.json").read_bytes())["bands"]
    variants=[]
    for g in (16,64,128):
        r=g//2
        rows=[]
        for b in bands:
            f=b["f"]
            deg,p,err=parameters(f,b["hi"]-1,g)
            rec=b["panels"][1]
            base=rec["first_cell"]//g*g
            coeff=supplied(f,base+r,rec["j"],r,deg,p)
            # Four direct Hurwitz references use the original coordinate system.
            worst=0
            for ix in (0,g//3,2*g//3,g-1):
                direct=seed(f,base+ix,rec["j"],ORDER-1,OUTPUT_BITS)
                got=translated(coeff,r,ix-r,p)
                worst=max(worst,max(abs(a-d) for x,y in zip(got,direct,strict=True) for a,d in zip(x,y,strict=True)))
            assert worst<=1
            count=(b["hi"]-b["lo"])*(f//g)
            rows.append(dict(band=b["band"],degree=deg,seed_fraction_bits=p,error_in_output_units=err,
                max_coordinate_delta=worst,groups=count,seeds=count*(deg+1),
                max_actual_signed_coefficient_bits=max(abs(t).bit_length()+1 for z in coeff for t in z)))
        variants.append(dict(group_width=g,groups=sum(x["groups"] for x in rows),
                             seeds=sum(x["seeds"] for x in rows),bands=rows))
    (HERE/"normalized.json").write_text(json.dumps(variants,indent=2)+"\n")
    print([(v["group_width"],v["seeds"],[r["seed_fraction_bits"] for r in v["bands"]]) for v in variants])


if __name__=="__main__":
    main()
