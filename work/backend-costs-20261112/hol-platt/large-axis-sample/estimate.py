"""Size-biased stratum estimate for complete groups with checked return status."""
import hashlib
import json
import math
import sys
from collections import defaultdict
from pathlib import Path
from statistics import mean,stdev

HERE=Path(__file__).resolve().parent


def fold(bits=None):
    plan=json.loads((HERE/"sample.json").read_bytes())
    times=defaultdict(lambda: defaultdict(list))
    scope={}
    hashes={}
    jobs=[(group,"a02_"+group,None) for group in ("small","medium","long")]
    jobs.extend(("tail","a03_tail_"+str(i),i-1) for i in range(1,9))
    for group,label,index in jobs:
        if bits:
            label=f"g{bits}a_"+group+("_"+str(index+1) if index is not None else "")
        log=HERE/(label+".log")
        status=log.with_suffix(".status")
        if not status.is_file() or status.read_text().strip()!="0" or not log.is_file():
            continue
        assert "AXIS_DONE" in log.read_text()
        keys=[tuple(map(int,row.split()[:4])) for row in (HERE/(group+".txt")).read_text().splitlines()]
        observed_keys=keys
        if bits:
            observed_keys=[tuple(map(int,row.split()[:4])) for row in (HERE/(f"p{bits}_"+group+".txt")).read_text().splitlines()]
            assert len(observed_keys)==len(keys)
            assert all(k[::2]==c[::2] and c[1]==bits for k,c in zip(keys,observed_keys,strict=True))
        if index is not None:
            keys=[keys[index]]
            observed_keys=[observed_keys[index]]
        seen=set()
        panels=iter(line.split() for line in log.read_text().splitlines() if line.startswith("PANEL "))
        for key,observed in zip(keys,observed_keys,strict=True):
            for repeat in ([0,1,4,4,0] if key[0]<=8192 else [0,1,1,0]):
                _,n,p,c,w,r,_prep,sec,_decode=next(panels)
                assert tuple(map(int,(n,p,c,w)))==observed and int(r)==repeat
                times[key][repeat].append(float(sec))
            seen.add(key)
        assert next(panels,None) is None
        assert set(keys)==seen
        hashes[log.name]=hashlib.sha256(log.read_bytes()).hexdigest()
    totals=positions=0
    variance=0
    for band,st in plan["strata"].items():
        keys=list(map(tuple,st["draws"]))
        if not all(k in times for k in keys):
            continue
        measured=[]
        replicate=[]
        for k in keys:
            tt=times[k]
            n=k[0]
            r=4 if n<=8192 else 1
            assert len(tt[r])==2 and len(tt[0])==2
            # Each repetition includes generation of a shared source and chirps,
            # so estimate a marginal slice by differencing the two controls.
            per=[(v-mean(tt[0]))/r for v in tt[r]]
            assert min(per)>0
            measured.append(mean(per)/n)
            replicate.append([t/n for t in per])
        ones=st["positions"]/3600
        hr=ones*mean(measured)
        se=ones*stdev(measured)/math.sqrt(len(measured))
        scope[band]=dict(hours=hr,between_draw_SE_hours=se,per_position_us=[t*1e6 for t in measured],
                         measurement_order_hours=[ones*mean(t[i] for t in replicate) for i in (0,1)])
        totals+=hr
        variance+=se**2
        positions+=st["positions"]
    return dict(completed_sampling_strata=scope,covered_positions=positions,total_positions=47891544124008,
                weighted_estimate_hours_covered_strata=totals,between_draw_SE_hours_covered_strata=math.sqrt(variance),
                measurement_scope="One-core stock HOL diagnostic marginal slices, deterministic dense inputs. The formula omits library admission, actual source/chirp construction, late sign repair, and short axes.",
                measured_log_hashes=hashes,plan_sha256=hashlib.sha256((HERE/"sample.json").read_bytes()).hexdigest())


if __name__=="__main__":
    assert sys.argv[1:] in ([], ["p24"], ["p28"])
    bits = int(sys.argv[1][1:]) if len(sys.argv)>1 else None
    r=fold(bits)
    (HERE/(f"estimate-p{bits}.json" if bits else "estimate.json")).write_text(json.dumps(r,indent=2)+"\n")
    print(list(r["completed_sampling_strata"]),r["covered_positions"],r["weighted_estimate_hours_covered_strata"],
          r["between_draw_SE_hours_covered_strata"])
