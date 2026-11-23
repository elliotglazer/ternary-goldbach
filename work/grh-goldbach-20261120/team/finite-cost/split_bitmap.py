"""Write independent leaf certificates and a checked join tree for bitmap expansion."""
from pathlib import Path
import json
import sys

width = int(sys.argv[1])
root = Path(__file__).resolve().parent
target = root / f"wide{width}-cache"
metadata = json.loads((root.parent / f"aws-pilot/wide/w{width}/workload.json").read_text())
bits = int.from_bytes((target / "bitmap.bin").read_bytes(), "little")
packed = int.from_bytes((target / "expanded.bin").read_bytes(), "little")
depth = (metadata["slots"] - 1).bit_length()
radix = (max(len(b["shifts"]) for b in metadata["blocks"]) - 1).bit_length() + 1
leaf = 12
group = 3

def name(level, start):
    return f"seg{level}_{start}"

def lit(key, n):
    if n == 0:
        return "0"
    filename = f"{key}.bin"
    (target / filename).write_bytes(n.to_bytes((n.bit_length()+7)//8,"little"))
    return f'fixtureNat% "{filename}"'

def node(level, start):
    size = 1 << level
    lo = (bits >> start) & ((1 << size) - 1)
    ex = (packed >> (radix*start)) & ((1 << (radix*size)) - 1)
    key = name(level,start)
    decls = [f"def {key}r : Nat := {lit(key+'r',lo)}",
             f"def {key}p : Nat := {lit(key+'p',ex)}",
             f"theorem {key} : expand {radix} {level} {key}r = {key}p := by"]
    if not lo:
        decls.append(f"  exact expand_zero {radix} {level}")
    elif level == leaf:
        decls.append("  decide +kernel")
    else:
        left = name(level-1,start)
        right = name(level-1,start+size//2)
        decls.append(f"  exact expand_join (d:={level-1}) (low:={left}r) (high:={right}r) "
                     f"(by decide +kernel) (by decide +kernel) {left} {right} (by decide +kernel)")
    return "\n".join(decls)+"\n"

def pre(mods):
    return ("".join(f"import {m}\n" for m in mods)+"namespace PackedWide\nopen Goldbach.Packed\n"
            +"set_option maxRecDepth 65536\n")

groups=[]
for start in range(0, 1<<depth, 1<<(leaf+group)):
    module=f"ExpansionGroup{len(groups)}"
    groups.append(module)
    body=pre(["PackedWideInputs","ExpandSegments"])
    for level in range(leaf,leaf+group+1):
        body+="".join(node(level,i) for i in range(start,start+(1<<(leaf+group)),1<<level))
    (target/(module+".lean")).write_text(body+"end PackedWide\n",encoding="utf-8")
body=pre(groups)
for level in range(leaf+group+1,depth+1):
    body+="".join(node(level,i) for i in range(0,1<<depth,1<<level))
body+=f"""theorem bound : source < 2^(2^{depth}) := by decide +kernel
theorem certified : expand {radix} {depth} source = expansion := {name(depth,0)}
end PackedWide
#print axioms PackedWide.certified
"""
(target/"PackedWideSource.lean").write_text(body,encoding="utf-8")
(target/"expansion-groups.json").write_text(json.dumps(groups)+"\n")
