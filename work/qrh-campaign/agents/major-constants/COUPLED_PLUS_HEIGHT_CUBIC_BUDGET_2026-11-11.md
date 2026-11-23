# A shorter plus-height profile paid from the cubic budget

2026-11-11. Conditional source/paper theorem with exact scalar witnesses. No finite-RH certificate, prime, zero, L-function, Mellin or transform value was evaluated. No Lean source, declaration or build was changed. The previously reviewed plus-height profile remains the fallback.

One four-band profile is sufficient. It lowers the plus height, permits the Gauss-weighted coprime coefficient to increase from 4.25e-7 to 5e-7, and gives a full plus residual radius **rho=5.75e-7**. Together with the actual star targets **A<=9e-12 and B<1915**, it preserves the original exact cubic-error allowance and unchanged Fourier tail. The profile dominates the separately proved reduced base-gap height and the star-tail cutoff. This is a candidate theorem, not a claim that its finite-RH premises or actual A target have been certified.

## 1. Candidate, domain and a useful general inequality

Fix R=132900, x=49y>=4.9e26 and the actual etaPlus/etaU smoothings. For each primitive nonprincipal conductor c in the current supported family (odd c<=132900 or even c<=265800), put

    d_c=1063200/qt(c),  qt(c)=c if c even and 2c if c odd,
    u(c)=23       if c<100,
         21.5     if 100<=c<1000,
         20.5     if 1000<=c<10000,
         19.5     if c>=10000,
    Tnew(c)=ceil(200+max(255,3.1416*u(c)*d_c)).             (1)

Require actual GRHUpTo(chi,Tnew(c)) for all primitive nonprincipal chi in that range, with the closed |Im rho|<=Tnew convention, including central and boundary zeros. Assigning (1) also to empty primitive families causes no difficulty. Retain the principal certificate through 1e8, principal count inputs and their localization separately. There is no global QRH or weakened beta strip in this implication.

The analytic/cubic tradeoff used below can be stated independently of this choice. If a profile gives

    sqrt(c)*|Schar(chi,Lambda*etaPlus_x,delta/x)|/x
        <=k(x)+e2(c)+2e-17,

then its coprime Gauss-weighted coefficient is at most

    b=k(x)+sup_c e2(c)+516e-15+2e-17.

Character Parseval gives Eplus<=b^2. With p0=2.83e-7 the full plus radius is any rho satisfying

    rho>516e-15,  b^2+p0^2<=(rho-516e-15)^2.             (2)

The inner coprime removal in b and the outer additive removal in (2) are distinct. For nonprincipal star energies A,B, the sufficient joint cubic inequality is

    sqrt(j)*(pbar+sqrt(A)+rho*sqrt(B))+rho*C <= Eold,       (3)
    j=8.79, pbar=1.902e-6,
    C=914205504131/4687500000,
    Eold=64019155993729/312500000000000000.

Equation (3) follows from the reviewed integrated cubic and weighted-principal arguments, retaining every mixed term. It removes an unnecessary intermediate rounding to a star parameter u. Section 4 checks (2)-(3) for (1).

## 2. Source errors that do not need new estimates

The exact Prop942 error is E0/x+E1(c,T)/sqrt(x)+E2(c,T,delta)+V/(2*pi*x*sqrt(x)). Prop942.prop_9_4_2 requires T>=200+max(10*pi*|delta|,50). Formula (1) satisfies this, since u>=19.5, T-200>=255 and pi<3.1416. For delta=0 the EA branch is zero, not a division by zero.

Pointwise, Tnew is no larger than the fallback Tplus: its floor parameter is 255 instead of 260, its first three u values are <=23.3, and its last is <=19.89. The fallback's ceiling-safe comparison with the original source endpoint therefore applies unchanged. The entire count and low-zero estimates are unconditional functions of that endpoint; they do not invoke RH at the larger height.

E1g is nondecreasing in T, so the old bound gives E1(c,Tnew)<=7.66e6/sqrt(c). Since (2.21e13)^2<4.9e26,

    sqrt(c)*E1(c,Tnew)/sqrt(x)<3.47e-7.                 (4)

