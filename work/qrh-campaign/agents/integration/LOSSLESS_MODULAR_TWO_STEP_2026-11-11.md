# Lossless receipt for one translation and one inversion/root

2026-11-11. The new, separately versioned packet passes exact full-input set-containment checks for all 16 arithmetic gates in the initial T step and first S/root step at `T=1,000,000`, real node `r=0`. Six explicit domain/branch inequalities also pass. Its only input is an **unproved transcendental seed box**. This is conditional arithmetic verification in external Python, not certification of that seed, a complete modular kernel, or a Lean proof.

The original four-point receipt and its partial replay are unchanged. In particular, the original 14 failed translation and 3 failed quotient edges remain failed under their exported-endpoint semantics. This new packet does not include the later three quotient failures: it concerns only the first S/root at real node zero.

## 1. Frozen inputs and new files

Paths are relative to `work/qrh-campaign/agents/`.

| Item | Path | SHA256 |
|---|---|---|
| Original producer | `prime-estimates/principal_theta_modular_pilot_20261111.py` | `EAFAC6A19BE3947CBF6D4BA6F900FE3E8BAB58E1C1963E0C1DC35A61A6F55B14` |
| Original data | `prime-estimates/principal_theta_modular_pilot_20261111.json` | `C39982174CAC9C51E9F816275082BCE322CA2AD143D9FCE61081DF72E57B11EF` |
| One-edge diagnosis data | `mellin/modular_endpoint_export_diagnosis_20261111.json` | `6CEA85CA705494E5DD20751722FF620CB6F7AF72EE898EE8C3D680F77DE4011F` |
| New generator/checker | `integration/lossless_modular_two_step_20261111.py` | `9A0EFE7074098764FDE27273836158B343F67FF300352B37F6E01B9ED74DE7E6` |
| New receipt | `integration/lossless_modular_two_step_20261111.json` | `31DD05C2F85A02D29037E91BA63BE85AEC5C55063FED96010552C5BCF0034FBE` |

The generator verifies all three input pins. It imports only the frozen producer's definitions, not its main program. It reproduces the original seed expression, then only one translation, one inversion, and the root-factor formula. The nine available original snapshots match exactly when re-exported by the original 256-bit endpoint routine: tau, translated tau, S output, root argument, root, A, norm, u, v. Newly recorded intermediate operations were previously absent.

Generate, from the repository root:

```
work/qrh-campaign/interval-env/Scripts/python.exe -X utf8 work/qrh-campaign/agents/integration/lossless_modular_two_step_20261111.py
```

Read-only exact replay, using ordinary Python without importing Arb:

```
python work/qrh-campaign/agents/integration/lossless_modular_two_step_20261111.py --check work/qrh-campaign/agents/integration/lossless_modular_two_step_20261111.json
```

Both completed successfully. The read-only verifier returns arithmetic status and lists `tau` as an unproved seed. Its successful exit is not an analytic certificate acceptance condition. It does not create or change a receipt.

## 2. Lossless semantics and bounded arithmetic

Each real node stores four exact signed-exponent dyadics: midpoint m, nonnegative radius r, and endpoints lo, hi. The verifier checks `lo=m−r`, `hi=m+r`, and `r>=0`. Its meaning is the closed interval `[lo,hi]`, exactly the internal ball rather than a rounded endpoint export. Complex nodes are Cartesian products of two such intervals.

Midpoint/radius extraction uses the external API semantics established in the one-edge diagnosis. Once serialized, none of the arithmetic checks relies on Arb's operation result being correct: the checker recomputes the required inequalities from exact numbers. Only generation/provenance and the unproved analytic seed still depend on the external computation.

This small experiment guards each input mantissa width and absolute exponent by 4,096 before converting to Python `Fraction`. It is deliberately **not** the general compact huge-exponent backend. Actual maxima are 283 mantissa bits and absolute exponent 333. The reciprocal candidate fractions have at most 582 numerator bits and 566 denominator bits. Larger-exponent production nodes must use the reviewed compact dyadic method or another proved bounded representation, not copy these Fraction conversions blindly.

The fixed `RECIPE` binds every node ID, kind, operation, operand ID, and numerical parameter. Forward references, duplicate IDs, changed argument identities, extra nodes, and unknown operations cannot silently change the expression being verified. The seed remains visibly unproved, rather than being promoted to a theorem by a successful parse.

## 3. Exact graph

Set `t=tau+1` and `z=−i*t`. The source's S output is `−1/t`, and its root multiplier is `A=1/sqrt(−i*t)` with the right-half-plane square-root branch. The packet spells out that root formula:

| Node | Operation and exact operand IDs |
|---|---|
| tau | unproved box for `−cos(2/1000001)+i sin(2/1000001)` |
| translated | tau + 1 |
| S_output | −1 / translated |
| root_argument | −i * translated |
| root_x, root_y | real and imaginary projections of root_argument |
| root_x_square, root_y_square | unary squares of root_x, root_y |
| root_norm_square | root_x_square + root_y_square |
| root_norm | nonnegative square root of root_norm_square |
| root_u_sum | root_norm + root_x |
| root_u_half | root_u_sum / 2 |
| root_u | nonnegative square root of root_u_half |
| root_v_denominator | 2 * root_u |
| root_v | root_y / root_v_denominator |
| root | complex assembly of root_u and root_v |
| A | 1 / root |

