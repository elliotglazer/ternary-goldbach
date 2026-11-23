"""Bounded serial campaign. Reinvoke with --resume after interruption."""
import math
import json
import sys
import shutil
import msvcrt
import time
from split_factor import build as split_factor
import extend as e
from audit_campaign import audit as audit_chain


def run():
    audit_chain(0)
    first = 11207959554
    prior_module = "ExtendedPrefixB"
    prior = "SmallGoldbach.ContiguousExtensionB.binaryGoldbachUpTo"
    for num, count in enumerate([8, 12, 18, 27, 40, 61], 1):
        rows = 1024
        upper = first - 2 + 2*e.width*rows*count
        tag = f"GoldbachBand{num:02d}"
        public = tag+"Prefix"
        if shutil.disk_usage(e.HERE).free < 2*1024**3 + count*8*1024**2:
            raise RuntimeError("Insufficient reserve for next band")
        e.ns = "SmallGoldbach."+tag
        e.cutoff = math.isqrt(upper+2)
        common, leaves = tag+"Common",tag+"Shard"
        band = common,leaves,public,first,rows,count,prior_module,prior
        producer = e.HERE/(public+"Producer.json")
        if not producer.exists():
            e.generate(band)
        modules = [common,*[leaves+str(i) for i in range(count)],public]
        split_cpu = 0
        if num >= 5:
            t = time.process_time()
            split_factor(tag,e.cutoff)
            split_cpu = time.process_time()-t
            modules.insert(0,tag+"FactorLeaves")
        e.verify(modules)
        audit = (e.HERE/(public+".log")).read_text(encoding="utf8").strip()
        assert audit == f"'{e.ns}.binaryGoldbachUpTo' depends on axioms: [propext, Classical.choice, Quot.sound]"
        receipts = [json.loads((e.HERE/(name+".json")).read_text()) for name in modules]
        production = json.loads(producer.read_text())
        cursor = first
        for shard in production["shards"]:
            assert shard["start"] == cursor
            cursor = shard["end_exclusive"]
        assert cursor == upper+2
        data = dict(first_even=first,last_even=upper,new_even_count=(upper-first)//2+1,
            total_even_count=upper//2-1,prior_module=prior_module,modules=modules,audit=audit,
            produce_cpu_s=split_cpu+production["common_cpu_s"]+sum(s["producer_cpu_s"] for s in production["shards"]),
            verify_cpu_s=sum(r["user_seconds"]+r["system_seconds"] for r in receipts),
            peak_rss_kib=max(r["max_rss_kib"] for r in receipts),
            generated_bytes=sum(f.stat().st_size for f in e.HERE.glob(tag+"*") if f.is_file()))
        (e.HERE/(tag+"Receipt.json")).write_text(json.dumps(data,indent=2))
        audit_chain(num)
        print(public,upper,flush=True)
        first,prior_module,prior = upper+2,public,e.ns+".binaryGoldbachUpTo"


if __name__ == "__main__":
    if "--resume" not in sys.argv:
        sys.argv.append("--resume")
    with (e.HERE/"campaign.lock").open("a+b") as lock:
        lock.seek(0)
        msvcrt.locking(lock.fileno(),msvcrt.LK_NBLCK,1)
        run()
