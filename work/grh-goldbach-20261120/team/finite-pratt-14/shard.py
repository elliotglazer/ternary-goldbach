"""Bound certificate elaboration by exporting small sequential chunks."""
import json, re, subprocess, sys
from pathlib import Path
here=Path(__file__).resolve().parent
source=(here/"Pratt14.lean").read_text()
header,body=source.split("theorem p2",1)
items=re.split(r"(?=^theorem p\d+\s*:)", "theorem p2"+body.rsplit("end Pratt14",1)[0],flags=re.M)[1:]
assert len(items)==json.loads((here/"producer.json").read_text())["nodes"]
prev="PrimeSupport"
command=[sys.executable,str(here.parent/"small-prefix/check.py"),"--scope",str(here),"--memory","1750"]
for i in range(0,len(items),34):
    name=f"PrattChunk{i//34:02}"
    (here/(name+".lean")).write_text(header.replace("import PrimeSupport","import "+prev)+"".join(items[i:i+34])+"end Pratt14\n",encoding="utf8")
    receipt=here/(name+".json")
    if not receipt.exists() or json.loads(receipt.read_text())["exit"]:
        subprocess.run([*command,name],check=True)
    prev=name
p=here/"Pratt14Cover.lean"
p.write_text(re.sub(r"^import (?:Pratt14|PrattChunk\d+)",f"import {prev}",p.read_text(encoding="utf8")),encoding="utf8")
subprocess.run([*command,"Pratt14Cover"],check=True)
