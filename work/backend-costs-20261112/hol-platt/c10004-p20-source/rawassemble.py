"""Bind raw head and mixed-grid output; independently compute scalar spectrum and error."""
import csv,json,sys
from collections import Counter
from pathlib import Path
from flint import acb,arb,ctx

HERE=Path(__file__).resolve().parent
OLD=HERE.parent/"c10004-real-transform"
sys.path.insert(0,str(OLD))
import reference as ct
ctx.prec=176


def load(path):
    with path.open() as f:
        return list(csv.DictReader(f,delimiter="\t"))


def write(path,fields,rows):
    with path.open("w",newline="") as f:
        w=csv.writer(f,delimiter="\t",lineterminator="\n")
        w.writerow(fields)
        w.writerows(rows)


def run():
    heads=load(HERE/"h1-rawhead.tsv")
    local=json.loads((HERE/"h1-horner.json").read_bytes())
    direct=load(HERE.parent/"c10004-reference/h1.tsv")
    rows=[]
    radii=[]
    gaps=[]
    for (i,a,k,x,y),head,old in zip(local,heads,direct,strict=True):
        assert i==int(head["index"])==int(old["index"]) and a==int(head["a"])==int(old["a"])
        pair=[((v<<6)+int(head[key])+(1<<18))>>19 for v,key in zip((x,y),("re","im"))]
        gap=ct.upnorm(pair[0]-int(old["re"]),pair[1]-int(old["im"]))
        radii.append(1+gap)
        gaps.append(gap)
        rows.append((i,a,*pair))
    write(HERE/"h1-rawassembled.tsv",["index","a","re","im"],rows)
    centers=[(x,y) for _,_,x,y in rows]
    ys=ct.tensor(centers,lambda r:ct.ct(r,True,Counter()))
    balls=ct.tensor([(x,y,e) for (x,y),e in zip(centers,radii)],ct.direct_balls)
    oldspec=load(OLD/"h1-spectrum.tsv")
    oldsign=load(OLD/"h1-completed.tsv")
    s=acb(arb(1)/2,arb(5)/64)
    factors=[abs((acb(10004)/arb.pi())**((s+p)/2)*((s+p)/2).gamma()*acb(10004)**(-s)) for p in (0,1)]
    spectra=[]
    for i,((x,y),(xx,yy,e),old,sign) in enumerate(zip(ys,balls,oldspec,oldsign,strict=True)):
        k,l=1+i//59,1+i%59
        assert (k,l)==(int(old["k41"]),int(old["k61"]))==(int(sign["k41"]),int(sign["k61"]))
        rad=e+ct.upnorm(x-xx,y-yy)
        gap=ct.upnorm(x-int(old["re"]),y-int(old["im"]))
        # Old completed interval bounds the true value; its sign margin dominates
        # diameter of the new square box after completion (unit-modulus phase).
        margin=abs(arb(sign["real_ball"])).lower()
        assert margin>factors[(1+k+l)%2]*3*rad/(1<<81)
        spectra.append([k,l,x,y,rad,gap,int(sign["sign"])])
    write(HERE/"h1-rawspectrum.tsv",["k41","k61","re","im","abs_error_grid_units",
                                    "eager_center_gap_grid_units","sign"],spectra)
    print(dict(changed_direct_inputs=sum(bool(x) for x in gaps),source_radius_sum=sum(radii),
               max_spectrum_rad=max(r[4] for r in spectra),max_eager_center_gap=max(r[5] for r in spectra)))


if __name__=="__main__":
    run()
