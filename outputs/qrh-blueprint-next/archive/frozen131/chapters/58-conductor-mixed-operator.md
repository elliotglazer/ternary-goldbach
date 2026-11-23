# Mixed character moment: exact conductor operator and the remaining density statistic

Research only. No Lean build, source edit, axiom or sorry was used. Source conventions remain those of `work/ternary-goldbach` at `23b2d68ca344203d4384e0aff7affa4ec034bef9`. The script `resume_mixed_operator_20261111.py` and its JSON output check finite arithmetic; they do not certify any L-function zero locations.

The new result is a paper proof of an arithmetic operator bound, with its constant enclosed by exact integer arithmetic. It turns the same-modulus Gauss-weighted product into a precise conductor-family fourth-moment integral at cost less than 25. It does not turn an ordinary second moment into a fourth moment. The unresolved number theory is now a conductor-L2 zero-count statistic, stated below. The existing strip, mass bounds and first-density information do not supply that statistic at the required size.

## 1. Exact definitions and scope of the operator

Keep x >= 4.9e26, y=x/49, Q=Qset(150000), and Iq=[-Dq,Dq], with Dq=1200000/qt(q). Thus odd q<=150000 and even q<=300000. The two independent character indices in Cross remain independent.

For a primitive character chi of conductor c, first take finite nontrivial-zero sums, with every zero counted with its actual multiplicity:

    z_chi,+(delta) = -sum_rho m_rho*x^(rho-1)*F+(rho,delta),
    z_chi,*(delta) = -sum_sigma m_sigma*y^(sigma-1)*F*(sigma,delta/49).

Here the Mellin transforms are the actual etaPlus and etaU transforms from BLUEPRINT_MIXED_MOMENT.md. The principal pole has been subtracted. Zeros at zero, trivial zeros, contour terms, omitted tails and imprimitive Euler/coprime corrections are not silently included in these sums.

Set

    P_c,+(delta) = sum_(chi primitive mod c) |z_chi,+(delta)|^2,
    P_c,*(delta) = sum_(chi primitive mod c) |z_chi,*(delta)|^2,
    W_c,±(delta) = (c/phi(c))*P_c,±(delta).

The relevant finite conductor set consists of c that can induce into some q in Q. In particular, primitive conductor c with v2(c)=1 does not exist. This is the familiar absence of primitive characters of conductor 2 modulo an odd factor, and follows from the local character decomposition.

The source Gauss formula is exact:

    |tau_q(psi)|^2 = c
      if q=c*r, r squarefree and gcd(c,r)=1;
    |tau_q(psi)|^2 = 0 otherwise.

Every primitive character induces once. Inversion does not change its conductor. Therefore the zero-only character energy is exactly

    E_q,z,± = sum_(q=c*r, r squarefree, gcd(c,r)=1) W_c,±/phi(r)
            = (T W_±)_q.

This identity is not asserted for the full coprime residual, whose removed prime powers depend on q. Those corrections are treated in Section 6.

Let Pi_delta be the diagonal projection on output coordinates q satisfying |delta|<=Dq. Then the exact zero-only mixed moment is

    Cross_z = integral_R <Pi_delta T W_+(delta),
                          Pi_delta T W_*(delta)> ddelta.

All vectors have nonnegative real coordinates, but the inner product still expands over two independent characters. Pi_delta retains the actual modulus-dependent windows. It is a norm contraction; no assertion that all arcs have the same width is needed.

## 2. A tensor-product proof of ||T||^2 < 25

Embed the finite coefficient vectors into the finite product of prime-exponent coordinate spaces. Extend them by zero and permit output integers beyond the original q cutoff, then project back. This enlargement can only increase the output norm.

At an odd prime p, the squarefree/coprimality restriction allows the local multiplier r to introduce p only when c has exponent zero. On exponent coordinates 0 and 1 the local operator is

    A_p = [[1, 0], [1/(p-1), 1]].

Every coordinate with exponent at least 2 is unchanged and does not mix with the first two. For h=1/(p-1), direct diagonalization of A_p^T A_p gives

    ||A_p||^2 = ((sqrt(4+h^2)+h)/2)^2
              = (2*(p-1)^2+1+sqrt(4*(p-1)^2+1))/(2*(p-1)^2).

At p=2 the input exponent-1 coordinate is zero, because there are no primitive characters with v2(c)=1. Its exponent-zero coordinate maps to two equal output coordinates, while exponents at least 2 stay fixed. The restricted local squared norm is consequently 2. Using the unrestricted shear norm here would waste a factor.

Every prime that occurs in a relevant modulus is at most 150000. Tensor-product norms multiply, and the input/output cutoff projections have norm at most one. Thus

    ||T||^2 <= 2 product_(3<=p<=150000, p prime) ||A_p||^2 < 25.

The product is approximately 24.5352832455. The strict upper bound is checked without floating-point square roots. For each p the script uses an integer square root at denominator 2^160, rounds the square-root bound upward, and rounds each product upward at that denominator. Its final rational upper bound is

    35858356635742588448682057677821345334002074112323
    /1461501637330902918203684832716283019655932542976 < 25.

