"""Emit one fixed explicit raw-state certificate proposal; never invoke Lean.

All arithmetic proof declarations remain in RawStateExplicit. The saved literal
fixture is untrusted. The emitted ordinary kernel `decide` proofs must establish
every update; Python validation is not formal acceptance.
"""
from pathlib import Path
import hashlib
import json

HERE = Path(__file__).resolve().parent
FIXTURE_HASH = "01C3E9F1AF2FD8DF40C9EF770840078E02EC356737727637C58397836C5C6BF9"
BASES = [1, 2, 3, 41, 61, 10004, 262144, 265800]
PINS = {
    "RawStateFixtureData.lean": "BB0388FFA768A4F4CAF9154534C7F7D40CC5F4177F91513A301610FEA1B72CFB",
    "RawStateSources.lean": "F501CDB3DAF8B2B41489B430057AA822854391902802DA091608EB31136756A6",
}


def require(ok, message):
    if not ok:
        raise RuntimeError(message)


def pair(w):
    require(isinstance(w, list) and len(w) == 2 and all(type(z) is int for z in w),
            "integer-pair schema")
    return f"({w[0]}, {w[1]})"


def main():
    raw = (HERE / "state_fixture.json").read_bytes()
    require(len(raw) < 2 << 20, "fixture byte cap")
    require(hashlib.sha256(raw).hexdigest().upper() == FIXTURE_HASH, "fixture hash")
    for filename, expected in PINS.items():
        require(hashlib.sha256((HERE / filename).read_bytes()).hexdigest().upper() == expected,
                f"source identity: {filename}")
    d = json.loads(raw)
    require(d["schema"] == "raw-head-matched-state-fixture-v1", "fixture schema")
    require(d["base_order"] == BASES and len(d["rows"]) == 8, "base order")
    require(d["grids"]["state"] == 120 and d["grids"]["step_export"] == 122, "grids")
    require(d["time_index"] == {"first": 0, "last_inclusive": 128,
                                "step_numerator": 5, "step_denominator": 64}, "time grid")
    lines = ["import RawStateSources", "import RawTraceCertificate", "",
             "/-! Fixed explicit operation-certificate proposal. No build was run by the emitter.",
             f"Fixture SHA256: {FIXTURE_HASH}",
             f"Generator SHA256: {hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper()}",
             "Every literal multiplication equality is checked separately by ordinary kernel decide.",
             "All explicit arithmetic declarations and composition helpers share the replay prefix.",
             "-/", "", "namespace RawStateExplicit", "open RawHead RawStateData", "",
             "lemma follows_cons {step previous next : ℤ × ℤ} {rest : List (ℤ × ℤ)}",
             "    (hstep : mulStep (2 ^ 122) previous step = next)",
             "    (hrest : traceFollows step next rest = true) :",
             "    traceFollows step previous (next :: rest) = true := by",
             "  simpa only [traceFollows, hstep, decide_true, Bool.true_and] using hrest", ""]
    klist = []
    for bi, row in enumerate(d["rows"]):
        x, k = row["x"], row["k"]
        require(row["base_index"] == bi and x == BASES[bi], "row identity")
        require(type(k) is int and 0 <= k <= 18 and 2**k <= x <= 2 * 2**k, "range")
        states, step = row["states_grid120"], row["step_grid122"]
        require(len(states) == 129 and states[0] == row["initial_grid120"], "trace shape/head")
        st = pair(step)
        for j in range(128):
            lines += [f"theorem step_{x}_{j} :",
                      f"    mulStep (2 ^ 122) {pair(states[j])} {st} =",
                      f"      {pair(states[j + 1])} := by", "  decide +kernel", ""]
        lines += [f"theorem certificate_{x} :",
                  f"    traceCertificate initial_{x} step_{x} trace_{x} = true := by",
                  f"  change traceFollows {st} {pair(states[0])} ["]
        lines += ["    " + pair(w) + ("," if i < 127 else "] = true")
                  for i, w in enumerate(states[1:])]
        lines += [f"  apply follows_cons step_{x}_{j}" for j in range(128)]
        lines += ["  rfl", "",
                  f"theorem trace_checked_{x} :",
                  f"    cachedTrace initial_{x} step_{x} 128 = trace_{x} := by",
                  f"  have h := traceCertificate_sound initial_{x} step_{x} trace_{x} certificate_{x}",
                  f"  rw [RawStateSources.trace_length_{x}] at h",
                  "  exact h.symm", "",
                  f"theorem actual_trace_{x} : rawCachedTrace {k} {x} 128 = trace_{x} := by",
                  f"  have hi : initial_{x} = rawStateInitial {x} := RawStateSources.initial_checked_{x}.symm",
                  f"  have hs : step_{x} = rawStepNumerator {k} {x} := RawStateSources.step_checked_{x}.symm",
                  f"  rw [← cachedTrace_eq_rawCachedTrace hi hs 128]",
                  f"  exact trace_checked_{x}", "",
                  f"theorem actual_error_{x} (j : ℕ) (hj : j < 129) :",
                  f"    ‖expIntegerValue (2 ^ 120) (trace_{x}[j]'(by rw [RawStateSources.trace_length_{x}]; exact hj)) -",
                  f"      integerPower ({x} : ℝ) ((j : ℝ) * 5 / 64)‖ < 1 / (2 : ℝ) ^ 96 := by",
                  f"  have hi : initial_{x} = rawStateInitial {x} := RawStateSources.initial_checked_{x}.symm",
                  f"  have hs : step_{x} = rawStepNumerator {k} {x} := RawStateSources.step_checked_{x}.symm",
                  (f"  simpa only [Nat.cast_one] using (traceCertificate_actual_error hi hs trace_{x} certificate_{x}"
                   if x == 1 else f"  exact traceCertificate_actual_error hi hs trace_{x} certificate_{x}"),
                  "    (by decide) (by decide) (by decide) (by decide) j",
                  f"    (by rw [RawStateSources.trace_length_{x}]; exact hj) (by omega)" +
                  (")" if x == 1 else ""), ""]
        klist.append(k)
    lines += ["theorem all_traces_checked :",
              "    [" + ", ".join(f"rawCachedTrace {k} {x} 128" for k, x in zip(klist, BASES)) + "] =",
              "      allTraces := by",
              "  rw [" + ", ".join(f"actual_trace_{x}" for x in BASES) + "]",
              "  rfl", "", "end RawStateExplicit", ""]
    output = "\n".join(lines).encode("utf-8")
    require(len(output) < 2 << 20, "Lean source byte cap")
    require(sum(s.startswith("theorem step_") for s in lines) == 1024, "update count")
    require(not any(s in output.decode() for s in ["sorry", "native_decide", "set_option"]),
            "forbidden proof mechanisms")
    # Split declarations, not the workload. Every name remains under the same
    # replay prefix, and all 1024 edge proofs are dependencies of the final root.
    text = output.decode("utf-8")
    head, body = text.split("namespace RawStateExplicit\n", 1)
    helper, rest = body.split("theorem step_1_0 :", 1)
    rest = "theorem step_1_0 :" + rest
    chunks = {"RawStateExplicitSupport.lean":
              head + "namespace RawStateExplicit\n" + helper + "end RawStateExplicit\n"}
    prefix = ("import RawStateExplicitSupport\n\n" +
              head[head.index("/-!"):] +
              "namespace RawStateExplicit\nopen RawHead RawStateData\n\n")
    for i, x in enumerate(BASES):
        delimiter = (f"theorem step_{BASES[i + 1]}_0 :" if i < 7
                     else "theorem all_traces_checked :")
        chunk, after = rest.split(delimiter, 1)
        chunks[f"RawStateExplicit{x}.lean"] = prefix + chunk + "end RawStateExplicit\n"
        rest = delimiter + after
    chunks["RawStateExplicit.lean"] = (
        "\n".join(f"import RawStateExplicit{x}" for x in BASES) + "\n\n" +
        head[head.index("/-!"):] + "namespace RawStateExplicit\nopen RawHead RawStateData\n\n" + rest)
    previous = HERE / "RawStateExplicit.lean"
    failed_hash = "2C3FA116F604C7C60FB83F75662ECA1373BD15A9181F2514DEBDDF02C567D56F"
    archive = HERE / "history" / "RawStateExplicit.lean.2C3FA116.pre_chunking"
    require(archive.exists() and hashlib.sha256(archive.read_bytes()).hexdigest().upper() == failed_hash,
            "failed whole source must be preserved exactly")
    old = archive.read_text(encoding="utf-8")
    require(old.split("namespace RawStateExplicit\n", 1)[1] == body,
            "chunking changed a declaration or literal")
    require(previous.exists() and hashlib.sha256(previous.read_bytes()).hexdigest().upper() == failed_hash,
            "only the exact failed whole source may be replaced")
    for name in chunks:
        require(name == previous.name or not (HERE / name).exists(), "refuse existing chunk")
    require(sum(s.count("theorem step_") for s in chunks.values()) == 1024, "chunk update count")
    result = []
    for name, source in chunks.items():
        raw_out = source.encode("utf-8")
        require(len(raw_out) < 1 << 20, "per-module source cap")
        mode = "wb" if name == previous.name else "xb"
        with (HERE / name).open(mode) as f:
            f.write(raw_out)
        result.append({"output": name, "bytes": len(raw_out),
                       "sha256": hashlib.sha256(raw_out).hexdigest().upper()})
    print(json.dumps({"outputs_in_build_order": result, "literal_update_theorems": 1024,
                      "trace_pairs": 1032, "declarations_unchanged": True,
                      "lean_executed": False}, indent=2))


if __name__ == "__main__":
    main()
