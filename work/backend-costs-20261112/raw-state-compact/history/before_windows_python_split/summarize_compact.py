"""Report observed phases only. No extrapolation or full-project refund."""
from pathlib import Path
import hashlib
import json
import sys

HERE = Path(__file__).resolve().parent


def check_manifest(path):
    for line in path.read_text().splitlines():
        digest, name = line.split("  ", 1)
        assert hashlib.sha256((HERE / name).read_bytes()).hexdigest() == digest


def phases(path, marker):
    out, before = {}, True
    for line in path.read_text().splitlines():
        if line == marker:
            before = False
        if before and line.startswith("HANDOFF_PHASE,"):
            _, name, cpu, elapsed = line.split(",")
            assert name not in out
            out[name] = dict(cpu=float(cpu), elapsed=float(elapsed))
    assert not before
    return out


def main():
    label = sys.argv[1]
    assert label and all(c.isalnum() or c == "_" for c in label)
    assert (HERE / f"{label}_complete.log").read_text().strip() == "COMPACT_RUN_COMPLETE"
    for p in ["prepare", "generic", "build", "run"]:
        assert (HERE / f"{label}_{p}.exit").read_text().strip() == "0"
    for suffix in ["source.sha256", "generated.sha256", "export.sha256"]:
        check_manifest(HERE / f"{label}_{suffix}")
    check_manifest(HERE / "predecessor_inputs.sha256")
    log = (HERE / f"{label}_run.log").read_text()
    assert "COMPACT_MATCHED_OLD_FULL_SIGNS,1032" in log
    assert "COMPACT_DONE" in log
    for control in ["base_label", "denominator", "depth", "final_mask"]:
        assert f"HANDOFF_REJECTED,{control}\n" in log
    for control in ["negative_ties", "sign_codes"]:
        assert f"HANDOFF_TAG,control_{control}," in log
    new = phases(HERE / f"{label}_run.log", "COMPACT_PRIMARY_COMPLETE,4,129,1032")
    old = phases(HERE.parent / "raw-state-handoff/handoff10_fused.log",
                 "HANDOFF_PRIMARY_COMPLETE,516,8,129")
    result = dict(
        scope="Different output contracts; matched integer source and signs only",
        compact_primary_instrumented_phases=new,
        old_full_primary_instrumented_phases=old,
        compact_primary_instrumented_cpu=sum(v["cpu"] for v in new.values()),
        old_full_primary_instrumented_cpu=sum(v["cpu"] for v in old.values()),
        excluded_from_phase_sums=["uninstrumented parsing and term setup",
            "new generic theorem/library construction", "process startup",
            "post-primary old-theorem validation", "controls", "theory export"],
        whole_phase_time_files=[f"{label}_{p}.time" for p in
                               ["prepare", "generic", "build", "run"]],
        no_full_model_cost_refund=True)
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
