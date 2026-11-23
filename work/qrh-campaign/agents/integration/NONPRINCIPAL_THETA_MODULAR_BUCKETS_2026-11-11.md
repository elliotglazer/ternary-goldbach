# Modular evaluation of signed nonprincipal theta buckets

2026-11-11. Source-based paper blueprint, submitted for independent review. Generalized theta characteristics give a modular route to signed residue buckets for both parities. All buckets at one sample share the modular reduction word, but acquire different characteristics and phases. An individual residue bucket is not a scalar Dirichlet theta function under arbitrary modular matrices.

No high-height values, full family scan, implementation, Lean build, dependency change, or canonical edit is supplied. The work comparison below is qualitative and preserves the possibility that direct summation is cheaper for large conductors.

## 1. Existing inputs and source conventions

The source and primitive-character conventions are those of `integration/UNIT_GROUP_CHARACTER_TRANSFORM_PLAN_2026-11-11.md`, SHA256 `DFA02789B3025A997F98E0500B001B3C5A7D983C400EEDC8F7B6DD4ADDAE4866`, independently reviewed at `222346A598FB72100005E065A6BFA77DCDE91B8B8F9F068847BE9DCBA0FB558D`.

The modular reduction input is `integration/PRINCIPAL_THETA_MODULAR_ACCELERATION_2026-11-11.md`, SHA256 `C64EDFEB89B0F15B8B225241248BC7A751C385247843CE3AFEBF8FCF0382E84D`, reviewed in `audit/REVIEW_PRINCIPAL_THETA_MODULAR_ACCELERATION_2026-11-11.md`, SHA256 `9C2C4348EC29A5C3B4ACD6221CFE96F011C191395877E3654FC69DD81C7987ED`. These paths are relative to `work/qrh-campaign/agents/`.

Mathlib pin remains `56a005855ea17e0b0958f73ec801ae140b0a1679`. Write

```
Theta(v,tau)=sum_(k in Z) exp(pi*I*k^2*tau+2*pi*I*k*v).
```

This is source `jacobiTheta₂ v tau`, not the classical one-variable theta2. In `NumberTheory/ModularForms/JacobiTheta/TwoVariable.lean`, the defining term is at line 46; the sum at 252; joint differentiability at 294; the first-variable derivative at 340; integer and lattice translations and evenness around 380–410; and the functional equation at 466. The file SHA256 is `CC4E420DA8441AD20DDBE3709040C4CFBEBB530C6DDD8E101FF2FC1F0B6F8820`.

For Im(tau)>0 the source identity is

```
Theta(v,tau)=A(tau)*exp(-pi*I*v^2/tau)*Theta(v/tau,-1/tau),
A(tau)=1/(-I*tau)^(1/2).                                   (S0)
```

The root is principal. Its argument -I*tau has positive real part, so the multiplier is holomorphic and nonzero on the upper half-plane. The source also gives `Theta(v+1,tau)=Theta(v,tau)`, `Theta(v+tau,tau)=exp(-pi*I*(tau+2v))*Theta(v,tau)`, and evenness in v. The generalized-characteristic and moment identities below are new adapters derived from these source objects.

## 2. Exact buckets and characteristics

Let c>=1 be an integer, Re(z)>0, r an integer residue representative, and a in {0,1}. Define the signed bucket

```
B_(r,a)(z)=sum_(n in Z, n congruent r mod c)
                 n^a*exp(-pi*n^2*z/c).
```

The zero term has weight one when a=0 and zero when a=1. All sums and their required derivatives converge absolutely and locally uniformly in Re(z)>0.

Put tau=I*c*z and alpha=r/c. For real characteristics alpha,beta define

```
H_a[alpha,beta](tau)
 = sum_(k in Z) (k+alpha)^a
     *exp(pi*I*(k+alpha)^2*tau+2*pi*I*(k+alpha)*beta).
```

Then the exact source-compatible bucket identity is

```
B_(r,a)(z)=c^a*H_a[r/c,0](I*c*z).                           (1)
```

It follows by n=r+c*k. There is no extra factor c in the a=0 case. In terms of the existing two-variable source,

```
H_0[alpha,beta](tau)
 = exp(pi*I*alpha^2*tau+2*pi*I*alpha*beta)
     *Theta(alpha*tau+beta,tau),
H_1[alpha,beta](tau)
 = exp(pi*I*alpha^2*tau+2*pi*I*alpha*beta)
     *(alpha*Theta(alpha*tau+beta,tau)
        +Theta_v(alpha*tau+beta,tau)/(2*pi*I)).              (2)
```

The source first-variable derivative, not its tau derivative, occurs here. Formula (2) also gives the direct residue-bucket version using v=r*tau/c.

## 3. Modular and elliptic transformations with phases

The following formulas hold for both a=0 and a=1. They use real characteristics for evaluation; local complex extensions justify the differentiations used in their proof.

For an integer translation n,

```
H_a[alpha,beta](tau+n)
 = exp(-pi*I*n*alpha*(alpha-1))
     *H_a[alpha,beta+n*(alpha-1/2)](tau).                    (T)
```

