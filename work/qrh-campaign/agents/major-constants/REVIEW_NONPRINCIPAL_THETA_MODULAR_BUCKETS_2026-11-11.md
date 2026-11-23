# Independent review of nonprincipal modular theta buckets

2026-11-11. **PASS as a mathematical proof plan and source-level adapter design.** No required correction was found. This review does not certify a numerical theta evaluation, a performance improvement, a spectral rectangle, or a Lean implementation.

## Frozen input and source inspection

Reviewed `integration/NONPRINCIPAL_THETA_MODULAR_BUCKETS_2026-11-11.md`, SHA256 `2EADB0ACEE2B3C8275D9C8CFA815E4E3E7CC39C3CB0EBA0A86763A4877F74F09`. Its entire contents were read. The referenced character-transform plan has SHA256 `DFA02789B3025A997F98E0500B001B3C5A7D983C400EEDC8F7B6DD4ADDAE4866`. The referenced modular reduction plan and its independent review were also hash-checked at `C64EDFEB89B0F15B8B225241248BC7A751C385247843CE3AFEBF8FCF0382E84D` and `9C2C4348EC29A5C3B4ACD6221CFE96F011C191395877E3654FC69DD81C7987ED`.

The pinned Mathlib revision is `56a005855ea17e0b0958f73ec801ae140b0a1679`, read from the existing `2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib` cache. The source file `Mathlib/NumberTheory/ModularForms/JacobiTheta/TwoVariable.lean` has SHA256 `CC4E420DA8441AD20DDBE3709040C4CFBEBB530C6DDD8E101FF2FC1F0B6F8820`.

Directly inspected source interfaces include the summand at line 46, the two-variable sum at 252, its first-variable derivative sum at 260, the positive-imaginary-part summability and derivative results at 262–270 and 293–355, translations and evenness at 377–443, and both functional equations at 466 and 496. The exact derivative identification is `hasDerivAt_jacobiTheta₂_fst` at line 337; the producer's reference to the surrounding line 340 points into that proof and does not change its meaning.

The source subscript 2 means two variables. It does not mean the classical theta2 constant. On the upper half-plane the source functional equation is

`Theta(v,tau)=(-i*tau)^(-1/2)*exp(-pi*i*v^2/tau)*Theta(v/tau,-1/tau)`.

The source first-variable derivative equation contains the extra value term

`Theta_v(v,tau)=(-i*tau)^(-1/2)*exp(-pi*i*v^2/tau)/tau`
` * (Theta_v(v/tau,-1/tau)-2*pi*i*v*Theta(v/tau,-1/tau))`.

The producer does not drop this term. Its characteristic-moment formulation accounts for its cancellation explicitly. Although the source's totalized functional-equation statement is written without a positive-imaginary-part hypothesis, the numerical series and analytic uses in this plan correctly stay in `Im(tau)>0`.

## Signed buckets and characteristic identities

For Re(z)>0, n=r+c*k gives

`sum_{n congruent r mod c} n^a exp(-pi*n^2*z/c)`
`=c^a H_a[r/c,0](i*c*z)`.

The factor is c^a, not c^(a+1), and the characteristic theta parameter is i*c*z. Replacing it by i*z/c after reindexing would be wrong. Expanding `(k+alpha)^2` and the linear beta term gives the two source expressions in producer equation (2). For a=1, the identity uses `alpha*Theta+Theta_v/(2*pi*i)`, so the derivative is with respect to the first argument.

The sums converge normally on compact sets of the upper half-plane and bounded complex characteristic neighborhoods: their absolute values have a strictly negative quadratic term in k and at most linear perturbations. This justifies the local complex characteristic derivatives used in the proof, even though the final characteristic labels are real rational numbers.

For T^n, the difference between the original summand phase and the proposed shifted-characteristic phase, in units of pi*i, is exactly `n*k*(k+1)`. It is an even integer for every integer k and n, including negative n. The proposed phase `exp(-pi*i*n*alpha*(alpha-1))` and shift `beta+n*(alpha-1/2)` therefore have the correct signs.

For the integer characteristic shifts, reindexing k to k+p leaves the moment unchanged. The remaining phase is `exp(2*pi*i*alpha*q)` because the other exponent is an integer. This applies to both a=0 and a=1. Reduction of both characteristics to a centered interval is consequently valid if its phase is recorded.

For S, put v=-1/tau. The a=0 formula follows from the source functional equation and evenness after expanding the characteristic prefactors. Independently differentiating it in beta gives

`(1/(2*pi*i))*partial_alpha H_0[alpha,beta](tau)`
`=tau*H_1[alpha,beta](tau)+beta*H_0[alpha,beta](tau)`.

On the transformed side, differentiating the phase contributes `alpha*H_0`. Differentiating the new first characteristic beta with fixed second characteristic -alpha contributes `v*H_1-alpha*H_0`. Their sum is exactly v*H_1. Thus the odd S multiplier is **-1/tau**, with no surviving H_0 term. This cancellation is a mathematical consequence of the complete characteristic expression, not a reason to omit the inhomogeneous term in the source derivative formula.

All roots use the principal branch at the actual intermediate point. Since Re(-i*tau)=Im(tau)>0, the root and its inverse are nonzero and holomorphic there. Multiplying recorded step factors is valid. Replacing their product by an arbitrary global square root would need an additional phase proof and is not done.

## Common reduction word and tail

The modular word depends only on the common starting tau=i*c*z. Updating rational characteristics does not affect its selection. T, S and integer characteristic reduction preserve denominators dividing 2c, starting from r/c and zero. The modular word and the non-unit scalar S factors are shared for a fixed parity; the characteristic phases and terminal labels still depend on r.

