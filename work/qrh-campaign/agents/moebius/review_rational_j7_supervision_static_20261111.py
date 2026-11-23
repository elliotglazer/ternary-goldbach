"""Read/parse/compile source text only; never import or execute inspected modules."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
PREFIX = "rational_j7_supervision_20261111"
result = {"scope": "source bytes and syntax only; no target execution", "files": {}}
trees = {}
texts = {}
for suffix in ("common.py", "native.py", "managed.py", "run.py", "PREPARATION.md"):
    rel = "integration/" + PREFIX + "_" + suffix
    data = (AGENTS / rel).read_bytes()
    text = data.decode("utf-8-sig")
    entry = {"sha256": hashlib.sha256(data).hexdigest().upper(), "bytes": len(data)}
    if suffix.endswith(".py"):
        tree = ast.parse(text, filename=rel)
        compile(tree, rel, "exec")  # The code object is never executed.
        trees[suffix] = tree
        texts[suffix] = text
        entry["syntax"] = "PASS"
        entry["declarations"] = {
            node.name: node.lineno for node in ast.walk(tree)
            if isinstance(node, (ast.FunctionDef, ast.ClassDef))
        }
    result["files"][rel] = entry

ref = AGENTS / "audit/c8_supervisor_capability_preflight_20261111_v5.py"
refdata = ref.read_bytes()
reftext = refdata.decode("utf-8-sig")
reftree = ast.parse(reftext)
result["native_reference_sha256"] = hashlib.sha256(refdata).hexdigest().upper()
result["native_exact_segments"] = {}
for name in ("Win", "identity_match"):
    a = next(n for n in trees["native.py"].body if getattr(n, "name", None) == name)
    b = next(n for n in reftree.body if getattr(n, "name", None) == name)
    same = ast.get_source_segment(texts["native.py"], a) == ast.get_source_segment(reftext, b)
    assert same, name
    result["native_exact_segments"][name] = same

out = HERE / "review_rational_j7_supervision_static_20261111.json"
out.write_text(json.dumps(result, sort_keys=True, indent=2) + "\n", encoding="utf-8")
print(json.dumps({"status": "STATIC_SYNTAX_AND_COPY_PASS", "receipt": str(out)}))
