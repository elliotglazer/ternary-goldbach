from pathlib import Path
import json,hashlib
p=Path(__file__).resolve().parent
lines=(p/'retained.hex').read_text().splitlines()
fields={}
for i in range(0,len(lines),3):
    lab,ix,mask,w,e,n=map(int,lines[i].split())
    raw=[int(v,16) for v in lines[i+1].split()]
    heads=list(map(int,lines[i+2].split()))
    j=0
    for b in range(64):
        if mask>>b&1:
            a=(raw[j//4]>>(256*(j%4)))%2**256
            q=(heads[j//4]>>(w*(j%4)))%2**w-2**(w-1)
            fields[lab,64*ix+b]=(a,q,2**e)
            j+=1
    assert j==n
src=(p.parent/'full-height-count/stencils.txt').read_text().splitlines()
ks={int(src[i].split()[0]):list(map(int,src[i+1].split())) for i in range(1,1+2*int(src[0]),2)}
out={}
for l in (3,6667,11,9091):
    jobs=[tuple(map(int,row.split())) for row in (p/f'jobs-{l}.txt').read_text().splitlines()]
    orig={tuple(v[:2]):v for row in (p.parent/f'grid-sign-join/jobs-{l}.txt').read_text().splitlines() if (v:=list(map(int,row.split())))}
    assert len(set(jobs))==len(jobs)
    rec=[]
    with (p/f'windows-{l}.txt').open('w') as stream:
        for t,k in jobs:
            _,_,r,off,den,err,sg=orig[t,k]
            base=129+t//4096-r//2
            vals=[fields[l,j] for j in range(base,base+r)]
            rawdot=sum(w*(a-2**255) for w,(a,q,u) in zip(ks[k],vals,strict=True))
            assert (rawdot>den*err if sg else rawdot < -den*err)
            print(t,k,sg+1,r,*(a for a,q,u in vals),*(v for a,q,u in vals for v in(q,u)),file=stream)
            rec.append(dict(t=t,k=k,code=sg+1,start=base,length=r))
    out[l]=rec
(p/'all-window-jobs.json').write_text(json.dumps(out,indent=2))
print([(k,len(v)) for k,v in out.items()])