The prime list comes from a complete finite Eratosthenes sieve. A Lean implementation would still need to verify the finite prime list/product and the operator lemma. This is an exact arithmetic certificate plus a paper proof, not a compiled Lean result.

It follows pointwise, preserving Pi_delta until its contraction step, that

    <Pi_delta T W_+, Pi_delta T W_*>
       <= 25*||W_+||_2*||W_*||_2.

Consequently, for

    I = integral_R ||W_+(delta)||_2*||W_*(delta)||_2 ddelta,

we have Cross_z <=25 I. Finite sums justify this immediately when the displayed integral is finite. Infinite-zero passage needs uniform mixed-norm tails, not merely pointwise convergence.

## 3. Exact block structure and an independent pair check

Define the powerful part pp(c) as the product of the full prime powers p^a exactly dividing c for which a>=2. Two primitive conductors c,d can contribute to the same q only if pp(c)=pp(d). Indeed a positive conductor exponent forces that exact exponent in q. If the other conductor omits p, q's exponent can only be one. Unequal positive exponents or a lone exponent at least two are impossible.

Write l=lcm(c,d). When the powerful parts agree, the exact coefficient of P_c,+ P_d,* at a fixed delta is

    (c*d/phi(l)^2)
      * sum_(k squarefree, gcd(k,l)=1,
             l*k in Q, |delta|<=D_(l*k)) 1/phi(k)^2.

It is zero when the powerful parts differ. The script independently compares this formula with direct q enumeration on eleven sample conductor pairs using exact fractions. This preserves all Gauss support, including nonsquarefree moduli.

The tensor bound can be applied separately in each powerful-part block. If m is odd, there is a factor 2 at the prime 2 and the remaining odd squarefree variables are bounded by R/m. If m is even, v2(m)>=2, there is no doubling and the odd variables are bounded by 2R/m. Omit primes dividing m from the product. At R=150000 the resulting squared-norm bounds include

| Powerful part m | Safe upper bound |
| ---: | ---: |
| 1 | 25 |
| 4 | 12 |
| 8 | 11 |
| 9 | 13 |
| 16 | 11 |
| 36 | 6 |
| 144 | 5 |
| 900 | 3 |

These are especially relevant to the earlier smooth-conductor rows, whose dominant families have powerful parts 36 and 16. They do not themselves bound the primitive family energies. At each delta one may also replace R by min(150000,600000/|delta|), with the evident convention at zero, before forming the contraction bound.

## 4. Exact corrected scalar target

Use the corrected combined coprime cap Astar+Cross<=9.5e-7. For any proved allocation Astar_actual<=a, let Rmix bound the Hilbert norm of all terms omitted from z_+ z_* in the exact character-pair expansion. The Hilbert measure is w(q,psi)w(q,xi)/phi(q)^2 times Lebesgue measure on Iq. Minkowski gives

    Cross_actual <= (5*sqrt(I)+Rmix)^2.

Therefore the remaining scalar target is

    I <= (sqrt(9.5e-7-a)-Rmix)^2/25,

provided the difference on the right before squaring is nonnegative. This is a target for the explicitly defined primitive fourth-moment integral, not an assertion that it is proved.

A convenient allocation with rational checks is

    Astar_actual <=2.5e-7,
    I <=2.79e-8,
    Rmix <=1e-6.

Indeed 5*sqrt(2.79e-8)<.0008352 and

    (.0008352+.000001)^2 = .00000069923044 <7e-7.

No ordinary L2 estimate implies I<=2.79e-8. For example, applying Cauchy-Schwarz in delta to I requires integrals of sum_c W_c,±^2, which are already fourth moments over primitive character families. Their proof is precisely part of the outstanding task.

## 5. A genuine zero-density interface

Let a(rho)=(2-beta)/((2-beta)^2+gamma^2), and suppose M_c is a proved upper bound for the total a-weighted zero mass of every primitive character of conductor c. This is where the completed-L logarithmic derivative estimates from WEIGHTED_ZERO_MOMENTS.md would enter. Their analytic and numerical proofs remain necessary.

For a finite zero cell A let N_c(A) be the multiplicity count over all primitive characters of conductor c in that cell, and let beta_A be its upper real endpoint. Define

    b_c(A)=(c/phi(c))*M_c*N_c(A),
    S_A=sum_c b_c(A)^2,
    H_+,A(delta)=sup_(rho in A) |F+(rho,delta)|^2/a(rho),
    H_*,A(delta)=sup_(rho in A) |F*(rho,delta/49)|^2/a(rho),
    J_AB=integral_R H_+,A(delta)*H_*,B(delta) ddelta.

Weighted Cauchy-Schwarz inside each primitive zero sum gives a linear sum over zeros. Summing characters, taking the conductor l2 norm, and then using its triangle inequality yields the sufficient bound

    Cross_z <=25 sum_(A,B)
       x^(2*beta_A-2)*y^(2*beta_B-2)*sqrt(S_A*S_B)*J_AB.

