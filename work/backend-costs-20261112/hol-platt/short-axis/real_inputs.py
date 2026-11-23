"""Pack true eight-height inputs for the first primitive character axis of q=10004."""
import csv
import hashlib
import json
from pathlib import Path
from prepare import HERE, HOL, LANES, P, pack


def main():
    divisor = 1 << (81-P)
    assert LANES==8 and divisor>=4
    picks = (0,1,29,199,600,1199,1671,2399)
    hashes = {}
    rows = []
    for group, heights in (("low",range(1,9)),("high",range(84184,84192))):
        lanes = []
        for j in heights:
            path = (HOL/"c10004-time-slab"/f"h{j}.tsv" if group=="low" else
                    HOL/"c10004-grid-repair"/f"j{j}-source.tsv")
            hashes[path.name] = hashlib.sha256(path.read_bytes()).hexdigest()
            with path.open(newline="") as handle:
                vals = list(csv.DictReader(handle,delimiter="\t"))
            assert [int(r["index"]) for r in vals]==list(range(4800))
            lanes.append([tuple((int(r[key])+divisor//2)//divisor for key in ("re","im")) for r in vals])
        for pair in picks:
            x = [pack([v[2*pair+side][part] for v in lanes]) for side in (0,1) for part in (0,1)]
            y = [pack([v[2*pair][part]-v[2*pair+1][part] for v in lanes]) for part in (0,1)]
            rows.extend([f"{group} {pair}"," ".join(map(str,x))," ".join(map(str,y))])
    (HERE/"real.txt").write_text("\n".join(rows)+"\n",newline="\n")
    (HERE/"real-inputs.json").write_text(json.dumps(dict(conductor=10004,source_bits=81,grid_bits=P,
        pairs=picks,heights=[[1,8],[84184,84191]],source_sha256=hashes),indent=2)+"\n")


if __name__=="__main__":
    main()
