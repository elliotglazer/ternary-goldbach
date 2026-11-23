"""Bounded text/hash checks, not SML evaluation or an equivalence proof."""
from pathlib import Path
import hashlib
import json
import re

HERE = Path(__file__).resolve().parent
def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()
def text(path):
    return path.read_text().replace("\r\n", "\n")
def main():
    manifest = json.loads((HERE / "harness_source_binding.json").read_text())
    for path, pin in manifest["input_pins"].items():
        assert sha(Path(path)) == pin, path
    for field in ("output_pins", "support_pins"):
        for name, pin in manifest[field].items():
            assert sha(HERE / name) == pin, name
    setup = HERE.parents[1] / "hol4-setup"
    hol = setup / "HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
    source = text(hol / "src/thm/Compute.sml")
    candidate = text(HERE / "CompiledComputeBenchmark.sml")
    # Every original definition before term_compute is byte-for-byte identical
    # after newline normalization and the single structure-header rename.
    original_prefix = source[:source.index("fun term_compute ")]
    expected_prefix = original_prefix.replace("structure Compute :> Compute =",
                                             "structure CompiledComputeBenchmark =", 1)
    assert candidate.startswith("(* UNBUILT NON-AUTHORITATIVE SAME-AST BENCHMARK COPY. *)\n" + expected_prefix)
    original_frontend = source[source.index("fun term_compute "):source.index("\nend (* struct *)")]
    assert original_frontend in candidate
    assert "make_thm" not in candidate and "Thm.compute" not in candidate
    baseline = text(setup / "dependent.sml")
    driver = text(HERE / "compiled_dependent.sml")
    assert baseline[:baseline.index("val fixture_1 =")] in driver
    for depth in (1, 8, 32, 128):
        declaration = re.findall(rf"^val fixture_{depth} = .*;$", baseline, re.M)
        assert len(declaration) == 1 and driver.count(declaration[0]) == 1
    old_tail = baseline[baseline.index("val changed_xs ="):]
    new_tail = driver[driver.index("val changed_xs ="):]
    new_tail = re.sub(r'^val _ = CompiledWorkload.run "control_[^"]+" \(acceptance .*\);\n',
                      "", new_tail, flags=re.M)
    new_tail = new_tail.replace("HOL4_COMPILED_DEPENDENT_BENCHMARK_DONE",
                                "HOL4_DEPENDENT_BLOCK_BENCHMARK_DONE")
    assert old_tail == new_tail
    config = text(HERE / "CvBenchmarkConfig.sml")
    cvlib = text(hol / "src/num/theories/cv_compute/cv_computeLib.sml")
    expected_cfg = cvlib[:cvlib.index("val cached = Thm.compute")].replace(
        "structure cv_computeLib :> cv_computeLib =", "structure CvBenchmarkConfig =", 1)
    assert config.startswith(expected_cfg)
    assert "Thm.compute" not in config
    result = {
        "status": "source-only checks passed; no SML executed",
        "manifest_sha256": sha(HERE / "harness_source_binding.json"),
        "pinned_inputs": len(manifest["input_pins"]),
        "pinned_outputs": len(manifest["output_pins"]),
        "pinned_support_sources": len(manifest["support_pins"]),
        "original_interpreter_primitives_frontend_preserved": True,
        "original_cv_configuration_preserved": True,
        "exact_positive_fixture_declarations": 4,
        "original_changed_data_and_five_negative_controls_preserved": True,
    }
    print(json.dumps(result, indent=2))
if __name__ == "__main__":
    main()
