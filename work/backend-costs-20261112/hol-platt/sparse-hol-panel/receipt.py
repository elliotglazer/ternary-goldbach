from pathlib import Path
import re,hashlib,json
here=Path(__file__).resolve().parent
out={}
import sys
for q in (sys.argv[1:] or ["7689","7283"]):
    d=here/q
    spec=json.loads((here.parent/"sparse-full-panel"/q/"spectrum.json").read_text())
    retained=sum(x["raw"] for x in json.loads((here.parent/"sparse-full-panel"/q/"fractions.json").read_text()))
    dense=4*(spec["final"]+257)
    item={"main_index":spec["main"],"main_height":spec["main"]*5/64,"guard_index":spec["final"],"guard_height":spec["final"]*5/64,"dense":dense,"retained":retained,"processes":{}}
    for tag in ("HeadProjection","SparseHead","PanelTables","HeadPairEven","HeadPairOdd"):
        files=[p for p in d.glob("*"+tag+".status") if p.read_text().strip()=="0"]
        p=sorted(files)[-1]
        timing=p.with_suffix(".time").read_text()
        log=p.with_suffix(".log").read_text(encoding="utf8",errors="replace")
        user,system=[float(re.search(k+r" time \(seconds\): ([0-9.]+)",timing)[1]) for k in ("User","System")]
        item["processes"][tag]={"user":user,"system":system,"cpu":user+system,"rss_kb":int(re.search(r"Maximum resident set size \(kbytes\): (\d+)",timing)[1]),"markers":[l for l in log.splitlines() if l.startswith(("RETAINED_PROJECTION","HEAD_INPUT","JOIN_EVAL","HEAD_CHANNEL","HEAD_PAIR_DONE","TABLE_SETUP"))],"export_sha256":hashlib.sha256((d/".hol/objs"/(tag+"Theory.dat")).read_bytes()).hexdigest()}
    groups=(d/"targets.txt").read_text().splitlines()
    basis_cpu=0
    for name in [x for x in groups if x.startswith("PanelWeights")]:
        path=next(x for x in sorted(d.glob("*"+name+".status")) if x.read_text().strip()=="0")
        timing=path.with_suffix(".time").read_text()
        basis_cpu+=sum(float(re.search(k+r" time \(seconds\): ([0-9.]+)",timing)[1]) for k in ("User","System"))
    item["basis_chunks_cpu"]=basis_cpu
    item["hashes"]={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for pattern in ("heads-*.txt","jobs-*.txt","main-*.txt","aux-*.txt","target-*.txt","pair-*.txt","retained.hex","kernels.txt","SparseHeadScript.sml","headobserve.sml") for p in d.glob(pattern)}
    costs=item["processes"]
    total=sum(costs[k]["cpu"] for k in ("HeadProjection","HeadPairEven","HeadPairOdd"))
    item.update(cold_projection_pair_cpu=total,us_per_dense=total/dense*1e6,us_per_retained=total/retained*1e6)
    costsum=sum(sum(float(s.split()[-1]) for s in costs[t]["markers"] if s.startswith("HEAD_CHANNEL") or s.startswith("HEAD_PAIR_DONE") or s.startswith("RETAINED_PROJECTION")) for t in costs)
    item.update(internal_cpu=costsum,internal_us_dense=costsum/dense*1e6,internal_us_retained=costsum/retained*1e6)
    out[q]=item
(here/("receipt"+("-"+sys.argv[1] if len(sys.argv)>1 else "")+".json")).write_text(json.dumps(out,indent=2))
print([(q,{k:r[k] for k in r if k not in ("processes","hashes")}) for q,r in out.items()])


