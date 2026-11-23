# Common finite height 100000000/c suffices for the major budgets

Research derivation, 2026-11-11. Source pin: `23b2d68ca344203d4384e0aff7affa4ec034bef9`. This is a conditional analytic implication with exact rational scalar checks. It neither certifies finite zeros nor proves a Lean theorem. The reviewed family and reduced-height reports remain unchanged.

The full major-arc budgets still fit if the finite beta<=111/200 assertion is available only through the exact real height `100000000/c`, for every active primitive conductor. The substantial new plus tail is handled with its actual Gauss weights. A uniform tiny per-character tail would not justify this conclusion. In particular, the previous mixed remainder `2e-10` does not apply here.

## Finite domain and retained low bounds

Let x>=49*10^25, y=x/49, and b=111/200. The active moduli are the odd q<=150000 and even q<=300000. Write qt(q)=2q for odd q and q for even q, and Dq=1200000/qt(q). The active primitive conductors are odd c<=150000 and multiples of four c<=300000. Their exact primitive-character counts a(c) sum to 5,543,640,188 over 150,000 conductors.

The new spectral premise, still unproved, is beta<=b for every nontrivial zero with |gamma|<=100000000/c. The inequality is inclusive and the height is rational; it is not rounded up. Retain the global reflected QRH strip 1/8<=beta<=7/8 outside this finite domain. The actual low-zero cutoffs consumed are

    Hp(c)=min(Hp_old(c),100000000/c),
    Hs(c)=min(Hs_old(c),100000000/c),
    Hp_old(c)=ceil(200+max(1000,(704/7)Dc)),
    Hs_old(c)=ceil(max(1000,(704/343)Dc)).

Thus the old integer count proxies Np_old and Ns_old still majorize the low multiplicities. Reapply the hereditary count, Gram and positive fourth-moment envelopes to these smaller low sets. An actual signed zero-sum norm need not decrease on deleting terms; no such monotonicity is used.

The reviewed low bounds consequently remain

    sqrt(Aplus_low)<.00007, sqrt(Astar_low)<.00049,
    N_low<.001, sqrt(Ep_low)<.0002, sqrt(Cross_low)<.0005,
    integral sum_q Lplus<.002, integral sum_q Lstar<10000.

Here Lplus,Lstar are the exact Gauss-weighted finite-zero energies. The mixed low estimate is the reviewed factor-25 two-character estimate, not an inference from the second moments alone. At c=1 both actual cutoffs equal the old cutoffs, so the old principal high-tail bound remains available.

## A stronger actual etaPlus tail from its Fourier mass

Use Fourier normalization exp(-2*pi*i*xi*u), and write ghat for the source Fourier transform of gC. The source Mellin identity `Explicit/EtaPlusMellin.lean`, `mellin_fP_eq` and its use at lines 197-205, is

    Mplus(s,delta)=integral_|2*pi*xi|<=200
      ghat(xi) Gr(s-1+2*pi*i*xi,delta,0) dxi.

The shifted real part is beta-1, inside [-1,1]. This formula retains the actual smoothing and its Gaussian tail.

The source `MajorArcs/HHFourier2.lean:195` proves the second-derivative energy <=368. The two Fourier-derivative identities and Plancherel used at lines 217-269 give the weighted identity

    integral (2*pi*xi)^4 |ghat(xi)|^2 dxi <=368.

Cauchy--Schwarz, with integral_|2*pi*xi|>A (2*pi*xi)^(-4) dxi=1/(3*pi*A^3), then gives a Fourier L1 tail <=sqrt(368/(3*pi*A^3)). This weighted integral consequence is a new analytic bridge to formalize; the source contains the ingredients, not this exact exported statement.

For the full L1 mass, use `Explicit/EtaPlusMellin.norm_fourier_gC_le` at line 36 and `Explicit/EtaPlusCg.Cg_le` at line 68. Splitting at |2*pi*xi|=3 gives

    integral |ghat| <=2.03*3/pi+sqrt(368/(81*pi))
                     <1.94+1.21<3.5.

For the outer portion of the actual bandlimit, pi>3.141 yields

    integral_100<|2*pi*xi|<=200 |ghat| <.00625.

The cutoff is in |2*pi*xi|, not |xi|. Bound the central portion |2*pi*xi|<=100 by mass 3.5 and the outer portion by .00625. The resulting primitive tail is much smaller than the source's uniform `Cg*(2*aH)<=129.24` estimate.

## Multiplicity windows and the explicit per-character tail

Source `Explicit/ZeroSumBound.lean:89-105` defines

    EB(t)=.892*t*exp(-.1598*t),
    EA(t,d)=.588*(t/(pi*|d|))^2*exp(-.1065*(t/(pi*|d|))^2),

