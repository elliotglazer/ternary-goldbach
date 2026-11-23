"""Independent scalar inputs and expected character outputs across consecutive heights."""
import csv
import hashlib
import importlib.util
import json
from collections import Counter
from pathlib import Path
from time import perf_counter,process_time
from flint import acb,arb,ctx

HERE=Path(__file__).resolve().parent
BASE=HERE.parent/"c10004-reference"
TRANSFORM=HERE.parent/"c10004-real-transform"


def load(name,path):
    spec=importlib.util.spec_from_file_location(name,path)
    module=importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    src=load("hurwitz_reference",BASE/"reference.py")
    ct=load("scalar_reference",TRANSFORM/"reference.py")
    ctx.prec,ctx.threads=176,1
    a_values=[src.residue(i%2,i//2%40,i//80) for i in range(4800)]
    expected={node["h"]:node["sha256"] for node in json.loads((BASE/"receipt.json").read_text())["nodes"]}
    report=dict(source= digest(BASE/"reference.py"),scalar_transform=digest(TRANSFORM/"reference.py"),
                roots=digest(ct.ROOTFILE),script=digest(Path(__file__)),threads=1,precision_bits=176,nodes=[])
    for h in range(1,33):
        node=dict(h=h,reused=h<3)
        start,cpu=perf_counter(),process_time()
        f=HERE/f"h{h}.tsv"
        if h<3:
            raw=(BASE/f.name).read_bytes()
            assert hashlib.sha256(raw).hexdigest()==expected[h]
            f.write_bytes(raw)
            data=[tuple(map(int,r)) for r in csv.reader(raw.decode().splitlines()[1:],delimiter="\t")]
            assert all((idx,a)==(i,a_values[i]) for i,(idx,a,_,_) in enumerate(data))
            xs=[(re,im) for _,_,re,im in data]
        else:
            s=acb(arb(1)/2,arb(5*h)/64)
            xs=[]
            with f.open("w",newline="") as file:
                writer=csv.writer(file,delimiter="\t",lineterminator="\n")
                writer.writerow(["index","a","re","im"])
                for i,a in enumerate(a_values):
                    z=s.zeta(acb(arb(a)/10004))
                    pair=(src.rounded(z.real),src.rounded(z.imag))
                    xs.append(pair)
                    writer.writerow([i,a,*pair])
        node.update(source_cpu=process_time()-cpu,source_wall=perf_counter()-start,source_sha256=digest(f))
        assert len(xs)==4800 and all(abs(v)<2**95 for row in xs for v in row)
        start,cpu=perf_counter(),process_time()
        c=Counter()
        ys=ct.tensor(xs,lambda row:ct.ct(row,True,c))
        node.update(ct_cpu=process_time()-cpu,ct_wall=perf_counter()-start)
        assert len(ys)==2301 and all(abs(v)<2**112 for row in ys for v in row)
        f=HERE/f"h{h}-spectrum.tsv"
        with f.open("w",newline="") as file:
            writer=csv.writer(file,delimiter="\t",lineterminator="\n")
            writer.writerow(["k41","k61","re","im"])
            writer.writerows((1+i//59,1+i%59,*z) for i,z in enumerate(ys))
        if h<3:
            with (TRANSFORM/f.name).open() as file:
                older=[(int(r["re"]),int(r["im"])) for r in csv.DictReader(file,delimiter="\t")]
            assert ys==older
        node["spectrum_sha256"]=digest(f)
        report["nodes"].append(node)
        (HERE/"receipt.json").write_text(json.dumps(report,indent=2)+"\n")


if __name__=="__main__":
    main()
