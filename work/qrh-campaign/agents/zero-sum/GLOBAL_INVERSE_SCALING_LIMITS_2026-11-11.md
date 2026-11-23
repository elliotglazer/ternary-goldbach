# Scaling limits of the tested global rational inverse

2026-11-11. Research only. This note uses the completed conductor-5 records and elementary operation counts; it performs no additional L-function evaluation, fit, contour scan or build. No frozen file is changed.

The conductor-5 experiment validates the certificate, but does not supply a production algorithm. Copying its fixed pole grid, dense fit and per-panel evaluation to production heights produces quadratic-size fitting arrays and quadratic-in-height rational-jet work. Even after replacing those operations, the first analytic gap is a bound on the size and approximation quality of an inverse candidate. The weak spectral target alone supplies no such bound. A production estimate obtained by multiplying the70-second pilot by a family size would therefore be unjustified.

## 1. What is established

The accepted complete run is `C5_CENTERED_COMPLETE_ATTEMPT_2026-11-11.md`, SHA256 `3DD9BBB44BF455FF0FDF812255180DBFE9205746674B3FF73BDE619AD15FFE77`, with independent review `moebius/REVIEW_C5_CENTERED_COMPLETE_ATTEMPT_2026-11-11.md`, SHA256 `E5CD912A809951BCF1BFD63C051C318DA50CE376BB28C904A6912ED42753A0CB`.

At conductor5, height12, the fixed385-pole candidate passed all1630 initial panels without refinement. The maximum scalar residual bound was526447087/1073741824<.491. The run took70.475 seconds after imports, of which69.839 seconds built models. The independent alternative also checked every panel. These facts concern exactly three primitive characters and the closed rectangle [111/200,2]+i[-12,12].

The candidate generator and complete-run programs were read. Their accepted mathematical background is `FAMILY_PRODUCT_CERTIFICATION_FEASIBILITY_2026-11-11.md` and the centered-model/width notes. The existing family baseline is `major-constants/FAMILY_BATCH_WORKLOAD_MODEL_2026-11-11.md`, SHA256 `3A5444AB295112E86DF0740DB8F4533EC37510A66E41EB0DF0340D16CF82A4E1`; the shared-transform plan is `JOINT_CHARACTER_FOURIER_BATCH_PLAN_2026-11-11.md`, SHA256 `3D41376E00A58D5EBC8403151807694163F0E59923869DCAAAB08F51A6A3625D`.

The selected nonprincipal family still consists of149999 conductors and5543640187 primitive characters. Conductor one remains separate. Every actual primitive zero, both ordinate signs, multiplicity and inclusive height Hcert(c) remain in the target. Here

    Hcert(c)=min(200+max(1000,ceil(704*1200000/(7*qt(c)))),10^8/c),
    qt(c)=c for even c, and2c for odd c.

No weighted-average substitute is used in this assessment.

## 2. The tested construction and its literal parameter growth

Write n=n(c) for the primitive count, v=phi(c), T for the chosen symmetric rectangle height, delta_p=1/16 for the pole spacing, and d=12 for the Taylor degree. The prototype fits one rational function per primitive character,

    B_chi(s)=b_chi,0 + sum_{j=-16T}^{16T} w_chi,j/(s-(1/2+i*j/16)),

when T is an integer. Thus P=32T+1 poles and P+1 coefficients per character. This formula describes the tested grid rule, not a theorem that P poles are mathematically necessary. For nonintegral T one would need to state the rounded pole range explicitly.

The c5 training grid uses a vertical spacing1/16 on both vertical edges and24 samples on each horizontal edge. Literal extension gives M_train=64T+48 rows. Validation doubles the sampling density, giving M_val=128T+96. The dense fitting matrix has M_train(P+1) complex entries shared across the characters, while the right-hand side and output have M_train*n and (P+1)*n complex entries. Full column rank in an ordinary determined least-squares fit requires at least P+1 independent rows; neither the count nor observed c5 rank guarantees conditioning or approximation quality at a new T.

The complete-run mesh has47 horizontal panels per edge and full vertical width1/32. At integer T its initial model count is

    J=128T+94.

Each model loops over all P poles and all n characters to form d+1 rational Taylor coefficients. Its explicit coefficient-product count is

    n(d+1)P*J,

before failed refinements, analytic error bounds, L-function jets or interval arithmetic overhead. This is quadratic in T with n,d and spacings fixed. Pole reciprocals can be shared across characters at a center, but the current coefficient accumulation remains character-dependent. Converting the n inverse functions to v group coefficients does not remove this issue; v is at least n and no sparse coefficient representation has been proved.

The dense fit itself allocates a quadratic-in-T matrix. Its actual NumPy factorization was not timed at large dimensions, and no measured asymptotic complexity is claimed. Replacing it by a structured solver would be a different implemented algorithm requiring its own correctness, conditioning and cost analysis.

