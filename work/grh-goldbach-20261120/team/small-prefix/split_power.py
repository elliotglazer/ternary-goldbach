"""Split a generated Lean prefix certificate into independently checkable modules."""
import argparse
import json
from pathlib import Path
import re


def packed_literals(source):
    return re.sub(r"\b0x([a-f0-9]{128,})\b", lambda m: f'packedHex% "{m[1]}"', source)


def join(names):
    while len(names) > 1:
        names = [f"(SmallGoldbach.join {names[i]} {names[i+1]})" if i+1 < len(names)
                 else names[i] for i in range(0,len(names),2)]
    return names[0]


def generate(source, out, groups_per_file=128, fast_hex=False):
    if groups_per_file < 1:
        raise ValueError("each file needs at least one group")
    namespace = source.stem
    target = f"SmallGoldbach.{namespace}"
    k = int(re.fullmatch(r"Power(\d+)",namespace)[1])
    bound = 10**k
    body, tail = source.read_text(encoding="utf-8").split("\ntheorem binaryGoldbachUpTo :",1)
    if f"n ≤ 10^{k} →" not in tail:
        raise ValueError("unexpected prefix statement")
    common, *groups = re.split(r"(?=^def rows[0-9]+ : List Row :=)",body,flags=re.M)
    ranges = [re.search(r"^theorem (part\d+) : Covered (\d+) (\d+) :=",g,re.M).groups() for g in groups]
    if int(ranges[0][1]) != 6 or int(ranges[-1][2]) != bound+2 or any(
        a[2] != b[1] for a,b in zip(ranges,ranges[1:])):
        raise ValueError("generated intervals do not partition the prefix")
    out.mkdir(parents=True,exist_ok=True)
    if fast_hex:
        (out/"FastHex.lean").write_bytes(Path(__file__).with_name("FastHex.lean").read_bytes())
    def write(name,src):
        if fast_hex:
            src = packed_literals(src)
        (out/(name+".lean")).write_text(src,encoding="utf-8",newline="\n")
    base = namespace+"Common"
    write(base,("import FastHex\n" if fast_hex else "")+common+f"end {target}\n")
    blocks = []
    theorems = []
    for i in range(0,len(groups),groups_per_file):
        batch = ranges[i:i+groups_per_file]
        name = f"{namespace}Block{i//groups_per_file:02d}"
        theorem = f"block{i//groups_per_file}"
        blocks.append(name)
        theorems.append(theorem)
        write(name,f"import {base}\nnamespace {target}\nopen PrimeCoverage SmallGoldbach\n"
              "set_option maxRecDepth 20000\nset_option maxHeartbeats 0\n"+
              "".join(groups[i:i+groups_per_file])+f"\ntheorem {theorem} : Covered {batch[0][1]} {batch[-1][2]} :=\n"
              f"  {join([x[0] for x in batch])}\nend {target}\n")
    public = namespace+"Joined"
    write(public,"".join(f"import {name}\n" for name in blocks)+f"namespace {target}\nopen SmallGoldbach\n"
          f"theorem binaryGoldbachUpTo : ∀ n : Nat, Even n → 4 ≤ n → n ≤ 10^{k} →\n"
          f"    ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n :=\n"
          f"  prefix_of_covered {join(theorems)} (by decide)\nend {target}\n")
    audit = namespace+"Audit"
    write(audit,f"import {public}\n#print axioms {target}.binaryGoldbachUpTo\n")
    manifest = dict(power=k,base=base,blocks=blocks,public=public,audit=audit,
                    intervals=len(groups),groups_per_file=groups_per_file,fast_hex=fast_hex)
    (out/"modules.json").write_text(json.dumps(manifest,indent=2)+"\n")
    return manifest


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("source",type=Path)
    parser.add_argument("out",type=Path)
    parser.add_argument("--groups-per-file",type=int,default=128)
    parser.add_argument("--fast-hex",action="store_true",help="elaborate long digit strings by balanced decoding")
    args=parser.parse_args()
    print(generate(args.source,args.out,args.groups_per_file,args.fast_hex))
