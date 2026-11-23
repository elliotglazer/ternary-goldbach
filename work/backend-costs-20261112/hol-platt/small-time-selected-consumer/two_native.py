from native import *
def go():
    rawtimes=[];checks=[];H=fmpz(1)<<(W*T);half=H>>1;keep=H-1;C=bias(T)
    for l in labels:
        entries={int(t[0]):tuple(map(int,t[-3:])) for s in (p/f'selected-{l}.tsv').open() if (t:=s.split())}
        for d in (2,3):
            source=[(p/f'c{l}-{k}-{d}.bin').read_bytes() for k in range(3)]
            lo=[fmpz(int.from_bytes(v,'little'))-C for v in source]
            hi=[fmpz(int.from_bytes((p/f'c{l}-{k}-{d}.carry').read_bytes(),'little',signed=True)) for k in range(3)]
            z=[a+(b<<(W*T)) for a,b in zip(lo,hi)]
            lp=[lo[0]-lo[1],lo[2]-lo[0]-lo[1]];hp=[hi[0]-hi[1],hi[2]-hi[0]-hi[1]]
            sb=[decode(s,T) for s in lp];mx=0
            for j in range(T):
                a,b,c=(readint(v,j) for v in source);u,v=(readint(t,j) for t in sb)
                assert (u,v)==(a-b,c-a-b);mx=max(mx,abs(u).bit_length(),abs(v).bit_length())
            checks.append(dict(label=l,d=d,max_field_bits=mx,lanes=T))
            base=d*T-2*J;sel=[j for j in range(T) if base+j in entries];roots=[chirp(base+j-128) for j in sel]
            for rep in range(5):
                for mode in (['baseline3','baseline2','heads2'] if rep%2==0 else ['heads2','baseline2','baseline3']):
                    tt=now()
                    if mode=='baseline3':
                        hs=[(i+half)>>(W*T) for i in z];ls=[v-(q<<(W*T)) for v,q in zip(z,hs)];assert hs==hi and ls==lo
                    else:
                        two=[z[0]-z[1],z[2]-z[0]-z[1]];bds=[v+C for v in two];hs=[v>>(W*T) for v in bds];ls=[v&keep for v in bds];assert hs==hp
                        if mode=='baseline2':assert [v-C for v in ls]==lp
                        else:
                            P,Q=(int(v).to_bytes(T*68,'little') for v in ls);words=[]
                            for j,(u,v) in zip(sel,roots):
                                w,e,want=entries[base+j];ar=readint(P,j);ai=readint(Q,j)
                                head=(rnd(ar*u-ai*v,1<<499)//2)//(1<<e);assert head==want
                                row=(base+j)//64
                                if not words or words[-1][0]!=row:words.append([row,0,0])
                                words[-1][1]+=(head+(1<<(w-1)))<<words[-1][2];words[-1][2]+=w
                    wall,cpu=now();rawtimes.append(dict(label=l,d=d,rep=rep,mode=mode,wall=wall-tt[0],cpu=cpu-tt[1]))
    with (p/'two-integrated.csv').open('w',newline='') as f:
        wr=csv.DictWriter(f,fieldnames=rawtimes[0]);wr.writeheader();wr.writerows(rawtimes)
    (p/'two-bounds.json').write_text(json.dumps(checks,indent=2))
    for m in ['baseline3','baseline2','heads2']:print(m,[round(sum(v['wall'] for v in rawtimes if v['rep']==j and v['mode']==m),4) for j in range(5)])
if __name__=='__main__':go()
