"""Reconcile actual benchmark totals and check the stock-HOL receipts and input hashes."""
from fractions import Fraction as F
from hashlib import sha256
import json
from pathlib import Path
import re
from spectrum import HERE,LABELS


def read(name):
    return json.loads((HERE/name).read_bytes())


def run_logs(theory,marker):
    good=[]
    for f in HERE.glob("*.status"):
        log=f.with_suffix(".log")
        if f.read_text().strip()=="0" and marker in log.read_text(errors="replace"):
            good.append(log)
    assert good,(theory,marker)
    log=max(good,key=lambda p:p.stat().st_mtime_ns)
    text=log.read_text(errors="replace")
    timer=log.with_suffix(".time").read_text()
    def num(key):
        return float(re.search(key+r":\s*([\d.]+)",timer).group(1))
    for line in log.with_suffix(".sha256").read_text().splitlines():
        digest,filename=line.split(maxsplit=1)
        assert sha256((HERE/filename).read_bytes()).hexdigest()==digest,(log,filename)
    dat=HERE/".hol/objs"/(theory+"Theory.dat")
    result=dict(log=log.name,process_cpu=num(r"User time \(seconds\)")+num(r"System time \(seconds\)"),
                peak_kib=num(r"Maximum resident set size \(kbytes\)"),
                export_bytes=dat.stat().st_size,export_sha256=sha256(dat.read_bytes()).hexdigest())
    return text,result


def main():
    count=read("counts.json")
    for f,digest in count["sha256"].items():
        assert sha256((HERE/f).read_bytes()).hexdigest()==digest
    spec,grid=read("spectrum.json"),read("grid.json")
    assert grid["spectrum_sha256"]==sha256((HERE/"coefficients.tsv").read_bytes()).hexdigest()
    for ch in grid["rows"]:
        assert sha256((HERE/("grid-%d.txt"%ch["label"])).read_bytes()).hexdigest()==ch["grid_sha256"]
        assert len(ch["checks"])==4
    cross=read("independent.json")
    assert len(cross["checks"])==4 and len(cross["gamma"])==2
    packs,stencils,parity=read("pack.json"),read("stencils.json"),read("parity.json")
    assert cross["input_sha256"]==stencils["packet_sha256"]==sha256((HERE/"stencils.txt").read_bytes()).hexdigest()
    assert parity["input_sha256"]==sha256((HERE/"counts.json").read_bytes()).hexdigest()
    assert all(p["tests"][1]["moderate_two_unit"] and p["tests"][2]["moderate_one_unit"] for p in parity["pairs"])
    lower=[]
    for pair in (LABELS[:2],LABELS[2:]):
        item=count["counts"][str(pair)]
        a=item["fixed"][-1]
        assert F(a["exact_margin"]["moderate"])>0
        assert F(item["fixed"][0]["exact_margin"]["Rumely"])>0
        lower.append(dict(labels=pair,coarse=item["coarse"][-1]["K"],edge=item["edge"][-1]["K"],
                          repaired=a["K"],upper_minus_lower=a["U_minus_K"]["moderate"]))
    _,generic=run_logs("FullCount",'Saved theorem _______ "exact_count_of_parity"')
    log,counting=run_logs("CountReceipt","FULL_COUNT_RECEIPT_DONE")
    assert "PAIR_RESULT 0 T" in log and "PAIR_RESULT 1 T" in log
    def number(s):
        return float(s.replace("~","-"))
    rates=[tuple(map(number,r)) for r in re.findall(r"TIMED runs_\d+ ([\d.E+~-]+) ([\d.E+~-]+) ([\d.E+~-]+)",log)]
    assert len(rates)==8
    counting["admit_evaluate_decode_cpu"]=[sum(row[j] for row in rates) for j in range(3)]
    _,short=run_logs("ShortGuard","PARITY_WIDTH25_DONE")
    log,st=run_logs("StencilReceipt","STRICT_STENCIL_JOBS 114")
    durations = re.findall(r"ENCODED y_(\d+)_(\d+) (\S+) (\S+)",log)
    assert len(durations)==114
    st["admit_evaluate_cpu"]=[sum(number(r[i]) for r in durations) for i in (2,3)]
    log,weights=run_logs("KernelWeights","EXACT_LAGRANGE_KERNELS 55 6")
    assert len(re.findall(r'Saved theorem _+ "kernel_\d+_lagrange"',log))==55
    assert len(re.findall(r'Saved theorem _+ "radius_\d+"',log))==6
    queries=sum(c["discovery_requests"] for c in count["channels"])
    edges=sum(c["edge_requests"] for c in count["channels"])
    coarse=sum(c["coarse"] for c in count["channels"])
    assert queries+edges==stencils["jobs"]==114
    dev=[]
    for status in sorted(HERE.glob("*.status")):
        if status.read_text().strip()=="0":
            continue
        t=status.with_suffix(".time").read_text()
        seconds=sum(float(v) for v in re.findall(r"(?:User|System) time \(seconds\):\s*([\d.]+)",t))
        dev.append(dict(attempt=status.stem,cpu=seconds))
    summary=dict(lower=lower,coarse=coarse,sparse_interior=queries,endpoint=edges,packed_blocks=sum(x["blocks"] for x in packs),
                 scanned=sum(x["entries"] for x in packs),interp_products=stencils["terms"],
                 generator_cpu=spec["cpu_seconds"],grid_cpu=grid["total_cpu"],
                 independent_L_in_grid_cpu=sum(r["reference_cpu"] for r in grid["rows"]),
                 discovery_cpu=sum(c["discovery_cpu"] for c in count["channels"]),full_native_repair_cpu=count["total_cpu"],
                 hol_generic=generic,hol_count=counting,hol_short=short,hol_sparse=st,hol_exact_weights=weights,
                 local_development_failed_attempts=dev)
    (HERE/"results.json").write_text(json.dumps(summary,indent=2)+"\n")
    print(summary)


if __name__=="__main__":
    main()
