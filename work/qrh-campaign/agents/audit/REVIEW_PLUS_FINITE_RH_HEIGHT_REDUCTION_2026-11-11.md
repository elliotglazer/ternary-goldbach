# Review of the reduced plus finite-RH heights

2026-11-11. PASS at conditional source and paper scope. The proposed profile preserves the old nonprincipal plus bound throughout the stated conductor, twist and scale domains. No correction to the frozen author note is required. This review does not establish a finite-RH instance, a whole-family cost saving, or a completed Lean replacement.

Reviewed author: `major-constants/PLUS_FINITE_RH_HEIGHT_REDUCTION_2026-11-11.md`, SHA256 `3F91F39B485607833A5FADD061BEC7602B1DCC02C77B8FB82CA10B6C076FA6A0`.

Author scalar script: `plus_finite_rh_height_scalars_20261111.py`, SHA256 `734DB06EE8574E090A4DE2B214B8BA8FC0445A7A07E6481E9774F492052C67DE`. Author receipt SHA256 `E76E705AD47465021709985BEC1A2A025573C07BD1F9188B1648A984654713D9`.

I read the complete author note and the source bodies listed below, then independently recomposed the rational bounds. No author code was imported or executed. No analytic function, L-function, zero, prime or transform value was evaluated, and no Lean build or source edit occurred. Frozen predecessor files were preserved.

## Exact accepted implication

Fix R=132900. For each primitive nonprincipal character of odd conductor c<=132900 or even conductor c<=265800, require actual `GRHUpTo chi Tplus(c)`, with

    d_c=1063200/qt(c),
    qt(c)=c for even c and 2c for odd c,
    u_c=19.89 for even c>60000, and 23.3 otherwise,
    Tplus(c)=ceil(200+max(260,u_c*3.1416*d_c)).

The ceiling is exact rational arithmetic. Then for every real x>=4.9e26 and |delta|<=d_c,

    ||Schar chi (Lambda*etaPlus(./x)) (delta/x)||/x
       <=(7.5e-8+7.7e6/sqrt(x))/sqrt(c).

The principal c=1 input remains RH through 10^8. This is an explicit finite-RH implication, not an assertion that the new hypothesis has been verified. The author quantifies over all even conductors, so the proof does not silently omit c=2 mod 4. If a later certificate enumerates only conductors divisible by four, it must separately discharge the impossible-primitive cases.

`MajorArcs/GRH.GRHUpTo:32` includes every actual zero with 0<Re rho<1 and |Im rho|<=T. Thus height equality and real-axis zeros are retained. No simplicity assumption, zero-table convention or off-line count is inserted.

## Source dependence and low-zero monotonicity

`Prop942.prop_9_4_2:76` consumes exactly an explicit `GRHUpTo chi T0`, together with T0>=200+max(10*pi*|delta|,50). The proposed Tplus satisfies this since Tplus-200>=260 and u_c>=19.89>10. `Explicit/EtaPlusBound.norm_SsumG_fP_le:153` confirms that this is the finite low-zero premise; its complementary tail covers the full nontrivial strip. It does not request the old-height RH statement or a global .555/7/8 hypothesis.

The scalar `E1g` at `ZeroSumGen:191` is

    ZLg(BP c,T)*[(1/3.48)*sqrt(Q1*2*Jl(T)*3.48)
                  +sqrt(Q2*2*Jl(T)*3.48)],
    Q1=2*pi*.6403, Q2=2*pi*1.129.

For nonnegative T, the explicit BP polynomial is nondecreasing, its logarithm and ZLg are nondecreasing and nonnegative, and Jl(T)=floor(T/3.48)+1 is nondecreasing. All product and square-root factors have the required sign. Consequently E1g is nondecreasing in T. Lowering T therefore lowers this bound; no comparison between actual zero sums is assumed.

I checked both branches of the ceiling against each applicable original endpoint. Writing A for the corresponding numerator u_c*3.1416*531600 or u_c*3.1416*1063200 gives

    Tplus < max(461,201+A/c).

