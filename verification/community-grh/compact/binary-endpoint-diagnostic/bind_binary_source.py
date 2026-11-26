"""Bind the existing binary verifier to one independently audited finite source closure."""
import argparse
import ast
from hashlib import sha256
from pathlib import Path

ORIGINAL = "65ce0a4ace395459efa319eba1bff721e0158c71e31f2b674827ac4b013bdaa7"
ORIGINAL_CLOSURE = "6ce489f265b47bf36b15e98244fb318b152bc5083cb9d9a0a845eb0cc651e843"
CHALLENGE = "8b8cfbc6c2727fd9c509c559af6ffaa6f5e764e2409dbad0ea1ab60bc529b523"
PROFILES = {
    "bitmap": (
        "a52dfee6c6337444a445b8b6782a6f906eae2b8a338b893439ad6ba13bcda878",
        "f4af9625761296d977c32412468028dc6b31cd4f77d3b3756947d6dbba2fad79",
    ),
    "scheduled": (
        "6b8e9432260a92538716538fab88b8fb477953923ae5ebdcc5ca9432af3bd58c",
        "c99727b5e03b78c59b8c33cbc0afb20958adccfa59e98a3bac698d27641718a2",
    ),
}

def bind(source, name):
    if sha256(source).hexdigest() != ORIGINAL:
        raise ValueError("the input must be the original published binary_endpoint.py")
    closure, expected = PROFILES[name]
    needle = ('CLOSURE = "' + ORIGINAL_CLOSURE + '"').encode("ascii")
    if source.count(needle) != 1:
        raise ValueError("the original verifier must contain exactly one expected closure field")
    variant = source.replace(needle, ('CLOSURE = "' + closure + '"').encode("ascii"))
    if sha256(variant).hexdigest() != expected:
        raise ValueError("unexpected generated worker hash")
    challenges = [ast.literal_eval(node.value)
                  for node in ast.parse(variant).body
                  if isinstance(node, ast.Assign) and len(node.targets) == 1
                  and isinstance(node.targets[0], ast.Name) and node.targets[0].id == "CHALLENGE"]
    if len(challenges) != 1 or sha256(challenges[0].encode("utf-8")).hexdigest() != CHALLENGE:
        raise ValueError("the full Lean challenge differs from the independently compiled statement")
    return variant

def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument("profile",choices=PROFILES)
    p.add_argument("output",type=Path)
    p.add_argument("--original",type=Path,default=Path(__file__).with_name("binary_endpoint.py"))
    a=p.parse_args()
    result=bind(a.original.read_bytes(),a.profile)
    if a.output.exists():
        if a.output.read_bytes() != result:
            raise SystemExit("refusing to overwrite a different existing file")
    else:
        with a.output.open("xb") as fp:
            fp.write(result)
    print(sha256(result).hexdigest(),a.output)

if __name__ == "__main__":
    main()
