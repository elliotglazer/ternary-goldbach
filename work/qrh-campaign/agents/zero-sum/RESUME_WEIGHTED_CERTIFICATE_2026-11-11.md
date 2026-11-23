# Conductor aggregate certificates for the finite spectral step

Research derivation, 2026-11-11. This note uses the original height profile and source pin `23b2d68ca344203d4384e0aff7affa4ec034bef9`. The reduced-height candidate is not substituted. No zeros were computed, no Lean build ran, and no canonical source changed.

A conductor aggregate of weighted zero counts suffices for the reviewed mixed fourth moment and all its second-moment companions. It does not require identifying which primitive character owns each zero. This gives a precise alternative to 5,543,640,188 individual character certificates: 150,000 conductor-product certificates with explicit completeness requirements. It does not establish that those products can be evaluated more cheaply.

There is also a concrete alternative spectral condition. For each conductor other than one, require every relevant finite zero to have real part at most .7. In each of its two height carriers, permit at most floor(n(c)N_eta(c)/10^8) zeros with real part above .54, counted with multiplicity and both signs. These conditions imply the previous numerical caps. They permit 17,325,508 plus-carrier and 12,714,114 star-carrier exceptions in total across conductors other than one, subject to their individual conductor caps. These are allowed budgets, not observed zeros or fractions of an actual zero inventory.

For compatibility with the entire blueprint, retain the original conductor-one .555 certificate through Hp(1). The separate psi-tail argument still uses it. Replacing conductor one by the alternative condition would require revisiting that argument.

## 1. Weighted data sufficient for the mixed moment

Use the exact carriers, Gauss support, kernels and notation of `RESUME_FAMILY_MIXED_2026-11-11.md`. Write n(c) for the number of primitive characters at conductor c. The original heights and per-character multiplicity bounds are

    Dc=1200000/qt(c),
    Hp(c)=ceil(200+max(1000,(704/7)Dc)),
    Hs(c)=ceil(max(1000,(704/343)Dc)),
    N_eta(c)=ceil(400*(2H_eta(c)/3.48+2)).

Let z_p=x, z_s=y=x/49, with endpoint values x0=4.9e26 and y0=1e25. Define actual finite spectral energies

    E_c,eta(z)=sum_(chi primitive mod c)
                 sum_(rho nontrivial, |Im rho|<=H_eta(c))
                   multiplicity(rho) * z^(2 Re rho-2).

Both height signs are included. Multiplicity is a repeated-index count, not an assumption of simple zeros. These quantities decrease with z because the QRH strip has Re rho<1.

Let P_c,eta(delta)=sum_chi |z_chi,eta(delta)|^2 and W_c,eta=(c/phi(c))P_c,eta. The reviewed analytic constants are

    Mp=3.95, Ms=4, Kp=23000, Ks=49*102000=4998000.

The per-character Jensen bound and finite Cauchy-Schwarz give

    sup_delta P_c,eta <= M_eta^2 N_eta(c) E_c,eta(z).

Within each character use |sum_i a_i F_i|^2<=N_chi sum_i |a_i F_i|^2, then N_chi<=N_eta(c). Sum over characters after this step. Independently the reviewed Gram row gives

    integral_R P_c,eta <= K_eta E_c,eta(z).

Consequently a genuine fourth-moment bound is

    integral_R W_c,eta^2
      <=(c/phi(c))^2 M_eta^2 K_eta N_eta(c) E_c,eta(z)^2.

Put D_eta equal to the sum of these right sides over active c. Cauchy-Schwarz in delta now proves I_low<=sqrt(D_p D_s). The actual pointwise factor is essential. This is not an inference from an ordinary second moment alone. The only character-specific input is the common Jensen bound, so E_c does not need to record character ownership of the zeros.

The exact conductor operator remains unchanged. A primitive character of conductor c contributes at q=cr exactly when r is squarefree and gcd(c,r)=1, with squared Gauss weight c. Thus

    E_q,eta=(T W_eta)_q,
    Cross_low=integral <Pi_delta T W_p, Pi_delta T W_s>
             <=25 I_low.

