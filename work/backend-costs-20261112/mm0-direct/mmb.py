"""Untrusted bounded MMB codec. No verification result is asserted by this module."""
import struct
from dataclasses import dataclass

LIMIT = 256 * 1024 * 1024


def cmd(op, n=0):
    assert 0 <= op < 64 and 0 <= n < 2**32
    size = 0 if n == 0 else 1 if n < 256 else 2 if n < 65536 else 4
    return bytes([op | {0: 0, 1: 64, 2: 128, 4: 192}[size]]) + n.to_bytes(size, 'little')


def read_cmd(data, at):
    assert 0 <= at < len(data)
    size = (0, 1, 2, 4)[data[at] >> 6]
    end = at + 1 + size
    assert end <= len(data)
    return data[at] & 63, int.from_bytes(data[at+1:end], 'little'), end


def statement(op, body):
    # Length includes its own prefix; reach the minimal fixed point.
    n = len(body) + 1
    while len(cmd(op, n)) + len(body) != n:
        n = len(cmd(op, n)) + len(body)
    return cmd(op, n) + body


def end_of_code(data, at):
    while True:
        op, _, at = read_cmd(data, at)
        if op == 0:
            return at


class Terms:
    def __init__(self):
        self.nodes = []
        self.index = {}

    def make(self, tid, args=()):
        key = (tid, tuple(args))
        if key not in self.index:
            assert len(self.nodes) < 2_000_000
            self.index[key] = len(self.nodes)
            self.nodes.append(key)
        return self.index[key]


@dataclass
class Proof:
    result: int
    name: str = ''
    args: tuple = ()
    premises: tuple = ()
    conversion: object = None


