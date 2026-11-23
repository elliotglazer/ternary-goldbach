# Static preflight review of the rational xi panel backend

2026-11-11. **PASS at static implementation/preflight scope. No blocking mathematical defect found.** This permits consideration of the separately authorized bounded pilot; it does not certify that any node radius, coefficient, or final disk test will pass. I did not run the backend, evaluate nodes or weights, rerun the scalar plan, launch Lean, or change author files.

## Reviewed versions

The complete backend, design note, both imported helper implementations, scalar planning implementation, and the relevant accepted specification/tail reviews were read. These SHA256 values were checked against local bytes:

| File under `work/qrh-campaign/agents` | SHA256 |
|---|---|
| `integration/rational_xi_panel_backend_20261111.py` | `DEE8AC9AA39F25023C77003BC2AAA5970388A016207AD5A8EE0DF8F6D912F84A` |
| `integration/RATIONAL_XI_PANEL_BACKEND_2026-11-11.md` | `7072D0D5EAECE93066F013799FC1B872B5E3A9CA4B5E589D299D458B7D115A32` |
| `integration/r1over8_p_node_exact_20261111.py` | `4EE532C9698CCD8B462D40A1D102CE6DAD35741173C7D43F911C3AE7B2F15286` |
| `integration/lossless_modular_two_step_20261111.py` | `9A0EFE7074098764FDE27273836158B343F67FF300352B37F6E01B9ED74DE7E6` |

The specification is `92E778B5…D00E957`; the preceding twelve-item preflight review is `A02D747B…4D4639C`. The sharp sixteen-mode acceptance is in the pinned `zero-sum/REVIEW_NEXT_RATIONAL_XI_PANEL_SPEC_2026-11-11.md`, `2F05928D…2CC97`. It is **not** a consequence of applying the weaker general tail theorem at N=16. The separate general-tail review explicitly makes that distinction, as does this backend's design.

## Twelve preflight items mapped to the implementation

| Requirement | Static finding |
|---|---|
| Fixed function and input identities | TARGET and authorization comparison retain `T_input=32`, eta=1/33, b=pi/4-1/33, `T_work=14`, center, a/kappa, grid, degree, radius and rectangle. They are not command-line numerical options. |
| All fresh nonnegative nodes | `node(k)` only accepts 0 through 928; `assemble` requires the ordered full list. Nodes are calculated anew, with post-rounding L1 radius <=2^-24. |
| Generic checked modular path | Each word has a whole-box translation guard, positive-height S domain, principal-root construction and type tracking. Four S steps are a hard maximum; stopping has priority. |
| Negative and zero nodes | Assembly conjugates the imaginary center for k<0 and leaves zero once. It does not copy the complex positive node unchanged. |
| Signed normalized weights | `weights(k)` uses signed v, h*v^j/j!, and exp((1/10+14i)*v). The six positive-order zero-node weights vanish; order zero is exactly h. |
| Weight radius and grid | Every nonzero weight is independently enclosed and rounded to 2^-64 with L1 error <=2^-48. It is not recursively formed from a rounded preceding order. |
| Exact finite sums | Integer complex products of 2^-32 and 2^-64 centers are summed on the 2^-96 grid. No extra factorial or sum rounding enters. |
| Complete scalar allocation | The pinned scalar `run()` is compared field-for-field to its saved receipt. It checks derivative cutoff q*exp(2V)>=2 and all analytic/node/weight bounds. |
| Whole-disk error | The replayed complete bound is required below 1/10. Node and weight checks enforce the hypotheses under which that uniform planning bound applies. |
| Fresh polynomial sign | The L1 variation U is computed from the new exact coefficients, with powers rho^j. Only `Re(c0)-U>1/10` gives positive-disk status. |
| Exact rectangle/polygon | Target corners, closure, turn orientation and disk distances are checked; the successful special-case image polygon is the constant 1. Its four zero crossings require no numerical argument evaluation. |
| Partial/failure separation | Incomplete prefixes remain PARTIAL; a completed failed sign test is INCONCLUSIVE. Resume recomputes prior nodes; --check recomputes all available nodes and, for 929, the complete assembly. |

## Arithmetic primitives and actual call paths

The executed helper functions use `Fraction`, integer powers, factorials, floor/ceiling and `isqrt`. Importing the helpers does not invoke their old `run()` or `generate()` functions. In particular the second helper contains an Arb-based historical generator, but the backend calls only its exact `reciprocal_rectangle` routine. No stored Arb endpoint or earlier numerical coefficient enters this path.

The original interval `rnd` encloses both exact rational endpoints; changing its module's BITS/SCALE changes its outward grid correctly. The clock wrapper does not change the result. Multiplication/division evaluate all endpoint combinations, with division excluding a zero denominator. Repeated-variable dependency may enlarge a box, but does not invalidate its enclosure.

