"""Write one bounded compact-output experiment, without evaluating any states.

Root runs this separately. No HOL subprocess, expected sign array, or recurrence
evaluation occurs here. The old full theorem is consumed after primary timing.
"""
from pathlib import Path
import hashlib
import json
import time

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
OLD = HERE.parent / "raw-state-handoff"
FIXTURE = ROOT / "work/lean-pilots/raw-head/state_fixture.json"
FIXTURE_HASH = "01C3E9F1AF2FD8DF40C9EF770840078E02EC356737727637C58397836C5C6BF9"
RUNTIME_HASH = "CB1CC15B68CF987AFA38182BCC7EAFC41E95ADA96565CC611239D23A30B7C1F0"
BASES = [1, 2, 3, 41, 61, 10004, 262144, 265800]


def digest(b):
    return hashlib.sha256(b).hexdigest().upper()


def pair(z):
    assert len(z) == 2 and all(type(v) is int for v in z)
    assert all(abs(v).bit_length() <= 124 for v in z)
    return "[" + ",".join(json.dumps(str(v).replace("-", "~")) for v in z) + "]"


def main():
    cpu, wall = time.process_time(), time.perf_counter()
    raw = FIXTURE.read_bytes()
    assert len(raw) <= 256 * 1024 and digest(raw) == FIXTURE_HASH
    data = json.loads(raw)
    assert data["schema"] == "raw-head-matched-state-fixture-v1"
    assert data["base_order"] == BASES and len(data["rows"]) == 8
    assert data["grids"]["state"] == 120
    assert data["grids"]["step_export"] == 122
    assert data["time_index"]["last_inclusive"] == 128
    seed_terms = []
    for i, row in enumerate(data["rows"]):
        assert row["x"] == BASES[i] and row["base_index"] == i
        seed_terms.append("(" + pair(row["initial_grid120"]) + "," +
                          pair(row["step_grid122"]) + ")")
    runtime_bytes = (OLD / "HandoffRuntime.sml").read_bytes()
    assert digest(runtime_bytes) == RUNTIME_HASH
    source = "[" + ",\n".join(seed_terms) + "]"
    text = '''open HolKernel Parse boolLib bossLib RawStateHandoffTheory
  RawCompactSignsTheory cv_transLib;
val _ = new_theory "CompactFusedResults";
''' + runtime_bytes.decode() + '''
(* The reused runtime audits its old ancestor. Check the new ancestor too. *)
val compact_context = List.concat (map (fn t =>
  map (fn (n,_) => t ^ "." ^ n) (DB.axioms t))
  ("RawCompactSigns" :: Theory.ancestry "RawCompactSigns"));
val _ = require (List.all (fn a => List.exists (fn b => a=b)
  allowed_axioms) compact_context) "unexpected compact context axiom";
val _ = print "COMPACT_MODE,fused,integer_signs_only\\n";
val source_literal = timed "construct_sources" (fn () => sources ''' + source + ''');
val source_def = define "define_sources" "compact_integer_sources" source_literal;
val _ = translated "translate_sources" source_def;
val source_name = lhs (concl source_def);
val bases = ``[1;2;3;41;61;10004;262144;265800]:num list``;
val c = ``61:int``;
val depth = ``128:num``;
val compact = list_mk_comb (``raw_compact``,[bases,c,depth,source_name]);
val result_th = evaluate "compact_pipeline" compact;
val masks_option = rhs (concl result_th);
val masks = optionSyntax.dest_some masks_option;
val (mask_terms,_) = listSyntax.dest_list masks;
val _ = require (length mask_terms = 4) "expected four row masks";
val _ = require (List.all numSyntax.is_numeral mask_terms) "mask not numeral";
val public_th = timed "public_literal_binding"
  (fn () => REWRITE_RULE [source_def] result_th);
val public_pipeline = list_mk_comb (``raw_pipeline``,
  [bases,c,depth,source_literal]);
val public_compact = list_mk_comb (``raw_compact``,
  [bases,c,depth,source_literal]);
val _ = require (aconv (concl public_th)
  (mk_eq(public_compact,masks_option))) "changed compact public input";
val semantic_th = timed "bind_sign_semantics" (fn () =>
  REWRITE_RULE [public_th]
    (SPECL [bases,c,depth,source_literal] raw_compact_correct));
val _ = require (aconv (concl semantic_th)
  (list_mk_comb (``raw_sign_summary_rel``,[public_pipeline,masks_option])))
  "unexpected sign semantics statement";
val _ = audit "compact_integer_pipeline" public_th;
val _ = audit "compact_sign_semantics" semantic_th;
val _ = timed "save_primary" (fn () =>
  (save_thm("compact_integer_pipeline",public_th);
   save_thm("compact_sign_semantics",semantic_th)));
val _ = print "COMPACT_PRIMARY_COMPLETE,4,129,1032\\n";

(* All full-result readback and validation are AFTER primary acceptance. *)
val old_dir = OS.Path.mkCanonical (OS.Path.mkAbsolute
  {path="../raw-state-handoff",relativeTo=OS.FileSys.getDir()});
val _ = timed "validation_load_old_full_theory" (fn () =>
  (Meta.qquse (OS.Path.concat(old_dir,"HandoffFusedTheory.sig"));
   Meta.qquse (OS.Path.concat(old_dir,"HandoffFusedTheory.sml"))));
val old_full = DB.fetch "HandoffFused" "final_integer_pipeline";
val _ = audit "old_full_readback" old_full;
val _ = require (aconv (lhs (concl old_full)) public_pipeline)
  "old full theorem has different input";
val old_masks_th = evaluate "validation_old_full_mask"
  (mk_comb (``raw_compact_of``,rhs (concl old_full)));
val from_full = timed "validation_compose_old_full" (fn () =>
  TRANS (AP_TERM ``raw_compact_of`` old_full) old_masks_th);
val compact_expanded = timed "validation_expand_compact" (fn () =>
  REWRITE_RULE [raw_compact_def] public_th);
val _ = require (aconv (concl from_full) (concl compact_expanded))
  "compact mask differs from old full result";
val _ = audit "old_full_derived_mask" from_full;
val _ = save_thm("old_full_derived_mask",from_full);
val _ = print "COMPACT_MATCHED_OLD_FULL_SIGNS,1032\\n";

(* Rejection is asserted only where the compact contract must differ. *)
val _ = false_claim "base_label" (mk_eq(list_mk_comb (``raw_compact``,
  [``[2;2;3;41;61;10004;262144;265800]:num list``,c,depth,source_name]),masks_option));
val _ = false_claim "denominator" (mk_eq(list_mk_comb (``raw_compact``,
  [bases,``62:int``,depth,source_name]),masks_option));
val _ = false_claim "depth" (mk_eq(list_mk_comb (``raw_compact``,
  [bases,c,``127:num``,source_name]),masks_option));
val wrong_masks = listSyntax.mk_list
  (mk_comb (``SUC``,hd mask_terms)::tl mask_terms,``:num``);
val _ = false_claim "final_mask" (mk_eq(compact,optionSyntax.mk_some wrong_masks));
val _ = true_claim "negative_ties"
  ``round_scaled 2 (~5) = ~2 /\\ round_scaled 2 5 = 3``;
val _ = true_claim "sign_codes"
  ``raw_sign_code (~1) = 0 /\\ raw_sign_code 0 = 1 /\\ raw_sign_code 1 = 2``;
val _ = timed "theory_export" export_theory;
val _ = print "COMPACT_DONE\\n";
'''
    encoded = text.encode()
    assert len(encoded) < 64 * 1024
    inputs = {str(FIXTURE.relative_to(ROOT)): digest(raw),
              "HandoffRuntime.sml": digest(runtime_bytes)}
    for name in ["RawCompactSignsScript.sml", "prepare_compact.py"]:
        inputs[name] = digest((HERE / name).read_bytes())
    receipt = dict(schema="raw-compact-source-binding-v1", inputs=inputs,
                   scope="integer sign packing only; no state evaluation by generator",
                   expected_large_pairs_embedded=0, seeds=8, output_masks=4,
                   represented_coordinate_signs=1032,
                   source_sha256=digest(encoded), source_bytes=len(encoded),
                   generation_cpu=time.process_time()-cpu,
                   generation_elapsed=time.perf_counter()-wall)
    for name in ["compact_fused.sml", "compact_binding.json", "prepared_inputs.sha256"]:
        assert not (HERE / name).exists()
    with (HERE / "compact_fused.sml").open("xb") as f:
        f.write(encoded)
    with (HERE / "compact_binding.json").open("x", encoding="utf-8") as f:
        json.dump(receipt, f, indent=2)
        f.write("\n")
    bound_files = ["compact_fused.sml", "compact_binding.json",
                   "RawCompactSignsScript.sml", "prepare_compact.py",
                   "../raw-state-handoff/HandoffRuntime.sml",
                   "../../lean-pilots/raw-head/state_fixture.json"]
    with (HERE / "prepared_inputs.sha256").open("x", encoding="utf-8", newline="\n") as f:
        for name in bound_files:
            f.write(digest((HERE / name).read_bytes()).lower() + "  " + name + "\n")
    print(json.dumps(receipt, indent=2))


if __name__ == "__main__":
    main()