with EA(t,0)=0. The Gaussian tail requires t>=max(10*pi*|d|,50). Source `Explicit/EtaPlusMellin.lean:286-307` supplies the shifted-height/floor argument. Apply that same argument separately at shifts 100 and 200. If |gamma|>H and |2*pi*xi|<=A, then

    floor((|gamma+2*pi*xi|-(H-A))/4.4)
       >=floor((|gamma|-H)/4.4).

Thus both frequency pieces use the same multiplicity windows based at H, even though their Gaussian base heights differ.

The generic multiplicity theorem `Explicit/ZeroSumGen.count_tail_windowG` at line 121 counts both signs and all multiplicities, using the correct BP(c),kappa=11 or zeta BPz2,kappa=10. The reviewed hybrid bounds Z3g<400 and c3g<53/H remain valid for our heights, all between 1000/3 and 61 million. They imply, using the geometric expression E2g at line 195,

    GB(H)=2400+954/H,
    G(D)=3+D/2.7,
    GA(H,D)=800*G(D)+(106/H)*G(D)^2.

Indeed (1-rhoB)^(-1)<3 and (1-rhoA(D))^(-1)<=1+pi*(D+1)/(1.93*4.4)<G(D). There is no assumed spacing or simplicity.

All actual Hp satisfy Hp-200>=max(10*pi*Dc,50). For the common-height branch, the worst even case follows directly from

    100000000-200*300000-12000000*(22/7)>0;

the odd case has larger slack. The old branch already meets the source condition. Consequently a valid normalized primitive plus-tail upper bound at x0 is

    t(c)=(1/2125)*{
       3.5*[EB(Hp-100)*GB(Hp)+EA(Hp-100,Dc)*GA(Hp,Dc)]
       +.00625*[EB(Hp-200)*GB(Hp)+EA(Hp-200,Dc)*GA(Hp,Dc)] }.

Here x0^(1/8)>2125. At other x the underlying bound has the factor x^(-1/8), so its endpoint envelope applies uniformly. The finite-rectangle estimates pass to the good-height explicit-formula limit by the same absolute-convergence argument as in the reviewed hybrid report.

## Exact finite arithmetic and weights

The script bounds t(c) on 5,303 monotone conductor cells, separately for odd conductors and multiples of four. A cell [lo,hi] uses Dmax=D(lo) and Hmin=Hp(hi), and verifies the Gaussian source condition at that corner. Each relative width is at most .25%, with an absolute span at most 200 integers. EB decreases for t>=50; u^2 exp(-.1065*u^2) decreases for u>=10. These facts justify the corner enclosure. Capping t downward at 2000 and u downward at 40 only enlarges the corresponding upper bounds.

Every exponential is bounded using positive rational Taylor lower sums for its inverse. For z=k+r, 0<=r<1, use exp(z)>=(sum_(j=0)^20 1/j!)^k * sum_(j=0)^16 r^j/j!. Each t upper bound is rounded upward to denominator 10^18. The script has no floating acceptance test, quadrature or imported zero data.

For q=c*r, only squarefree r coprime to c contributes. Its exact imprimitive Gauss norm squared is c. Define

    Tq=sum_eligible_c [c*a(c)/phi(q)]*t(c)^2,
    Sq=sum_eligible_c [c*a(c)/phi(q)]*(49*102000)*Ns_old(c)*Y,
    Y=5.625e-23 > (10^25)^(-.89).

Tq is a pointwise plus-tail energy bound; Sq bounds the full-delta integral of the low star energy. The factor 49 is the actual delta/49 scaling. Inversion of a character preserves its conductor, and each induced character occurs once. The script independently verifies sum_eligible_c c*a(c)=phi(q)^2 for every active modulus. There is no extra conductor division or primitive-only Gauss identity imposed on imprimitive characters.

The exact directed aggregate bounds are

    sum_q 2Dq*Tq
      <=5217686454735567/250000000000000000 <.025,
    sum_q Tq*Sq
      <=1689410003000861169/80000000000000000000000000 <2.5e-8.

The second expression bounds the norm squared of plus-tail times low-star in the actual two-character space. It retains the same modulus q and both character indices. It is not a product of two all-modulus averages.

For Aplus, the actual Fourier U has supremum <=1.2534 and integral |U|^2<=381.22=49*7.78, from `MajorArcs/MajorTotal.lean:453,469`. Therefore its tail energy is at most

    sum_q [mu(q)^2/phi(q)^2]*min(381.22,2Dq*1.2534^2)*Tq
      <=60793/(5*10^29) <1e-20.

Only squarefree moduli occur in this expression; their eligible primitive conductors are odd. This explains why the Aplus high tail remains much smaller than the unrestricted N and mixed tails. The largest rounded primitive bound is about 4.4062e-6. Replacing every conductor's tail by that worst value would lose the useful arithmetic weighting.

