# Four-band common RH assembly without the direct B theorem

2026-11-11. Conditional paper assembly, pending independent review. No spectrum, numerical analytic values, new Lean declarations or builds are supplied.

The reviewed four-band plus-height theorem can replace the earlier common Tplus profile without requiring the new direct B<1915 theorem. Its ordinary RH certificate already supplies the stronger, separately reviewed spectral star estimates. The original relaxed aggregate assembly is sufficient to join the components. This avoids making the conservative computational comparator depend on additional direct-sieve proof work.

Fix R=132900 and x=49y>=4.9e26. On primitive nonprincipal conductors odd1<c<=R or4|c<=2R, put D_c=1063200/qt(c), and

    H4(c)=ceil(200+max(255,3.1416*u(c)*D_c)),
    u(c)=23 if c<100,
         21.5 if 100<=c<1000,
         20.5 if 1000<=c<10000,
         19.5 otherwise.

Assume actual ordinary finite RH through H4(c), with the closed absolute-height convention. All inverse characters and true multiplicities are retained. Empty primitive families at exact2-adic valuation1 are excluded only by the unit-group factorization proof. Principal RH through1e8 and all previously retained principal/head/finite arithmetic remain separate.

The source theorem COUPLED_PLUS_HEIGHT_CUBIC_BUDGET and its independent review prove the ambient, already Gauss-weighted coprime coefficient bound5e-7, including the primitive-to-ambient and inner-removal arguments. Therefore Eplus<2.5e-13. This is stronger than the relaxed7.02e-13 input of the existing three-aggregate assembly. The author's stronger full radius5.75e-7 is also below the retained8.85e-7 radius. Hence the earlier residual integration, X/x<8.79 and integrated principal norm1.902e-6 all apply. No old upper-J wrapper tied to the smaller original coefficient4.25e-7 is invoked.

The same reviewed theorem establishes Hbase(c)<=H4(c) and Hstar(c)<=H4(c), where

    Hbase(c)=ceil(27e6/c) for odd c, ceil(54e6/c) for4|c,
    Hstar(c)=ceil(max(300,(704/343)*D_c)).

The inequalities hold before the monotone ceilings. Both height and spectral strength are transferred: ordinary RH restricts to ordinary RH, and implies beta<=.5075 at squarefree conductors and beta<=.62 at nonsquarefree conductors. The complete star carrier remains the one through Hstar, not all zeros through H4.

The independently reviewed floor300 star proof consequently gives A<4e-12 and B<42. This uses the full star zero statistic and its full-strip high tail. It includes all actual nonprincipal families, Gauss weights, removals and true orders. It does not need the direct-sieve B bound. Inserting these into the previously reviewed weighted-principal allocation A<=4e-12,B<=62 and the retained rho8.85e-7 proves the full Wstar hypothesis of the old integrated cubic assembly. The smaller actual rho may be weakened monotonically to that retained radius. All normalized squared quantities are nonnegative.

For the base gap, ordinary RH through Hbase supplies the separately reviewed error bound .024547036<.03<ghatY(y,R), uniformly in y>=1e25. It is the original character modulus and displacement from the parity-specific gap argument. This bypasses the old .014 intermediate guard and does not identify the base-gap twist with the49-times smaller major-star twist.

Thus the three aggregate premises of the earlier common-RH assembly hold with their original allowances. The exact cubic identity, Fourier tail, principal lower-J projection, source-mass checkpoint, nine minor cells, asymptotic branch, singular-series loss and nonprime subtraction remain unchanged. In particular its final conditional coefficient is still

    17454234627055702473150105611895106422794893597
    /12867056213564954145112500000000000000000000000000
       >.0013565,

with the same N0=989*10^24 and xOf relation. No extra reserve is claimed or spent. This is a conditional large-N argument, not an evaluated representation count or a full unconditional end theorem.

The current source refactors, principal RH/head certificates, finite arithmetic, inclusive binary input through4e18, prime ladder and overlap, auxiliary zero-count certification, and Lean/MM0 foundations/implementation remain open. The four-band cost inventory is independently reviewed separately; this mathematical join does not assert a runtime ratio. The newly derived tighter line-star budget is also unnecessary for this join, although useful for future lower-height candidates.

## Evidence pins

All paths below except the root directory are under work/qrh-campaign/agents.

| Artifact | SHA256 |
|---|---|
|major-constants/COUPLED_PLUS_HEIGHT_CUBIC_BUDGET_2026-11-11.md|6767F9E14E5B6D7264D972085EA9C70359C87544403D37DAE315CBEF2510FC54|
|zero-sum/REVIEW_COUPLED_PLUS_HEIGHT_CUBIC_BUDGET_2026-11-11.md|A410B45323B9EB77E006E6E47403C6C4A8EC69E2E59E6C66FF44089E80FED6A5|
|independent-feasibility/GLOBAL_FINITE_RH_TPLUS_PAPER_ASSEMBLY_2026-11-11.md|24E1A29A0FEAFFA297159DAE04CDD0613C5A38757F5F44B63B01A2B5E5D1280A|
|moebius/REVIEW_GLOBAL_FINITE_RH_TPLUS_PAPER_ASSEMBLY_2026-11-11.md|8F5F58CEB40A60B770884346397BCCA458825C65874F05B6373A17E5959097A5|
|moebius/REVIEW_WSTAR_LOWER_FLOORS_AND_SQUAREFREE_PROFILE_2026-11-11.md|422940369A04ED695A45EF28F20F154349932CEBC0242EEEE15FF3373D5CE6A4|
|integration/REVIEW_BASE_GAP_REDUCED_FINITE_RH_HEIGHT_2026-11-11.md|2E902497CE7445F78CEF7A2F229D0A9042FAF4FB573AB1A01B79D05331635076|
|prime-estimates/REVIEW_WEIGHTED_PRINCIPAL_WSTAR_BUDGET_2026-11-11.md|52C3D991DE018E5B21682DD498819A5DDC66BDE484A43969DDB54026CE4E40D5|

The new assembly is a monotone substitution of independently reviewed inputs. Its review must check this does not silently preserve the direct B hypothesis from the four-band author's chosen cubic allocation. Only the author's plus-error and height-dominance conclusions are used; its separate A9e-12/B1915 route is not used here.
