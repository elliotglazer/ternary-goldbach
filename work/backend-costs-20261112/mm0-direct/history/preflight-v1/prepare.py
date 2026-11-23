"""Untrusted fixed-fixture producer. Root runs after review; not a checker."""
from pathlib import Path
import argparse
import hashlib
import json
import re
import sys
import time
from mmb import Builder, Library, Proof, frontend

HERE=Path(__file__).resolve().parent
PA=HERE.parent/'mm0-pa'
FIXTURE=HERE.parents[2]/'work/lean-pilots/batched-transform/P343N64.json'
FIXTURE_PIN='F024EAF87BD02898530A72CAB2C567B00C98BCC83DF48E0BE4E8D9CFCA6D00AE'
LIB_PIN='813A982693548162973DCBAAB7BA4B2558EDD3CEFC7179040113E92ECBD9CBF4'


def read_pinned(path,pin,cap):
    data=path.read_bytes()
    assert len(data)<=cap and hashlib.sha256(data).hexdigest().upper()==pin
    return data


def write(name,data):
    if isinstance(data,str):data=data.encode()
    assert len(data)<=256*1024*1024
    with (HERE/name).open('xb') as f:f.write(data)
    return {'bytes':len(data),'sha256':hashlib.sha256(data).hexdigest().upper()}


