"""Strict completed-run log validation; never runs arithmetic or SML."""
from pathlib import Path
import collections,json,math,sys

def main():
    path=Path(sys.argv[1]); order=sys.argv[2]
    assert order in ('stock-first','typed-first')
    lines=path.read_text(encoding='utf-8').splitlines()
    labels=['depth1','depth8','depth32','depth128']+[f'control_{s}' for s in ('checksum','bound','depth','input','coefficient')]
    def exact(s): assert lines.count(s)==1,s
    exact('TYPED_ORDER,'+order)
    exact('TYPED_EDGES_PASS,22')
    exact('HOL4_TYPED_DEPENDENT_BENCHMARK_DONE')
    expected=[]
    for family,n in [('round',8),('array',6)]:
        for i in range(n):
            expected += [f'edge_{family}{i}:{s}' for s in ('discover','parse','stock_kernel_reference')]
    for label in labels:
        expected.append(label+':decode_validate')
        for kind in ('array','accept'):
            expected += [label+'_'+kind+':'+s for s in ('discover','parse','stock_kernel_reference')]
        for i in range(3): expected += [f'{label}:r{i}:{s}' for s in ('stock_array','typed_array','stock_accept','typed_accept')]
    rows=[]
    for line in lines:
        if line.startswith('TYPED_TIME,'):
            fields=line.split(',');assert len(fields)==4
            cpu,wall=map(float,fields[2:]);assert all(math.isfinite(v) and v>=0 for v in (cpu,wall))
            rows.append({'label':fields[1],'cpu_seconds':cpu,'wall_seconds':wall})
    assert len(rows)==len(expected)==213
    assert collections.Counter(r['label'] for r in rows)==collections.Counter(expected)
    passes=[s.split(',') for s in lines if s.startswith('TYPED_WORKLOAD_PASS,')]
    assert len(passes)==9 and collections.Counter(s[1] for s in passes)==collections.Counter(labels)
    for p in passes:
        depth=int(p[1][5:]) if p[1].startswith('depth') else (7 if p[1]=='control_depth' else 8)
        assert p==['TYPED_WORKLOAD_PASS',p[1],'points=128',f'depth={depth}'],p
    for c in ('checksum','bound','depth','input','coefficient'):exact('HOL4_REJECTED_'+c)
    # Reject any additional malformed/duplicate status markers of these families.
    for prefix,count in [('TYPED_ORDER,',1),('TYPED_EDGES_PASS,',1),('HOL4_REJECTED_',5)]:
        assert sum(s.startswith(prefix) for s in lines)==count
    result={'status':'completed log gates passed; source/executable bindings still required',
            'order':order,'edge_checks':22,'workloads':9,'timing_rows':rows}
    out=Path(sys.argv[3]);assert not out.exists()
    with out.open('x',encoding='utf-8') as f:json.dump(result,f,indent=2);f.write('\n')
    print('TYPED_LOG_VALIDATED,213')
if __name__=='__main__':main()
