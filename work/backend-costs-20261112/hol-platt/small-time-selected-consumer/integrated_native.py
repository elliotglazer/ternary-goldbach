from native import *
def integrate():
    rows=[];B=fmpz(1)<<(W*T);half=B>>1;C=bias(T);keep=B-1
    for l in labels:
        entries={int(fields[0]):tuple(map(int,fields[-3:])) for s in (p/f'selected-{l}.tsv').open() if (fields:=s.split())}
        for d in (2,3):
            lo=[];hi=[]
            for c in range(3):
                lo.append(fmpz(int.from_bytes((p/f'c{l}-{c}-{d}.bin').read_bytes(),'little'))-C)
                hi.append(fmpz(int.from_bytes((p/f'c{l}-{c}-{d}.carry').read_bytes(),'little',signed=True)))
            z=[a+B*b for a,b in zip(lo,hi)];base=d*T-2*J;meta={i:entries[base+i] for i in range(T) if base+i in entries}
            sel=sorted(meta);ids=set(sel);roots=[chirp(base+i-128) for i in range(T)]
            gold=None
            for rep in range(5):
                for mode in (['baseline','ordinary','fused'] if rep%2==0 else ['fused','ordinary','baseline']):
                    start=now()
                    if mode=='fused':
                        parts=[s+C for s in z];high=[s>>(W*T) for s in parts]
                        raw=[int(s&keep).to_bytes(T*68,'little') for s in parts]
                        out=run('fused',raw,T,sel,roots,meta,ids,base)
                    else:
                        high=[(s+half)>>(W*T) for s in z];low=[s-(q<<(W*T)) for q,s in zip(high,z)]
                        if mode=='ordinary':out=run('select',low,T,sel,roots,meta,ids,base)
                        else:assert low==lo
                    assert high==hi
                    if mode!='baseline':
                        if gold is None:gold=out
                        else:assert gold==out
                    wall,cpu=now();rows.append(dict(label=l,diag=d,rep=rep,mode=mode,wall=wall-start[0],cpu=cpu-start[1]))
    with (p/'native-integrated.csv').open('w',newline='') as f:
        wr=csv.DictWriter(f,fieldnames=rows[0]);wr.writeheader();wr.writerows(rows)
    for mode in ['baseline','ordinary','fused']:
        print(mode,[round(sum(r['wall'] for r in rows if r['rep']==j and r['mode']==mode),4) for j in range(5)])
if __name__=='__main__':integrate()
