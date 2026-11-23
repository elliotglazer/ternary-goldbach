# Blueprint for nonprincipal averages and upper major-arc energy

Scope: research blueprint only. No Lean compilation or implementation was performed. Sources are the pinned ternary-goldbach commit 23b2d68ca344203d4384e0aff7affa4ec034bef9 and the pinned comparison tree. The final target remains TernaryGoldbachFrom (10^27), followed by the existing small-case argument. No missing analytic estimate below has been introduced as an assumption or claimed proved.

## Corrected full-goal budget

IMPORTANT: the earlier .011670451 dynamic budget in AVERAGING.md, STRONGEST_AVERAGE.md, UNIFORM_AND_HYBRID.md and WEIGHTED_ZERO_MOMENTS.md reserved nothing for the nonprime subtraction. Their associated A/V targets were only major-minus-minor positivity diagnostics. They do not suffice for the full Goldbach conclusion. The current blueprint supersedes those sufficient-target labels.

The reviewed averaged cubic algebra gives, in units x^2/49,

    main >= 1.314*.800689 = 1.052105346,
    fixed Fourier loss <=49*2.03e-5*2.85 = .002834895,
    dynamic loss <= sqrt(B(J)*Aplus) + sqrt(2*J*(Astar+Cross)),
    B(J)=2J+17.41053338496.

Use the clean replacement major lower bound 1.0404. Its dynamic allowance is

    1.052105346 - .002834895 - 1.0404 = .008870451.

The intended primary upper-energy bound is J<=10. The corrected COPRIME targets are

    Aplus' <=5e-7,
    Astar'+Cross' <=9.5e-7.

The established removal algebra, with a=1.01, bp=3.03e-23, bs=3.03e-17, integrated Eplus<=57 and Estar<=4.15e14, gives conservative full-sum bounds

    Aplus <=5.050000000000330e-7,
    Astar+Cross <=9.817952468e-7.

They yield dynamic loss <.008778, below .008870451. These decimals were computed and sent for independent exact arithmetic audit; the analytic targets remain open.

The final nonprime term is 6.7e6*N*sqrt(N)*log(N). Here x=xOf(N)=N/d, d=2+9/(196*sqrt(2*pi))<=2.02, and kappa=49. The audit worker showed that the existing Numerics.final_inequality_crude argument can instead bound its normalized size by .00271: set v=N^(1/64), use v>=2.64 and log(v)<=v/2.7, obtaining

    1.589e8*4.0804*49/(2.64^31) < .00271.

This ordinary numeric lemma still needs a Lean proof at the new constant. It preserves the endpoint N>=10^27. Then

    1.0404 - 1.0376 - .00271 = .00009 >0.

A separate elementary route proves <.0027: log(N)/sqrt(N) decreases for N>=e^2, log(10^27)<62.181 and sqrt(10^27)>3.162e13; thus its normalized size is at most 6.7e6*49*2.02^2*62.181/(3.162e13)=.0026343257...<.0027. The blueprint uses .00271 so it can reuse the existing final numeric proof structure.

This changes the internal major_arcs_input constant and the final numeric assembly. It preserves the user-facing theorem and the 10^27 endpoint. If the internal source major bound 1.049 must also be retained, the dynamic allowance shrinks to .000270451 and the above targets do not suffice.

## Exact domains and character definitions

Let Q=Qset 150000: odd q<=150000 and even q<=300000. Put qt(q)=2q for odd q and qt(q)=q for even q, Dq=1200000/qt(q), and Iq=(-Dq,Dq). Endpoints do not affect these integrals. Let x>=4.9e26 and y=x/49>=1e25.

    P(delta)=Fourier(etaPlus)(-delta),
    U(delta)=Fourier(etaU)(-delta/49),
    m_q=mu(q)/phi(q).

