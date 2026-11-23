import json
from pathlib import Path
from collections import Counter
p=Path(__file__).resolve().parent; work=p.parents[2]
rows=json.loads((work/"qrh-campaign/agents/integration/transform_structural_manifest_20261111.json").read_bytes())["conductors"]
board=[b["height_indices"] for b in json.loads((p.parent/"large-weighted-slab/later-band-budget.json").read_bytes())["bands"]]
board.append([board[-1][1],board[-1][1]+640]); res={}
for guard in (0,167,320,640):
 z=Counter()
 for c,phi,chars,H,j,axes,_ in rows:
  h=j+41+guard; n,q=axes[-1]; live=n-(n//q if q else 0); batches=sum((max(0,min(h,hi)-lo)+7)//8 for lo,hi in board)
  assert chars%live==0
  if n>=32:
   z["long_retained_outputs"]+=h*chars
   z["long_prepruning_outputs"]+=h*(chars//live)*n
   z["long_dropped_outputs"]+=h*(chars//live)*(n-live)
  else:
   z["short_retained_outputs"]+=h*chars
   z["short_height_padded_outputs"]+=(8*batches-h)*chars
   z["short_packets"]+=batches*(chars//live)
   z["short_padded_live_output_slots"]+=8*batches*chars
 res[guard]=z
print(res[640]); (p/"terminal-padding.json").write_text(json.dumps(res,indent=2))
