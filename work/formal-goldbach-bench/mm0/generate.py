"""Generate a schematic, model-valid cached slice/OR MMB benchmark.

The specification explicitly axiomatizes the finite tables and generic lifting.
This is a kernel-workload benchmark, NOT an end-to-end proof from PA.
"""
import argparse, hashlib, json, random, struct, time
from pathlib import Path

ROOT = Path(__file__).resolve().parent
def cmd(op, n=0):
    if n == 0: return bytes([op])
    if n < 256: return bytes([op|64,n])
    if n < 65536: return bytes([op|128])+struct.pack('<H',n)
    return bytes([op|192])+struct.pack('<I',n)
def decl(op, body=b''):
    return bytes([op|192])+struct.pack('<I',5+len(body))+body
def E(t,*args): return (t,args)

class Gen:
    def __init__(self):
        self.terms=[]; self.thms=[]; self.spec=['delimiter $ ( $ $ ) $;']; self.stream=[]
        self.sorts=['byte','word','source','trace','prop']
        self.flags=[10,10,10,10,4]
        for s,f in zip(self.sorts,self.flags):
            self.spec.append(('provable sort ' if f==4 else 'strict free sort ')+s+';')
            self.stream.append(decl(4))
    def term(self,name,args,ret):
        i=len(self.terms); self.terms.append((name,args,ret))
        bs=' '.join(f'(x{j}:{self.sorts[s]})' for j,s in enumerate(args))
        self.spec.append(f'term {name} {bs}: {self.sorts[ret]};')
        self.spec.append(f'prefix {name}: ${name}$ prec '+('max' if not args else '1000')+';')
        self.stream.append(decl(5)); return i
    def text(self,e):
        if isinstance(e,int): return 'x'+str(e)
        t,args=e; n=self.terms[t][0]
        return n if not args else '('+n+' '+' '.join(map(self.text,args))+')'
    def expr(self,e):
        if isinstance(e,int): return cmd(0x12,e)
        t,args=e;return b''.join(map(self.expr,args))+cmd(0x10,t)
    def unify(self,e):
        if isinstance(e,int): return cmd(0x32,e)
        t,args=e; return cmd(0x30,t)+b''.join(map(self.unify,args))
    def thm(self,name,args,hyps,concl,proof=None):
        i=len(self.thms); self.thms.append((args,hyps,concl))
        bs=' '.join(f'(x{j}:{self.sorts[s]})' for j,s in enumerate(args))
        hs=' '.join(f'(h{j}: $ {self.text(h)} $)' for j,h in enumerate(hyps))
        self.spec.append(f'{"axiom" if proof is None else "theorem"} {name} {bs} {hs}: $ {self.text(concl)} $;')
        body=b''.join(self.expr(h)+cmd(0x16) for h in hyps)
        body+=self.expr(concl) if proof is None else proof
        self.stream.append(decl(2 if proof is None else 6,body+b'\0'))
        return i
    def write(self,stem):
        ns,nt,nh=len(self.sorts),len(self.terms),len(self.thms)
        data=bytearray(40+ns); data.extend(b'\0'*((-len(data))%8))
        pt=len(data);data.extend(b'\0'*(8*nt));ph=len(data);data.extend(b'\0'*(8*nh))
        for i,(_,args,ret) in enumerate(self.terms):
            data.extend(b'\0'*((-len(data))%8));p=len(data)
            for a in args+[ret]:data.extend(struct.pack('<Q',a<<56))
            struct.pack_into('<HBBI',data,pt+8*i,len(args),ret,0,p)
        for i,(args,hyps,concl) in enumerate(self.thms):
            data.extend(b'\0'*((-len(data))%8));p=len(data)
            for a in args:data.extend(struct.pack('<Q',a<<56))
            data.extend(self.unify(concl))
            for h in reversed(hyps):data.extend(cmd(0x36)+self.unify(h))
            data.append(0)
            struct.pack_into('<HHI',data,ph+8*i,len(args),0,p)
        pp=len(data);data.extend(b''.join(self.stream));data.extend(b'\0'*5)
        struct.pack_into('<4sBBHIIIIIIQ',data,0,b'MM0B',1,ns,0,nt,nh,pt,ph,pp,0,0)
        data[40:40+ns]=bytes(self.flags)
        stem.with_suffix('.mmb').write_bytes(data)
        stem.with_suffix('.mm0').write_bytes(('\n'.join(self.spec)+'\n').encode())
        return data,pp

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--digit-bits',type=int,default=8)
    ap.add_argument('--width',type=int,default=64);ap.add_argument('--updates',type=int,default=1000)
    ap.add_argument('--op',choices=['slice-or','or'],default='slice-or')
    ap.add_argument('--reset-every',type=int,default=0);ap.add_argument('--sparse-level',type=int,default=1)
    ap.add_argument('--name',default='bench');a=ap.parse_args()
    assert a.digit_bits in (4,8) and a.width%a.digit_bits==0
    started=time.perf_counter();g=Gen();q=1<<a.digit_bits;n=a.width//a.digit_bits
    shift=3 if a.digit_bits==8 else 1;mask=q-1
    vals=[g.term(f'b{i:02x}',[],0) for i in range(q)]
    word=g.term('wordpack',[0]*n,1);src=g.term('sourcepack',[0]*(n+1),2)
    nil=g.term('nil',[],3);cons=g.term('step',[3,1,2,1],3)
    valid=g.term('valid',[3,1],4);ok=g.term('ok',[],4)
    bor=g.term('byteor',[0,0,0],4);sl=g.term('byteslice',[0,0,0],4)
    reset_term=g.term('reset',[3],3) if a.reset_every else None
    W0=E(word,*([E(vals[0])]*n))
    V=lambda t,w=W0:E(valid,t,w);N=E(nil)
    empty=g.thm('empty',[0],[],V(N))
    clear=g.thm('clear',[0],[V(N)],V(N))
    drop=[]
    for t in [bor,sl]:drop.append(g.thm('drop'+str(t),[0]*3,[V(N),E(t,0,1,2)],V(N)))
    tabs=[]
    operations=[bor,sl] if a.op=='slice-or' else [bor]
    for t in operations:
        ids=[]
        for x in range(q):
            for y in range(q):
                z=x|y if t==bor else ((x>>shift)|(y<<(a.digit_bits-shift)))&mask
                ids.append(g.thm(('or' if t==bor else 'sl')+f'{x:02x}{y:02x}',[],[],E(t,E(vals[x]),E(vals[y]),E(vals[z]))))
        tabs.append(ids)
    # Parameters: previous trace, destination digits, source digits, slice digits, result digits.
    A=list(range(1,n+1))
    if a.op=='slice-or':
        B=list(range(n+1,2*n+2));C=list(range(2*n+2,3*n+2));R=list(range(3*n+2,4*n+2))
        hh=[E(sl,B[i],B[i+1],C[i]) for i in range(n)]+[E(bor,A[i],C[i],R[i]) for i in range(n)]
        bbexpr=B
    else:
        B=list(range(n+1,2*n+1));C=[];R=list(range(2*n+1,3*n+1))
        hh=[E(bor,A[i],B[i],R[i]) for i in range(n)];bbexpr=B+[B[-1]]
    hyps=[V(0,E(word,*A))]+hh
    conclusion=V(E(cons,0,E(word,*A),E(src,*bbexpr),E(word,*R)),E(word,*R))
    lift=g.thm('lift',[3]+[0]*R[-1],hyps,conclusion)
    reset_id=g.thm('reset_valid',[3,1],[V(0,1)],V(E(reset_term,0))) if a.reset_every else None
    finish=g.thm('finish',[3,1],[V(0,1)],E(ok))
    # Heap: canonical byte zero, empty trace, initial zero word. The unused
    # byte argument of 'empty' consumes the first saved expression on stack.
    proof=bytearray(cmd(0x11,vals[0])+cmd(0x11,nil)+cmd(0x12,0)*n+cmd(0x11,word)+cmd(0x10,valid)+cmd(0x14,empty));heap=3
    vh=[0]
    for v in vals[1:]:
        proof.extend(cmd(0x11,v));vh.append(heap);heap+=1
        proof.extend(cmd(0x12,1)+cmd(0x12,2)+cmd(0x10,valid)+cmd(0x14,clear))
    cache=[]
    for ti,t in enumerate(operations):
        hh=[]
        for x in range(q):
            for y in range(q):
                z=x|y if t==bor else ((x>>shift)|(y<<(a.digit_bits-shift)))&mask
                for v in [x,y,z]:proof.extend(cmd(0x12,vh[v]))
                proof.extend(cmd(0x10,t)+cmd(0x15,tabs[ti][x*q+y]));hh.append(heap);heap+=1
                for v in [x,y,z]:proof.extend(cmd(0x12,vh[v]))
                proof.extend(cmd(0x12,1)+cmd(0x12,2)+cmd(0x10,valid)+cmd(0x14,drop[ti]))
        cache.append(hh)
    boot_bytes=len(proof);trace=1;current_word=2;aa=[0]*n;rng=random.Random(20261110);bad_offset=None
    last_values=None
    for j in range(a.updates):
        if a.reset_every and j and j%a.reset_every==0:
            proof.extend(cmd(0x12,trace)+cmd(0x12,current_word)+cmd(0x12,trace)+cmd(0x11,reset_term))
            trace=heap;heap+=1;current_word=2;aa=[0]*n
            proof.extend(cmd(0x12,2)+cmd(0x10,valid)+cmd(0x14,reset_id))
        bb=[]
        for _ in range(n+(a.op=='slice-or')):
            v=mask
            for _ in range(a.sparse_level):v &= rng.randrange(q)
            bb.append(v)
        cc=[((bb[i]>>shift)|(bb[i+1]<<(a.digit_bits-shift)))&mask for i in range(n)] if a.op=='slice-or' else []
        maskvals=cc if cc else bb;rr=[aa[i]|maskvals[i] for i in range(n)]
        if cc:
            for i in range(n):
                if bad_offset is None:bad_offset=len(proof)
                proof.extend(cmd(0x12,cache[1][bb[i]*q+bb[i+1]]))
        for i in range(n):
            if bad_offset is None:bad_offset=len(proof)
            proof.extend(cmd(0x12,cache[0][aa[i]*q+maskvals[i]]))
        proof.extend(cmd(0x12,trace))
        for v in aa+bb+cc+rr:proof.extend(cmd(0x12,vh[v]))
        proof.extend(cmd(0x12,trace)+cmd(0x12,current_word))
        for vs,t in [(bb if cc else bb+[bb[-1]],src),(rr,word)]:
            for v in vs:proof.extend(cmd(0x12,vh[v]))
            proof.extend(cmd(0x11 if t==word else 0x10,t))
            if t==word:current_word=heap;heap+=1
        proof.extend(cmd(0x11,cons));trace=heap;heap+=1
        proof.extend(cmd(0x12,current_word)+cmd(0x10,valid)+cmd(0x14,lift));last_values=[aa,bb,cc,rr];aa=rr
    update_bytes=len(proof)-boot_bytes
    proof.extend(cmd(0x12,trace)+cmd(0x12,current_word)+cmd(0x10,ok)+cmd(0x14,finish))
    proof_stmt_prefix=sum(map(len,g.stream))
    g.thm('bench',[],[],E(ok),bytes(proof))
    stem=ROOT/a.name;data,pp=g.write(stem)
    if bad_offset is not None:
        # Ref index points to the wrong existing cached slice proof; keep bytecode well formed.
        pos=pp+proof_stmt_prefix+5+bad_offset
        bad=bytearray(data);sz=(0,1,2,4)[bad[pos]>>6]
        idx=int.from_bytes(bad[pos+1:pos+1+sz],'little');idx=idx+1
        bad[pos+1:pos+1+sz]=idx.to_bytes(sz,'little')
        stem.with_name(stem.name+'-bad').with_suffix('.mmb').write_bytes(bad)
    update_start=pp+proof_stmt_prefix+5+boot_bytes
    if a.updates==0:
        stem.with_suffix('.prefix').write_bytes(data[:update_start])
    meta=vars(a)|dict(table_shift=shift,tables_per_operator=q*q,heap_slots=heap,bootstrap_bytes=boot_bytes,
       update_start=update_start,proof_decl_offset=pp+proof_stmt_prefix,lift_id=lift,finish_id=finish,reset_id=reset_id,
       update_bytes=update_bytes,bytes_per_update=update_bytes/max(a.updates,1),mmb_bytes=len(data),
       mm0_bytes=stem.with_suffix('.mm0').stat().st_size,generation_wall_s=time.perf_counter()-started,
       sha256=hashlib.sha256(data).hexdigest(),semantic_scope='Schematic finite slice/OR axioms; not PA proof.',last_values=last_values)
    stem.with_suffix('.json').write_text(json.dumps(meta,indent=2)+'\n');print(json.dumps(meta,indent=2))

if __name__=='__main__':main()