The imported exponential sums orders 0 through 95. Its added `2^-96 * 97/(96*96!)` bounds the full omitted tail on the reduced interval [0,1/2], and subsequent squarings are outward. Negative arguments use reciprocal bounds. The new branch is applied to each endpoint separately: for x<=-384, exp(x)<2^-384, and otherwise the old endpoint routine runs. Thus an interval crossing the threshold does not discard its larger exponential. The widened 320-bit endpoint is an intentional enclosure, not a zero substitution.

The cosine/sine routine reduces by an integer multiple of an interval containing exact 2*pi, checks the entire reduced interval lies in [-4,4], and encloses the degree-158 cosine/degree-159 sine polynomials with the common absolute tail `2*4^160/160!`. Its interval recurrence remains an enclosure even when a repeated product such as y*y is wider than the exact square range. Machin's alternating sums have the correct lower/upper direction. These are analytic primitive contracts supported by the prior paper reviews; Python execution alone is not a formal proof of them.

The new square-root code brackets each nonnegative rational endpoint by exact integer squares. Its complex reciprocal helper checks exclusion of zero and includes corner values and all possible edge stationary points for both coordinate functions. This is full-box containment, not an overlap test. The principal-root construction uses z=-i*t with Re(z)>0, then positive u=sqrt((|z|+Re z)/2) and v=Im z/(2u). Inverting u+iv therefore gives the intended `(-i*t)^(-1/2)` branch.

## Dynamic theta word and reconstruction

The translation is consistently **t=current-n**. For theta2, reconstruction multiplies by exp(+pi*i*n/4); the exact-axis/sqrt(1/2) table implements this for positive and negative integers modulo eight. Odd n swaps theta3/theta4 with no extra scalar. The initial type is theta3.

S uses new point -1/t, factor A=(-i*t)^(-1/2), and swaps types 2 and 4 while fixing 3. Reverse transport applies

`A*g0`,
`A*(-g0/(2t)+g1/t^2)`,
`A*(3g0/(4t^2)-3g1/t^3+g2/t^4)`.

The prior translation phase multiplies all three components **after** that S reconstruction. Terminal stages with no S still apply their translation phase. This order is correct for the recorded forward word. The lower-height stop has priority, and after four inversions an undecided stop rejects instead of taking a fifth.

Terminal theta2 uses modes 1/2 through 31/2; theta3/theta4 use 1 through 16. Theta4 has the correct alternating sign. The central 1 occurs only in order-zero theta3/theta4. Ordinary derivatives multiply by `(pi*i*mode^2)^j`; there is no derivative-factorial division here. Padding each real/imaginary coordinate by 2^-277 encloses the independently accepted norm tail, and subsequent interval operations propagate it. No fixed amplification constant substitutes for that propagation.

The final kernel formula includes both original tau factors and the complete exp((r+ib)/2) phase. It reconstructs `exp((r+ib)/2)*(6*tau*theta3'+4*tau^2*theta3'')`, with no half-normalization or missing theta constant. The center-norm assertion uses squared integer centers with scale 2^64, so its threshold 2^118 is exactly the required norm bound squared 2^54. The L1 radius test safely implies the requested Euclidean radius.

## Replay, completion, and limits that remain

The backend rejects optimized Python, so its mathematical assertions are active. Pinned helpers and scalar inputs are checked before a run. Authorized target metadata is exact. Resume compares recomputed node records before extending; changed radii, word records or centers will fail that comparison. A full --check additionally compares weights, coefficients, geometry, disk status and scalar receipt through complete assembly equality. A saved partial record cannot gain positive-disk status merely from replaying its prefix.

The temporary-file replacement is suitable for the stated single-writer experiment. It is not a multi-writer transaction protocol or a hardened adversarial parser. Time checks are cooperative between arithmetic operations; they do not interrupt an individual big-integer operation or the initial scalar replay. These are operational limits, not false mathematical acceptance paths.

**This is a deterministic producer/replayer, not a self-contained proof-object verifier.** `node()` clears the earlier Machin event from its event list, and weight elementary events are not serialized in the assembly. Nevertheless both are recalculated from the pinned source during replay. The saved records therefore must not be described as independently checkable merely by traversing their recorded elementary events. Likewise a backend's self-hash only binds its current code to its output; acceptance by the campaign must additionally match the externally reviewed hash above.

The documented independent checks of dynamic words, all terminal types, threshold-straddling exponentials, signed weights and corrupted records have **not** been performed by this static review. They remain appropriate for the independently reviewed pilot packet. No claim of measured runtime, guaranteed precision success, standalone arithmetic soundness, a certified new panel, or Lean validation follows here.

No blocking correction is requested for the frozen backend. Its prospective successful conclusion is limited to the specified low-height disk and inscribed rectangle. It does not supply either high principal strip, any full conductor-family certificate, the global QRH theorem, or either final Goldbach root.
