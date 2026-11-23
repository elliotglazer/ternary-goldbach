"""Independent structural audit. Does not import the encoder or accept proofs."""
from pathlib import Path
import argparse,hashlib,json,re,struct,sys

HERE=Path(__file__).resolve().parent
PA=HERE.parent/'mm0-pa'
FIXTURE=HERE.parents[2]/'work/lean-pilots/batched-transform/P343N64.json'


def command(data,p):
    n=(0,1,2,4)[data[p]>>6];q=p+1+n
    assert q<=len(data)
    return data[p]&63,int.from_bytes(data[p+1:q],'little'),q


def read(path,known_names=None):
    d=path.read_bytes();assert len(d)<256*1024*1024
    magic,v,ns,z,nt,nh,pt,ph,pp,z2,pi=struct.unpack_from('<4sBBHIIIIIIQ',d)
    assert (magic,v,z,z2)==(b'MM0B',1,0,0)
    names=None
    if pi:
        for i in range(struct.unpack_from('<Q',d,pi)[0]):
            tag,_,at=struct.unpack_from('<4sIQ',d,pi+8+16*i)
            if tag==b'Name':
                names=[]
                for j in range(ns+nt+nh):
                    _,p=struct.unpack_from('<QQ',d,at+16*j)
                    names.append(d[p:d.index(0,p)].decode())
    if names is None:
        assert known_names is not None and len(known_names)==ns+nt+nh
        names=known_names
    sn,tn,hn=names[:ns],names[ns:ns+nt],names[ns+nt:]
    th=[struct.unpack_from('<HBBI',d,pt+8*i) for i in range(nt)]
    hh=[struct.unpack_from('<HHI',d,ph+8*i) for i in range(nh)]
    def expr(p,heap):
        op,x,p=command(d,p)
        if op==0x32:
            assert x<len(heap) and heap[x] is not None
            return heap[x],p
        assert op in (0x30,0x31) and x<nt
        slot=len(heap)
        if op==0x31:heap.append(None)
        args=[]
        for _ in range(th[x][0]):
            child,p=expr(p,heap);args.append(child)
        out=(tn[x],tuple(args))
        if op==0x31:heap[slot]=out
        return out,p
    defs={};theorems={}
    for i,(n,sort,_,p) in enumerate(th):
        if sort&128 and tn[i].startswith(('XP','XN','YP','YN','ZP','ZN')):
            assert n==0
            value,end=expr(p+8,[]);assert d[end]==0
            defs[tn[i]]=value
    for i,(n,_,p) in enumerate(hh):
        if hn[i].startswith(('product','signedProduct')) or hn[i]=='allSignedProducts':
            assert n==0
            value,end=expr(p,[]);assert d[end]==0
            theorems[hn[i]]=value
    p=pp;counts=[0,0,0];axioms=[];declarations=[];ncommands=0
    while d[p]:
        op,length,start=command(d,p);end=p+length
        assert op in (2,4,5,6,13,14) and start<=end<=len(d)
        if op==4: name=sn[counts[0]];counts[0]+=1
        elif op in (5,13):name=tn[counts[1]];counts[1]+=1
        else:
            name=hn[counts[2]];counts[2]+=1
            if op==2:axioms.append(name)
        if op!=4:
            q=start
            while q<end:
                c,_,q=command(d,q);assert c!=0x20,'Sorry forbidden';ncommands+=1
            assert q==end
        declarations.append((name,op,p,start,end));p=end
    assert counts==[ns,nt,nh]
    return dict(data=d,names=names,sn=sn,tn=tn,hn=hn,defs=defs,theorems=theorems,
                axioms=axioms,declarations=declarations,proof_commands=ncommands)


def term(name,*args):return (name,tuple(args))


