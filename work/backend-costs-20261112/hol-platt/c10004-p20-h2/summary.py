"""Record final hash bindings and sign comparisons for the linked two-height inputs."""
import csv,hashlib,json
from collections import Counter
from pathlib import Path

HERE=Path(__file__).resolve().parent
files=sorted(HERE.glob("h2-*"))
def rows(p):
    with p.open() as f:
        return list(csv.DictReader(f,delimiter="\t"))

h1=rows(HERE.parent/"c10004-p20-source/h1-rawspectrum.tsv")
h2=rows(HERE/"h2-rawspectrum.tsv")
assert len(h1)==len(h2)==2301
assert [(r["k41"],r["k61"]) for r in h1]==[(r["k41"],r["k61"]) for r in h2]
report=dict(files={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in files},
            h2_signs=Counter(r["sign"] for r in h2),
            opposite_endpoint_signs=sum(r["sign"]!=s["sign"] for r,s in zip(h1,h2)),
            max_absolute_radius_grid81=max(int(r["abs_error_grid_units"]) for r in h2),
            max_archived_center_gap_grid81=max(int(r["eager_center_gap_grid_units"]) for r in h2))
(HERE/"assembly-receipt.json").write_text(json.dumps(report,indent=2)+"\n")