Pi_delta retains precisely |delta|<=Dq. It is a diagonal contraction; the q-dependent arc windows remain explicit. The product contains two independent characters. These are primitive zero residuals. Euler-factor removal, vertical terms, zero-at-zero terms and high-zero tails enter only in the reviewed remainder ledger.

## 2. The same data control the other caps

Replace n(c)N_eta(c)z^(2b-2) by E_c,eta in each reviewed linear Gram bound. Put

    w_c=2c sum_(r odd squarefree<=150000, c|r) phi(r)^(-3),

with w_c=0 when the sum is empty. The exact squarefree-modulus contributions obey

    Aplus_low <=1.2534^2 Kp sum_c w_c E_c,p,
    Astar_low <=(641547/700000)^2 Ks sum_c w_c E_c,s.

The nonprincipal upper energy obeys

    N_low <=Kp sum_(q in Q) [1/phi(q)]
              sum_(c>1, q=cr, r squarefree, gcd(c,r)=1) c E_c,p.

The principal weighted energy satisfies Ep_low<=14 Kp E_1,p. These are the actual Gauss weights, with no invented conductor saving. The low total star energy in the mixed remainder also has a positive linear form, with Ks and E_c,s. Componentwise domination by the old .555 endpoint energies therefore preserves all old fixed numerical bounds and the no-J mixed remainder proof.

## 3. An exact substitute for the uniform .555 certificate

For each conductor other than one, suppose the following finite facts are certified.

1. All nontrivial zeros through Hp(c) have beta<=7/10.
2. For eta=p,s, the count B_c,eta of zeros with beta>27/50 and |gamma|<=H_eta(c), summed over primitive characters with multiplicity, is at most floor(n(c)N_eta(c)/10^8).

Together with the total count upper bound n(c)N_eta(c), these give

    E_c,eta(z0)
      <=n(c)N_eta(c) z0^(-.92)+B_c,eta z0^(-.6)
      <=n(c)N_eta(c) z0^(-.89)
          *[z0^(-.03)+10^(-8) z0^(.29)]
      <(4/5)n(c)N_eta(c) z0^(-.89).

The first line counts an exceptional zero in the baseline as well as its exception allowance, which is safe for an upper bound. The final strict inequality is certified with integers alone:

    y0^3>5^100,    x0^29<(6*10^7)^100.

These show z0^(-.03)<1/5 and 10^(-8)z0^(.29)<3/5 at both endpoints. No numerical logarithm enters this certificate.

Uniformity requires care. The ratio comparison is proved at x0 and y0 only; its positive-power term grows with z. For larger x use E_c,eta(z)<=E_c,eta(z0). The Gram inequalities hold for every oscillatory phase, so fixed endpoint bounds give the uniform caps. We do not assert that the new energy stays below .8 of the old power envelope at every x.

If the new condition were also used at conductor one, each linear low cap would shrink by .8 and I_low by .64 relative to the old endpoint calculation. That is a major-arc-only variant. The selected blueprint-compatible variant retains conductor-one beta<=.555 instead. Every componentwise energy is then still at most its old endpoint bound. Hence I_low<1e-8, Astar_coprime<=2.5e-7 and the full reviewed Astar+Cross bound remain valid with the original remainder ledger. The psi-tail proof is unchanged.

The script independently reconstructs primitive character counts and heights. There are 150,000 active conductors and 5,543,640,188 primitive characters. Total crude multiplicity bounds are 1,740,063,512,485,802 for plus and 1,278,926,120,257,689 for star. These are upper bounds, not actual zero inventories.

For example, c=149993 has 149991 primitive characters, Np=276663 and Ns=230686. Its alternative condition permits 414 plus exceptions and 346 star exceptions above .54, all bounded by .7. At c=3 the limits are 46 and zero. The plus allowance cannot substitute for the star allowance. Summing the floors over c>1 gives the budgets stated at the beginning. Unused allowances cannot be moved between conductors without rechecking D_p,D_s and the linear weighted sums.

The exception denominator is the SOURCE UPPER COUNT n(c)N_eta(c). It does not assert that at most10^-8 of actual zeros are exceptional. The condition is not implied by QRH, and neither it nor uniform .555 implies the other. It permits some zeros to the right of .555 but restricts the aggregate already above .54. This is a sufficient information interface, not a proved zero-density theorem.

