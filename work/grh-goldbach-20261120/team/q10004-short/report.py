"""Recompute timings, bind source hashes and check the four kernel receipt exports."""
from hashlib import sha256
import json,re
from pathlib import Path

here=Path(__file__).resolve().parent
def hash_file(p):return sha256(p.read_bytes()).hexdigest()
out={}
for name,n in [('ShortUnary',13),('ShortBatch',13),('PanelUnary',270),('PanelBatch',270),('PanelJoin',270),('ActualSign',1),('PanelFast',270)]:
    export=here/(name+'.sha256')
    if name=='PanelFast' and not export.exists():continue
    log=(here/(name+'.log')).read_text()
    time=(here/(name+'.time')).read_text()
    h=export.read_text().split()[0]
    assert h==hash_file(here/'.hol/objs'/(name+'Theory.dat'))
    assert f'Exporting theory "{name}" ... done.' in log
    row=dict(rows=n,sha256=h,worker_cpu=sum(float(re.search(rf'{k} time \(seconds\): ([.\d]+)',time)[1]) for k in ('User','System')))
    def total(pattern):return sum(float(x) for x in re.findall(pattern,log,re.M))
    if 'KERNEL_WITH_ENCODING' in log:
        row.update(read_cpu=total(r'^READ ([.\d]+)'),term_cpu=total(r'^TERMS ([.\d]+)'),kernel_including_conversion_cpu=total(r'^KERNEL_WITH_ENCODING \S+ ([.\d]+)'))
    if name=='PanelJoin':row['join_cpu']=total(r'^MATCHED_BATCH_FROM_270 ([.\d]+)')
    if name=='PanelFast':row.update(conversion_cpu=total(r'^CONVERT_SOURCE ([.\d]+)'),kernel_cpu=total(r'^PURE_KERNEL ([.\d]+)'),read_cpu=total(r'^READ ([.\d]+)'),term_and_definition_cpu=total(r'^TERMS ([.\d]+)'))
    out[name]=row
source=here.parents[2]/'backend-costs-20261112/hol-platt/guard-repricing/strip-repair-packets-stress.tsv'
result=dict(receipts=out,panel_source_sha256=hash_file(source),direct_hurwitz_packet_sha256=hash_file(here/'short.txt'),
    source_scope='13 closed numeric checks include outward source decimal intervals. The 270 input rows contain fixed integer centers, weights and remainder ceilings. Their analytic admission and target remainder are separate premises.')
(here/'timings.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result,indent=2))
