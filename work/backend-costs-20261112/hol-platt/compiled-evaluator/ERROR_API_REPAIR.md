# compiled02 HOL error API repair

2026-11-13. Prepared at root's request; no build or SML run by this author. `compiled02` remains the recorded failed runtime typecheck, with its receipts unmodified.

The repaired dependency edges allowed source loading to reach `CompiledEvalChecks.sml`. The next failure was its obsolete `HOL_ERR {origin_structure,origin_function,message}` pattern. The installed API instead has `exception HOL_ERR of hol_error`, where `hol_error` is a `HOL_ERROR` constructor carrying an origin list and message.

Only the observer's exception branch changed:

```sml
HOL_ERR err =>
  if length (Feedback.origins_of err) = 1 then
    Raised (Feedback.top_structure_of err ^ ":" ^
            Feedback.top_function_of err ^ ":" ^ Feedback.message_of err)
  else raise Fail "unexpected wrapped/empty HOL error origin"
```

The public accessors are declared in `src/prekernel/Feedback.sig:14–18`; their implementations are in `Feedback.sml:23–24,77–86`. The stock `mk_HOL_ERR` at line94 constructs exactly one origin via `mk_hol_error` at lines26–29. Thus the expected unwrapped `Thm:compute.env_lookup:...` and `Thm:compute.get_code:...` strings remain exact comparisons. An unexpected wrapped/empty origin is a hard failure; unrelated exceptions are still not caught. The test signal branch and all259 test cases are unchanged. This is an API adaptation, not a weakening to arbitrary exception equality.

The original checks source, manifest and strict receipt checker are preserved in `pre_error_api_repair/`. The manifest changes only the checks-module support hash. `prepare_harness.py` already hashes the current support source, so it needs no edit. The strict checker now pins the new manifest; its acceptance conditions are unchanged. No interpreter, primitive, fixture, theorem construction, timing or runner source changed.

The source-only checker passes against the new manifest, confirming the original parser/interpreter/CV configuration, exact four fixtures and all five corruptions remain bound. That is not a runtime typecheck. Root may proceed with a fresh `compiled03` smoke attempt after source review, retaining the same resource limits and failure preservation. The final receipt audit must still require all259 semantics,208 timing rows per process and exact expected controls; partial logs cannot support a performance conclusion.

| File | SHA256 |
|---|---|
| CompiledEvalChecks.sml | `05F00A7054DF6BD7FCBF7C009AFC6CE006032CB0E793DA8F55229786E0404C38` |
| harness_source_binding.json | `16121C4FAEEE89B7CDF0982B5226BD885A887BA619EC21CB1E8BD3235CE34E7F` |
| audit_compiled_results.py | `AEEEDDB8B1B77C573B32EE356D563A5FE3B90F38B2A28CEA7D572834764C63C1` |
| installed Feedback.sig | `F7EF83DDCC96741ED146004A75DD61D9E26F659E9A6A9135CB5EF4739C248184` |
| installed Feedback.sml | `E5F564E1BF61CA63ECFF01058EE069AD41D2291C8681DDE89E49531F22EBD7B4` |

The prior two-reference dependency repair remains in force. Earlier reviewed pins are superseded only for the files explicitly listed here; all prior attempt artifacts remain untouched.
