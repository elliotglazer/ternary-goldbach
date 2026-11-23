"""Pack only retained raw samples and express requested coarse signs at original indices."""
from hashlib import sha256
from pathlib import Path
import json
import sys
sys.path.insert(0,str(Path(__file__).resolve().parent.parent/"sparse-count"))
import prepare

here=Path(__file__).resolve().parent
src=prepare.HERE
def witnesses(path,prev,sgn):
    for line in path.read_text().splitlines():
        n,code=map(int,line.split())
        for _ in range(n):
            code,tag=divmod(code,256)
            if tag==255:
                code,t=divmod(code,1<<32)
            else:
                t=(prev//4096+tag)*4096
            assert t>prev
            yield t,sgn
            prev,sgn=t,1-sgn
        assert code==0

def main():
    meta=json.loads((src/"inputs.json").read_text())
    log=[]
    with (here/"stream.txt").open("w",newline="\n") as out:
        for info in meta["channels"]:
            lab=info["label"]
            rawpath=src/f"raw-{lab}.txt"
            assert sha256(rawpath.read_bytes()).hexdigest()==info["hashes"]["raw"]
            full=list(map(int,(prepare.OLD/f"grid-{lab}.txt").read_text().splitlines()))
            wanted={}
            for prefix,lo in [("main",0),("aux",prepare.CUT)]:
                for t,s in witnesses(src/f"{prefix}-{lab}.txt",lo,int(info[prefix]["first_positive"])):
                    if t%4096==0: wanted[128+t//4096]=s
            for t in (0,prepare.CUT,prepare.LAST):
                i=128+t//4096
                wanted[i]=int(full[i]>0)
            seen=0
            for tile,line in enumerate(rawpath.read_text().splitlines()):
                mask,*tokens=line.split()
                keep=int(mask)
                values=list(map(lambda x:int(x,16),tokens))
                indices=[64*tile+i for i in range(64) if keep>>i&1]
                assert len(values)==len(indices)
                assert all(v==full[i]+(1<<255) for i,v in zip(indices,values))
                want=sum(1<<(i%64) for i in indices if i in wanted)
                pos=sum(wanted[i]<<(i%64) for i in indices if i in wanted)
                seen+=want.bit_count()
                for i in indices:
                    if i in wanted:
                        assert abs(full[i])>519575974158995 and (full[i]>0)==bool(wanted[i])
                words=[sum(v<<(256*j) for j,v in enumerate(values[k:k+4])) for k in range(0,len(values),4)]
                print(lab,tile,keep,want,pos,len(values),*(format(w,"x") for w in words),file=out)
            assert seen==len(wanted)==info["coarse"]
            log.append([lab,info["required_raw"],seen])
    print(log)
    (here/"manifest.json").write_text(json.dumps(dict(channels=log,stream_sha256=sha256((here/"stream.txt").read_bytes()).hexdigest()),indent=2)+"\n")
if __name__=="__main__": main()