The same comparison yields Z3g(BP c,Tnew)<=177.26. E0 and the vertical term do not depend on T and remain at most 1e-17/sqrt(c) each. Their c<=300000, |delta|<=600000 and x>=4.9e26 domains hold. This accounts for all four source errors; no shortened zero sum is assumed to cancel.

## 3. The improved high-zero estimate

Use Thm714.E2_gen_le:101 with T1=255, Z=177.26, C0=.09 and IB=2.1768. Because Tnew>=455,

    11*4.4 <= .09*455*1.2039,

which supplies its growth constant via c3g_le. The source IB and prefactor129.24 are unchanged. Its IA_le:208 implies the useful conductor-dependent bound

    IA<=1+3.1416*(|delta|+1)/8.492
       <=a+K/c,  a=1.371, K=393400.                   (5)

Here d_c<=1063200/c, so this deliberately treats odd and even conductors by the same safe expression. Both rational comparisons defining a,K are strict. Unlike the fallback's global IA<=222000, (5) preserves the decay with c before multiplying the high-zero error by sqrt(c).

The following finite positive-polynomial witnesses suffice for the source exponential bounds:

    EB(255)<=4.6e-16,
    .588*u^2*exp(-.1065*u^2) <= EA_cap(u),

| u | EA_cap |
|---:|---:|
|23|1.061e-22|
|21.5|1.133e-19|
|20.5|9.023e-18|
|19.5|5.781e-16|

These are proved without an exponential evaluator. For each nonnegative rational z, set P(z)=sum_(k=0)^16 (z/64)^k/k!. Positivity of the exponential series and exp(z)=exp(z/64)^64 give exp(z)>=P(z)^64. The script checks .892*255<4.6e-16*P(.1598*255)^64 and .588*u^2<EA_cap(u)*P(.1065*u^2)^64 as exact rational inequalities. Source monotonicity of t*exp(-.1598t) for t>=255 and of u^2*exp(-.1065u^2) for u>=10 extends these endpoint witnesses to the entire required ranges.

To bound the scaled EA bracket on a band L<=c<=U, choose positive sl,su with sl^2<=L and U<=su^2. Expanding (5) gives

    sqrt(c)*[2Z*IA+2C0*IA^2]
      <= (2Za+2C0*a^2)*su
         +(2ZK+4C0*aK)/sl +2C0*K^2/(L*sl) = G(L,U).   (6)

Every coefficient is nonnegative. The first term uses sqrt(c)<=su, and the other two use sqrt(c)>=sl and c>=L. This covers the continuum of conductors, not a sampled endpoint assertion about the unsplit expression.

| Band for bounding | sl | su |
|---|---:|---:|
|2<=c<=100|1.414|10|
|100<=c<=1000|10|32|
|1000<=c<=10000|31.62|100|
|10000<=c<=265800|100|516|

The overlaps only enlarge the actual half-open bands in (1). For every row, exact substitution proves

    129.24*[516*(4.6e-16)*(2Z*IB+2C0*IB^2)
               +EA_cap(u)*G(L,U)] <1.49e-7.           (7)

Consequently sqrt(c)*E2(c,Tnew,delta)<1.49e-7 for every required delta, throughout every conductor class. The 516 factor in the EB term is a safe bound on sqrt(c), not an extra number of characters. All EA, EB, geometric-denominator and count terms are retained.

## 4. Coprime transfer, joint budget and unchanged consumers

From (4), (7), E0 and the vertical term, the unrestricted primitive estimate has scaled error less than 3.47e-7+1.49e-7+2e-17. The same inverse-character, induction and Gauss transfer as ArcChars:378-440 applies: c divides q, its required twist is within d_c, and |tau_q(psi)|<=sqrt(c). The inner coprime removal costs at most516e-15. Thus

    |tau_q(psi)|*|Schar(psi^-1,coprimePart(q,cP(x)),delta/x)|/x
       <3.47e-7+1.49e-7+2e-17+516e-15 <5e-7.