The referenced reduction uses strict overlapping tests, not equality decisions. After translation, `|Re(tau)|<3/5`; inversion is allowed only when `Im(tau)<1/2`, and multiplies the imaginary part by more than 100/61. A stop is allowed when `Im(tau)>2/5`. The overlap permits every exact positive height, including both threshold equalities, to be handled by sufficiently sharp enclosures. Given a positive certified lower bound on the initial height, a finite inversion bound follows. This proves termination of the word search at a fixed computable upper-half-plane input, not a uniform bound on its bit cost.

At the reduced point, `pi*Im(tau)>6/5`. With centered real alpha,beta, the modulus of a summand is precisely `|k+alpha|^a*exp(-pi*Im(tau)*(k+alpha)^2)`. The beta phase has modulus one. For t>=0, the auxiliary bound

`t*exp(-(6/5)*t^2/2)<=1`

is valid. For example `exp(3t^2/5)>=1+3t^2/5>t`, since

`1+3t^2/5-t=(3/5)*(t-5/6)^2+7/12`.

After retaining -N through N, N>=1, either omitted tail has `|k+alpha|>=N+1/2+j`. Write u=N+1/2. Splitting the Gaussian and using `(u+j)^2>=u^2+(2u+1)j` gives exactly producer equation (4). Its denominator is positive, and it tends to zero uniformly in the reduced real characteristics. Both parity channels are covered.

The reconstruction multiplies this error by `c^a*|M_a|`. Each S step contributes modulus `|tau|^(-a-1/2)`; the T and characteristic phases have modulus one. Small intermediate |tau| can amplify errors. The note correctly requires enclosures for the actual transformed points and all multipliers. The original-point error cannot be discarded after choosing the word. A word valid at one point is not automatically valid on a whole input panel.

## Independent check of the finite-vector alternative

The even vector modulus M=2c is sufficient. With `V_a,r(t)=sum_{n congruent r mod M} n^a exp(pi*i*t*n^2/M)`, splitting a residue class modulo c into its two classes modulo 2c gives the stated bucket identity at t=2i*z.

For T, `(r+Mk)^2/M-r^2/M=2rk+Mk^2` is even because M is even. This proves the diagonal multiplier. The same unmodified law fails at an odd M: M=3,r=0,k=1 already produces exponent 3 and factor -1.

For S, use Gaussian Poisson on each progression. The Fourier transform of `exp(-pi*i*x^2/(M*t))` is

`sqrt(-i*M*t)*exp(pi*i*M*t*xi^2)`.

Differentiation in additive frequency shows that the transform of x times this Gaussian is **-M*t*xi** times this expression. Substituting xi=m/M and the progression factor 1/M gives the two claimed positive-DFT laws, including the odd factor -t. The principal-root extraction of positive real M is consistent on the upper half-plane.

S mixes every residue class, including nonunits. Deleting those entries before this vector DFT invalidates its identity. This alternative is therefore different from independently following characteristics for just the unit residues. Its displayed mathematical laws are valid, but their packaged Poisson/source proof and arithmetic implementation remain obligations if selected.

## Character reconstruction and scope of the work claim

Splitting the signed sum into positive n, negative n and zero yields producer equation (6). In that formula `r=0` is equality of residue classes modulo c, consistent with the surrounding notation. An arbitrary integer representative divisible by c also has the zero term. Multiplying by chi and replacing r by -r in the negative part gives factor `(-1)^a*chi(-1)=1` for matching parity. Thus the signed contraction is twice the desired positive theta sum plus its explicit zero contribution. At c>1, chi(0)=0; at conductor one the zero term must remain. Opposite parity gives a zero signed contraction and does not recover the positive sum.

An individual positive residue bucket is not generally half the signed bucket. The final factor 1/2 applies only after matching-parity character contraction, and remains separate from any DFT normalization. The producer keeps these distinctions and preserves the source character labels.

The work comparison is appropriately conditional. A direct evaluator can accumulate all residue buckets in one pass over n; it does not repeat the whole cutoff for every residue. The modular route needs a short series, phase updates and reconstruction for each requested residue, although the word and Gaussian factors can be shared. For large conductors, phi(c) short evaluations may cost more than the original common accumulation. The quoted square-root cutoff dependence is qualitative, with precision and tail factors unspecified; it is not a certified runtime or fixed finite cutoff. The proposed Laurent-polynomial/multipoint view follows from the finite source expression but is explicitly not implemented or assigned a speedup.

This plan does not treat an individual residue or character theta as an unchanged scalar modular form under arbitrary S/T. It tracks the new characteristics, or alternatively the full mixed residue vector. That is the necessary restriction. Character-level primitive S reciprocity alone would not justify the general T operations used by modular reduction.

## Exact diagnostics and unresolved implementation

The independent script `review_nonprincipal_theta_modular_20261111.py` passed 2,266 exact rational phase, reindexing and scalar checks. They cover negative and positive integer translations, nontrivial rational characteristics, characteristic shifts, the signed parity identity, the even-lattice T condition and an odd-lattice counterexample, and the S moment cancellation algebra. No theta series or modular numerical values were evaluated. The analytic S proof and branch analysis above are independent of these finite checks.

- Script SHA256: `E04483589A3B9F8F76AEA1405F8B9D4831D2E996E0E4EB83FDB202775646584F`.
- Receipt `review_nonprincipal_theta_modular_20261111.json` SHA256: `2868951AB932B3FD9FEFA43CB5E34A2FF5D4E32F0C7C643710DCA234EFC05897`.

Remaining formal work includes the characteristic/source wrappers, moment derivatives, modular word and phase replay, interval propagation, reduced-series bounds, and parity-to-character contraction. Actual coefficient intervals, full contour coverage, and spectral truth remain absent. The note supplies no new permitted hypothesis at either Goldbach root and makes no end-to-end throughput claim.