These literal counts already prevent straightforward extrapolation:

| Conductor and reference height | Poles P | Initial models J | Dense training-matrix entries | Rational-jet coefficient products at d=12 |
| --- | ---: | ---: | ---: | ---: |
|c=4,T=25000001,n=1|800000033|3200000222|1280000144000003808|33280003681600095238|
|c=5,T=12068773,n=3|386200737|1544803038|298302037056321760|23267558800022121234|

These heights are T0(c)=floor(Hcert(c))+1, not new certified ranges. The counts assume the entire initial mesh is evaluated; early stopping would save work by leaving the task incomplete. They are consequences of the prototype's loops, not lower bounds on every possible certificate method.

The accepted family arithmetic gives sum_c n(c)T0(c)=5392479925954 and sum_c n(c)=5543640187. Therefore copying the same pole grid throughout the family would store

    sum_c n(c)(32T0(c)+2)=172570444910902

literal complex coefficient slots. Encoding each merely as a16-byte floating center would already use2761127118574432 bytes, about2.76 decimal petabytes; that is an illustrative encoding cost, not the size of a rigorous rational certificate or a lower bound against compression. Exact coefficients, metadata, interval precision and replay data are additional. No such arrays were generated.

## 3. Why pole count, sampling and precision have no proved uniform choice

The certificate checks r_chi=1-L_chi B_chi. A sufficient construction would have a uniform residual slack mu>0, meaning sup_boundary |r_chi|<=1-mu for every retained character. The c5 value below.491 supplies substantial slack there. It supplies no slack at another conductor or height.

The target Re(rho)<=111/200 permits zeros exactly on that boundary. A closed right-rectangle inverse certificate cannot exist if such a zero lies in its height range. Even if all those zeros lie strictly left, the target gives no quantitative separation from the boundary. This is the first obstacle to a guaranteed cost bound, before choosing numerical precision.

A simple analytic example isolates the issue. Let f_epsilon(s)=s-(111/200-epsilon), epsilon>0. It is zero-free on the closed right rectangle and has uniformly bounded magnitude on any fixed rectangle. If |1-f_epsilon B|<=eta<1 at s=111/200, then |B|>=(1-eta)/epsilon there. For candidates with all poles on Re s=1/2,

    |B(111/200)| <= |b0| + (200/11) sum_j |w_j|.

Hence the coefficient norm must grow without bound as epsilon tends to zero. This is an analytic counterexample to obtaining a uniform inverse-norm bound from zero exclusion plus an upper-growth estimate alone. It is not a constructed Dirichlet L-function or a claim that the actual family realizes this behavior. Adding a reflected factor can impose the corresponding s to1-s symmetry without removing the inverse-norm issue.

The actual source bound for nonprincipal L-functions, `Explicit/LGrowth.lean:179`, is an upper bound |L(s,chi)|<=(c+1)|s|/Re(s) on Re(s)>0. It supplies no lower bound at the target boundary. The finite family may have a positive actual minimum if the stronger closed-rectangle assertion holds, but its existence does not provide a usable numerical value or precision budget.

Fixed simple poles on a regular line also do not come with an approximation theorem guaranteeing the required residual slack at fixed spacing1/16. Increasing precision alone cannot improve the best approximation in a fixed finite rational space. More poles, closer spacing, repeated poles, different poles or smaller independent domains might be required. None of those growth rates is determined by the successful c5 fit. The sampled c5 validation was not its proof; its complete interval check was.

The training matrix's smallest singular value and the coefficient norms are separate unknowns. The c5 generator found a full-rank386-column fit with moderate coefficients. It does not follow that the corresponding higher-dimensional matrices are uniformly well conditioned. Large cancellation in a fit can produce large exact rational coefficients even when the candidate values are moderate, increasing both storage and verification precision.

## 4. Explicit conditional bounds expose the missing quantities

Let W_chi=sum_j |w_chi,j| and Delta=11/200, the minimum horizontal distance between the tested pole line and the right rectangle. On its boundary,

    |B_chi| <= beta0_chi=|b_chi,0|+W_chi/Delta,
    |B_chi'| <= beta1_chi=W_chi/Delta^2.

The degree-d candidate Taylor remainder on a disk of radius rho<Delta is at most

    W_chi*(rho/Delta)^(d+1)/(Delta-rho).

The observed pole clearance therefore allows a fixed geometric disk radius, but does not allow a fixed d or error budget unless W is controlled. For required remainder epsilon_B, this sufficient rule requires

    (rho/Delta)^(d+1) <= epsilon_B*(Delta-rho)/W_chi.

At fixed rho/Delta, the degree needed by this rule grows logarithmically with W/epsilon_B. This is a property of the bound, not a proof of the optimal approximation degree.

A coarse source-backed derivative budget is also explicit. On the radius1/4 neighborhood of the rectangle let

    M=(c+1)(T+3)/(111/200-1/4).

