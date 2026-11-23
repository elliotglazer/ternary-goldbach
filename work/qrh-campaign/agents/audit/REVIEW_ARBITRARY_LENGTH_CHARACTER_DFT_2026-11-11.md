# Independent review: arbitrary-length positive character DFT

2026-11-11. **PASS as a finite algebraic algorithm, deterministic error analysis, and terminating arithmetic-precision plan.** No correction to the frozen packet is required. This is not an implemented or Lean-checked character evaluator, and supplies no L-values, contours, or spectral evidence.

## Frozen inputs

All paths in this section are relative to `work/qrh-campaign/agents/`. The following hashes were independently checked:

| Artifact | SHA256 |
| --- | --- |
| `integration/ARBITRARY_LENGTH_CHARACTER_DFT_2026-11-11.md` | `FFF8C45E75DA6EF89D13E657C0E7C05713F861FCF7FFE47E87497C7ED624F5F1` |
| `integration/arbitrary_length_character_dft_20261111.py` | `74430B4B7CC49586CEF3114C43CCD186F8DF49E7E3AF23EECB8B55256840D727` |
| `integration/arbitrary_length_character_dft_20261111.json` | `29FE8DB6FED8983AF49189F0E25F8D03413B43C15EAE5CAF24697CFF0C73D444` |
| `moebius/FAMILY_FINITE_FFT_PROOF_PLAN_2026-11-11.md` | `6E303D60C855E2CAD444EBC4EB3B1A3BD192D9BEAFAE0448F3F6D63CD9CDAC2E` |
| `major-constants/REVIEW_FAMILY_FINITE_FFT_PROOF_PLAN_2026-11-11.md` | `B98A0735B223EBA01922044733750DC13A3C806B531AA1894D54589B68A88B0D` |

The source-to-character adapter is the previously reviewed unit-group plan `DFA02789B3025A997F98E0500B001B3C5A7D983C400EEDC8F7B6DD4ADDAE4866`, with my review `222346A598FB72100005E065A6BFA77DCDE91B8B8F9F068847BE9DCBA0FB558D`. That review pins the actual Mathlib LFunction, Hurwitz, and DFT definitions. The present audit read the complete new note, code, receipt, and accepted radix-two proof/review. I did not execute the author script because it rewrites its frozen receipt; I wrote and executed an independent tiny diagnostic instead.

## Exact chirps, padding, and normalization

Let m>=1, let L be a power of two with L>=2m-1, and write P for the positive transform normalized by 1/L. The accepted radix-two invariant computes exactly P, with positive twiddles and division by two at every stage. It does not compute an unnormalized forward transform. Its general invariant and recurrence are applicable here; its former stage cap 36, Gaussian inputs, and fixed precision are not imported.

The chirps have the correct signs:

```
a_j = x_j exp(pi*i*j^2/m),
b_(t mod L) = exp(-pi*i*t^2/m),  -(m-1)<=t<=m-1.
```

The signed t range is injective modulo L: the absolute difference of two such t is at most 2m-2<L. For each retained output 0<=k<m and input 0<=j<m, k-j lies in that signed range. Thus circular convolution uses the intended negative-square chirp, not a wrong wrapped value. Multiplication by the final positive chirp gives the exponent

`j^2 + k^2 - (k-j)^2 = 2jk`,

which is the desired positive DFT. The zero padding and signed placement prove this identity for every input, without a sampling or periodicity assumption. Although the kernel is even in t, an odd-m chirp is not m-periodic. Reduction modulo 2m, as specified, is necessary.

With J the output reversal and Q=JP, finite root orthogonality gives `QP=PQ=(1/L)id`. For circular convolution C, direct finite reindexing gives `P(C)=L P(a)P(b)`. Therefore

`C=L^2 Q(P(a)P(b))`.

The factor L^2 is correct. Three normalized transforms, one output reversal, and this factor recover convolution. A factor L would leave an erroneous 1/L. Multiplication by L^2 can be exact for an unbounded dyadic representation; it is not automatically exact in an overflow-prone or rounding fixed-width implementation. The note retains that distinction.

For m=1, L=1 yields the identity and zero stages; the construction and all inequalities remain defined. For m=2 the least allowed L is 4, and the signed kernel is at residues 0,1,3. No order-two test alone can distinguish every sign reversal, which is why odd lengths are included in the independent checks. Nonminimal padding also preserves the proof.

## Full error pipeline

B is a nonnegative rational bound for the fixed rational input centers. With local root and operation errors bounded by q, the initial chirp product error `e_a=q(B+1)` and kernel error `e_b=q` are valid. The normalized transform has sup-norm operator bound one. Hence input perturbation can be separated from arithmetic performed on the perturbed centers:

```
E_alpha = e_a + R_d(B+e_a,q),
E_beta  = e_b + R_d(1+e_b,q).
```

