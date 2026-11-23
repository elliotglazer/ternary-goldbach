"""Read the three pinned inputs and verify the packet/archive association."""
from hashlib import sha256
from pathlib import Path
import json

def inputs():
    s=Path(__file__).resolve().parent.parent/"guard-repricing"
    w=json.loads((s/"strip-parameter-witnesses.json").read_bytes())
    p=(s/"strip-repair-panel-stress.json").read_bytes()
    t=(s/"strip-repair-packets-stress.tsv").read_bytes()
    sh=json.loads((s/"strip-shortcut.json").read_bytes())
    assert sha256(t).hexdigest()==w["packet_sha256"]==sh["packet_sha256"] and sha256(p).hexdigest()==w["panel_sha256"]
    return w,json.loads(p),[list(map(int,row.split())) for row in t.splitlines()],sh