def num(n):
    assert n>=0
    return term('d0') if n==0 else term('b1' if n%2 else 'b0',num(n//2))


def main(kind,count,controls):
    sys.setrecursionlimit(10000)
    base=read(PA/'fourbit0.mmb')
    raw=FIXTURE.read_bytes()
    assert hashlib.sha256(raw).hexdigest().upper()=='F024EAF87BD02898530A72CAB2C567B00C98BCC83DF48E0BE4E8D9CFCA6D00AE'
    rows=json.loads(raw)['rows'];assert len(rows)==64 and count in (0,64)
    rows=rows[:count];new_terms=[];new_thms=[];expected_defs={};expected_thms={};leaves=[]
    for i,r in enumerate(rows):
        x,y=r['input'][2],r['input'][4];z=x*y
        values=[max(x,0),max(-x,0),max(y,0),max(-y,0),max(z,0),max(-z,0)]
        labels=[f'{s}{i}' for s in ('XP','XN','YP','YN','ZP','ZN')]
        new_terms+=labels
        for name,value in zip(labels,values):expected_defs[name]=num(value)
        xp,xn,yp,yn,zp,zn=map(term,labels)
        eq=lambda l,r:term('eq',l,r)
        mul=lambda l,r:term('mul',l,r)
        add=lambda l,r:term('add',l,r)
        expected_thms[f'product{i}']=eq(mul(xp if x>=0 else xn,yp if y>=0 else yn),zp if z>=0 else zn)
        leaf=term('an',eq(add(mul(xp,yp),mul(xn,yn)),zp),eq(add(mul(xp,yn),mul(xn,yp)),zn))
        expected_thms[f'signedProduct{i}']=leaf;leaves.append(leaf)
        new_thms += [f'product{i}',f'signedProduct{i}']
    def balance(xs):
        if len(xs)==1:return xs[0]
        m=len(xs)//2;return term('an',balance(xs[:m]),balance(xs[m:]))
    expected_thms['allSignedProducts']=balance(leaves) if leaves else term('eq',num(0),num(0))
    new_thms.append('allSignedProducts')
    names=base['sn']+base['tn']+new_terms+base['hn']+new_thms
    stem=f'{kind}{count}'
    cur=read(HERE/(stem+'.mmb'),names if kind=='direct' else None)
    assert cur['axioms']==base['axioms'] and len(cur['axioms'])==26
    assert cur['defs']==expected_defs and cur['theorems']==expected_thms
    # The direct file carries every old statement body byte-for-byte.
    if kind=='direct':
        for old,new in zip(base['declarations'],cur['declarations']):
            assert old[:2]==new[:2]
            assert base['data'][old[2]:old[4]]==cur['data'][new[2]:new[4]]
    spec=(HERE/f'signed{count}.mm0').read_text()
    assert re.findall(r'^axiom\s+(\w+)',spec,re.M)==base['axioms']
    actual_defs={}
    for name,body in re.findall(r'^def ((?:XP|XN|YP|YN|ZP|ZN)\d+): nat = \$([^$]+)\$;',spec,re.M):
        tokens=re.findall(r'b[01]|0|\S',body)
        tokens=[t for t in tokens if t not in ('(',')')]
        assert tokens[-1]=='0' and all(t in ('b0','b1') for t in tokens[:-1])
        value=0
        for t in tokens[-2::-1]:value=2*value+int(t[1])
        actual_defs[name]=num(value)
    assert actual_defs==expected_defs
    record=dict(scope='Structural/sign/source audit only, not logical acceptance',kind=kind,count=count,
        sha256=hashlib.sha256(cur['data']).hexdigest().upper(),bytes=len(cur['data']),
        exact_components=True,exact_signed_conjunction=True,axioms=cur['axioms'],
        no_sorry=True,proof_commands=cur['proof_commands'])
    if controls:
        assert count==64
        def exclusive(name,data):
            if isinstance(data,str):data=data.encode()
            with (HERE/name).open('xb') as f:f.write(data)
        target=next(name for name,value in expected_defs.items() if name.startswith(('XP','XN')) and value!=num(0))
        changed,n=re.subn(rf'(def {target}: nat = \$\s*\()(b[01])',lambda m:m[1]+('b1' if m[2]=='b0' else 'b0'),spec,count=1)
        assert n==1
        exclusive(f'{stem}_bad_input.mm0',changed)
        i=int(re.search(r'\d+',target)[0]);pname,nname=f'XP{i}',f'XN{i}'
        pat=rf'(def ({pname}|{nname}): nat = \$)([^$]+)(\$;)'
        bodies={m[1]:m[2] for m in re.findall(pat,spec)}
        assert bodies[pname]!=bodies[nname]
        flipped=re.sub(pat,lambda m:m[1]+bodies[nname if m[2]==pname else pname]+m[4],spec)
        exclusive(f'{stem}_bad_sign.mm0',flipped)
        target=next(name for name,value in expected_defs.items() if name.startswith(('ZP','ZN')) and value!=num(0))
        changed,n=re.subn(rf'(def {target}: nat = \$\s*\()(b[01])',lambda m:m[1]+('b1' if m[2]=='b0' else 'b0'),spec,count=1)
        assert n==1;exclusive(f'{stem}_bad_result.mm0',changed)
        declaration=next(t for t in cur['declarations'] if t[0]=='signedProduct63')
        q=declaration[3];candidates=[]
        while q<declaration[4]:
            start=q;op,ident,q=command(cur['data'],q)
            if op in (0x14,0x15) and ident:candidates.append((start,q))
        start,end=candidates[-1];bad=bytearray(cur['data']);bad[start+1:end]=b'\0'*(end-start-1)
        exclusive(f'{stem}_bad_proof.mmb',bad)
        record['controls']='input bit, nonzero input sign, output bit, signed theorem reference'
    with (HERE/(stem+'.audit.json')).open('x') as f:json.dump(record,f,indent=2)
    print(json.dumps(record,indent=2))


if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('kind',choices=['direct','frontend']);p.add_argument('count',type=int,choices=[0,64]);p.add_argument('--controls',action='store_true');a=p.parse_args()
    main(a.kind,a.count,a.controls)