## Star tail and complete perturbation ledger

If Hs=Hs_old, reuse the old star high-tail bound. If Hs=100000000/c<Hs_old, then c>100000, Hs_old=1000, Hs>=1000/3 and Dc/49<=12/49. The etaU multiplicative Gaussian representation has mass <2 and no frequency shift. Its tail is at most

    (2/1333)*[EB(1000/3)*(2400+954/(1000/3))
        +EA(1000/3,12/49)*(800*3.1+(106/(1000/3))*3.1^2)]
      <7.885e-21<1e-18.

This is a coarse independent-corner estimate; it respects all source conditions. Together with the reviewed vertical contour, possible zero-at-zero, and primitive-to-coprime terms it leaves the same total per-character star error dstar=2e-12. The plus error excluding its separately aggregated high tail is d0=2e-15. Principal poles remain subtracted in Ep; no pole is included in a nontrivial-zero count.

The reviewed finite norm bounds and direct-sum measures give the full coprime estimates

    Aplus <(.00007+1e-10+2e-9)^2 <5e-7,
    Astar <(.00049+1.2e-6)^2 <2.5e-7,
    N <(.032+.16+2e-9)^2 <1.23,
    Ep <(.0002+1e-8)^2 <1e-4.

For Ep, c=1 retains the old cutoff and old high tail, so no large-conductor tail is charged to it. Thus the reviewed q=1 identification still supplies the local raw residual on [-4,4], and the weighted lower-J argument gives (2.94-.00020001-1e-9)^2>8.6296. Upper J<=10 uses the same reviewed Ep,N implication.

To check the mixed error, expand the tensor product of the two actual character vectors. The plus high-tail times low-star norm is <.00016 by the second aggregate above. All remaining terms have total norm at most

    extra=d0*55000+dstar*25+dstar*87+d0*dstar*180000000000
          =4175009/12500000000000000 <1e-9.

Here 55000^2>300000*10000 handles d0 times low-star, 25^2>300000*.002 handles dstar times low-plus, and 87^2>300000*.025 handles dstar times the newly enlarged plus tail. The final measure is the previous bound sqrt(sum_q 2Dq*phi(q)^2)<=180000000000. These estimates do not assume J and do not infer an L4 estimate from an L2 estimate.

The complete new mixed norm remainder is therefore

    Rmix<.00016+extra<.000160001,
    Cross_coprime<(.0005+.00016+extra)^2<4.357e-7<7e-7.

In particular Astar+Cross<9.5e-7, with all high zeros, contour and removal terms included. The final corrected major/minor/nonprime budget remains 1.0404 / 1.0376 / .00271 after the previously reviewed coprime-to-full transfer. This note does not bypass that transfer.

## Scope and reproducibility

Run `python work/qrh-campaign/agents/major-constants/resume_common_height_major_20261111.py`. The accompanying JSON contains exact rational aggregate bounds and separately labeled decimal displays. The cells JSON records each rational tail numerator and conductor cell. An independent review is requested before selecting this profile.

The common finite height lies inside the common published 100000000/c domain discussed in the separate Platt domain comparison. This is only a containment statement. No published computation is imported as a proof or axiom, and no runtime or proof-volume saving is claimed.

Still open are the finite spectral certificate, global QRH proof input, the existing actual-smoothing Gram and explicit-formula bridges, the new weighted-Plancherel L1 split, the generic tail/limit and moment transfer formalizations, and formal replay of the finite arithmetic. This result supplies a smaller sufficient certificate domain with a complete revised remainder budget; it does not complete Goldbach or remove PlattGRH in Lean.

## Corollary: certify only the minimum height

The premise above can be weakened further, without changing any number or proof step. It suffices to certify the finite beta<=111/200 assertion only through

    Hcert(c)=min(Hp_old(c),100000000/c).

Indeed Hp(c)=Hcert(c), while Hs(c)=min(Hs_old(c),100000000/c)<=Hcert(c), because Hs_old(c)<=Hp_old(c). The proof never uses finite-strip information above these actual low cutoffs. This is an inclusive rational height with no upward rounding.

For the shared blueprint, the separately established base-gap inequalities Hbase<=Hp_old and Hbase<=100000000/c imply Hbase<=Hcert. They must both be retained as inputs from the base-gap derivation. At c=1, Hcert=Hp_old=60343058, so the principal psi route keeps its reviewed intermediate height and its separate low-zero refinement premise. The q=1 lower-J conclusion above is unchanged. Thus this single minimum profile is no larger than either the original plus profile or the common published height at any active conductor. This restriction is logical only; it asserts no finite certificate, checker implementation, or runtime comparison.
