"""Verify the one-line edits and, when supplied, the original production timings."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import subprocess

def require(ok,msg):
    if not ok:
        raise ValueError(str(msg))

def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument("--repo",required=True,type=Path)
    p.add_argument("--warm-log",type=Path)
    a=p.parse_args()
    root=Path(__file__).resolve().parent
    src=json.loads((root/"source-manifest.json").read_bytes())
    linux=json.loads((root/"linux-production-intervals.json").read_bytes())
    summary=json.loads((root/"measurement-summary.json").read_bytes())
    for name,expected in summary["evidence_sha256"].items():
        require(hashlib.sha256((root/name).read_bytes()).hexdigest()==expected,name)
    git=["git","-C",str(a.repo)]
    env=dict(os.environ,GIT_NO_LAZY_FETCH="1")
    def g(*cmd):
        return subprocess.check_output(git+list(cmd),env=env)
    require(g("rev-parse",src["commit"]+"^{tree}").decode().strip()==src["tree"],"candidate tree mismatch")
    require(g("rev-parse",src["commit"]+"^").decode().strip()==src["parent"],"candidate parent mismatch")
    names=sorted(src["files"])
    changed=g("diff-tree","--no-commit-id","--name-only","-r",src["parent"],src["commit"]).decode().splitlines()
    require(sorted(changed)==[n+".lean" for n in names],"unexpected changed paths")
    marker=b"set_option maxRecDepth 20000\n"
    delta=b"set_option Elab.async false\n"
    for module in names:
        r=src["files"][module]
        old=g("cat-file","blob",r["old"])
        new=g("cat-file","blob",r["new"])
        require(g("rev-parse",src["parent"]+":"+module+".lean").decode().strip()==r["old"],module)
        require(g("rev-parse",src["commit"]+":"+module+".lean").decode().strip()==r["new"],module)
        require(old.count(marker)==1 and delta not in old and old.replace(marker,marker+delta)==new,module)
        require(hashlib.sha256(new).hexdigest()==r["sha256"],module)
        checkers=re.findall(rb"^private theorem c[0-9]+ : Covered ",new,re.M)
        require(len(checkers)==r["checkers"] and new.count(b"(by decide +kernel)")==r["kernel_checks"],module)
    require(len(names)==103 and sum(x["checkers"] for x in src["files"].values())==6248,"unexpected selection")
    if a.warm_log:
        raw=a.warm_log.read_bytes()
        require(hashlib.sha256(raw).hexdigest()==linux["warm_log_sha256"],"full production log hash mismatch")
        seen={}
        for m in re.finditer(r"\bBuilt (ProductRange\d+Interval) \(([0-9.]+)(ms|s|min)\)",raw.decode("utf8")):
            mod=m[1]
            if mod not in src["files"]:
                continue
            require(mod not in seen,("duplicate producer timing",mod))
            seen[mod]=float(m[2])*{"ms":.001,"s":1.0,"min":60.0}[m[3]]
        require(set(seen)==set(names),"not all 103 reached a Built result")
        require(all(seen[n]==linux["modules"][n]["seconds"] for n in names),"timings mismatch")
    print(f"Verified {len(names)} one-line source edits and 6248 checker applications")
    if a.warm_log:
        print(f"Verified the 103 completed Linux builds, totalling {sum(seen.values()):.1f} reported module-seconds")

if __name__=="__main__":
    main()
