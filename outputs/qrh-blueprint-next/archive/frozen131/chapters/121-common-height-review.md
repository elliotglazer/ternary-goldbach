# Independent review of the common-height major-family proposal

2026-11-11. Verdict: **PASS as a conditional paper argument and exact finite scalar certificate.** No defect was found in the reviewed high-tail aggregation or complete mixed-error ledger. This is not a finite zero certificate, a Lean theorem, or a change to the selected/frozen blueprint. No Lean process or canonical source edit was used.

## Exact reviewed inputs

All paths in this table are relative to `work/qrh-campaign/agents/major-constants/`.

| File | SHA256 |
|---|---|
| `RESUME_COMMON_HEIGHT_MAJOR_2026-11-11.md` | `79833f8d5d5856e000a96d3f5cca9fc9e26cb3baf637cde089fefdd703436ba7` |
| `resume_common_height_major_20261111.py` | `3c82d0b914f5569c8d0fb3b3d5f0092773886d0c412257f2999208ee242f6390` |
| `resume_common_height_major_20261111.json` | `981a924b548dfd6b012455e9d79ebb190c0fa1db9fccb6dfeb55a5df6ce362e5` |
| `resume_common_height_major_20261111_cells.json` | `27308326ba94ba838f3ceb38c764398f88896da8eb4c8d65bff1075cdc56fc42` |

The actual Lean sources inspected are in `work/ternary-goldbach/TernaryGoldbach/`, at the report's source pin `23b2d68ca344203d4384e0aff7affa4ec034bef9`. The independent replay is `review_common_height_new_20261111.py`, beside this note; its output is the same stem with `.json`. It reads the producer inputs and writes only its own review output. The previous frozen 104-chapter package remains unchanged.

Pin history: the full arithmetic replay first checked note hash `721cb62bd232305ba3dbc69c751f9f21816e0384c48a738a430017a53b67a9bf`. The producer then appended only the minimum-height corollary. Its final hash above was separately checked, and the corollary was reviewed directly. All three arithmetic input hashes are unchanged. A final full independent replay against the final pins exited0 in28.43 seconds, including the minimum-profile cutoff inequalities for every active conductor.

## Finite-domain and source checks

The new **unproved** premise is that every nontrivial zero of every active primitive character satisfies beta<=111/200 through the inclusive, exact rational height 100000000/c. Active conductors are odd c<=150000 and c divisible by four with c<=300000. The corresponding active moduli are odd q<=150000 and even q<=300000. Global beta<=7/8 controls the remaining zeros. These inputs are not inferred from a published computation or assumed finite RH.

The actual low cutoffs are min(old plus cutoff,100000000/c) and min(old star cutoff,100000000/c). This matters: the old star floor1000 exceeds the common height for c>100000. The final report does not consume that unavailable finite information. It retains the old star **count proxy** as an upper bound for the smaller low set. It also correctly distinguishes hereditary positive/count/operator envelopes from false monotonicity of a signed zero sum under deletion.

At c=1 both consumed cutoffs are the old ones. The full common certificate asks for more principal height than the major argument consumes; it is not a pointwise reduction of every old requested height. Principal pole subtraction remains part of the reviewed explicit-formula interface. No pole is counted as a nontrivial zero.

The final appended corollary correctly removes that unnecessary extra finite information: it suffices to certify beta<=111/200 only through Hcert(c)=min(Hp_old(c),100000000/c). Indeed Hp=Hcert and Hs<=Hcert because Hs_old<=Hp_old. This weaker premise leaves every reviewed number unchanged and is pointwise no larger than either old Hp or the common height. At c=1 it is60343058. Compatibility with base-gap and the separate principal-psi low-zero refinement still uses their own stated inputs; neither is silently obtained from this major-family audit.

`Explicit/EtaPlusMellin.lean` gives the actual convolution with Gr(s-1+2*pi*i*xi,delta,0). Both the real shift beta-1 and the frequency normalization are retained. The central/outer split is **|2*pi*xi|<=100** and **100<|2*pi*xi|<=200**, not a split in |xi|. The source shifted-height proof at lines286-307 gives the same floor index based at H for both pieces, using Gaussian base heights H-100 and H-200 respectively.

The source second-derivative energy in `MajorArcs/HHFourier2.lean:195`, together with the Fourier derivative and Plancherel argument at217-269, yields

    integral_(|2*pi*xi|>A) |ghat(xi)| <= sqrt(368/(3*pi*A^3)).

The factor1/(3*pi) is correct. The inner Fourier bound is `norm_fourier_gC_le`, with `EtaPlusCg.Cg_le` giving2.03. Splitting the full Fourier L1 integral at frequency3 proves

    total mass <1.94+1.203<3.5.

At frequency100, pi>3.141 proves the outer mass<.00625. Pi>3.14 alone would not prove that last decimal. The final producer uses the sufficient bound. These integral consequences still need exported Lean lemmas; their source ingredients do not already amount to a compiled replacement theorem.

The Gaussian admissibility condition H-200>=max(10*pi*Dc,50) holds. In particular the worst even common-height endpoint follows from

    100000000-200*300000-12000000*(22/7)>0.

`ZeroSumGen.count_tail_windowG` counts both signs and all multiplicities. The correct window base is H, not H-100 or H-200. With the retained source polynomial/count bounds, the geometric factors are GB=2400+954/H and GA=800G+106G^2/H, G=3+D/2.7. The report uses these factors without a zero-spacing or simple-zero premise.

