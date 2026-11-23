# Arbitrary-length positive character DFT by Bluestein

2026-11-11. Paper derivation, explicit rational error bounds, and a small exact diagnostic. Submitted for independent review. This extends the accepted unit-group tensor transform to every finite axis length. It supplies no actual L-function samples, spectral certificate, Lean implementation, runtime forecast, or new premise at the Goldbach root.

## 1. Accepted dependencies and conventions

Paths below are relative to `work/qrh-campaign/agents/`.

| Input | SHA256 |
| --- | --- |
| `integration/UNIT_GROUP_CHARACTER_TRANSFORM_PLAN_2026-11-11.md` | `DFA02789B3025A997F98E0500B001B3C5A7D983C400EEDC8F7B6DD4ADDAE4866` |
| `audit/REVIEW_UNIT_GROUP_CHARACTER_TRANSFORM_PLAN_2026-11-11.md` | `222346A598FB72100005E065A6BFA77DCDE91B8B8F9F068847BE9DCBA0FB558D` |
| `moebius/FAMILY_FINITE_FFT_PROOF_PLAN_2026-11-11.md` | `6E303D60C855E2CAD444EBC4EB3B1A3BD192D9BEAFAE0448F3F6D63CD9CDAC2E` |
| `major-constants/REVIEW_FAMILY_FINITE_FFT_PROOF_PLAN_2026-11-11.md` | `B98A0735B223EBA01922044733750DC13A3C806B531AA1894D54589B68A88B0D` |

The radix-two algorithm starts from bit-reversed input and uses simultaneous butterflies `(u+w*v)/2,(u-w*v)/2`, with positive unit twiddles. At length L=2^d its exact output is

```
P_L(z)(k) = (1/L) * sum_(j=0..L-1) z_j * exp(2*pi*I*j*k/L).
```

Its algebraic invariant and general error recurrence are used here. Its particular Gaussian input, fixed precision 180, stage cap 36, and fixed-Hcert numerical budget are not imported. This note derives precision for arbitrary finite d and input size.

Define the exact output permutation `J_L(z)(k)=z_((-k) mod L)` and the normalized negative transform `Q_L=J_L P_L`. Thus `Q_L P_L=P_L Q_L=(1/L) id`. At L=1 both transforms and J are the identity, with no butterflies.

## 2. Exact chirps and signed embedding

Fix any integer m>=1. The desired output is the unnormalized positive transform

```
Y_k = sum_(j=0..m-1) x_j * exp(2*pi*I*j*k/m),  0<=k<m.
```

Let L be any power of two with L>=2m-1. The implementation can take the smallest such power. Put

```
u_j = exp(pi*I*j^2/m),
v_t = exp(-pi*I*t^2/m) for integer t.
```

Construct length-L arrays

```
a_j = x_j*u_j if 0<=j<m, and 0 otherwise;
b_(t mod L) = v_t for -(m-1)<=t<=m-1;
b_l = 0 at all remaining residues.
```

The signed interval has 2m-1 elements and is injective modulo L. Indeed, the difference of two distinct members has absolute value at most 2m-2<L. Thus no assignments conflict, even when L=2m-1. In particular `b_0=1` and `b_t=b_(L-t)=exp(-pi*I*t^2/m)` for 1<=t<m. The remaining zero block may be empty.

Use circular convolution

```
C_k = sum_(j=0..L-1) a_j*b_((k-j) mod L).
```

For 0<=k<m, the only nonzero a_j have 0<=j<m. Then k-j lies in the signed interval just embedded, so every summand uses precisely v_(k-j). Consequently

```
u_k*C_k
 = sum_(j=0..m-1) x_j*exp(pi*I*(j^2+k^2-(k-j)^2)/m)
 = Y_k.                                                       (1)
```

There is no unknown wraparound term. Only the first m convolution outputs are retained.

For efficient angle reduction use j^2 modulo 2m, not modulo m. For odd m the chirp changes sign under j -> j+m, so it is not m-periodic. The identity v_(-t)=v_t permits copying the same certified kernel entry to both signed residues, without treating their errors as independent.

At m=1 choose L=1. Then u_0=b_0=1 and (1) is the identity map. A direct identity implementation can avoid all arithmetic errors in this case.

## 3. Convolution normalization

Finite reindexing gives

```
P_L(C) = L * (P_L(a) * P_L(b)),
C = L^2 * Q_L(P_L(a) * P_L(b)),                               (2)
```

where multiplication inside the transform is pointwise. Both P and Q are normalized by 1/L. This is why the factor is L^2, not L.

The complete implementation is two normalized positive transforms, a pointwise product, a third normalized positive transform, exact output reversal J, exact multiplication by L^2, then the final positive chirp u_k. No negative-twiddle FFT is necessary. Multiplication by L^2 is an exact binary shift for dyadic numbers when the representation allows the required exponent and integer size; a fixed-width overflow-prone implementation would need additional bounds.