class Library:
    def __init__(self, data):
        assert len(data) < LIMIT
        self.data = data
        magic, version, self.ns, reserved, self.nt, self.nh, pt, ph, pp, r2, pi = struct.unpack_from('<4sBBHIIIIIIQ', data)
        assert (magic, version, reserved, r2) == (b'MM0B', 1, 0, 0)
        assert self.ns <= 128 and self.nt < 10000 and self.nh < 10000
        self.sorts = data[40:40+self.ns]
        self.term_headers, self.term_blobs, self.arity = [], [], []
        for i in range(self.nt):
            raw = data[pt+8*i:pt+8*i+8]
            n, sort, _, p = struct.unpack('<HBBI', raw)
            end = p+8*(n+1)
            if sort & 128:
                end = end_of_code(data, end)
            assert end <= len(data)
            self.term_headers.append(raw[:4])
            self.term_blobs.append(data[p:end])
            self.arity.append(n)
        self.thm_headers, self.thm_blobs = [], []
        for i in range(self.nh):
            raw = data[ph+8*i:ph+8*i+8]
            n, reserved, p = struct.unpack('<HHI', raw)
            assert reserved == 0
            end = end_of_code(data, p+8*n)
            self.thm_headers.append(raw[:4])
            self.thm_blobs.append(data[p:end])
        at, declarations = pp, []
        while data[at]:
            op, n, start = read_cmd(data, at)
            assert op in (2, 4, 5, 6, 13, 14) and n >= start-at
            end = at+n
            assert end <= len(data)
            if op != 4:
                q = start
                while q < end:
                    p_op, _, q = read_cmd(data, q)
                    assert p_op != 0x20, 'Sorry is forbidden'
                assert q == end
            declarations.append((op, at, start, end))
            at = end
        self.proof = data[pp:at]  # Drop only the outer end, not any theorem proof.
        self.declarations = declarations
        assert sum(o in (5,13) for o,*_ in declarations) == self.nt
        assert sum(o in (2,6,14) for o,*_ in declarations) == self.nh
        assert sum(o == 4 for o,*_ in declarations) == self.ns
        assert 0 < pi < len(data)
        count = struct.unpack_from('<Q',data,pi)[0]
        names_at = None
        for j in range(count):
            tag, _, p = struct.unpack_from('<4sIQ',data,pi+8+16*j)
            if tag == b'Name': names_at = p
        assert names_at is not None
        names = []
        for j in range(self.ns+self.nt+self.nh):
            _, p = struct.unpack_from('<QQ',data,names_at+16*j)
            names.append(data[p:data.index(0,p)].decode())
        self.sort_names = names[:self.ns]
        self.term_names = names[self.ns:self.ns+self.nt]
        self.thm_names = names[self.ns+self.nt:]
        assert len(set(self.term_names)) == self.nt and len(set(self.thm_names)) == self.nh
        self.tid = {n:i for i,n in enumerate(self.term_names)}
        self.hid = {n:i for i,n in enumerate(self.thm_names)}
        self.schemas = {}
        self.extra_terms, self.extra_thms, self.extra_decls = [], [], []

    def schema(self, name):
        if name in self.schemas: return self.schemas[name]
        i = self.hid[name]
        n = struct.unpack('<H',self.thm_headers[i][:2])[0]
        data = self.thm_blobs[i]
        # Only ordinary regular variables in the arithmetic rules used here.
        assert all(not (struct.unpack_from('<Q',data,8*j)[0] & (1<<63)) for j in range(n))
        heap = [('v',j) for j in range(n)]
        at = 8*n
        def term():
            nonlocal at
            op, x, at = read_cmd(data,at)
            if op == 0x32:
                assert x < len(heap)
                return heap[x]
            assert op in (0x30,0x31)
            pos = len(heap)
            if op == 0x31: heap.append(None)
            out = ('t',x,tuple(term() for _ in range(self.arity[x])))
            if op == 0x31: heap[pos] = out
            return out
        result = term()
        hyps = []
        while data[at]:
            op, _, at = read_cmd(data,at)
            assert op == 0x36
            hyps.append(term())
        assert at+1 == len(data)
        ans = (n,result,tuple(reversed(hyps)))
        self.schemas[name] = ans
        return ans

    def add_def(self, name, body, terms, emitted):
        tid = self.nt+len(self.extra_terms)
        assert name not in self.tid
        self.tid[name] = tid
        self.arity.append(0)
        sort = self.sort_names.index('nat')
        blob = struct.pack('<Q',sort<<56)+unify(terms,body)+b'\0'
        self.extra_terms.append((struct.pack('<HBB',0,128|sort,0),blob))
        self.extra_decls.append(statement(5,emitted+b'\0'))
        return terms.make(tid)

    def add_thm(self, name, result, terms, emitted):
        assert name not in self.hid
        self.hid[name] = self.nh+len(self.extra_thms)
        blob = unify(terms,result)+b'\0'
        self.extra_thms.append((b'\0'*4,blob))
        self.extra_decls.append(statement(6,emitted+b'\0'))
        self.schemas[name] = (0,pattern(terms,result),())

    def output(self):
        terms = list(zip(self.term_headers,self.term_blobs))+self.extra_terms
        thms = list(zip(self.thm_headers,self.thm_blobs))+self.extra_thms
        out = bytearray(40)+self.sorts
        def align(): out.extend(b'\0'*((-len(out))%8))
        align(); pt=len(out); out.extend(b'\0'*(8*len(terms)))
        for i,(head,blob) in enumerate(terms):
            align(); p=len(out); out.extend(blob)
            out[pt+8*i:pt+8*i+8] = head+struct.pack('<I',p)
        align(); ph=len(out); out.extend(b'\0'*(8*len(thms)))
        for i,(head,blob) in enumerate(thms):
            align(); p=len(out); out.extend(blob)
            out[ph+8*i:ph+8*i+8] = head+struct.pack('<I',p)
        pp=len(out); out.extend(self.proof)
        for d in self.extra_decls: out.extend(d)
        out.append(0)
        # No debug index is required by the independent verifier.
        out.extend(b'\0'*8)  # readable lookahead for final command
        assert len(out) < LIMIT
        out[:40] = struct.pack('<4sBBHIIIIIIQ',b'MM0B',1,self.ns,0,len(terms),len(thms),pt,ph,pp,0,0)
        return bytes(out)


def pattern(terms, node):
    tid,args=terms.nodes[node]
    return ('t',tid,tuple(pattern(terms,a) for a in args))


def unify(terms,node):
    tid,args=terms.nodes[node]
    return cmd(0x30,tid)+b''.join(unify(terms,a) for a in args)