There are at most phi(q) nonprincipal labels, so Eplus_q<2.5e-13. The exact orthogonal principal split (2) gives rho=5.75e-7. This is a weaker plus energy than the old 1.80625e-13, and the old upper-J lemma with that smaller coefficient must not be reused. Instead the already reviewed direct residual integration gives Z<.006^2 and X<=8.79x: 16*150000*19*rho^2<.006^2. Its proof contains no extra phi(q) factor. The principal lower-J proof and all original domain guards remain unchanged.

Retain the actual A,B definitions from the weighted-statistic and reallocation reports: A=sum a_q^2 integral|P|^2 E_q and B=sum integral E_q, with E_q the unaveraged nonprincipal coprime etaU numerator energy. They retain the Gauss weights and inverse labels. Given A<=9e-12 and B<1915, use sqrt(j)<2.965 and sqrt(1915)<43.762 to check

    2.965*(1.902e-6+3e-6+(5.75e-7)*43.762)
        +(5.75e-7)*C < Eold.                         (8)

The exact positive reserve is in the receipt. This proves (3), including principal/removal terms and both cubic cross terms. The Fourier tail, singular/main terms, minor estimates, nonprime subtraction, N0 and finite-range coverage can retain their previously reviewed bounds. No precision is borrowed from any of them.

B<1915 is the separately reviewed conditional source-sieve/etaU coefficient result, not a consequence of finite RH at (1). A<=9e-12 is still an actual-function requirement. In particular the newer A<=1e-10 sufficient spectral profile cannot be imported unchanged here: (8) spends some of its slack on the larger plus radius. A stronger finite-star statistic or the earlier A9e-12 route must be supplied. The common RH certificates would imply any weaker beta cap on covered heights, but the full statistic/count/remainder implication remains a separate proof.

## 5. Heights and the certification union

Selected exact integer examples compare (1) with the frozen fallback:

| c | Tnew | Fallback Tplus |
|---:|---:|---:|
|100|718333|778455|
|1000|68674|78026|
|10001|3457|4091|
|60000|1286|1498|
|100000|852|865|
|125000|722|732|
|132899|455|493|
|265800|455|460|

No output-count or runtime estimate is inferred from these examples. All values are rational ceiling calculations, not spectral evaluations.

The reduced base-gap height is ceil(27e6/c) for odd c and ceil(54e6/c) for even supported c. It is below Tnew because 19.5*3*531600>27e6 and 19.5*3*1063200>54e6. The separate star-tail cutoff ceil(max(300,704*d_c/343)) is also below Tnew, since 455>=300 and 19.5*3>704/343. These comparisons concern the exact respective twist domains; the star cutoff is not used as a base-gap proof. Both separate consumer implications still need their premises and source localization; their acceptance status is not established by this scalar comparison.

Thus those cutoffs add no height to this candidate common RH profile. Principal RH through1e8, exact principal counts/reciprocal data and Turing auxiliary work are unchanged. Calling the old blanket PlattGRH plus/star wrappers would reinstate the old requirements and defeat this reduction. This note does not certify the new spectrum or claim the smaller profile is preferred after total production/checking costs.

## Evidence

The exact script coupled_plus_height_budget_20261111.py and its JSON verify 48 rational/integer assertions and 11 height examples. No floating-point or analytic evaluator is used. The receipt binds nine source/predecessor files by SHA256, including the reviewed fallback, cubic reallocation and the base-gap/star-cutoff reports.

The source baseline remains work/ternary-goldbach commit23b2d68ca344203d4384e0aff7affa4ec034bef9. Substantive source entry points are Prop942.lean:50-82 (all four errors and explicit finite-RH input), Thm714.lean:101 (full E2 inequality), :208 (IA), :221 (growth), :247/:315-337 (old unconditional E1/count constants), and :430-482 (T-independent errors), with ArcChars.lean:314-440 for coprime/Gauss transfer. Their exact hashes are recorded in the receipt. Frozen predecessors are unchanged. Independent review is required before treating (1) as an accepted replacement.