For a_+(n)=Lambda(n)*etaPlus(n/x) and a_*(n)=Lambda(n)*etaU(n/y), the COPRIME residuals are

    e_(q,psi,+)=Schar(psi^-1,coprimePart(q,a_+),delta/x)/x -1_(psi=1) P(delta),
    e_(q,psi,*)=Schar(psi^-1,coprimePart(q,a_*),delta/x)/y -1_(psi=1) U(delta).

Define Eplus and Estar by summing |tau_q(psi)|^2 |e|^2/phi(q). Then

    Aplus'=sum_q integral_Iq |m_q U|^2 Eplus,
    Astar'=sum_q integral_Iq |m_q P|^2 Estar,
    Cross'=sum_q integral_Iq Eplus Estar.

The exact imprimitive Gauss weight is conductor c if q/c is squarefree and coprime to c, and zero otherwise. Keep psi^-1 in the primitive conversion. Euler/coprime corrections must be added after the primitive explicit formula. Bombieri.lean:27,78,135 supplies the relevant algebra; it supplies no cancellation estimate.

Aplus and Astar only involve squarefree q. Pair q=r,2r with r odd squarefree<=150000. For each primitive chi of odd squarefree conductor c dividing r, the individual coefficient is exactly 2c/phi(r)^3. There is no extra 1/sqrt(c) in a generic QRH primitive error.

## Upper J: two distinct proof routes

The primary route retains the principal/nonprincipal orthogonality from L2_REPLACEMENT.md. Write

    Ep=sum_q mu(q)^2/phi(q) *integral_Iq |g_q-P|^2,
    N=sum_q 1/phi(q) *integral_Iq sum_(psi!=1)|tau_q(psi)|^2
           |Schar(psi^-1,coprimePart(q,a_+),delta/x)/x|^2,

where g_q is the coprime principal sum divided by x. The Fourier main energy is <=M0=8.70526669248. With the source removal estimate, square splits t=.0034,u=1e-6 show

    Ep<=1e-4 and N<=1.23 imply J<9.994387<10.

These two analytic bounds are open. Aplus does not imply them: its multiplier can vanish, and it excludes nonsquarefree moduli. N includes every relevant primitive conductor, including even and nonsquarefree conductors.

A genuine alternative avoids this nonprincipal theorem by paying a tighter cubic budget. Global Parseval and major-arc inclusion imply

    J <= (1/x) sum_n Lambda(n)^2 etaPlus(n/x)^2.

The ACTUAL_ENERGY.md paper proof already supplies enough unconditional coefficient control. Its compact etaO argument gives coefficient energy <=1.36*x*log(2x). The complete Gaussian remainder has coefficient l2 norm divided by sqrt(x) <=.0105*sqrt(log(2x)), by the same infinite block argument with the large-sieve factor omitted. Minkowski gives

    J <= (sqrt(1.36)+.0105)^2 log(2x) <1.4 log(2x).

This needs the existing Fourier-inversion tail bridge and the ordinary Chebyshev summation-by-parts lemmas, but no new prime cancellation. At x0 this upper bound is about87.0094. It is NOT a uniform constant87 for all larger x. Use J(x)=1.4log(2x) in B(J) and in every budget. With dynamic allowance .008870451, the equal-half full-sum caps are exactly

    Aplus <= .008870451^2/[4 B(J(x))],
    Astar+Cross <= .008870451^2/[8 J(x)].

This removes the independent Ep/N proof, while tightening Aplus by about a factor5 and Astar+Cross by about a factor9 near x0. It is an option if the mixed-moment work is strong enough. No such strength is currently established. For unbounded x, retain the decaying raw coprime-removal formulas rather than combine a constant removal bound with indefinitely shrinking caps. The raw bounds are proportional to log(x)/x and log(y)/y; their monotonicity follows by differentiation in this range.

The lower bound J>=8.6296 is separate. The proposed q=1 weighted-mass kernel estimate on |delta|<=4 may prove it without nonprincipal control. It does not prove either upper-J route or the cubic estimates.

## New second-moment route: use density after mass Cauchy-Schwarz