def numeral(n):
    if n==0:return '0'
    return '(b'+str(n%2)+' '+numeral(n//2)+')'


class Arithmetic:
    def __init__(self,b):self.b=b

    def eq(self,a,b):return self.b.t('eq',a,b)

    def succ(self,n):
        b=self.b;goal=self.eq(b.t('suc',b.num(n)),b.num(n+1))
        if n==0:return b.use('paSuccZero',goal)
        if n%2==0:return b.use('sucb0',goal)
        return b.use('paSuccOdd',goal,(self.succ(n//2),))

    def add(self,a,c):
        b=self.b;goal=self.eq(b.t('add',b.num(a),b.num(c)),b.num(a+c))
        if a==0:return b.use('add01',goal)
        if c==0:return b.use('add0',goal)
        if a>=8 and c>=8:
            aa,x=divmod(a,16);cc,y=divmod(c,16)
            ps=[self.add(aa,cc)]
            if x+y>=16:ps.append(self.succ(aa+cc))
            return b.use(f'paFour{x:x}{y:x}',goal,tuple(ps))
        aa,cc=a//2,c//2;bits=f'{a%2}{c%2}'
        ps=[self.add(aa,cc)]
        if bits=='11':ps.append(self.succ(aa+cc))
        return b.use('paAdd'+bits,goal,tuple(ps))

    def mul(self,a,c):
        b=self.b;goal=self.eq(b.t('mul',b.num(a),b.num(c)),b.num(a*c))
        if a==0:return b.use('mul01',goal)
        if c==0:return b.use('mul0',goal)
        if c==1:return b.use('paMulOne',goal)
        ps=[self.mul(a,c//2)]
        if c%2:ps.append(self.add(2*a*(c//2),a))
        return b.use('paMulOdd' if c%2 else 'paMulEven',goal,tuple(ps))


def pair(n):return (max(n,0),max(-n,0))


def main(mode,count):
    sys.setrecursionlimit(10000)
    start=time.process_time();wall=time.perf_counter()
    lib=Library(read_pinned(PA/'fourbit0.mmb',LIB_PIN,2*1024*1024))
    b=Builder(lib);a=Arithmetic(b)
    f=json.loads(read_pinned(FIXTURE,FIXTURE_PIN,1024*1024))
    assert len(f['rows'])==64 and count in (0,64)
    rows=f['rows'][:count]
    # Fixed public prelude, including bootstrap, is replayed in each full file.
    spec=read_pinned(PA/'fourbit0.join.mm0','C49E32460300AC9457BAA31BB5CBA8C954355975896A80DD1AF969A9E8D5E7EE',1024*1024).decode()
    read_pinned(PA/'arithmetic4.mm1','90093AD07BE8E8A4851A741E7CA1FFA20003CB69EC9351135C841906E94ECD7D',1024*1024)
    read_pinned(PA/'arithmetic.mm1','813D4824FBACFE0032B78CFA00A5B67F9D45A9D30091B94DDADFAAFFD4CAC976',1024*1024)
    assert len(re.findall(r'^axiom\s+',spec,re.M))==26
    text=['import "../mm0-pa/arithmetic4.mm1";',
          "pub theorem bootstrap: $ 0 = 0 $ = 'eqid;"]
    final_nodes=[];final_names=[];counts=[];cases=[]
    for i,row in enumerate(rows):
        x,y=row['input'][2],row['input'][4]
        assert type(x) is int and type(y) is int
        assert abs(x).bit_length()<=1024 and abs(y).bit_length()<=1024
        z=x*y;values=pair(x)+pair(y)+pair(z)
        labels=[f'{t}{i}' for t in ('XP','XN','YP','YN','ZP','ZN')]
        defs=[]
        for label,v in zip(labels,values):
            body=b.num(v);defs.append(b.define(label,body))
            decl=f'def {label}: nat = $ {numeral(v)} $;'
            spec+='\n'+decl;text.append(decl)
        xp,xn,yp,yn,zp,zn=defs
        mag_x=xp if x>=0 else xn;mag_y=yp if y>=0 else yn;mag_z=zp if z>=0 else zn
        mag=b.t('eq',b.t('mul',mag_x,mag_y),mag_z)
        mag_name=f'product{i}'
        mag_statement=f'{labels[0 if x>=0 else 1]} * {labels[2 if y>=0 else 3]} = {labels[4 if z>=0 else 5]}'
        spec+=f'\ntheorem {mag_name}: $ {mag_statement} $;'
        if mode!='spec':
            p=b.convert(a.mul(abs(x),abs(y)),mag)
            if mode=='direct':counts.append(dict(name=mag_name,**b.declare(mag_name,p)))
            else:
                text.append(f"pub theorem {mag_name}: $ {mag_statement} $ = '{frontend(p)};")
                lib.add_thm(mag_name,mag,b.terms,b'')
        def signed_coordinate(left,right,dest):
            # Operate on expanded canonical components and reuse the one checked
            # magnitude product. All zero products and additions have PA proofs.
            av,bv=values[left[0]],values[left[1]]
            cv,dv=values[right[0]],values[right[1]]
            def product(u,v):
                goal=a.eq(b.t('mul',b.num(u),b.num(v)),b.num(u*v))
                if u and v:return b.convert(b.use(mag_name,mag),goal)
                return a.mul(u,v)
            p1,p2=product(av,bv),product(cv,dv)
            pleft=b.t('add',b.t('mul',b.num(av),b.num(bv)),b.t('mul',b.num(cv),b.num(dv)))
            pmid=b.t('add',b.num(av*bv),b.num(cv*dv))
            first=b.use('addeq',a.eq(pleft,pmid),(p1,p2))
            return b.use('eqtr',a.eq(pleft,b.num(values[dest])),(first,a.add(av*bv,cv*dv)))
        positive=b.t('eq',b.t('add',b.t('mul',xp,yp),b.t('mul',xn,yn)),zp)
        negative=b.t('eq',b.t('add',b.t('mul',xp,yn),b.t('mul',xn,yp)),zn)
        signed=b.t('an',positive,negative);name=f'signedProduct{i}'
        line=f'({labels[0]} * {labels[2]} + {labels[1]} * {labels[3]} = {labels[4]}) /\\ ({labels[0]} * {labels[3]} + {labels[1]} * {labels[2]} = {labels[5]})'
        spec+=f'\ntheorem {name}: $ {line} $;'
        if mode!='spec':
            p1=b.convert(signed_coordinate((0,2),(1,3),4),positive)
            p2=b.convert(signed_coordinate((0,3),(1,2),5),negative)
            p=b.use('iani',signed,(p1,p2))
            if mode=='direct':counts.append(dict(name=name,**b.declare(name,p)))
            else:
                text.append(f"pub theorem {name}: $ {line} $ = '{frontend(p)};")
                lib.add_thm(name,signed,b.terms,b'')
        final_nodes.append((signed,line));final_names.append(name)
        cases.append({'index':i,'x':str(x),'y':str(y),'z':str(z),'component_names':labels,'components':list(map(str,values))})
    def finish(lo,hi):
        if hi-lo==1:
            node,line=final_nodes[lo]
            return node,line,None if mode=='spec' else b.use(final_names[lo],node)
        mid=(lo+hi)//2
        l,ls,lp=finish(lo,mid);r,rs,rp=finish(mid,hi)
        node=b.t('an',l,r)
        return node,f'({ls}) /\\ ({rs})',None if mode=='spec' else b.use('iani',node,(lp,rp))
    if count:goal,line,p=finish(0,count)
    else:
        goal=a.eq(b.num(0),b.num(0));line='0 = 0';p=b.use('eqid',goal)
    spec+=f'\ntheorem allSignedProducts: $ {line} $;\n'
    artifacts={}
    if mode=='spec':
        artifacts[f'signed{count}.mm0']=write(f'signed{count}.mm0',spec)
    elif mode=='frontend':
        text.append(f"pub theorem allSignedProducts: $ {line} $ = '{frontend(p)};")
        artifacts[f'signed{count}.mm1']=write(f'signed{count}.mm1','\n'.join(text)+'\n')
        assert (HERE/f'signed{count}.mm0').read_text()==spec
    else:
        counts.append(dict(name='allSignedProducts',**b.declare('allSignedProducts',p)))
        artifacts[f'direct{count}.mmb']=write(f'direct{count}.mmb',lib.output())
        assert (HERE/f'signed{count}.mm0').read_text()==spec
    receipt=dict(schema='mm0-direct-construction-v1',mode=mode,count=count,
        scope='Untrusted proposed PA certificate; independent acceptance pending',
        fixture_sha256=FIXTURE_PIN,library_sha256=LIB_PIN,
        cpu_seconds=time.process_time()-start,elapsed_seconds=time.perf_counter()-wall,
        cases=cases,counts=counts,artifacts=artifacts)
    write(f'{mode}{count}.json',json.dumps(receipt,indent=2)+'\n')
    print(json.dumps({k:v for k,v in receipt.items() if k not in ('cases','counts')},indent=2))


if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('mode',choices=['spec','frontend','direct'])
    parser.add_argument('count',type=int,choices=[0,64]);args=parser.parse_args()
    main(args.mode,args.count)