The four whole-range tests in the author note imply Tplus<Hold. These tests cover the full unit ceiling overshoot, not just the unrounded height. For c>125000 even, they compare with 200+75e6/c; elsewhere they compare with 1e8/c. Endpoint monotonicity in c makes this a proof for all conductors in the stated ranges. The saved examples are diagnostics only.

The old scalar E1 endpoint bounds remain legitimate because `E1P_le:247`, `Cor713.ZL_le:344` and `Thm714.ZL_R3_le:314` do not assume RH. Their constants give

    K1=145.21*(28515/3.48+37864)<7.66e6,
    K2=143.21*(33086/3.48+43934)<7.66e6.

The same positive BP comparison gives Z3g<=177.26; for high even conductors the old scalar bound is the stronger 174.82. Neither use of an old endpoint imports the old spectral hypothesis. The resulting E1<=7.66e6/sqrt(c) is valid under the new profile.

## The high-zero, origin and vertical terms

The actual `Prop942.errP:50` retains four terms. Its origin term uses Z3g(BP c,0), and its vertical term uses DN(c), thP(delta), and x. Neither depends on T0. All their source bounds in `Thm714.errP_le_of:430` remain valid because c<=300000, |delta|<600000 and x>=4.9e26 still hold. Each contributes at most 1e-17/sqrt(c). There is no unexamined T0 dependence in these two terms.

E2 is not monotone by simple inspection: lowering T changes both tail amplitudes and count constants. I therefore checked the new application of `E2_gen_le:101` rather than inheriting the old E2 result. Its common choices are

    T1=260, Z=177.26, C=.09, EBb=.892*260/2^59.

The condition 11*4.4<=.09*460*1.2039 proves the c3g bound for every Tplus>=460. The EB bound follows from exp(.7)>2, .1598*260>59*.7, and the source monotonicity of t exp(-.1598t) for t>=260. This accounts for the actual shifted amplitude EB(Tplus-200).

For the other shifted amplitude, the height definition gives u_c<=(Tplus-200)/(pi*|delta|) whenever delta is nonzero. At delta=0 the source EA branch is zero. The source `EAb_233:204` and `EAb_1989:199` provide the exact exponential-series bounds 6e-23 and 1.2e-16. I read their proofs and checked their final rational products; no decimal exponential evaluator was substituted.

Both geometric denominators are included. The inverse for rhoB is at most 2.1768. `IA_le:210` supplies at most 222000 for the first row using |delta|<600000, and 8.77 for high even c using |delta|<20. The common prefactor Cg*(2*aH)<=129.24 is retained. Independently expanding the source expression gives exactly the two saved rational E2 bounds, both below 1.12e-10. Finally,

    547.73*(1.12e-10)<6.9e-8.

Thus every premise of `errP_le_of` holds with the new Tplus. The proof is uniform in x over the unbounded stated range. No high-zero multiplicity or Mellin phase is discarded.

## Primitive-to-ambient transfer

For an ambient q with qt(q)<=265800 and |delta|<=1063200/qt(q), source `ArcChars.arc_chars:350` uses the primitive character inducing psi inverse, with c=conductor(psi inverse). If c is even, q is even and c<=q=qt(q). If c is odd, the divisibility and parity argument gives 2c<=qt(q), including when q is even. Hence qt(c)<=qt(q) and the ambient twist lies in the primitive d_c range. The conductor cutoffs follow from the same inequalities.

I checked the actual source transfer at `ArcChars:378-440`: c divides q, the primitive character is indeed primitive, `conductor_inv` identifies the Gauss norm's conductor, and

    ||tau_q(psi)||<=sqrt(c),
    ||Schar(psi inverse,coprimePart(q,cP x))||
       <=||Schar(chi,cP x)||+1e-15*x.

`err_scaled_le:324` then gives 4.25e-7*x, unchanged. The principal character is excluded before this step, so c=1 does not enter the nonprincipal profile. Vanishing Gauss sums need no artificial support exclusion.