class Emitter:
    def __init__(self, lib, terms, definitions):
        self.lib,self.terms,self.definitions=lib,terms,definitions
        self.out=bytearray(); self.cache={}; self.commands=0

    def put(self,op,n=0):
        self.out.extend(cmd(op,n)); self.commands+=1
        assert len(self.out)<LIMIT and len(self.cache)<2**22

    def term(self,node):
        if node in self.cache: self.put(0x12,self.cache[node]); return
        tid,args=self.terms.nodes[node]
        for a in args:self.term(a)
        self.put(0x11,tid)
        self.cache[node]=len(self.cache)

    def conv(self,left,right):
        if left==right:self.put(0x18);return
        lt,la=self.terms.nodes[left];rt,ra=self.terms.nodes[right]
        if lt in self.definitions:
            assert not la
            body=self.definitions[lt];self.term(body);self.put(0x1b)
            self.conv(body,right);return
        if rt in self.definitions:
            self.put(0x19);self.conv(right,left);return
        assert lt==rt and len(la)==len(ra),'unsupported conversion'
        self.put(0x1a)
        for a,b in zip(la,ra):self.conv(a,b)

    def proof(self,p):
        if p.conversion is not None:
            self.term(p.result);self.proof(p.conversion);self.put(0x17)
            self.conv(p.result,p.conversion.result);return
        for h in p.premises:self.proof(h)
        for a in p.args:self.term(a)
        self.term(p.result);self.put(0x14,self.lib.hid[p.name])


class Builder:
    def __init__(self,lib):
        self.lib=lib;self.terms=Terms();self.definitions={}

    def t(self,name,*args):return self.terms.make(self.lib.tid[name],args)

    def num(self,n):
        assert n>=0
        if not n:return self.t('d0')
        return self.t('b1' if n&1 else 'b0',self.num(n//2))

    def substitute(self,p,sub):
        if p[0]=='v':return sub[p[1]]
        return self.terms.make(p[1],tuple(self.substitute(a,sub) for a in p[2]))

    def match(self,p,node,sub):
        if p[0]=='v':
            if p[1] in sub:assert sub[p[1]]==node,'inconsistent substitution'
            else:sub[p[1]]=node
            return
        tid,args=self.terms.nodes[node]
        assert (p[1],len(p[2]))==(tid,len(args)),'signature mismatch'
        for a,b in zip(p[2],args):self.match(a,b,sub)

    def use(self,name,result,premises=()):
        n,raw,hyps=self.lib.schema(name)
        assert len(premises)>=len(hyps)
        extra=len(premises)-len(hyps)
        leaf=raw;arrows=[]
        for _ in range(extra):
            assert leaf[0]=='t' and leaf[1]==self.lib.tid['im']
            arrows.append(leaf[2][0]);leaf=leaf[2][1]
        sub={};self.match(leaf,result,sub)
        for pat,pf in zip(hyps+tuple(arrows),premises):self.match(pat,pf.result,sub)
        assert set(sub)==set(range(n)),f'unbound arguments: {name}'
        out=Proof(self.substitute(raw,sub),name,tuple(sub[i] for i in range(n)),tuple(premises[:len(hyps)]))
        for pf in premises[len(hyps):]:
            _,(_,target)=self.terms.nodes[out.result]
            out=self.use('ax_mp',target,(out,pf))
        assert out.result==result
        return out

    def convert(self,p,target):
        return p if p.result==target else Proof(target,conversion=p)

    def emit(self,p):
        e=Emitter(self.lib,self.terms,self.definitions);e.proof(p)
        return bytes(e.out),{'commands':e.commands,'saved_terms':len(e.cache),'body_bytes':len(e.out)}

    def define(self,name,body):
        e=Emitter(self.lib,self.terms,self.definitions);e.term(body)
        node=self.lib.add_def(name,body,self.terms,bytes(e.out))
        self.definitions[self.terms.nodes[node][0]]=body
        return node

    def declare(self,name,p):
        data,counts=self.emit(p);self.lib.add_thm(name,p.result,self.terms,data)
        return counts


def frontend(p):
    if p.conversion is not None:return frontend(p.conversion)
    return p.name if not p.premises else '('+p.name+' '+' '.join(frontend(h) for h in p.premises)+')'
