"""Same-fixture native arithmetic comparison, excluding packing and formal checking."""
import json
from flint import fmpz
from packed_cover import ROOT,timed

def shift_or(source,shifts,mask,zero):
    result=zero
    for shift in shifts:
        result |= source>>shift
    return result&mask==mask

out=[]
for f in json.loads((ROOT/"lean_fixtures.json").read_text()):
    src=int(f["source_hex"],16); shifts=f["shifts"];mask=(1<<f["width"])-1
    fs,fm=fmpz(src),fmpz(mask)
    assert shift_or(src,shifts,mask,0) and shift_or(fs,shifts,fm,fmpz(0))
    row=dict(width=f["width"],m=len(shifts),
             python_shift_or=timed(lambda:shift_or(src,shifts,mask,0)),
             flint_shift_or=timed(lambda:shift_or(fs,shifts,fm,fmpz(0))))
    out.append(row)
    print(row["width"],row["python_shift_or"]["median_us"],row["flint_shift_or"]["median_us"],flush=True)
(ROOT/"packed_shift_or_timings.json").write_text(json.dumps(out,indent=2))