Indeed k^2 and k have the same parity, so expanding `(k+alpha)^2` gives the phase and characteristic shift shown. The factor (k+alpha)^a is unchanged.

For integer p,q, shifting characteristics gives

```
H_a[alpha+p,beta+q](tau)
 = exp(2*pi*I*alpha*q)*H_a[alpha,beta](tau).                 (E)
```

Reindex k by k+p. The remaining beta shift contributes the displayed phase; the integer product p*q creates no additional factor. Thus alpha and beta can always be reduced to [-1/2,1/2] with an exact phase. Their rational endpoints may use either tie convention, provided (E) is applied consistently.

For inversion, write v=-1/tau. The exact formula is

```
H_a[alpha,beta](tau)
 = A(tau)*exp(2*pi*I*alpha*beta)*v^a
     *H_a[beta,-alpha](v).                                 (S)
```

For a=0, insert (2) into (S0) and use evenness of Theta. For a=1, differentiate the a=0 formula with respect to beta and divide by 2*pi*I. The characteristic derivative identity is

```
(1/(2*pi*I))*partial_alpha H_0[alpha,beta](tau)
 = tau*H_1[alpha,beta](tau)+beta*H_0[alpha,beta](tau).
```

On the right of (S), the derivative of the phase contributes alpha*H_0, while the new second characteristic is -alpha and contributes -alpha*H_0. These cancel, leaving exactly v*H_1. Thus the odd-moment multiplier is -1/tau, not 1/tau, and there is no surviving value term.

Equivalently, the source elliptic formulas can be used directly. For integers l,k,

```
Theta(v+l+k*tau,tau)
 = exp(-pi*I*k^2*tau-2*pi*I*k*v)*Theta(v,tau),
Theta_v(v+l+k*tau,tau)
 = exp(-pi*I*k^2*tau-2*pi*I*k*v)
     *(Theta_v(v,tau)-2*pi*I*k*Theta(v,tau)).                (E0)
```

Formula (E) is usually preferable for evaluation: the reduced characteristics stay real rational, so their phases have modulus one and their series have a direct uniform Gaussian bound. Direct elliptic reduction of v is an alternative, but must retain the value term in (E0).

Every S multiplier uses the principal root at that actual intermediate tau. The algorithm stores the word and these factors, rather than replacing their product with an unproved square root of a global denominator. Translation and characteristic phases are exact rational multiples of pi and can be stored modulo 2*pi.

## 4. One shared reduction word, different bucket labels

For fixed c,z all buckets in (1) start at the same tau=I*c*z. Apply the accepted overlapping reduction:

* Translate to certify |Re(tau)|<3/5.
* Stop if Im(tau)>2/5, or invert if Im(tau)<1/2.

The overlap avoids equality tests. Every inversion raises the imaginary part by more than 100/61, so a positive certified lower bound on the initial imaginary part gives a finite bound on the number of inversions. The terminal tau_red has Im(tau_red)>2/5. No assumption about the residue r is used in this word selection.

For each initial `(alpha,beta)=(r/c,0)`, update its pair and phase through (T), (S), and (E). The pairs remain rational; denominators divide 2c after reduction. Distinct initial pairs may acquire nonzero beta. Such a beta is an additive twist, not an error and not a return to the original untwisted residue bucket. The common S product depends only on tau and a; the unit phases and final characteristic pair depend on r. For both parity channels one can share the reduction, but the products differ by the v factors in (S).

This gives a pointwise reconstruction

```
B_(r,a)(z)=c^a*M_a(tau,word)*phase_r
                       *H_a[alpha_r,beta_r](tau_red),      (3)
```

where phase_r has modulus one and all transformations are bound to the stored word. It is not the assertion that B_(r,a) itself has a scalar modular law within the original c untwisted buckets.

For interval inputs, certify the word's strict tests on the actual point enclosure and refine as needed. For a whole panel, a word is valid only where those tests hold uniformly; otherwise subdivide or use separate local words. The same compactness and effective-variation obligations as in the principal plan apply. No separation from a modular reduction boundary is assumed.

## 5. Uniform reduced series and error propagation

After applying (E), assume alpha,beta in [-1/2,1/2] and Im(tau_red)>2/5. Each exponential term has modulus `exp(-pi*Im(tau_red)*(k+alpha)^2)`, because the second characteristic is real. Set gamma=6/5, a strict lower Gaussian exponent using pi>3.

Retain -N<=k<=N with N>=1. Both omitted tails have absolute shifted coordinate at least u=N+1/2. For a=0,1, a common bound is

```
E_N <= 2*exp(-gamma*u^2/2)
          /(1-exp(-gamma*(2u+1)/2)).                       (4)
```

For a=0 this follows directly by splitting the exponential. For a=1 use `t*exp(-gamma*t^2/2)<=1` for t>=0. The remaining geometric bound uses `(u+j)^2>=u^2+(2u+1)*j`. The estimate is uniform in both reduced characteristics and the original height.

