from pathlib import Path
import json, struct, hashlib, collections

ROOT=Path(__file__).resolve().parent
SOURCE=ROOT.parents[1]/'formal-goldbach-bench/native/pratt_certificates.json'
B=2**33+2**20
j=json.loads(SOURCE.read_text())
nodes={x['prime']:x for x in j['certificates']}
roots=list(dict.fromkeys(j['roots']))
def selected(p):
    factors=sorted(nodes[p]['factors'],key=lambda x:x[0]**x[1],reverse=True)
    result=[]; f=1
    for q,e in factors:
        result.append((q,e));f*=q**e
        if f*f>p:break
    return sorted(result)
def closure(rs,partial=False,cached=False):
    seen=set()
    def visit(p):
        if cached and p<=B or p in seen:return
        for q,e in (selected(p) if partial else nodes[p]['factors']):visit(q)
        seen.add(p)
    for p in rs:visit(p)
    return seen
def encode(name,ns,rs,partial=False,inverses=False):
    b=bytearray((b'POCK0002' if inverses else b'POCK0001')+struct.pack('<II',len(ns),len(rs)))
    offsets={}; count=collections.Counter()
    for p in sorted(ns):
        fs=selected(p) if partial else sorted(nodes[p]['factors'])
        f=1
        for q,e in fs:f*=q**e
        r=(p-1)//f
        offsets[p]=len(b)
        b+=struct.pack('<QQQB',p,nodes[p]['base'] or 0,r,len(fs))
        for q,e in fs:
            b+=struct.pack('<QB',q,e)
            if inverses:b+=struct.pack('<Q',pow((pow(nodes[p]['base'],(p-1)//q,p)-1)%p,-1,p))
        count[len(fs)]+=1
    for p in rs:b+=struct.pack('<Q',p)
    path=ROOT/(name+'.bin');path.write_bytes(b)
    return {'file':path.name,'nodes':len(ns),'roots':len(rs),'bytes':len(b),
            'bytes_per_root':len(b)/len(rs) if rs else None,
            'factor_count_histogram':dict(count),'sha256':hashlib.sha256(b).hexdigest(),
            'first_nontrivial_offset':next((offsets[p] for p in sorted(ns) if p>2),None),
            'last_node_offset':offsets[max(ns)] if ns else None}
small={p for p in nodes if p<=B}
smooth=[p for p in roots if all(q<=B for q,e in nodes[p]['factors'])]
reports={}
reports['small_cache']=encode('small_cache',small,[],False)
reports['full_pratt']=encode('full_pratt',closure(roots),roots,False)
reports['partial_pock']=encode('partial_pock',closure(roots,True),roots,True)
reports['cached_pock']=encode('cached_pock',closure(roots,True,True),roots,True)
reports['smooth_pock']=encode('smooth_pock',set(smooth),smooth,True)
reports['cached_inverse']=encode('cached_inverse',closure(roots,True,True),roots,True,True)
reports['smooth_inverse']=encode('smooth_inverse',set(smooth),smooth,True,True)
meta={'source_sha256':hashlib.sha256(SOURCE.read_bytes()).hexdigest(),'B':B,
      'root_count_with_duplicates':len(j['roots']),'distinct_roots':len(roots),
      'smooth_count':len(smooth),'smooth_fraction':len(smooth)/len(roots),
      'cases':reports}
(ROOT/'cases.json').write_text(json.dumps(meta,indent=2)+'\n')
print(json.dumps(meta,indent=2))
