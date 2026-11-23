from actual import *
import hashlib
def sha(f):return hashlib.sha256(f.read_bytes()).hexdigest()
meta=json.loads((src/'spectrum.json').read_text());assert meta['sha256']['coefficients.tsv']==sha(src/'coefficients.tsv')
grid=json.loads((src/'grid.json').read_text());assert grid['spectrum_sha256']==sha(src/'coefficients.tsv')
assert all(it['grid_sha256']==sha(src/('grid-%d.txt'%it['label'])) for it in grid['rows'])
audit=[]
for l in labels:
    jobs=[list(map(int,z.split())) for z in (old/f'jobs-{l}.txt').read_text().splitlines()]
    lengths=[int(z.split()[1]) for z in (src/'stencils.txt').read_text().splitlines()[1:111:2]]
    sup=set()
    for t,k in jobs:
        n=lengths[k];lo=t//4096+128+1-n//2;sup.update(range(lo,lo+n))
    seen=set()
    for row in (p/f'selected-{l}.tsv').read_text().splitlines():
        j,A,B,C,u,v,w,e,head=map(int,row.split());kind='repair' if j in sup else 'sign'
        if kind in seen:continue
        assert project(A,B,C,(u,v))//(1<<e)==head
        if abs(u+v)>=S//2:A+=1<<510
        else:C+=1<<510
        bad=project(A,B,C,(u,v))//(1<<e);assert bad!=head
        seen.add(kind);audit.append(dict(label=l,slot=j,kind=kind,expected=head,changed=bad))
    assert seen=={'repair','sign'}
    assert (p/f'heads-{l}.txt').read_bytes()==(old/f'heads-{l}.txt').read_bytes()
(p/'controls.json').write_text(json.dumps(dict(spectrum=sha(src/'coefficients.tsv'),changes=audit),indent=2))