The failed mass-only route bounded every character by K^2 M_chi^2. Instead retain the individual zeros after applying weighted Cauchy-Schwarz. Put

    w(rho)=(2-beta)/((2-beta)^2+gamma^2),
    M_chi=sum_rho m_rho w(rho).

The completed logarithmic derivative at2 gives prospective explicit bounds M_chi<=.5log(c)-.29 for even nonprincipal chi and <=.5log(c)+.017 for odd chi; M_zeta<.07. Their analytic identity and small numerical certificates are separate proof obligations described in WEIGHTED_ZERO_MOMENTS.md.

For a primitive spectral error and any nonnegative delta multiplier W, Cauchy-Schwarz and Tonelli give

    integral_I W |sum_rho m_rho x^(rho-1) F_plus(rho,delta)|^2
      <= M_chi sum_rho m_rho x^(2beta-2) H_plus(rho;W,I),

    H_plus(rho;W,I)=integral_I W(delta)|F_plus(rho,delta)|^2 /w(rho) ddelta.

This leaves the zero count LINEAR. Use W=|U|^2 for Aplus, W=1 for N, and replace x,F_plus,W by y,F_U(rho,delta/49),|P|^2 for Astar. Reflection pairs can be grouped before the inequality. Any factor arising from grouping must remain explicit; the real-character quartet is not automatically valid for a nonreal character.

For a cell R<=c<2R and T<=|gamma|<2T, retain the exact conductor coefficient and bound H only over that cell and its actual arc interval. If H<=H_RT, Aplus's spectral contribution is at most

    H_RT * max_(R<=c<2R)[2c*M_chi,upper*sum_(r<=150000,c|r,odd squarefree)phi(r)^(-3)]
       * sum_(primitive chi in cell,rho in cell) m_rho x^(2beta-2).

The logarithmic derivative mass estimate, Mellin kernel cell bound, and family zero count are independent tasks. None is a restatement of Aplus.

Here is a useful calculus reduction for a candidate explicit density theorem. Suppose a proved density bound in this cell has numerical C,a and

    N_RT(s) <= C*B^(a(1-s)), B=(2R)^2*(2T), 1/2<=s<=7/8.

This is a model shape, NOT an available theorem. Stieltjes summation over beta gives, if 2log(x)>a log(B),

    sum_(beta>=1/2) x^(2beta-2)
       <= C * [2log(x)/(2log(x)-a log(B))] * x^(-1/4) B^(a/8).

The proof writes the sum as x^(-1)N_RT(1/2)+2log(x) integral_(1/2)^(7/8) x^(2s-2)N_RT(s) ds. The negative endpoint term can be discarded. Zeros left of1/2 can be paired by the functional equation with explicit constant loss. No claim is made that a=12/5 or any useful C has been proved in the local comparison library. The scoped PNTPort search found no such explicit family-density theorem.

This mechanism has a potentially useful conductor saving that mass-only estimates miss. Ignoring constants, a=12/5 would produce R^(.6) zero count growth against a roughly R^(-2) Aplus coefficient, before the mass log(R). Astar has analogous conductor weights. Upper N has no R^(-2) factor and is substantially harder, which motivates the Parseval alternative above.

As a conditional sensitivity check only, if the finite arithmetic inequality phi(r)>=(3/8)r for odd r<=150000 is certified, the individual Aplus coefficient is <40/c^2 after summing odd multiples. With a=12/5,T=32, the coefficient multiplying C*H_RT at x0 is about

    R=16:     2.07e-6,
    R=256:    8.86e-8,
    R=4096:   3.14e-9,
    R=65536:  1.05e-10.

These numbers omit explicit reflection and other cell-allocation losses. They are not achieved estimates. They show why a family-density theorem could help high conductors yet still leave small conductors as the bottleneck. Actual H_RT can be large near the Mellin stationary range; setting it to1 is unjustified. Large height cells need genuine transform decay, since the Plancherel-only H bound grows like gamma^2.