The exact normalized outputs obey `|alpha|<=mB/L` and `|beta|<=(2m-1)/L`, because only the indicated numbers of entries are nonzero. The product estimate includes both linear errors and their product. The additional q accounts for product rounding. Its `M_p=A*D+E_p` bounds the actual rounded product centers supplied to the third transform. The third transform's input error and own arithmetic error are then correctly added.

After exact scaling, the convolution error is L^2 E_w. Splitting the final chirp product using the rounded chirp of norm at most 1+q gives

`E_arith <= (1+q)L^2 E_w + q*mB + q`.

The term mB bounds the exact retained convolution output. This includes every operation stage in the stated algorithm. Cached kernel enclosures retain their original E_beta; reuse does not discard or statistically reduce it. All correlations are permitted.

The separate source uncertainty term `sum eps_j` is also correct. It compares the actual input's exact length-m DFT to the centers' exact length-m DFT. It therefore is not multiplied by the internal L^2 factor. This separation would be invalid if the arithmetic comparison silently changed its reference inputs, but the packet explicitly keeps those references fixed.

## Precision termination

I independently rederived the coarse constants in section 5. For `q<=1/(d+1)`, the recurrence satisfies `R_d(M,q)<=dq(M+2)`; the finite product multiplier is below two since `dq/2<1/2`. This also holds at d=0. Then

```
E_alpha <= q[B+1+d(2B+3)] = q*a1,
E_beta  <= q(1+4d)       = q*b1,
E_p     <= q*p1,
E_w     <= q*w1,
E_arith <= q[2L^2*w1+mB+1] = q*K.
```

The product contribution is bounded using q^2<=q. Since K>0 and the requested arithmetic tolerance is positive, doubling a dyadic denominator until `q<=min(1/(d+1),tau/(2K))` terminates and yields error at most tau/2<tau. No uniform bound on d or on the size of B is being assumed.

The root construction supplies the necessary local errors rather than presupposing them. Modulo-2m chirp residues and analogous butterfly residues reduce angles to [0,2pi). A Machin enclosure with error at most q/8 gives angular error at most q/4. The approximate angle is below 7. The exponential polynomial tail uses its first omitted term and the ratio bound 7/(N+2)<1, so its rational upper bound tends to zero. Componentwise dyadic rounding supplies the last error term. The combined root radius is below q. Signed floor rounding at p+1 bits gives operation error below q in complex norm by summing the two component errors. These are existence and reference-algorithm arguments, not a bit-complexity guarantee.

As the note correctly states, arithmetic precision cannot repair an already excessive source-coefficient radius or force a nonzero output. A separate convergent coefficient engine and source-to-interval proofs remain necessary.

## Tensor and source consequences

Each unnormalized length-m axis transform has sup-norm operator bound m. Therefore an arithmetic error introduced at axis i is multiplied by the product of later axis lengths. Formula (6) is the correct accumulated bound, and the proposed per-axis allowances give a strict total below half the chosen budget. Every line needs a verified magnitude bound for its actual current centers; using the initial input bound at every later axis without updating it would be invalid. The packet does not make that shortcut.

The algorithm acts separately on the accepted CRT unit-group coordinates, including separate sign and five-power coordinates for powers of two. It introduces no cyclic assumption on the whole unit group. Positive labels, primitive extraction, and eventual multiplication by `c^(-s)` remain those of the accepted unit-group plan. In particular this FFT computation adds no Gauss or totient weights and supplies no new principal-row pole convention.

## Independent exact diagnostic

I wrote `audit/review_arbitrary_length_character_dft_20261111.py`, SHA256 `A3DBA49A0A68D7EFFC31E2FF37226AF4E5B94A41F826DBCFFB6507E9750EBF0C`, with receipt `audit/review_arbitrary_length_character_dft_20261111.json`, SHA256 `80B397427E87D14E201864C7124490DA5AED29985A8C25682E7A6517314D6410`. It imports no producer code and uses no floating-point trigonometry.

The diagnostic builds cyclotomic polynomials by exact integer division and computes in `Q[zeta_lcm(2m,L,4)]`. For m=1,2,3,5,7,8 it compares direct positive DFTs, signed chirp convolution, and an independently written recursive unnormalized radix-two transform. Tracking its normalization explicitly verifies that the third-transform result is L times convolution, equivalent to the packet's L^2 scaling for three normalized transforms. It also checks every relevant signed index and compares the recursive transform with the direct transform. Wrong normalization is rejected in every nontrivial case; omission of output reversal is rejected in the tested m>2 cases. Small-length exceptions in these mutation tests are recorded rather than claimed as rejections.

A further 56 exact Fraction cases iterate the original stage recurrence, rather than recomputing its geometric-sum formula. They verify every intermediate coarse bound and the final Kq bound, including q=1/(d+1), zero and large B, and nonminimal padding. The script exited zero. These finite checks corroborate the general paper argument; they are not a kernel proof, a complete implementation test, or a spectral computation.

The remaining work is still the formal signed-index and convolution proof, source adapters, implemented circuit/refinement and exact-rounding checks, actual coefficient packets, and any later contour/completeness evidence. The unchanged Goldbach roots acquire no new assumptions from this plan.
