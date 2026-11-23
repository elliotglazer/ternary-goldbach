from actual import *
import csv,statistics
def now():return time.perf_counter(),time.process_time()
def colslice(z,n):return [decode(x,n) for x in z]
def run(mode,zs,n,indices,roots,metadata,ids,base_index):
    if mode=='pruned':
        def rec(k,base,arr,lo,hi):
            if lo==hi:return
            if k<=64:
                raw=colslice(arr,k)
                for s in range(lo,hi):
                    i=indices[s];yield i,[readint(v,i-base) for v in raw]
                return
            from bisect import bisect_left
            half=k//2;mid=bisect_left(indices,base+half,lo,hi);sh=W*half;H=fmpz(1)<<sh
            high=[(v+(H>>1))>>sh for v in arr]
            if mid>lo:yield from rec(half,base,[v-(u<<sh) for v,u in zip(arr,high)],lo,mid)
            if mid<hi:yield from rec(half,base+half,high,mid,hi)
        it=rec(n,0,zs,0,len(indices))
    else:
        raw=zs if mode=='fused' else colslice(zs,n)
        if mode in ('select','fused'):it=((i,[readint(v,i) for v in raw]) for i in indices)
        else:it=((i,[readint(v,i) for v in raw]) for i in range(n))
    outs=[]
    for i,abc in it:
        if mode=='full-post' or i in ids:r=project(*abc,roots[i])
        if i in ids:
            w,e,q=metadata[i];v=r//(1<<e);assert v==q
            outs.append((v+(1<<(w-1)),w))
    bits=0;nb=0;words=[]
    # Repack small rows in order, preserving each masked sample's width.
    for j,(v,w) in zip(indices,outs):
        row=(base_index+j)//64
        if not words or words[-1][0]!=row:words.append([row,0,0])
        words[-1][1]+=v<<words[-1][2];words[-1][2]+=w
    return words
def main():
    results=[];modes=['full-post','full-extract','select','pruned'];rr=json.loads((p/'actual.json').read_text())
    expected={} # independent gold head from the existing sparse-head file
    for item in rr:
        label=item['label'];store={};goldwords={};rows=(old/f'heads-{label}.txt').read_text().splitlines()
        for line in (p/f'selected-{label}.tsv').open():
            j,A,B,C,u,v,w,e,q=map(int,line.split());store[j]=(w,e,q)
        for k in (10,12,16):
            n=1<<k
            for d in [2,3]:
                allbytes=[(p/f'c{label}-{c}-{d}.bin').read_bytes() for c in range(3)]
                # For small runs choose one aligned interior subblock of each physical tile.
                off=(8192 if d==2 else 4096) if n<T else 0
                zs=[fmpz(int.from_bytes(v[off*68:(off+n)*68],'little'))-bias(n) for v in allbytes]
                base=d*T+off-2*J;meta={i:store[base+i] for i in range(n) if base+i in store}
                sel=sorted(meta);ids=set(sel);roots=[chirp(base+i-128) for i in range(n)]
                for rep in range(3):
                    gold=None
                    for mode in (modes if rep%2==0 else modes[::-1]):
                        t=now();v=run(mode,zs,n,sel,roots,meta,ids,base);w1,c1=now();dt=w1-t[0];cpu=c1-t[1]
                        if gold is None:gold=v
                        assert v==gold
                        if k==16 and rep==0 and mode=='select':
                            for ix,digits,bits in v:
                                prior,shift=goldwords.get(ix,(0,0));goldwords[ix]=(prior+(digits<<shift),shift+bits)
                        results.append(dict(label=label,k=k,diag=d,rep=rep,mode=mode,selected=len(sel),wall=dt,cpu=cpu))
            print(label,k,flush=True)
        dest=[]
        for ix,line in enumerate(rows):
            mask,w,e,h=line.split();v,bits=goldwords.get(ix,(0,0));assert v==int(h,16) and bits==int(mask).bit_count()*int(w)
            dest.append(f'{mask} {w} {e} {v:x}')
        (p/f'heads-{label}.txt').write_bytes(('\n'.join(dest)+'\n').encode())
    with (p/'native-timings.csv').open('w',newline='') as f:
        wr=csv.DictWriter(f,fieldnames=results[0]);wr.writeheader();wr.writerows(results)
if __name__=='__main__':main()



