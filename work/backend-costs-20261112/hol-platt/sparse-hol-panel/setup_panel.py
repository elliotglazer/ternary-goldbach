from pathlib import Path
import sys,os,json,importlib.util,shutil
from fractions import Fraction
from math import ceil
base=Path(__file__).resolve().parent.parent
q=sys.argv[1]
out=base/"sparse-hol-panel"/q
out.mkdir(exist_ok=True)
d=base/"sparse-full-panel"/q
sys.path.insert(0,str(d))
from spectrum import LABELS,parameters
import grid,repair
sys.path.append(str(base/"full-height-count"))
def module(name,path):
    spec=importlib.util.spec_from_file_location(name,path)
    m=importlib.util.module_from_spec(spec)
    spec.loader.exec_module(m)
    return m
(out/"quant.py").write_text((base/"grid-sign-join/prepare.py").read_text().replace(chr(34)+"packets.txt"+chr(34),chr(34)+"counts.json"+chr(34)))
join=module("quant",out/"quant.py")
join.DATA=d
join.HERE=out
join.main()
pack=module("pack",base/"sparse-count/prepare.py")
main,last,n,j,theta=parameters()
cut,end=main*4096,last*4096
dense=last+257
sparse=json.loads((d/"fractions.json").read_text())
def wr(name,s): (out/name).write_bytes(s.encode())
for label,cert in zip(LABELS,sparse):
    raw=list(map(int,(d/f"grid-{label}.txt").read_text().splitlines()))
    entries=[tuple(map(int,l.split())) for l in (d/f"signs-{label}.tsv").read_text().splitlines()]
    lookup=dict(entries)
    m,mb,mr=pack.region(entries,0,cut,raw,False)
    a,ab,ar=pack.region(entries,cut,end,raw,True)
    pts={t for t,s in m+a}|{0,1,cut-1,cut,end}
    spans={t//4096+128 for t in pts if t%4096==0}
    jobs=[]
    for line in (out/f"jobs-{label}.txt").read_text().splitlines():
        t,k,r,*rest=map(int,line.split())
        if t in pts:
            jobs.append((t,k))
            start=t//4096+129-r//2
            spans.update(range(start,start+r))
    assert len(spans)==cert["raw"]
    blocks=[]
    for i,l in enumerate((out/f"tiles-{label}.txt").read_text().splitlines()):
        w,e,count,*words=map(int,l.split())
        ids=[u for u in range(count) if i*64+u in spans]
        mask=sum(1<<u for u in ids)
        packed=sum(((words[u//4]>>(w*(u%4)))%2**w)<<(w*t) for t,u in enumerate(ids))
        blocks.append(f"{mask} {w} {e} {packed:x}")
    wr(f"heads-{label}.txt","\n".join(blocks)+"\n")
    for tag,rows in [("main",mb),("aux",ab),("jobs",jobs)]:
        wr(f"{tag}-{label}.txt","".join(f"{x} {y}\n" for x,y in rows))
    target=[int(mr["first_positive"]),int(ar["first_positive"]),1+int(lookup[0]>0),1+int(lookup[cut]>0),mr["brackets"],mr["weight"],ar["brackets"],ar["weight"]]
    wr(f"target-{label}.txt"," ".join(map(str,target))+"\n")
proj=(base/"sparse-head/projprep.py").read_text().split("hol=(H/")[0]
proj=proj[proj.index("records=0"):].replace("prepare.labels","LABELS").replace("prepare.OLD","d").replace("prepare.write","wr")
total=sum(x["raw"] for x in sparse)
exec(proj.replace("71325",str(total)),dict(H=out,P=base/"grid-projection",LABELS=LABELS,d=d,wr=wr))


