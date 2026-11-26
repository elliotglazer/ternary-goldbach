#!/usr/bin/env python3
import base64
import hashlib
import json
from pathlib import Path
import random
import subprocess
import sys
import tempfile
import compact_collect as c
import compact_joint_stack as stack
import compact_watch as w

def main():
    commit,tree,attempt="a"*40,"b"*40,"1"*32
    canonical=f"/work/compact-joint-runs/{commit}-{attempt}"
    sr=stack.DRIVER.split("<<'TG_SUMMARY'\n",1)[1].split("\nTG_SUMMARY",1)[0]
    with tempfile.TemporaryDirectory() as tmp:
        path=Path(tmp)/(commit+"-"+attempt);receipt=path/"run/evidence/receipt.json"
        receipt.parent.mkdir(parents=True)
        def emit(pad):
            record={"status":"verified","pin":commit,"git_tree":tree,"steps":[],"root":canonical+"/run","padding":pad}
            raw=(json.dumps(record,indent=2)+"\n").encode();receipt.write_bytes(raw)
            return raw,subprocess.check_output([sys.executable,"-",str(path),commit,tree,"0"],input=sr,text=True)
        pad=base64.b64encode(random.Random(1031).randbytes(4500)).decode()
        raw,printed=emit(pad);wire=printed.splitlines()
        digest=hashlib.sha256(raw).hexdigest();r=(canonical+"/run/evidence/receipt.json",digest)
        # The fixture's temporary directory supplies real bytes. Production's exact absolute path
        # is checked independently, and the encoder's real REF/V1 still must match each other.
        assert c.read_summary(printed,commit,tree)[0]["receipt_sha256"]==digest
        assert wire[-2].startswith("TG435_RECEIPT_REF") and wire[-1].startswith("TG435_RECEIPT_V1")
        frames=wire[:-2]
        assert len(frames)>1 and max(map(len,frames))<700 and len(printed.encode())<=24*1024
        def check(text):return c.console_full(text,commit,tree,attempt,r,{"status":"verified"})
        assert check("\r\n".join(frames))[1]==raw
        assert check("\n".join(frames+[frames[1]]))[1]==raw
        def reject(text):
            try:check(text);raise AssertionError("damaged frame was accepted")
            except ValueError:pass
        reject("\n".join(frames[1:]))
        line=frames[1];tok,frag=line.rsplit(" ",1);corrupt=tok+" "+("A" if frag[0]!="A" else "B")+frag[1:]
        reject("\n".join(frames+[corrupt]))
        reject("\n".join([frames[0],corrupt,*frames[2:]]))
        bad=raw.replace(b'"status": "verified"',b'"status": "failed"')
        assert c.console_full(printed,commit,tree,"2"*32,None) is None
        assert c.console_full(printed,commit,"f"*40,attempt,(r[0],"e"*64)) is None
        for wrong in [(commit,"3"*40,attempt,r,{"status":"verified"}),(commit,tree,attempt,r,{"status":"failed"})]:
            try:c.console_full(printed,*wrong);raise AssertionError("invalid inner status/pin")
            except ValueError:pass
        large=base64.b64encode(random.Random(309).randbytes(42000)).decode()
        _,overflow=emit(large)
        assert "TG435_FULL_V1" not in overflow and c.read_summary(overflow,commit,tree)[0]["status"]=="verified"
        assert c.console_full(overflow,commit,tree,attempt,r) is None
        # Validate the emitted startup receipt even when no previous worker file exists.
        receipt.unlink()
        result=subprocess.check_output([sys.executable,"-",str(path),commit,tree,"8"],input=sr,text=True)
        initial=json.loads((path/"startup-receipt.json").read_text())
        assert (initial["pin"],initial["git_tree"],initial["status"])==(commit,tree,"failed") and "TG435_FULL_V1 " in result
    print("Multiple bounded full frames, exact original bytes, missing/corrupt/conflicting frames, proof/status mismatch, oversized fallback and early startup receipt passed.")

if __name__=="__main__":main()
