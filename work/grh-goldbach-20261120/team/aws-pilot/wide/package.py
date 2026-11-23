"""Package only pinned inputs; keep generated .oleans, logs and receipts outside the payload."""
import hashlib
import json
from pathlib import Path
import tarfile

wide=Path(__file__).resolve().parent
root=wide.parent
base=sorted(set(json.loads((root/"inputs.json").read_text()))|{"inputs.json","README.md"})
sources=[wide/n for n in ("README.md","Table.lean","Cover.lean","ReadTable.lean","bootstrap.sh","generate.py","run_wide.py")]
for width in (8192,262144):
    fixture=wide/f"w{width}"
    workload=json.loads((fixture/"workload.json").read_text())
    sources.extend([fixture/"workload.json"]+[fixture/n for n in sorted(workload["inputs"])])
manifest=wide/"SHA256SUMS"
manifest.write_text("".join(hashlib.sha256(p.read_bytes()).hexdigest()+"  "+p.relative_to(root).as_posix()+"\n"
                            for p in sources),encoding="utf-8",newline="\n")
out=wide/"goldbach-4e15-wide-linux.tar.gz"
with tarfile.open(out,"w:gz") as archive:
    for p in [root/name for name in base]+sources+[manifest]:
        archive.add(p,arcname="goldbach-wide/"+p.relative_to(root).as_posix(),recursive=False)
print(json.dumps(dict(bytes=out.stat().st_size,sha256=hashlib.sha256(out.read_bytes()).hexdigest())))