## Hybrid finite certificates and the real remaining theorem

A finite certificate need only exclude beta>=3/4 for selected small conductors and |gamma|<=T, rather than prove beta=1/2. The squared x exponent for these zeros improves from x^(-1/4) to x^(-1/2), an extra factor about2.125e-7 at x0. For star it improves by y^(-1/4), about5.623e-7. This is a substantial gain. The high-height tail still requires a certified weighted Mellin envelope, and high conductors require the density calculation above or another mean estimate.

The certificate must be checked in Lean or reduced to already proved analytic lemmas with exact finite computations. Merely renaming PlattGRH as a weaker finite-zero hypothesis does not discharge the goal. Old Qc/T tables used speculative envelope constants and the now-invalid larger budget; they are not usable certificate sizes for this blueprint. No adequate new cutoff has been established.

For Astar, exploit the actual Mellin transform of etaU and its delta/49 scaling, rather than reuse an etaPlus kernel constant. The zero-sum worker derived a possible exact formula from the eta2 log tent and Gaussian convolution and is handling the correlated mixed kernel. Cross is a same-modulus fourth moment over two character indices. A global density estimate alone controls only one of those two factors; the other needs local character information or a direct pair-density bound. See that worker's blueprint.

The precise missing second-moment theorem is an explicit family zero-density estimate WITH numerical constants and a certified cell bound for H_plus/H_star whose weighted sum fits the corrected caps. The currently available generic large sieve proves only a narrow high-conductor partial bound: the ACTUAL_ENERGY route at c>=149900 costs about8.14e-7 at x0, already more than the NEW entire Aplus' allowance5e-7. It cannot be combined with the corrected budget unchanged. The mass-only constant K85 also cannot supply the cubic estimate. These obstructions remain in force.

## Independent etaU base-gap path

Even successful Aplus/Astar/Cross bounds would not remove every Platt dependency. BaseGap2.norm_S_etaStar_le_gap243 is a separate minor-arc consumer. Its source uses y>=1e25, q<=300000, the delta range 4*300000/d, and E1=1e-17+4.7e6/sqrt(y) to obtain .0121*y. The symbol d here is the source denominator parameter, not the xOf denominator above. Its exact approximation/primitive-character hypotheses must be retained when replacing that lemma. The Moebius worker owns this audit. A cubic average does not imply the required base-gap pointwise or local bound.

## Proposed order of mathematical work

1. Prove the Fourier-tail/actual coefficient-energy bridges. They give the unconditional variable upper J(x), whether or not the sharper J<=10 route succeeds.
2. Complete the q=1 local kernel lemma for the lower-J minor-arc input. Keep it separate from principal cubic control.
3. Prove the weighted mass Cauchy-Schwarz/zero-cell reduction with the actual Mellin transforms and exact Gauss weights. This is ordinary analysis and exposes the genuine density constants.
4. Obtain a numerical family-density theorem and kernel-cell bounds, or a finite low-conductor rectangle certificate. Until then the corrected Aplus/Astar targets remain open.
5. Combine only with the zero-sum worker's independently sufficient Cross estimate and the base-gap replacement. Then prove major>=1.0404 and the new nonprime numeric lemma before claiming the large-case theorem.

At present there is no complete Lean blueprint with every analytic leaf discharged. The new useful route is the density-after-mass reduction plus the optional variable Parseval upper J. The unresolved leaf has been identified quantitatively rather than hidden in an assumption.

## Independent arithmetic review

The statement-audit worker checked the corrected J10 arithmetic with exact fractions. For Af=5.050000000000330e-7, B*Af<.0043466^2. For Qf=9.817952468e-7, 20*Qf<.0044313^2. Hence the total dynamic loss is <.0087779<.008778. The resulting major lower bound is at least1.040492451, above1.0404. The final .00009 reserve is exact. All older full-sufficiency claims in FULL_TRANSFER.md and the other historical budget notes are superseded by this corrected budget; their algebraic removal identities remain applicable.
