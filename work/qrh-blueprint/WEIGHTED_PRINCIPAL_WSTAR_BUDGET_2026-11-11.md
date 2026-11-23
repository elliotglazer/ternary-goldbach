# Retaining the principal modulus weight in Wstar

2026-11-11. New conditional paper argument with exact rational checks. It improves the sufficient aggregate budget without assuming a new estimate on actual primes or zeros. It does not prove the remaining nonprincipal energy targets or certify a spectrum. No Lean source, build or numerical evaluator was used.

Use the exact dimensionless variables of audit/WSTAR_WEIGHTED_SPECTRAL_STATISTIC_2026-11-11.md. Fix R132900, x>=4.9e26, y=x/49, delta=x*beta, Dq=8R/qt(q), and a_q=mu(q)/phi(q). The finite tagged measure sums q in Qset R and unit numerators b, then integrates delta in [-Dq,Dq]. Write s=Sp/x=a_q*P+r, where P(delta)=Fourier(etaPC)(-delta). Write the full normalized star residual as u+v, where u is the actual nonprincipal coprime character contribution.

Retain the proposed plus target and its reviewed consequences

    sum_b |r_q,b(delta)|^2 <= rho^2, rho=8.85e-7,
    Z=sum_q integral sum_b |r|^2 < .006^2,
    X=sum_q integral sum_b |s|^2 <= j=8.79.

The last two quantities are dimensionless. The physical Z and X of the root upper-L2 note are divided by x after beta=delta/x. The actual plus target remains unproved; this argument changes only its downstream use.

## 1. A weighted principal remainder

The prior reviewed argument uses |v|<=1.504e-6 uniformly. Its source decomposition supplies the sharper modulus-dependent estimate

    |v_q,b| <= p1*|a_q|+d0,
    p1=1.502e-6, d0=2e-9.                         (1)

The principal unrestricted star error is less than1.5e-6 on this domain. Its inner coprime removal costs at most2e-9, and both are multiplied by a_q. The outer additive removal costs at most2e-9 and is not multiplied by a_q. These are the same source estimates and signs used in the reviewed Wstar reduction. The principal RH-through1e8 localization is retained. In particular mu(q)=0 deletes the principal projection, not the outer removal.

Weighted L2 triangle inequality gives

    ||s*v||_2 <= p1*||a*s||_2+d0*sqrt(j).           (2)

Since |a_q|<=1, the plus residual term satisfies ||a*r||_2<=sqrt(Z)<.006. The main term gives

    ||a^2*P||_2^2
      = sum_q mu(q)^4/phi(q)^3 * integral_[-Dq,Dq] |P|^2
      <= .640208*M3,
    M3=sum_q mu(q)^2/phi(q)^3.                    (3)

There are phi(q) unit numerators, and mu^4=mu^2. These identities explain the exponent3; an extra average over numerators would be incorrect. The full Fourier energy bound is the actual source EtaPlusL2.integral_norm_sq_fourier_etaPC with integral_sq_etaPlus_bounds at lines115-150. Restricting its nonnegative integral to the finite interval can only decrease it.

## 2. An elementary uniform bound on M3

Only squarefree q contribute. Enlarge the finite set of their prime divisors to all primes up to2R and expand a finite Euler product. Multiplicativity of phi for squarefree integers gives

    M3 <= 2 * product_(3<=p<=2R, p prime) [1+1/(p-1)^3].

The factor at p=2 is exactly2. Each odd prime has p-1=2k for a distinct positive integer k. Hence, with u_p=1/(p-1)^3,

    sum_p u_p <= (1/8) sum_(k>=1) k^-3 <=3/16.

The last inequality uses the k=1 term and the decreasing-function comparison sum_(k>=2) k^-3<=integral_1^infinity t^-3 dt=1/2. No prime list or zeta value is needed.

For finitely many nonnegative u_i of sum S<1,

    product_i(1+u_i) <=1/(1-S).

For example, induct on the factors: if the previous sum is S and the next term u has S+u<1, then (1+u)/(1-S)<=1/(1-S-u), because (1+u)(1-S-u)=1-S-uS-u^2<=1-S. Thus

    M3 <= 2/(1-3/16)=32/13.                       (4)

This finite-product proof avoids infinite Euler-product convergence and transcendental numerical leaves. It applies to the actual finite Qset regardless of omissions from that set.