This keeps both character indices and every multiplicity. A sharper version uses the exact powerful-part blocks and their constants. One may also retain the delta-dependent projection bound instead of the constant 25. Supremum-of-integral and integral-of-supremum must not be interchanged: J_AB here is explicitly the latter, possibly weaker quantity.

If the finite cells, mass bounds and kernels are independent of x, every displayed power of x and y decreases for x>=x0 because beta_A,beta_B<=7/8<1. Checking this upper bound at x0 is therefore sufficient uniformly for all larger x. This does not assert that the actual oscillatory I(x), or any individual zero sum, is monotone in x.

The key new density statistic is S_A, a second moment of the primitive-family zero count across conductors. A global first-density bound on sum_c N_c(A) does not control it linearly. A legitimate bridge is

    S_A <= max_c[(c/phi(c)*M_c)^2*N_c(A)] * sum_c N_c(A),

or an actual conductor second-moment density theorem. The local maximum, its constants and its height range must be supplied; they cannot be suppressed by calling a global first-density theorem an average.

The numerical sensitivity is explicit. At x0, (x0*y0)^(-1/4)=1.1952286093e-13. Spending 7e-7 on one right-edge cell with the global constant 25 would permit approximately S_A*J_AA<=234264.8 before remainder reserves. If b_c(A)=6*N_c(A) as a diagnostic model and J_AA=1, this permits about 6507 zeros spread one per conductor, but only 80 zeros if concentrated in one conductor. The script records analogous thresholds for J from .01 to1000. Neither the factor 6 nor any listed J is asserted as a proved bound. The example isolates the quantitative concentration obstruction without inventing an actual family of L-functions or claiming such zeros occur.

The common mass-only replacement remains unusable. The operator lemma reorganizes the arithmetic; it does not supply zero sparsity, repulsion, multiplicity control beyond the source counts, or cancellation inside a primitive residual. It cannot rescue the earlier mass-envelope calculation merely by replacing its modulus sum with 25 times a large conductor norm.

## 6. Imprimitive correction is separable and much smaller

The raw unconditional source lemmas are `MajorArcs/ArcChars.sum_noncoprime_etaPlus_le` and `MinorArcs/BaseGap2.sum_noncoprime_le`. They bound the omitted coefficient sums by 1.94*K*log(q)+1 and 6.2*K*log(q)+1 when the relevant scale squared is at most 2^K. Character values have norm at most one, so the same bounds apply when comparing a primitive character sum with its induced coprime version.

Choose K=ceil(2*log(z)/log(2)). The continuous upper bound K<=2*log(z)/log(2)+1 and monotonicity of (A*log(z)+B)/z give uniform normalized bounds

    d_plus <=1e-23,  x>=4.9e26;
    d_star <=1.4e-21, y>=1e25;

for q<=300000. Safe endpoint arithmetic uses log(x0)<62, log(y0)<58, log(2)>.69 and log(300000)<13. The script checks the resulting coefficient inequalities exactly. These elementary logarithm and monotonicity bridges have not been compiled in Lean.

Under the already required J<=10 interface, the existing transfer argument supplies integral_sum Eplus<=57 and integral_sum Estar<=4.15e14 for coprime residuals. The exact identity sum_psi |tau_q(psi)|^2=phi(q)^2 gives Euler-error energy at most phi(q)*d^2. Expanding primitive-full products around coprime products then bounds their Hilbert-norm difference by

    d_plus*sqrt(300000*4.15e14)
      +d_star*sqrt(300000*57)
      +d_plus*d_star*sqrt(3.24e22)
      <1.2e-13.

This is a useful sharper transfer, conditional on the shared J interface but independent of new zero locations. It is not the explicit-formula contour/tail estimate. Those other terms must still be included in Rmix. Nor should this primitive-to-coprime correction be confused with, or double-counted as, the later coprime-to-full additive-sum transfer used in the final major-arc theorem.

The independent-feasibility worker is developing conductor-dependent height cutoffs and mixed-norm tails from the actual Gaussian bounds. Its reported target below1e-8 would fit the Rmix<=1e-6 allocation, but that report is not incorporated here as a completed proof.

## 7. Viable next bounded task and stopping point

The next numerical test should estimate the actual J_AB table for low heights and right-edge beta cells, separately by powerful part, and pair it with certified N_c(A) information. The operator and correction calculations now specify exactly what is needed. A finite zero certificate need only give a weighted rectangle count strong enough for S_A; it need not establish RH equality. Its completeness and high-height tail must be independently checked.

If a density theorem is used instead, it must control conductor clustering through S_A or the explicit local-max bridge above. The old abstract global first-density model does not settle this. A finite certificate for only conductor one also cannot settle the many nonprincipal families in Cross. The existing etaU Mellin formula, its real-twist Taylor remainder and etaPlus's shifted Gaussian representation provide the transform side of this test; no fictitious zero-spacing premise is required.

Completed here are the exact conductor-pair support formula, the finite tensor-product norm proof with a rational constant below25, improved powerful-part constants, the precise residual scalar target, and a sharper imprimitive-error calculation. The required primitive conductor fourth moment and the Astar cap remain open. This is substantive progress in the proof interface, not a QRH replacement theorem or a closure claim for Goldbach.
