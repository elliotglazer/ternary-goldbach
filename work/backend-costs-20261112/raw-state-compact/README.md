# Compact integer-sign handoff experiment

Source preparation only. Nothing in this directory has been built or evaluated
by the author. Root runs generation and reporting with the existing Windows
Python, separately from the Linux proof runner. No Linux Python is required.
From the repository root in PowerShell, after review:

```powershell
& 'C:/Users/glaze/AppData/Local/Python/pythoncore-3.14-64/python.exe' work/backend-costs-20261112/raw-state-compact/prepare_compact.py
```

Then in the existing Linux environment:

```
sh work/backend-costs-20261112/raw-state-compact/run_compact.sh compact01
```

After a successful run, back in PowerShell:

```powershell
& 'C:/Users/glaze/AppData/Local/Python/pythoncore-3.14-64/python.exe' work/backend-costs-20261112/raw-state-compact/summarize_compact.py compact01
```

Capture each Windows process's whole elapsed/CPU cost separately. The generator
receipt measures internal preparation before writing files, not complete process
startup or output costs. Generation is exclusive-create; preserve prior attempts
before any explicitly authorized retry. The Linux runner checks the generated
source, binding receipt, original fixture, runtime and generic source against
`prepared_inputs.sha256` before and after HOL phases.

The predecessor is the successful handoff10 numerical run plus readback03.
Its old sources, logs, archived data and current exported theory data are pinned.
No old source, artifact or numerical executable is changed or rerun here.

## Exact new output contract

For an integer x, code(x) is 0 for negative, 1 for zero and 2 for positive.
Each complex integer pair contributes code(real)+3*code(imag), a digit below9.
A row is packed in base9, first time index least significant. The result is
SOME four natural masks. Row lengths129 are supplied by the unchanged source
pipeline and the matched old full-output theorem; mask values alone do not
encode row lengths. Leading zero digits mean negative/negative pairs, not
missing data.

The generic theorem binds the compact result to `raw_sign_summary_rel` on the
actual `raw_pipeline` output. This relation specifies every successive digit
through an existential tail, terminating at zero. `raw_sign_mask_rel_iff`
proves its equality to the exact recursive packer; `raw_sign_code_meaning`
and `raw_sign_digit_bound` state the comparison semantics and digit bound.
This is not a hash or a success-only assertion. It contains all1032 integer
coordinate signs, but not their magnitudes. It is a different theorem from
the predecessor's exact516-pair equality. It does not certify analytic signs,
Hardy-function signs, roots, zero counts or the original analytic seed bridge.

## Matched computation and boundaries

The generator reads the same pinned fixture, checks its identifying fields,
and emits only its eight seed/step pairs. It performs no recurrence, head or
mask evaluation and embeds no expected large output array. The primary
computation is `raw_compact_of (raw_pipeline ... sources)`: all original
8x129 production, full shape/bounds checks, and four raw-head rows remain.
The extra sign comparisons/packing happen inside the checked computation.
Only the four masks cross its final decode boundary.

Source literal construction, definition, translation, common scale proof,
representation, computation, decode, closure, public source binding and sign
relation binding are named phases. Generic theorem construction and process
costs are recorded separately. The instrumented primary sum is not a complete
first-acceptance time; parsing, some term construction and audits remain in
whole-process time. No complete acceptance or performance claim follows from
source preparation.

After the primary marker, the wrapper loads the pinned old fused export. It
checks that its full theorem has exactly the same public pipeline input, maps
the new packer over its RHS with the checked evaluator, and uses AP_TERM/TRANS
to derive the same compact equality. This deliberately materializes the old
full result only in the validation phase, never as an input to the primary
compact computation. Readback, representation, conversion and validation
costs are charged separately, not silently excluded from complete-run totals.

The new controls test invalid base label, denominator and depth, an altered
compact result, zero/negative/positive sign codes, and negative rounding ties.
The old seed/step/interior/full-array controls remain proven by the pinned
predecessor. They are not asserted to remain discriminating after sign-only
compression: two different magnitudes can legitimately have the same signs.
The unchanged raw pipeline still performs its entire shape/bounds guard.

## Interpretation

Compare final decode and result-binding costs with handoff10, and also charge
the new sign packer's compute cost. Count the new library proofs, source
generation, executable preparation, old-result validation, controls, export
and any future readback in the applicable cold or warm lifecycle. A successful
comparison would demonstrate a representation tradeoff for this fixed
integer-sign contract only. It would not justify refunding the227.54-year
source-translation proxy or changing any end-to-end forecast. The actual
analytic consumer needs a separately proved sign enclosure interface.
