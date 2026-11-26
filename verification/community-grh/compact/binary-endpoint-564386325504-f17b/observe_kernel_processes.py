"""Sample the complete PPid chain of the authenticated Linux comparator tree."""
import argparse
from datetime import datetime, timezone
import json
import os
from pathlib import Path
import time

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument("job", type=Path)
parser.add_argument("--period", type=float, default=5)
args = parser.parse_args()
job = args.job
tick = os.sysconf("SC_CLK_TCK")
rows = {}
out = job / "kernel-process-observations.json"
temporary = job / "kernel-process-observations.tmp"
while True:
    observed = datetime.now(timezone.utc).isoformat()
    kernel = json.loads((job / "receipt.json").read_bytes())
    stage = kernel.get("stages", {}).get("protected-kernels", {})
    lake_pids = {int(k) for k, v in stage.get("sampled_processes", {}).items() if v.get("exe") == "lake"}
    all_stats = {}
    for entry in Path("/proc").iterdir():
        if not entry.name.isdigit():
            continue
        try:
            raw = (entry / "stat").read_text()
            prefix, fields = raw.rsplit(") ", 1)
            comm = prefix.split(" (", 1)[1]
            parts = fields.split()
            all_stats[int(entry.name)] = (int(parts[1]), comm, parts)
        except (OSError, ValueError, IndexError):
            continue
    uptime = float(Path("/proc/uptime").read_text().split()[0])
    for pid, (_, comm, parts) in all_stats.items():
        if comm not in {"lake", "nanoda_bin", "leanchecker"}:
            continue
        ancestor = pid
        while ancestor in all_stats and ancestor not in lake_pids:
            ancestor = all_stats[ancestor][0]
        if ancestor not in lake_pids:
            continue
        try:
            lines = Path(f"/proc/{pid}/status").read_text().splitlines()
            rss = int(next(line for line in lines if line.startswith("VmHWM:")).split()[1])
        except (OSError, StopIteration):
            continue
        row = rows.setdefault(str(pid), {"exe": comm, "first_observed_utc": observed, "samples": 0})
        row.update(last_observed_utc=observed, samples=row["samples"]+1, start_ticks=int(parts[19]),
                   lake_ancestor=ancestor, user_cpu_s_lower_bound=int(parts[11])/tick,
                   system_cpu_s_lower_bound=int(parts[12])/tick,
                   lifetime_s_lower_bound=round(uptime-int(parts[19])/tick, 3),
                   peak_rss_kib_lower_bound=max(row.get("peak_rss_kib_lower_bound", 0), rss))
    state = {"method": "Linux /proc field counters for processes descending from the stock comparator's authenticated Lake PID",
             "clock_ticks_per_second": tick, "sampling_period_s": args.period, "updated_utc": observed,
             "comparator_status": stage.get("status"), "processes": rows}
    temporary.write_text(json.dumps(state, indent=2) + "\n", encoding="utf8")
    temporary.replace(out)
    if kernel.get("finished_utc"):
        print(json.dumps({p: r["exe"] for p, r in rows.items()}), flush=True)
        break
    time.sleep(args.period)