## Independent arithmetic and true Gauss weights

The replay independently re-bounds **all5303 cells** using longer positive rational Taylor sums:24 terms beyond the constant for exp(1), and20 beyond the constant for the residual exponent. Both are lower bounds for the positive exponential, hence their reciprocal is an upper bound for the required negative exponential. All acceptance comparisons are exact fractions. The replay verifies every producer cell numerator is at least this independently obtained upper bound.

The corner choice H=Hp(hi), D=D(lo) is valid within each parity class: both cutoff branches decrease with c; GA and GB increase when H decreases; and the Gaussian envelopes decrease in their admissible height or height/twist ratio. Capping the height at2000 or the ratio at40 decreases the input to a decreasing function and therefore enlarges the upper bound. Cell coverage is contiguous for every odd conductor through149999 and every multiple of four through300000.

Primitive character counts were independently reconstructed by divisor inversion of phi(n)=sum_(d|n) a(d), instead of the producer's prime-power formula. This yields150000 active conductors and5,543,640,188 primitive characters. For every active q, the replay checks

    sum_(q=cr, mu(r)^2=1, gcd(c,r)=1) c*a(c) = phi(q)^2.

Thus each induced character's actual Gauss norm squared is c, with the vanishing cases excluded. Neither a primitive-only Gauss rule nor an additional conductor denominator has been inserted.

Let Tq bound the pointwise plus-tail energy and Sq the full-delta integral of the low star energy. Their factors c*a(c)/phi(q) and the star dilation49 are correct. The mixed quantity is sum_q Tq*Sq: it keeps the same q and both character indices. It is not a product of independent all-modulus averages. The exact independently reproduced aggregates are:

| Quantity | Exact upper bound | Decimal display |
|---|---|---:|
| sum_q 2Dq*Tq | 5217686454735567/250000000000000000 | .020870745818942268 |
| sum_q Tq*Sq | 1689410003000861169/80000000000000000000000000 | 2.1117625037510765e-8 |
| Aplus high energy | 60793/(5*10^29) | 1.21586e-25 |

For Aplus, the weight mu(q)^2/phi(q)^2 is present in addition to Tq's existing1/phi(q). Its Fourier factor min(381.22,2Dq*1.2534^2) is justified by `MajorTotal.lean:453,469`:381.22=49*7.78. This squarefree-modulus restriction removes the large even primitive-conductor tails from Aplus. It does not remove them from N or Cross.

The new star branch has c>100000, old Hstar=1000, Hstar>=1000/3, Dc/49<=12/49 and G<3.1. The independent rational Gaussian check gives a tail below the producer's rounded7.884113587e-21 bound, hence below1e-18. The old star branch retains its reviewed tail. The available total star error2e-12 remains sufficient after adding the contour and coprime corrections.

## Complete mixed ledger and all-scale conclusion

Write the actual plus vector as low plus + high tail + error, and the actual star vector as low star + error. In the product space the difference from low plus tensor low star has exactly five types:

    high plus * low star,
    plus error * low star,
    low plus * star error,
    high plus * star error,
    plus error * star error.

The first norm is below.00016 because its squared norm is bounded by the mixed aggregate above. For d0=2e-15 and dstar=2e-12, the other four norms sum to at most

    d0*55000+dstar*25+dstar*87+d0*dstar*180000000000
      =4175009/12500000000000000
      =3.3400072e-10.

The newly necessary dstar*87 term uses87^2>300000*.025. Omitting it would leave the star-error times plus-tail term unbudgeted. The retained55000,25 and180000000000 factors follow from the old low second moments and direct-sum measure bounds. No J bound is used to prove itself. The low mixed norm.0005 still requires the previously reviewed factor25 product-space estimate; separate per-leg L2 estimates would not supply it.

Consequently the full mixed norm remainder is below.000160001, **not** the former2e-10, and

    Cross <4.356004408810620e-7,
    Astar <2.4127744e-7,
    Astar+Cross <6.768778808810620e-7 <9.5e-7.

The other producer bounds independently satisfy Aplus<5e-7, N<1.23 and Ep<1e-4. The principal cutoff is unchanged, so its old high-tail estimate still applies to Ep; the large even-conductor tails are not charged to that principal term.

All stated envelopes apply for every x>=49*10^25: the low estimates have decreasing powers x^(-.89) or y^(-.89), the absolute high-tail estimates have decreasing x^(-1/8) or y^(-1/8), and the twist ranges are the fixed source Dq. An inducing primitive conductor has Dc>=Dq on every Gauss-active lift. The aggregate coefficients are nonnegative, so endpoint bounds persist. This uses the existing uniform explicit-formula remainder and good-height limit bridges, not a numerical scan in x or delta.

## Limits of this pass

The review accepts the revised high-tail and full remainder argument conditional on the previously reviewed low-zero Gram/product-space and explicit-formula inputs. It does not reprove all those earlier analytic lemmas. It supplies no finite spectral nonvanishing/completeness certificate and does not verify the global QRH input. Formal extraction of the Fourier L1 split, the tail/limit transfer, the exact Gauss and character arithmetic, and the final Lean replay remain work. Base-gap compatibility is a separate review, not a conclusion of these major-family calculations. No existing frozen profile was adopted or altered by this audit.