The kernel b and its transformed enclosure depend only on m, L and precision. They can be cached and reused for different input lines, with their same certified error bound. Such reuse does not assume independent rounding. A fresh kernel computation costs one transform; subsequent lines need only the input transform and the final transform.

## 4. Deterministic error propagation

First analyze the arithmetic relative to the exact transform of fixed rational input centers x_j. Let B be a proved rational bound for max_j |x_j|. Any uncertainty about actual source coefficients is added separately below.

Suppose every chirp and FFT twiddle center has absolute complex error <=q, where q>0 is rational, and each rounded complex butterfly output, input product, pointwise product, or final product has error <=q relative to its exact rational expression. Padding and permutations are exact. Define

```
R_d(M,q) = (q*M/2+q) * sum_(i=0..d-1) (1+q/2)^i,
R_0(M,q) = 0.
```

The accepted normalized FFT recurrence proves arithmetic error <=R_d(M,q) for exact input centers bounded by M. Its ideal intermediate values are bounded by M. For additional input errors, use the fact that P and Q have sup-norm operator bound 1, and add the input error separately. This avoids assuming a computed twiddle is exactly unitary.

All errors in the following table are maximum absolute entry errors. Let alpha=P(a), beta=P(b). Their exact bounds are

```
A = m*B/L,             D = (2m-1)/L <= 1,
|alpha|<=A,            |beta|<=D.
```

The certified pipeline is

```
e_a = q*B+q,                  e_b = q,
E_alpha = e_a + R_d(B+e_a,q),
E_beta  = e_b + R_d(1+e_b,q),

E_p = D*E_alpha + A*E_beta + E_alpha*E_beta + q,
M_p = A*D + E_p,
E_w = E_p + R_d(M_p,q),

E_arith = (1+q)*L^2*E_w + q*m*B + q.                          (3)
```

Here e_a includes the initial chirp multiplication and rounding; b is already a certified chirp table. The two middle transforms compare their rounded inputs to exact a and b by contraction, and compare their arithmetic to the exact transforms of those rounded inputs by R. The product bound uses

```
|alphahat*betahat-alpha*beta|
 <= D*E_alpha + A*E_beta + E_alpha*E_beta.
```

The third transform again separates input error E_p from its arithmetic. Output reversal does not change the bound. Exact scaling multiplies it by L^2. Finally |C_k|<=mB and |uhat_k|<=1+q, giving the last line of (3), including final product rounding. No scale-rounding term is omitted: this implementation requires that binary scaling be exact. An implementation that rounds it must add that term before the final chirp estimate.

There is no statistical cancellation in these bounds. They remain valid with all chirps, twiddles, pi values, cached kernels, and arithmetic errors correlated.

For actual input coefficients X_j with `|X_j-x_j|<=eps_j`, the desired length-m positive DFT differs from the exact center transform by at most `sum_j eps_j` in every output. Therefore the complete row radius is

```
sum_j eps_j + E_arith.                                      (4)
```

This source-input term is not multiplied by the internal L^2. The exact complete map is the length-m DFT, and (4) uses a separate triangle inequality against that map. Existing coefficient uncertainty cannot be eliminated merely by increasing FFT precision.

## 5. A terminating dyadic precision rule

For arbitrary finite m,d,B and a requested arithmetic tolerance tau>0, the following explicit rule works. Put

```
a1 = B+1+d*(2*B+3),
b1 = 1+4*d,
p1 = a1+B*b1+a1*b1+1,
w1 = p1+d*(B+p1+2),
K  = 2*L^2*w1+m*B+1.
```

Choose an integer p>=0 such that

```
q=2^(-p) <= min(1/(d+1), tau/(2*K)).                         (5)
```

Doubling the denominator until these rational inequalities hold terminates because the right side is strictly positive. It follows that E_arith<=K*q<=tau/2<tau.

Here is the bound behind that claim. For q<=1/(d+1), q<=1 and

```
(1+q/2)^d <= 1/(1-d*q/2) < 2,
R_d(M,q) <= d*q*(M+2).
```

For d=0 the first inequality is equality at 1 and the displayed strict bound by 2 still holds. The geometric majorant follows by bounding binomial coefficients by d^j. Thus e_a<=q(B+1), B+e_a<=2B+1, and E_alpha<=q*a1. Similarly E_beta<=q*b1. Since A<=B and D<=1, E_p<=q*p1. Then M_p<=B+p1 and E_w<=q*w1. Substitution into (3) gives K*q. This is deliberately conservative and can lose many bits compared with entrywise propagation, but it is finite for every m and B.

To meet a total tolerance tau_total using (4), first require an input certificate with `sum eps_j<tau_total`, then apply (5) with any positive arithmetic allowance below the remaining gap. Termination of this arithmetic precision search does not prove convergence of a separate coefficient engine, nor does it force any output or contour to exclude zero.

