"""Source preparation only. Does not launch SML, HOL, or a benchmark."""
from pathlib import Path
import hashlib
import json
import re

HERE = Path(__file__).resolve().parent
SETUP = HERE.parents[1] / "hol4-setup"
HOL = SETUP / "HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
PINS = {
    HOL / "src/thm/Compute.sml": "7dab9dd6e848fdfe2eb7869865031cfdadba44a2fb3d7e74d98cea77f712e059",
    HOL / "src/num/theories/cv_compute/cv_computeLib.sml": "b66d57885cb0d2dcf49f5d5fec665cb5fdca4edb9f726a2ced0ad579cdd08b6c",
    SETUP / "dependent.sml": "ecb62c8c7b1f1aaaa8df9617daf4145d7fcadbeedd9cf8579d3f57962c5e1ab1",
    HERE / "ClosureCompiler.sml.inc": "08bc1b75ad3ab92d0b51def4a1787a3a106d18919f6786d0fbbfa38cb94d2015",
}
def sha(b):
    return hashlib.sha256(b).hexdigest()
def read(path):
    raw = path.read_bytes()
    assert sha(raw) == PINS[path], f"pin mismatch: {path}"
    return raw.decode().replace("\r\n", "\n")
def replace_once(text, old, new):
    assert text.count(old) == 1, f"marker count: {old[:80]}"
    return text.replace(old, new, 1)
def main():
    compute, cvlib, dependent, fragment = map(read, PINS)
    start = compute.index("fun term_compute ")
    end = compute.index("\nend (* struct *)", start)
    original = compute[start:end]
    parse = replace_once(original, "fun term_compute ", "fun prepare_program ")
    old = """      in
        fn tm =>
          let
            val cexp = dest_cexp ct [] eqs tm
            val cval = exec code [] cexp
          in
            cv_to_term cval
          end
      end"""
    new = """      in
        {code = code,
         parse = fn tm => dest_cexp ct [] eqs tm,
         to_term = cv_to_term}
      end"""
    parse = replace_once(parse, old, new)
    bench_compute = (
        "(* UNBUILT NON-AUTHORITATIVE SAME-AST BENCHMARK COPY. *)\n"
        + replace_once(compute[:start], "structure Compute :> Compute =",
                       "structure CompiledComputeBenchmark =")
        + fragment + "\n" + original + "\n" + parse + compute[end:]
    )
    cfg = cvlib[:cvlib.index("val cached = Thm.compute")]
    cfg = replace_once(cfg, "structure cv_computeLib :> cv_computeLib =",
                       "structure CvBenchmarkConfig =")
    cfg += """val _ = if List.all (fn (_,th) => null (hyp th)) char_eqns then ()
          else raise Fail "open characteristic theorem";
val config = {
    cval_terms = cval_terms, cval_type = cvSyntax.cv, num_type = numSyntax.num,
    char_eqns = List.map (fn (name,th) => (name,concl th)) char_eqns
  };
end;
"""
    # Preserve all original data construction and theory-qualified definitions.
    # This executable runs only in the new directory, not in SETUP.
    prefix = dependent[:dependent.index("val fixture_1 =")]
    fixtures = []
    for depth in (1, 8, 32, 128):
        matches = re.findall(rf"^val fixture_{depth} = .*;$", dependent, re.M)
        assert len(matches) == 1
        fixtures.append(matches[0])
        fixtures.append(f'val _ = CompiledWorkload.run "depth{depth}" fixture_{depth};')
        fixtures.append(f'val stock_true_{depth} = timed "stock_full_depth{depth}" '
                        f'(fn () => check_true fixture_{depth});')
        fixtures.append(f'val _ = audit "stock_full_depth{depth}" stock_true_{depth};')
        fixtures.append(f'val _ = ignore (save_thm ("stock_full_depth{depth}",stock_true_{depth}));')
    tail = dependent[dependent.index("val changed_xs ="):]
    pattern = r'^val _ = timed "control_([^"]+)" \(fn \(\) => check_false "[^"]+" \((acceptance .*)\)\);$'
    matches = list(re.finditer(pattern, tail, re.M))
    assert [m[1] for m in matches] == ["checksum", "bound", "depth", "input", "coefficient"]
    tail = re.sub(pattern, lambda m:
        f'val _ = CompiledWorkload.run "control_{m[1]}" ({m[2]});\n' + m[0], tail, flags=re.M)
    tail = replace_once(tail, "HOL4_DEPENDENT_BLOCK_BENCHMARK_DONE",
                        "HOL4_COMPILED_DEPENDENT_BENCHMARK_DONE")
    driver = "(* Generated from pinned dependent.sml; same values, definitions and requests. *)\n" + prefix + "\n".join(fixtures) + "\n" + tail
    outputs = {
        "CompiledComputeBenchmark.sml": bench_compute,
        "CvBenchmarkConfig.sml": cfg,
        "compiled_dependent.sml": driver,
    }
    # No overwrite or implicit rerun; preserve failed preparation artifacts.
    for name in [*outputs, "harness_source_binding.json"]:
        assert not (HERE / name).exists(), f"output already exists: {name}"
    for name, text in outputs.items():
        with (HERE / name).open("x", encoding="utf-8", newline="\n") as out:
            out.write(text)
    metadata = {
        "status": "prepared only; no SML typecheck or execution",
        "input_pins": {str(p): h for p, h in PINS.items()},
        "output_pins": {name: sha((HERE / name).read_bytes()) for name in outputs},
        "support_pins": {name: sha((HERE / name).read_bytes()) for name in
                         ("CompiledEvalChecks.sml", "CompiledWorkload.sml", "prepare_harness.py", "Holmakefile", "run_compiled.sh")},
        "same_ast": "one code vector and one request AST per comparison, shared by stock/compiled",
        "depths": [1, 8, 32, 128],
        "controls": ["checksum", "bound", "depth", "input", "coefficient"],
        "kernel_change": False,
        "theory_export": "stock references and closed source equations only; candidate creates no theorem",
    }
    with (HERE / "harness_source_binding.json").open("x", encoding="utf-8") as out:
        json.dump(metadata, out, indent=2)
        out.write("\n")
    for path, pin in PINS.items():
        assert sha(path.read_bytes()) == pin
    print(json.dumps(metadata, indent=2))
if __name__ == "__main__":
    main()
