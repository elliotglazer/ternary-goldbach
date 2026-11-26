#!/usr/bin/env python3
"""Run chained permission checks in an actual non-root process using root-owned job anchors."""
import json, os, subprocess, sys
from pathlib import Path as P
import test_warm_layers as fixture
from warm_main import validate_previous

def under_builder(token,work,rows,deps,tool,available,queue):
    # The two paths below belong exclusively to this temporary test job.
    assert work.parent.parent==P("/tmp") and queue.parent==P("/var/lib")
    os.chmod(work.parent,0o755);os.chmod(queue,0o755)
    spec=work/"input-for-uid65534.json"
    spec.write_text(json.dumps({"token":token,"rows":rows,"deps":{n:list(v) for n,v in deps.items()},
                               "tool":str(tool),"available":list(available),"queue":str(queue)}))
    out=work/"source/.lake/build"
    os.chown(work,65534,65534);os.chown(out,65534,65534)
    for d in out.rglob("*"):
        if d.is_dir():os.chown(d,65534,65534)
    p=subprocess.run(["setpriv","--reuid=65534","--regid=65534","--clear-groups",sys.executable,
                      "-B",__file__,"--child",str(work)],text=True,capture_output=True)
    # The outer source fixture runs its later compilers as the original temporary-directory owner.
    # Restore only its disposable new output, never the previous diagnostic inputs.
    os.chown(work,0,0);os.chown(out,0,0)
    for t in out.rglob("*"):os.chown(t,0,0)
    if p.returncode:raise ValueError(p.stderr.splitlines()[-1].removeprefix("ValueError: "))
    return json.loads(p.stdout)

if __name__=="__main__":
    if sys.argv[1]=="--child":
        assert os.getuid()==65534
        w=P(sys.argv[2]);v=json.loads((w/"input-for-uid65534.json").read_bytes())
        r=validate_previous(v["token"],w,{k:tuple(z) for k,z in v["rows"].items()},
              {k:set(z) for k,z in v["deps"].items()},P(v["tool"]),set(v["available"]),queue=P(v["queue"]))
        print(json.dumps(r))
    else:
        fixture.validate_previous=under_builder
        fixture.main(*map(P,sys.argv[1:]))