## 6. Constructing the required local enclosures

Rule (5) is meaningful only if the root and rounding bounds are constructible. The accepted finite FFT note already proves the necessary elementary arctangent and exponential remainder formulas. Their truncation orders can be increased instead of fixing its numerical example.

Use the rational Machin approximation `pi_hat=16*S_n(1/5)-4*S_n(1/239)`, with S_n the n-term alternating arctangent polynomial. Its rational remainder is

```
e_pi = 16/((2n+1)*5^(2n+1))
       +4/((2n+1)*239^(2n+1)).
```

Increase n until e_pi<=q/8 and `0<pi_hat<22/7`, both rational checks. This terminates. Reduce each root angle to `2*pi*r/M` with integer 0<=r<M, where M is 2m for chirps or a butterfly length for twiddles; the negative kernel uses the corresponding negative residue. Its approximate angle `theta_hat=2*pi_hat*r/M` is in [0,44/7), hence below 7, and its error is <=2e_pi<=q/4.

For N with N+2>7, the complex exponential polynomial through degree N has absolute tail bounded by

```
7^(N+1)/(N+1)! * 1/(1-7/(N+2)).
```

Increase N until this rational bound is <=q/4. The factorial makes this search terminate. The real-axis Lipschitz bound for exp(I*theta) adds at most q/4 for the angle error. Round the polynomial componentwise to dyadic precision p+3; the complex rounding error is less than 2^(-p-2)=q/4. The resulting root error is less than q, as required.

For arithmetic operations, compute the specified expression on rational centers exactly and round each complex output componentwise to p+1 bits after the binary point. The complex norm error is less than 2^(-p)=q. The signed-floor rule applies also to negative components. This is a mathematically terminating reference algorithm, not a speed claim for arbitrary-precision rational intermediates. A faster fixed-precision implementation must prove equivalent residual bounds and avoid overflow.

## 7. Tensor composition and source labels

Apply this axis algorithm to every line of the accepted unit-coordinate tensor, with the same positive root convention, flattening order, and primitive-label extraction. No global cyclic-group assumption is introduced. Each axis of length m has sup-norm operator bound m.

For axis lengths m_1,...,m_r, let tau_i bound the arithmetic error of every line at axis i, relative to that line's exact input centers. Then the final arithmetic error is at most

```
sum_(i=1..r) tau_i * product_(j>i) m_j.                       (6)
```

For example, when r>0 choose `tau_i=tau/(2*r*product_(j>i)m_j)` and apply (5) to each line with a proved bound for its actual input centers. This gives total arithmetic error <tau/2. Source coefficient uncertainty can again be added as its full sum over the tensor, since every exact transform coefficient has modulus one. The empty tensor is the identity, with no arithmetic error; length-one axes can also be skipped.

For the smallest padded length, L<4m for m>1. Thus a butterfly implementation uses O(m log m) arithmetic operations per axis line, with finite precision chosen above. This is an operation-count statement, not a measured runtime bound or a claim about bit complexity. Cached kernels reduce repeated work but preserve the same propagated E_beta. Output multiplication by c^(-s), with its own interval error, is still required by the accepted source-L identity.

## 8. Small exact diagnostic and remaining work

The new script `integration/arbitrary_length_character_dft_20261111.py` uses only integer and Fraction arithmetic in `Q[X]/(X^8-X^4+1)`, with X interpreted as exp(2*pi*I/24). This cyclotomic relation accommodates every chirp and FFT root for the four tested lengths. It runs the normalized positive radix-two butterflies, constructs the signed kernel, checks the L^2 convolution identity against a direct circular convolution, then checks the result against the direct positive DFT.

It passed for `(m,L)=(1,1),(2,4),(3,8),(4,8)`. The odd-length input is `(1+2I,-3+I,2-I)`. It distinguishes the positive and negative transforms and rejects three deliberate changes: reducing the chirp square modulo m, dropping negative kernel differences, and using L instead of L^2. No floating trigonometric functions or L-functions are called.

The same script checks (3) against K*q and tau/2 for 21 exact rational parameter cases. Those finite checks corroborate the general derivation; they do not substitute for it. The run exited zero. Script SHA256 is `74430B4B7CC49586CEF3114C43CCD186F8DF49E7E3AF23EECB8B55256840D727`. Its adjacent JSON records the scope and cases. Reproduction is `python work/qrh-campaign/agents/integration/arbitrary_length_character_dft_20261111.py`; this rewrites only its owned adjacent receipt.

Remaining formal work is the signed embedding lemma, chirp identity, normalized convolution theorem, exact schedule refinement, all error recurrences, dyadic rounding and elementary root enclosures, and the tensor/source adapter. Actual input enclosures, production transform traces, contour proofs, zero counts and saturation remain separate. No claim here closes the finite-family spectral obligation or changes any final theorem's hypotheses.