The actual L upper bound gives |L|<=M there, and Cauchy gives |L'|<=4M on the rectangle. Consequently

    |r_chi'| <= 4M*beta0_chi + M*beta1_chi.

If a candidate's positive slack mu were known, this gives a conditional small-panel rule of order h<mu/(2 sup|r'|), with another mu/2 allocated to numerical error. The resulting bound can be very pessimistic, but it identifies genuine input quantities: coefficient norm, conductor/height upper growth, and residual slack. Without bounds on W and mu it is not a production estimate.

The exact verified error decomposition is

    E_res <= E_L*(B_poly_bound+E_B)+G_poly_bound*E_B,

plus rounding retained in the coefficient balls. Thus large inverse values require small absolute L errors. If each of P+1 candidate coefficients has absolute error at most2^(-p), a simple value-error bound is

    (P+1)*max(1,Delta^(-1))*2^(-p).

Under a relative-error model, the analogous condition depends instead on |b0|+W/Delta. Both require explicit precision allocation. Holding192 bits fixed because it worked at c5 is not justified. Exact binary-rational coefficients avoid uncertainty about the candidate's definition, but evaluating their large/cancelling sums still requires adequate arithmetic precision.

Increasing n introduces another choice. A sufficient uniform scalar residual bound eta gives the primitive group l1 estimate at most sqrt(n)*eta, by Parseval and Cauchy. The alternative2k-th moment bound is at most n*eta^(2k); choosing

    k > log(n)/(2 log(1/eta))

removes that particular dimension loss. This does not bound eta or the cost of producing the residual enclosures. The successful c5 run used l1 everywhere; it did not demonstrate a high-conductor moment advantage.

## 5. The L-evaluator is another changing parameter

The c5 implementation uses N64,M20 Euler-Maclaurin. With M fixed and |s| about T, its explicit remainder contains product_{j=0}^{39}(|s|+j). For a general conductor the conservative per-character estimate from v Hurwitz components has the form

    E_EM <= 4*v*c^(-sigma0)*(T+42)^40
             / [6^40*(sigma0+39)*N^(sigma0+39)],

Here42 covers the rising-factorial offset39 and the bound |s|<=T+3 on the control disks, and N is a positive lower bound for the shifted summation endpoints. This displayed sufficient bound cannot stay small with N64 and growing T. Solving it for N makes N grow on the scale (T+42)^(40/(sigma0+39)), times conductor and tolerance factors, if M20 is retained. Increasing M is another algorithmic choice, not a cost-free repair.

The finite exprel approximation also depends on (|s|+1)*|log(B_r/B_1)|; its degree18 was not established uniformly for unchanged N at production heights. Actual-L/finite-g separation, changed disk floors and negative-log initial terms must all remain in the error contract.

The accepted Gaussian/Fourier and modular-bucket plans could replace this expensive L evaluation while preserving the final residual certificate. That would address a different cost term. They do not automatically remove the global rational fit's quadratic data structures or the loop over every pole at every center. No end-to-end implementation of such a combination is assumed here.

## 6. Consequence for the next architecture decision

There are two distinct conclusions.

First, the literal global c5 construction is not a credible production design at Hcert. Its dense fitting matrix becomes enormous even for c=4, and its validation performs quadratic-in-height pole accumulation. This follows from the fixed algorithm, without any guess about hardware speed or the difficulty of the actual zeros.

Second, no impossibility theorem for aggregate inverse certificates follows. A structured fit or multipoint rational evaluator could avoid literal matrices and repeated sums. But that would require a new checked algorithm and error analysis, and the exact coefficient data still need a manageable representation. Dropping distant poles would require a proved bound on their coefficient-weighted tails; the current fits supply no such decay theorem.

A more direct way to remove the global-height dictionary is to use separate bounded-height closed rectangles, each with its own holomorphic inverse candidate. The previously accepted closed-slab assembly can combine their zero exclusions, including overlaps and real-axis seams. One must not glue inverse functions or image polygons from different slabs as if they were the same analytic function. This would change the global witness architecture, while retaining the same local residual theorem. It would still need high-height L evaluation and evidence for local inverse norms/slack. No constant-cost-per-slab assumption is warranted from c5.

The next useful research question is therefore an a priori or measured bound on LOCAL inverse complexity and residual slack, together with a certified shared evaluator at the actual height. Another low-height success with one much longer global pole grid would not resolve the first obstacle. Until these parameters are controlled, report costs as functions of n,v,T,P,d,coefficient size,precision and certified slack, rather than as an asymptotic runtime or a projected number of core-years.

All arithmetic totals above come from the pinned workload sums and elementary substitution into the tested loops. They are not new family enumeration or spectral computations. No conclusion about the truth or falsehood of the remaining finite spectral assertion is obtained.