Character Parseval includes the factor 1/phi(q). There are at most phi(q) nonprincipal character terms. Therefore the retained per-character weighted bound yields the normalized nonprincipal energy at most (4.25e-7)^2=1.80625e-13, rather than that number multiplied by the character count. This is stronger than 7.02e-13. The principal error still comes from the separate principal RH input and the same removal bound. On this exact ambient domain the old arc-energy and plus residual inputs can be kept.

This transfer is a localized replacement of the relevant source calls. Invoking the old `thm_7_1_4_odd/even` wrappers with their broad `Fact PlattGRH` would retain the old requirements and would not implement the reduction. The review does not assert a closed transitive theorem graph or authorize that refactor.

## Limits and certification union

The profile is genuinely lower for the plus subproblem. It is not by itself an end-to-end certificate saving. Untouched Cor713 star/base-gap consumers can still require 1e8/c. Other proposed star or base-gap reductions must be independently joined, with their exact spectral properties as well as heights. A maximum of heights alone does not identify a weaker strip condition with RH. The author's union warning correctly preserves this distinction.

No actual finite spectrum, sign saturation, Turing guard width, proof size or runtime is certified. Principal RH through 10^8, all other consumers, finite arithmetic and compatible kernel validation remain separate. The final Goldbach statement and its original binary input are unchanged by this conditional source result.

## Independent receipt and pins

Own script `review_plus_height_checks_20261111.py`, SHA256 `A3530EA9B20180B40298622B05BAAEC0209854E3168E717380F9A34B1EF6BE11`, performs 53 exact rational and saved-metadata checks. It recomposes E2 with a separately factored formula, verifies ceiling endpoint inequalities and all 11 saved examples, and checks K1/K2 and the energy comparison. It does not run the author script or evaluate any analytic function.

Own receipt `review_plus_height_checks_20261111.json`, SHA256 `EDFA605B0BAC772ED123D0AF99DE12FADFB720E1FB0F997D3E65BF920FA13C80`.

The seven author source pins and both cited direct-plus author/review pins match. The independent receipt additionally pins `ZeroSums.lean` and `GRH.lean`. Source paths below are relative to `work/ternary-goldbach/TernaryGoldbach`.

| Source | SHA256 |
|---|---|
| Explicit/ZeroSumGen.lean | 9096C5D611A09FFCF5A4516BFDDC1E518B9917C52B5BC206216AF86A31A52389 |
| Explicit/ZeroSumBound.lean | A1294627F676EC49BED1BD86407A9460DC569B77AF8CBE8D65F1F49129BF17D4 |
| Explicit/ZeroSums.lean | 3E5CD828CC6ADD2AF6D17F03F97E65F15720AEAF907826847EF191DEA8BCB72D |
| Explicit/EtaPlusBound.lean | 8A0D0BE027F1560321D3AB4088C49768D0DE3E18D92A074823679A71AD043695 |
| MajorArcs/Prop942.lean | 35B170971DBD0F1C6646CD86ECE8C3A86021085C1B07730141CD6311D9CA5716 |
| MajorArcs/Thm714.lean | 7BBF8F06B1A0B703A0C00FF1E5E64997792C4E93629CED591FCB6A646301FD3F |
| MajorArcs/Cor713.lean | 11325BE6F77A7A762747542F30E2A9035782765A801C603F14107E84ED5D7433 |
| MajorArcs/ArcChars.lean | 0A5BA0770CC02C94C0A802FF78FC297FE7B5776153516033ECC189331A6041CF |
| MajorArcs/GRH.lean | 89C6DF8490955EEA8F4141498BCA6D163355C2E7765C9ECD09F8CEE5B257A070 |

The author note's few approximate line offsets do not change the referenced declarations; exact EA declaration lines are 199 and 204 in the pinned `Thm714.lean`. All mathematical references used for this review resolve in the pinned files.
