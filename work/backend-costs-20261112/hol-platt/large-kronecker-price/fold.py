"""Reconstruct the canonical outer-axis traversal and reconcile guarded operands."""
from collections import Counter,defaultdict
import csv,gzip,hashlib,json
from pathlib import Path
here=Path(__file__).resolve().parent
agents=here.parents[2]/'qrh-campaign/agents'
pins={
'integration/transform_structural_manifest_20261111.json':'a41d70db2bb439d73cc817f80b24cb598d3efa89cce1d19a5fa618abbe239637',
'major-constants/combined_conductor_precision_rows_20261111.json':'2b9c245dca582c93bffcb022cee858d09b07637d1d1d1f37d5c1fe5bdf94dbcb',
'integration/short_window_guard_conductor_rows_20261111.json':'a75e4ee6ebbbd5ba82aa91377040228140596989e03667148b55900f53ade3ea'}
def read(name):
    b=(agents/name).read_bytes()
    assert hashlib.sha256(b).hexdigest()==pins[name]
    return json.loads(b)
m,pr,gr=map(read,pins)
dag={(row[0],row[1]):row[-1] for row in m['requests']}
hist=defaultdict(lambda:[0,0])
total=Counter()
ops=defaultdict(Counter)
maxima={}
for rid,(raw,prices,guard) in enumerate(zip(m['conductors'],pr['rows'],gr['rows_data'],strict=True)):
    c,phi,prim,H,J,axes,ws=raw
    assert prices[:4]==[rid,c,phi,prim] and guard[:4]==[c,J,phi,prim]
    assert c>10000 and (c<=132900 if c%2 else c%4==0 and c<=265800)
    p=prices[-2]
    assert all(sum(ws[i:i+5])+sum(guard[-1][i:i+5])==J+e+41 for i,e in zip(range(0,20,5),[0,167,320,640]))
    full=kept=1
    suffix=phi
    check=[0]*5
    h=J+41
    for n,q in axes:
        kept_n=n if q==0 else n-n//q
        suffix//=n
        lines=kept*suffix
        # Envelope for stage input, from the ledger's 2*full*16384 width contract.
        cap=2*full*16384
        # For each rounded prechirp coordinate |a| <= 2*cap*S+2, kernel |b|<=S.
        S=1<<p
        digit_bytes=((2*n*(2*cap*S+2)*S).bit_length()+1+7)//8
        hist[n,p,q,cap,digit_bytes][0]+=lines*h
        hist[n,p,q,cap,digit_bytes][1]+=lines
        band='short' if n<32 else 'packed'
        for i,v in enumerate(dag[n,q]):
            check[i]+=lines*v
            ops[band][i]+=lines*h*v
        total[band+'_lines']+=lines*h
        total[band+'_all_inputs']+=n*lines*h
        total[band+'_retained_outputs']+=kept_n*lines*h
        if n>=32:
            total['odd_packed_lines']+=(n%2)*lines*h
            for label,val in [('length',n),('lane_bytes',digit_bytes),('packed_bytes',n*digit_bytes)]:
                if label not in maxima or val>maxima[label][0]: maxima[label]=[val,c,n,p,cap]
        full*=n
        kept*=kept_n
    assert kept==prim and full==phi and check==guard[4]
    total['conductors']+=1
    total['conductor_nodes']+=h
    total['residue_inputs']+=phi*h
    total['primitive_outputs']+=prim*h
assert [total[k] for k in ['conductors','conductor_nodes','residue_inputs','primitive_outputs']]==[125400,1528006797,60254515577760,36468561640066]
assert list(sum(ops[b][i] for b in ('packed','short')) for i in range(4))==[1009140175344178,2090319798067922,92576511158537,19970124208]
with gzip.open(here/'axis-histogram.csv.gz','wt',newline='') as f:
    w=csv.writer(f)
    w.writerow(('n','p','omit_modulus','input_coordinate_cap','lane_bytes','base_plus_41_slices','slices_per_extra_node','input_per_slice','retained_outputs_per_slice'))
    for (n,p,q,cap,d),(count,extra) in sorted(hist.items()):
        w.writerow((n,p,q,cap,d,count,extra,n,n if not q else n-n//q))
by_p=Counter()
bins=defaultdict(lambda:Counter())
for (n,p,q,cap,d),(count,unit) in hist.items():
    if n<32: continue
    by_p[p]+=count
    b=(n-1).bit_length()
    z=bins[b]
    z['slices']+=count
    z['extra']+=unit
    z['max_length']=max(z['max_length'],n)
    z['max_p']=max(z['max_p'],p)
    z['max_cap']=max(z['max_cap'],cap)
    z['max_lane_bytes']=max(z['max_lane_bytes'],d)
r=dict(threshold=32,total=total,ops=ops,maxima=maxima,p_counts=by_p,bins=bins,
       hist_rows=len(hist),unique_packed_kernel_keys=len({(n,p,d) for n,p,q,cap,d in hist if n>=32}),pins=pins)
(here/'counts.json').write_text(json.dumps(r,indent=2))
print(json.dumps({k:r[k] for k in ('total','maxima','hist_rows','unique_packed_kernel_keys')},indent=2))
