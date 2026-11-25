#!/usr/bin/env python3
"""Regression controls for wrapped, missing, and damaged EC2 console evidence."""
import base64
import gzip
import hashlib
import json
import os
from pathlib import Path
import random
import stat
import sys
import tempfile
from contextlib import redirect_stdout
from io import StringIO
from unittest.mock import patch

import compact_watch as w

def main():
    a="0123456789abcdef"*2;c="a"*40;t="b"*40;d="d"*64
    path=f"/work/compact-joint-runs/{c}-{a}/run/evidence/receipt.json"
    rng=random.Random(42)
    s={"receipt_path":path,"receipt_sha256":d,"commit":c,"tree":t,"status":"failed",
       "padding":base64.b64encode(rng.randbytes(2600)).decode()}
    msg=json.dumps(s).encode()
    digest=hashlib.sha256(msg).hexdigest()
    body=base64.b64encode(gzip.compress(msg)).decode()
    note=f"2026-11-26T11:00:00Z joint-source-build\nRuntimeError: joint-source-build failed with 1; see {path}\n"
    ref=f"TG435_RECEIPT_REF {path} {d}\n"
    mark=f"TG435_RECEIPT_V1 {digest} "
    for sep in ["\r\n","\n","\r","\r\n[  122.3333] ","\n2026-11-26T11:00:00Z "]:
        payload=body[:913]+sep+body[913:1812]+sep+body[1812:]
        assert w.exact_receipt(note+ref+mark+payload,c,t,a)==(s,msg)
        outer=base64.b64encode((ref+mark+payload).encode()).decode()
        assert w.exact_receipt(outer,c,t,a)==(s,msg)
    valid=ref+mark+body+"\n"
    bad=ref+mark+body[:913]+"\n"
    conflict=ref.replace(" "+d," "+"e"*64)+mark+body+"\n"
    assert w.exact_receipt(bad+valid,c,t,a)==(s,msg)
    assert w.exact_receipt(valid+bad,c,t,a)==(s,msg)
    for damaged in [bad, ref, ref+mark+"%%%malformed\n",ref+mark+body[:913]+"\n[malicious] "+body[913:],
                    ref+mark+body[:913]+"\n"+body[914:],ref+mark+body[:913]+"\n"+body[913:950]+"\nboot completed"]:
        assert w.exact_receipt(damaged,c,t,a) is None
        assert w.exact_reference(damaged,c,a)==(path,d)
    assert w.exact_reference(ref.replace(a,a+"1"),c,a) is None
    try:w.exact_reference(ref+conflict,c,a);raise AssertionError("conflicting digest accepted")
    except ValueError:pass
    with tempfile.TemporaryDirectory() as tmp:
        orig=os.getcwd();os.chdir(tmp)
        try:
            h="i-"+"a"*17
            def aws(*args):
                return {"describe-stack-resource":{"StackResourceDetail":{"PhysicalResourceId":h}},
                        "describe-instances":{"Reservations":[{"Instances":[{"State":{"Name":"stopped"}}]}]},
                        "get-console-output":{"Output":note+bad}}[args[1]]
            capture=StringIO()
            with patch.object(w,"aws",aws),patch.object(sys,"argv",["watch","--commit",c,"--tree",t,"--attempt",a,"--instance",h]),redirect_stdout(capture):
                assert w.main()==2
            files=list(Path.cwd().glob("compact-console-*.txt"));assert len(files)==1
            assert files[0].read_bytes()==(note+bad).encode() and stat.S_IMODE(files[0].stat().st_mode)==0o600
            output=capture.getvalue()
            assert "TG435_REF_ONLY "+path+" "+d in output and "terminal mathematical status unverified" in output
            assert "error joint-source-build exit 1" in output and "EC2 stopped" in output
        finally:os.chdir(orig)
    print("wrapped V1 at 913, timestamp continuations, corrupt/truncated/repeated references, private raw save and REF-only controls passed")

if __name__=="__main__":main()