The 17 nodes consist of one seed and 16 verified gates. The explicit domain checks prove positive imaginary part of translated, positive root_x, nonnegative root_norm, positive root_u and its doubled divisor, and positive real part of root. No pole or branch boundary lies in the relevant input box.

## 4. What “full-input containment” means here

For translation and rotation the exact affine image of the entire input box is checked. For addition, scaling, and division, the verifier checks the Cartesian product of the displayed operand intervals, even when the true operands share ancestors. Division checks all four rational endpoint quotients after excluding zero from the denominator.

For a unary square, the range is `[0,max(lo²,hi²)]` if zero is contained, otherwise `[min(lo²,hi²),max(lo²,hi²)]`. A general proof must distinguish that operation from multiplication of two independently chosen elements of the same interval. In this packet both intervals are sign definite, and the separately recorded independent-product tests also pass. No tightening based on correlation is needed for these two gates.

For a nonnegative square root, output `[L,U]` is accepted only if the input lower bound and L are nonnegative and `L²<=input.lo`, `input.hi<=U²`. These are full unary-range conditions, not a test of endpoint overlap.

For a complex reciprocal, write `1/(x+iy)=x/(x²+y²)−i*y/(x²+y²)`. The input rectangle must exclude the origin. Neither component has an interior stationary point away from zero. Hence coordinate extrema occur on edges. The real component requires corners, y=0 on vertical edges, and x=±y on horizontal edges. The imaginary component requires corners, x=0 on horizontal edges, and y=±x on vertical edges. Only candidates lying on the edge segment are included. Their coordinates and values are rational, so the range is checked exactly. Negating the two ranges gives the `−1/t` rule.

Both actual reciprocal gates pass this exact rectangle-image rule, with 16 candidate evaluations in total. The earlier coarse rule bounded numerator and norm denominator independently and certified neither reciprocal; its failure was an overestimate, not an identified false reciprocal. Two independent exact examples in the script exercise non-corner extrema: `[-2,2]+i[1,2]` and `[1,2]+i[-2,2]`. A rectangle containing the pole is rejected.

All these gates accept the full advertised sets. This small graph therefore needs no bespoke correlation-aware gate beyond ordinary unary semantics and preservation of operand identities. That conclusion is local; it does not establish that arbitrary later Arb graphs will pass independent-box rules.

## 5. Root identity is a separate symbolic argument

For an exact input z=x+iy with x>0, let `n=sqrt(x²+y²)`, `u=sqrt((n+x)/2)>0`, and `v=y/(2u)`. Then `n²−x²=y²`, so `v²=(n−x)/2`, `u²−v²=x`, and `2uv=y`. Thus `(u+iv)²=z` and `Re(u+iv)>0`; this identifies the principal square root on the right half-plane. The exact graph consistently uses the same x and y in this argument.

The interval test does **not** claim every independently selected pair in the output root box squares to the same z. It claims that the value of this fixed expression for every input z is enclosed by the root box. The symbolic identity then links that expression to the required square root. This is the semantic bridge a future formal verifier must prove once. A small output overlap would not supply it.

Likewise, the A gate contains the reciprocal of every value in the whole root box, which in particular contains the exact expression for each original input. This gives valid composition without treating independent interval coordinates as algebraically equal.

## 6. Rejections and remaining obligations

Seven corruption controls are rejected: changed translation constant, zero S output, wrong rotation operand, wrong division operand, negative square-root branch, negative radius, and forward reference. The controls combine arithmetic failures with fixed-recipe/type/dependency failures; they are not comprehensive adversarial testing.

The next proof obligations remain explicit:

1. Prove the transcendental seed enclosure with certified elementary operations. At present only a rigorous external producer supplies it; neither successful arithmetic replay nor original-point snapshot agreement proves that analytic fact in Lean.
2. Formalize the typed graph semantics and soundness of every gate, including the reciprocal edge-extremum lemma and the principal-root identity. Porting the tested Python is not itself a proof.
3. Use compact signed-exponent arithmetic for general production data, together with a resource policy and a parser whose accepted values/operations are fully specified.
4. Produce and validate the remaining modular steps, reduced theta series, error bounds, derivative unwind, and final P graph. This test generates none of them and says nothing about their previously failed edges.
5. Compose the eventual coefficient certificate with the reviewed Fourier/node-substitution and whole-panel arguments, then supply the actual contour coverage and spectral certificates. No such conclusion follows from these two steps.

The useful result is narrow: lossless internal-ball serialization removes the known first-translation mismatch, and a complete explicit arithmetic graph for the first S/root passes a checker that uses full-input ranges rather than intended-point overlap. It does not upgrade any existing frozen analytic or spectral status.