The exact scalar comparisons are

    .640208*(32/13)<1.256^2,
    ||a*s||_2 <=||a^2*P||_2+||a*r||_2 <1.262,
    sqrt(j)<3.

Equations(2)-(4) imply

    ||s*v||_2 <1.502e-6*1.262+2e-9*3
                =1.901524e-6 < pbar=1.902e-6.     (5)

This pbar is the entire integrated principal/removal norm. It is not a pointwise residual constant and must not be multiplied by sqrt(j) again.

## 3. Relaxed nonprincipal sufficient targets

Keep exactly the prior definitions

    E_q(delta)=sum_b|u_q,b(delta)|^2,
    A=sum_q a_q^2 integral |P(delta)|^2 E_q(delta),
    B=sum_q integral E_q(delta).

The already reviewed main/residual split of s gives ||s*u||_2<=sqrt(A)+rho*sqrt(B). Combining this with(5), including all cross terms through Minkowski, yields

    sqrt(49^2 Wstar/x^3) <pbar+sqrt(A)+rho*sqrt(B). (6)

The target remains 49^2 Wstar/x^3<=j*(3.67e-6)^2. Since2.964^2<j, the following are independently sufficient pairs, all checked by exact rational comparisons:

| Bound on A | Bound on B |
|---:|---:|
|9e-12|45|
|4e-12|62|
|1e-12|81|
|0|102|

These rows are alternatives, not simultaneous requirements or proved estimates. The last row assumes A=0 and is only an allocation endpoint. The A9e-12 row increases the former sufficient B9 budget fivefold while keeping the same plus/principal/source inputs. These integer rows are sufficient, not claimed optimal.

The new bound does not eliminate the direct-sieve obstruction reported in audit/DIRECT_STAR_B_SOURCE_OBSTRUCTION_2026-11-11.md. Even with A=0, this particular scalar allocation requires

    B < [(3*3.67e-6-pbar)/rho]^2
       =9217296/87025 <117.6,

where sqrt(j)<3 deliberately weakens the ceiling. Thus a comparison tending above117.6 cannot close this updated sufficient inequality either. This is a limitation of the two stated upper-bound arguments, not a lower bound on actual B or a claim that all Wstar approaches fail. A further refinement of the principal bound or a different treatment of mixed terms can change the allocation.

## 4. Scope and evidence

Actual plus energy, A, B and the independent base-gap target remain unproved. Principal RH and its head data remain separate certificate obligations. All integrals use the finite tagged arc space; physical-arc identification and the final reduced-cutoff assembly are unchanged. No aggregate saving is entered as a demonstrated computational result.

The new script check_weighted_principal_wstar_20261111.py uses fractions only and writes a fresh receipt weighted_principal_wstar_20261111.json. It checks the scalar mass conversion, norm bounds, four sufficient pairs and the conservative comparison ceiling. The finite Euler-product and functional L2 arguments are paper proofs above, not consequences of those scalar tests.

Input pins read by the coordinator:

| Artifact | SHA256 |
|---|---|
|agents/audit/WSTAR_WEIGHTED_SPECTRAL_STATISTIC_2026-11-11.md|AFDBBF90157F5170666C481D512D475A1F719366C8FB785D312A213864C38D0B|
|agents/independent-feasibility/REVIEW_WSTAR_WEIGHTED_SPECTRAL_STATISTIC_2026-11-11.md|85849ED642AEED600A71F41E56D4C7DC86ACAB23F338E19979CD15B58B8D60DE|
|qrh-blueprint/PLUS_RESIDUAL_TO_MAJOR_L2_UPPER_2026-11-11.md|F3EBC1B68CC57B607496D9E6445137A08A0F17C3202D986301F8EC25F14F4663|
|TernaryGoldbach/MajorArcs/EtaPlusL2.lean|0E86FF780F7F4A817F3093787D24D0C5DC10290B56B8555C7EA62362E049D949|

Agent paths are under work/qrh-campaign, the root note under work, and Lean source under work/ternary-goldbach. This is a successor budget; prior frozen reports are unchanged. Independent review of this new weighted argument is pending.

DRAFT_ANCHORS: none created; repository-wide state not audited.
UNREGISTERED_SORRIES: none introduced; repository-wide state not audited.
DRAFT_IMPORT_VIOLATIONS: no imports changed; repository-wide state not audited.
SEALED_THIS_TURN: 0.
