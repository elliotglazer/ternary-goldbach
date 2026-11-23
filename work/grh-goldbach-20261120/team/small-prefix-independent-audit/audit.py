"""Read the live certificate and receipts without importing or calling its producer."""
from pathlib import Path
from math import isqrt
import hashlib,json,re,time
p=Path(__file__).resolve().parent; live=p.parent/'small-prefix/contiguous-extension'
def sha(f):return hashlib.sha256(f.read_bytes()).hexdigest()
def checks(mod):
    f=live/(mod+'.json')
    if not f.exists():return 'pending'
    r=json.loads(f.read_text())
    assert r['exit']==0 and r['source_sha256']==sha(live/(mod+'.lean')) and r['olean_sha256']==sha(live/(mod+'.olean')),mod
    return 'matching successful source and olean receipt'
def primes(n):
    m=bytearray([1])*(n+1);m[:2]=b'\0\0'
    for j in range(2,isqrt(n)+1):
        if m[j]:m[j*j::j]=bytes((n-j*j)//j+1)
    return m
allflags=primes(540000);small=[j for j in range(3,106001,2) if allflags[j]]
w=262144;halo=3200
buf=bytearray((w+halo+7)//8)
for i in range(w+halo):
    if allflags[3+2*i]:buf[i//8]|=1<<(i%8)
src=int.from_bytes(buf,'little'); mask=(1<<w)-1
def large_flags(base,hi):
    assert base%2==1 and isqrt(hi)<106000
    l=(hi-base+1)//2; out=bytearray([1])*l
    for q in small:
        if q*q>hi:break
        j=((q-base%q)*pow(2,-1,q))%q
        if j<l:out[j::q]=bytes((l-1-j)//q+1)
    return out
def joined(spans,lo,hi):
    nextlo=lo
    for l,h in spans:
        if l!=nextlo or h<=l or (h-l)%2:raise ValueError(f'expected {nextlo}, got {l}:{h}')
        nextlo=h
    if nextlo!=hi:raise ValueError(f'ends at {nextlo} instead of {hi}')
def run():
    out=[];edge=[];allsp=[]; startcpu=time.process_time()
    for band,meta,nrows in [('', 'producer',128),('B','producerB',512)]:
        md=json.loads((live/(meta+'.json')).read_text())['shards']
        for sh,expected in enumerate(md):
            mod='Extension'+band+str(sh); f=live/(mod+'.lean');raw=f.read_bytes();txt=raw.decode('utf8');digest=hashlib.sha256(raw).hexdigest();status=checks(mod)
            blocks=re.findall(r'def (r\d+_\d+) : List Row := \[(.*?)\]\s*theorem p\1 : Covered (\d+) (\d+) :=',txt,re.S)
            assert len(blocks)==nrows//8
            spans=[];anchors=0
            for name,body,lo,hi in blocks:
                lo,hi=int(lo),int(hi);spans.append((lo,hi)); assert hi-lo==16*w
                rows=re.findall(r'⟨(\d+), (\d+), packedHex% "([0-9a-f]+)", packedHex% "([0-9a-f]+)"⟩',body)
                assert len(rows)==8
                o=lo-3-2*halo; flags=large_flags(o,hi)
                for r,(width,k,ofs,_inv) in enumerate(rows):
                    assert int(width)==w
                    k=int(k);v=int(ofs,16);anchor=[]
                    for _ in range(k):
                        a=v&65535;v>>=16;assert a<=halo and flags[r*w+a];anchor.append(a)
                    assert v==0
                    cv=0
                    for a in anchor:cv|=src>>(halo-a)
                    assert cv&mask==mask,(mod,name,r)
                    anchors+=k
                    for i in ([0] if name==blocks[0][0] and r==0 else [])+([w-1] if name==blocks[-1][0] and r==7 else []):
                        n=lo+2*(r*w+i);a=next(a for a in anchor if allflags[3+2*(halo+i-a)])
                        x=o+2*(w*r+a);y=n-x;assert flags[r*w+a] and allflags[y]
                        edge.append(dict(module=mod,n=n,p=x,q=y))
            a,b=expected['start'],expected['end_exclusive'];assert expected['rows']==nrows and anchors==expected['anchors']
            joined(spans,a,b)
            title=re.search(r'theorem shard\d+ : Covered (\d+) (\d+) := ([^\n]+)',txt)
            assert (a,b)==tuple(map(int,title.groups()[:2])) and re.findall(r'pr\d+_\d+',title[3])==['p'+row[0] for row in blocks]
            assert sha(f)==digest
            allsp.append((a,b));out.append(dict(module=mod,source_sha256=sha(f),receipt=status,lo=a,exclusive=b,even_count=(b-a)//2,anchors=anchors))
    joined(allsp,10000000002,11207959554)
    controls=[]
    for i in range(len(allsp)):
        bad=allsp[:];lo,hi=bad[i];bad[i]=(lo+2,hi)
        try:joined(bad,10000000002,11207959554)
        except ValueError as e:controls.append(dict(skipped=lo,diagnostic=str(e)))
        else:raise AssertionError('gap accepted')
    last=allsp[:];last[-1]=(last[-1][0],last[-1][1]-2)
    try:joined(last,10000000002,11207959554)
    except ValueError as e:controls.append(dict(skipped=11207959552,diagnostic=str(e)))
    else:raise AssertionError('last even missing')
    return dict(shards=out,witnesses=edge,missing_even_faults=controls,published={k:checks(k) for k in ['ExtendedPrefix','ExtendedPrefixB']},count=sum(x['even_count'] for x in out),cpu=time.process_time()-startcpu)
if __name__=='__main__':
    r=run();(p/'audit.json').write_text(json.dumps(r,indent=2));print(r['count'],r['published'],r['cpu'])


