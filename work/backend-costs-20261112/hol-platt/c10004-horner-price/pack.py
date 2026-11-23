import ast
from pathlib import Path
root=Path(__file__).resolve().parent
lines=(root/"actual_terms.txt").read_text().splitlines()
def flat(x):
    if isinstance(x,int):return [str(x).replace("-","~")]
    return [w for z in x for w in flat(z)]
with (root/"packed.txt").open("w") as out:
    for a,b in zip(lines[::2],lines[1::2]):
        cells=ast.literal_eval(a[len("actual_groups "):].replace(";",",").replace("~","-"))
        ans=ast.literal_eval(b.split(" : ")[0].replace(";",",").replace("~","-"))
        tokens=[str(len(cells))]
        for k,top,stages,units in cells:
            tokens+=flat([k,top,stages,len(units),units])
        tokens+=flat([len(ans),ans])
        out.write(" ".join(tokens)+"\n")