The finite terms need certified complex exponentials and arithmetic. The reconstruction (3) must include errors in tau_red, the characteristic phases, all principal roots, all reciprocal v factors, and the initial z. Characteristic labels can remain exact rationals; they need not be rounded. Compute a certified bound on `c^a*|M_a|` before allocating a reduced-series error budget.

For any fixed actual sample, the word is finite and every denominator and root input is nonzero. Refining convergent elementary enclosures and increasing N makes the final absolute bucket radius arbitrarily small. This is a convergence argument, not a uniform bound on the number of precision bits or a guarantee that a later nonvanishing test succeeds. Errors shared among residues are deterministic; no statistical cancellation is allowed when their character sums are formed.

## 6. A finite-vector alternative and its limitation

A fully closed vector can instead use the even modulus M=2c. Define

```
V_(r,a)(t)=sum_(n congruent r mod M) n^a*exp(pi*I*t*n^2/M),
Im(t)>0,
(Dplus V)_r=sum_(u mod M) exp(2*pi*I*r*u/M)*V_u.
```

Then B_(r,a)(z)=V_(r,a)(2*I*z)+V_(r+c,a)(2*I*z), and

```
V_(r,a)(t+1)=exp(pi*I*r^2/M)*V_(r,a)(t),
V_0(-1/t)=sqrt(-I*t/M)*Dplus V_0(t),
V_1(-1/t)=-t*sqrt(-I*t/M)*Dplus V_1(t).                    (5)
```

These follow from Gaussian Poisson summation, differentiating the additive frequency for a=1. The positive DFT is unnormalized. The principal root is consistent because -I*t/M has positive real part. The factor -t in the odd channel is essential. Equation (5) was also derived independently by the assigned reviewer during coordination; it still needs its own packaged source proof if used in implementation.

The even modulus makes the T law diagonal: for n=r+M*k the extra factor exp(pi*I*M*k^2) is one. At odd modulus c the analogous untwisted c-bucket vector is not closed under T without an additional twist or refinement. Even in the closed M-vector, S mixes all residues, including nonunits. Deleting nonunit entries before transforming is invalid. The scalar-characteristic route (3) avoids computing this entire vector for each S step but must keep the transformed twists.

## 7. Parity, positive sums, and character reconstruction

Let P_(r,a) denote the original sum over n>=1 in residue r. Exact reindexing gives

```
B_(r,a)=P_(r,a)+(-1)^a*P_(-r,a)+[a=0 and r=0].             (6)
```

In particular B_(-r,a)=(-1)^a*B_(r,a), and self-negative residues have zero odd signed bucket. An individual positive bucket is generally not B/2 and cannot be recovered from the signed data alone.

For an actual character chi with matching parity chi(-1)=(-1)^a,

```
sum_(r mod c) chi(r)*B_(r,a)
 = 2*sum_(n>=1) chi(n)*n^a*exp(-pi*n^2*z/c)
     +[a=0]*chi(0).                                       (7)
```

For c>1, zero is a nonunit and every source Dirichlet character has chi(0)=0. Thus the desired positive theta sum is exactly one half of the character-weighted signed buckets. With the opposite parity the full signed contraction is zero; it is not a way to evaluate that positive sum. The conductor-one constant term remains separate.

Use the accepted positive-exponent unit-group transform on the unit entries B_(r,a), then take one half and extract only the matching-parity primitive labels. Its CRT indexing, character identification, and nonreal inverse-label conventions are unchanged. Keep both a channels if both parities are needed. The signed-to-positive factor 1/2 is separate from any DFT normalization or later Fourier/Mellin factor.

## 8. Work comparison and remaining obligations

Direct summation can accumulate all buckets in one pass over n up to a Gaussian cutoff roughly proportional to `sqrt(c/Re(z))` times a precision factor. In the near-boundary setting Re(z) is of order 1/H, producing the familiar sqrt(cH) scale. It does not pay that entire cost separately for every residue.

The characteristic route uses one modular word, then roughly one short reduced series for each requested residue, plus characteristic phase updates and reconstruction. It removes the small-Im(tau) dependence from each reduced series. But doing c such series can cost more than one direct pass up to sqrt(cH), especially when c is large and H is small. The unit-only route still has phi(c) outputs before the character transform. No blanket speedup follows from modularity.

The reduced series can share their base Gaussian terms and common modular factors. Viewed through (2), they are evaluations of a common finite Laurent polynomial and its weighted version at residue-dependent points, so certified multipoint evaluation is a possible additional optimization. This note does not prove or implement that optimization. A hybrid producer can choose direct accumulation or modular bucket evaluation after comparing certified work estimates; either branch must return enclosures for the same actual B values.

The new formal obligations are characteristic/source identities, the moment S cancellation, exact word/phase replay, reduced-series tails and interval reconstruction, the parity adapter (7), and its interface to the existing character transform. If the finite-vector alternative is selected, its Gaussian Poisson and odd-channel normalization require proof as well. These are mathematical and implementation tasks within the intended theorem, not new allowed root assumptions. No actual character value, contour, zero count, or family completion is established by this note.
