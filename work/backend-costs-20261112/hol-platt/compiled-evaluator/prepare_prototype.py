"""Materialize a pinned, renamed SML experiment; never load or execute SML.

All outputs are exclusive. No installed source or dependency is changed.
"""
from pathlib import Path
import hashlib
import json

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
HOL = ROOT / "hol4-setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
SOURCE = HOL / "src/thm/Compute.sml"
EXPECTED = "7dab9dd6e848fdfe2eb7869865031cfdadba44a2fb3d7e74d98cea77f712e059"

def digest(data):
    return hashlib.sha256(data).hexdigest()

def main():
    raw = SOURCE.read_bytes()
    assert digest(raw) == EXPECTED, "Compute.sml pin mismatch"
    source = raw.decode().replace("\r\n", "\n")
    fragment = (HERE / "ClosureCompiler.sml.inc").read_text()
    assert source.count("structure Compute :> Compute =") == 1
    assert source.count("fun term_compute ") == 1
    start = source.index("fun term_compute ")
    end = source.index("\nend (* struct *)", start)
    original = source[start:end]
    pair = original.replace("fun term_compute ", "fun prepare_term_comparison ", 1)
    marker = "val code = Vector.map (fn (_,(bvs,r)) => dest_cexp ct bvs eqs r) eqs"
    assert pair.count(marker) == 1
    pair = pair.replace(marker, marker + "\n        val compile_entry = prepare_closures code")
    old = """            val cval = exec code [] cexp
          in
            cv_to_term cval"""
    new = """            val entry = compile_entry cexp
          in
            {stock_cval = fn () => exec code [] cexp,
             compiled_cval = fn () => entry [],
             stock_term = fn () => cv_to_term (exec code [] cexp),
             compiled_term = fn () => cv_to_term (entry [])}"""
    assert pair.count(old) == 1
    pair = pair.replace(old, new)
    generated = (
        "(* GENERATED NON-AUTHORITATIVE EXPERIMENT; UNBUILT.\n"
        "   Not wired to Thm.compute and not a proof acceptance path. *)\n"
        + source[:start].replace("structure Compute :> Compute =",
                                "structure CompiledComputeExperiment =", 1)
        + fragment + "\n" + original + "\n" + pair + source[end:]
    ).encode()
    output = HERE / "CompiledComputeExperiment.sml"
    manifest = HERE / "source_binding.json"
    assert not output.exists() and not manifest.exists(), "preserve existing attempt"
    metadata = {
        "status": "source-only; unbuilt; no benchmark; no equivalence audit",
        "source": str(SOURCE), "source_sha256": EXPECTED,
        "fragment_sha256": digest((HERE / "ClosureCompiler.sml.inc").read_bytes()),
        "preparer_sha256": digest(Path(__file__).read_bytes()),
        "output_sha256": digest(generated),
        "stock_interpreter_and_primitives": "copied unchanged",
        "changes": ["renamed structure and removed opaque Compute signature",
                    "inserted closure compiler and raw cval comparison fixture",
                    "added duplicated parser frontend returning same-AST comparison thunks"],
        "trusted_kernel_modified": False,
    }
    with output.open("xb") as stream:
        stream.write(generated)
    with manifest.open("x", encoding="utf-8") as stream:
        json.dump(metadata, stream, indent=2)
        stream.write("\n")
    assert SOURCE.read_bytes() == raw
    print(json.dumps(metadata, indent=2))

if __name__ == "__main__":
    main()
