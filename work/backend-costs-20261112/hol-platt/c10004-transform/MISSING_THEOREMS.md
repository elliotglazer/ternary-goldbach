# Explicit missing theorem targets

These are mathematical obligations, not HOL declarations or assumptions
accepted by `tx_checked`. No placeholder theorem is exported for them.

## Outer tensor projection

The exact target is

```
!cache xs.
  LENGTH xs = 4800 ==>
  tx_tensor_selected cache xs = tx_project (tx_tensor_full cache xs)
```

The local `tx_omit_projection` proof is included in the generic source.
To extend it, prove bounded lookup/GENLIST and flattening equations, then
carry three stage invariants. Selected axis2 element40*j61+j41 equals
full axis2 element2*(40*j61+j41)+1. Selected axis40 element39*j61+(k41-1)
equals full axis40 element(2*j61+1)*40+k41. Selected axis60 element
59*(k41-1)+(k61-1) equals final full element(2*k41+1)*60+k61.
Apply congruence of each next line transformation after establishing its
input-list equality. All lookup ranges must be proved before discarding
the total helpers' zero/empty-list defaults.

This is a finite-index/list proof with arbitrary integer values and arbitrary
cached root entries. It does not require analytic roots. The two synthetic
runtime equality tests are not a universal proof of it.

## Actual source association and characters

Compose the separately owned layout's mutual-inverse index maps and residue
preservation with the source producer's exact scatter relation. Define actual
characters on the c10004 units, extend by zero, and prove multiplicativity,
primitivity and the stated positive-exponent convention. Then identify the
exact-arithmetic tensor with the corresponding character sum. The existing
finite map's residue enumeration is insufficient by itself.

## Root and numerical error contracts

Prove each supplied root center approximates its exact exp(2*pi*i*k/n) within
the selected error, and bind exact cached sums to the same centers. Root
coordinate bounds and special-root checks do not establish this. Transfer
the local signed residual to the actual complex norm, prove the exact CT
identity and summation-order error, then instantiate the selected p81
input-error/peak/safety contract for the complete tensor.

Input coordinate capacity is not a proof of its complex norm bound. Output
coordinate capacity is not a proof of L-value accuracy. Both remain separate
from the executable representation checks.

## End-to-end source and completion

The program does not yet construct the two actual input arrays. Required
producers are the rational shared EM powers/jet recurrence/translation,
the K20/b94 rounded Horner, the integer raw-head powers and conductor cache,
and the exact grid100 assembly plus p81 regrid. Their full original source
error and radius contracts must be proved in HOL and composed.

The remaining completion producer must generate the canonical parity,
root-number and Gamma factors, form every completed center and rigorous
radius, and prove reality via the actual functional equation. Only then can
an enclosure-aware status function establish real Hardy signs. The existing
integer sign compressor cannot supply that semantic theorem.

These gaps prevent any present claim of a complete measured analytic block,
even if all prepared integer diagnostics succeed.
