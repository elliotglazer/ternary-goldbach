"""Bind the original 220-bit-grid samples to their block-floating heads."""
from hashlib import sha256
import json
from pathlib import Path
from time import process_time

HERE=Path(__file__).resolve().parent
JOIN=HERE.parent/"grid-sign-join"
DATA=HERE.parent/"full-height-count"
BASE=1<<256
BIAS=BASE//2


def main():
    start=process_time()
    records=json.loads((JOIN/"inputs.json").read_bytes())["results"]
    with (HERE/"source.hex").open("w",newline="\n") as f:
        for r in records:
            ident=r["label"]
            grid=DATA/("grid-%d.txt"%ident)
            short=JOIN/("tiles-%d.txt"%ident)
            assert sha256(grid.read_bytes()).hexdigest()==r["input_sha256"]
            assert sha256(short.read_bytes()).hexdigest()==r["tiles_sha256"]
            raw=list(map(int,grid.read_text().splitlines()))
            pos=0
            for k,line in enumerate(short.read_text().splitlines()):
                w,e,n,*words=map(int,line.split())
                xs=raw[pos:pos+n]
                assert len(xs)==n and len(words)==(n+3)//4
                packed=[]
                for l in range(0,n,4):
                    vals=xs[l:l+4]
                    assert all(-BIAS<=x<BIAS for x in vals)
                    z=sum((x+BIAS)<<(256*j) for j,x in enumerate(vals))
                    head=words[l//4]
                    for j,x in enumerate(vals):
                        q=((head>>(j*w))% (1<<w))-(1<<(w-1))
                        assert x//(1<<e)==q and (z>>(256*j))%BASE==BIAS+x
                    packed.append(z)
                f.write(" ".join(map(str,[ident,k,w,e,n]))+"\n")
                f.write(" ".join(format(z,"x") for z in packed)+"\n")
                f.write(" ".join(map(str,words))+"\n")
                pos+=n
            assert pos==len(raw)
    digest=sha256((HERE/"source.hex").read_bytes()).hexdigest()
    out=dict(source_sha256=digest,tiles=sum(r["tiles"] for r in records),samples=sum(r["samples"] for r in records),
             input_sha256=sha256((JOIN/"inputs.json").read_bytes()).hexdigest(),cpu=process_time()-start)
    (HERE/"source.json").write_text(json.dumps(out,indent=2)+"\n")
    print(out)


if __name__=="__main__":
    main()