## 4. Counting conductor products

For c>1 define the finite entire product

    F_c(s)=product_(chi primitive mod c) L(s,chi).

There are no principal primitive characters at these c. For c=1 use the source's entire pole-corrected zetaF, which agrees with (s-1)zeta(s) away from its removable point and is nonzero at s=1. In the nontrivial strip, a zero multiplicity of F_c is the sum of its factor multiplicities. Entire products have no zero/pole cancellation. The source nontrivial carriers must be identified with these product zeros in that strip.

A certified argument-principle count of F_c gives B_c,eta without assigning any zero to a character. A further empty-rectangle count to the right of .7 gives the other condition. The global QRH right boundary bounds the search region. Count both height signs directly; do not presume that an individual complex character has a real-character quartet.

Contours need certified nonvanishing, with boundary cases accounted for. A sufficient implementation takes horizontal edges strictly outside +/-H_eta(c), a left edge strictly below .54 or .7, and a right edge beyond7/8. Its count overcovers every requested zero. Prove edge positions and nonvanishing, then certify the winding number with rigorous errors. Extra zeros in the enlarged region are harmless if the count cap passes. For conductor one the selected variant instead certifies the old .555 rectangle.

This reduces the number of separately specified functions to150000 and removes character identifiers from the zero data. It does not reduce the analytic degree of those functions. Evaluating a product factor by factor still pays for billions of characters. No comparable runtime or proof-size reduction is claimed.

There is an exact arithmetic identity that a future aggregate evaluator could use. For c>1 and Re(s)>1,

    -F_c'(s)/F_c(s)=sum_(m>=1) Lambda(m) A_c(m) m^(-s),
    A_c(m)=1_(gcd(m,c)=1)
             *sum_(d|c, d|(m-1)) mu(c/d) phi(d).

Primitive-character orthogonality and Mobius inversion prove the identity. Its coefficients use divisors instead of a character enumeration. The unit indicator is essential for the Euler factors. This series is absolutely convergent in the stated half-plane; it does not directly evaluate the needed .54 or .7 contours. Analytic continuation with certified errors and acceptable cost remains unresolved. The conductor-one logarithmic derivative has an extra pole-correction term and should be handled separately.

## 5. Why an omitted-conductor QRH bound does not close this recipe

The weighted criterion does not justify skipping large conductors with only QRH. Its fourth-moment majorant is sensitive to one possible low zero at beta=7/8. If one such repeated index lies in both finite carriers at conductor c, its contributions to E_p,E_s alone make the computed majorant sqrt(D_p D_s) at least

    (c/phi(c))^2 Mp Ms sqrt(Kp Ks Np(c)Ns(c)) (x0*y0)^(-1/4).

The script checks every active conductor and proves this expression exceeds .01. The minimum diagnostic is approximately .1617566 at c=149993, far above2.79e-8. The comparison is exact after squaring twice.

This is a lower bound on a numerical upper-bound functional, not on the true mixed moment. It proves that this pointwise-times-Gram recipe cannot certify the target while allowing that possibility. It does not establish the existence of such a zero, or exclude stronger kernel or cancellation arguments. The test applies below Hs(c), where the zero belongs to both carriers.

Product aggregation removes individual character ownership from the required data, but it still needs strong finite family information. Neither the current400-per-window Jensen bound nor QRH supplies the proposed .54/.7 counts. One bounded next test is to certify both rectangles for c=149993 with an aggregate evaluator, compare the cost against factorwise evaluation, and retain a complete winding-number transcript. Until then, the interface is rigorous but its computational advantage is unproved.

## Validation and open proofs

`resume_weighted_certificate_20261111.py` and its JSON reconstruct the finite arithmetic and exit successfully. They establish no actual spectral statement. This note depends on the reviewed actual smoothing Gram and pointwise derivations, the exact factor25 Gauss operator, and the full primitive-to-coprime remainder ledger. Their analytic Lean bridges remain open. The product, orthogonality and certified contour-count interfaces also need formal proofs. No part of this note completes the finite spectral obligation or the Goldbach proof.
