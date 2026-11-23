# High-twist bounds for reduced denominators2 through39

Research, 2026-11-11. Pinned source `23b2d68ca344203d4384e0aff7affa4ec034bef9`. No Lean compilation or canonical source edit. The result is an exact scalar certificate conditional on the original Type I/II producer inequalities. Its overlap with the finite-family branch also retains the SAME unproved uniform finite beta<=111/200 certificate. It does not turn either condition into a new allowed hypothesis of Goldbach.

## Two sufficient rectangles

Use Q for the reduced denominator of2alpha, y=x/49>=1e25 and

    2alpha=A/Q+Delta/y modulo an integer,
    u=Q|Delta|,
    1200000/49<=u<1200000.

The exact high-twist certificate tests the following two rectangles:

    2<=Q<=39, Q/phi(Q)<=2, 300000<=u<=1200000;
    2<=Q<=39, Q/phi(Q)<=15/4, 600000<=u<=1200000.

It proves the unchanged comparison|S_etaStar(alpha,49y)|/y<=ghatY(y,150000) at every scale, conditional on the original pointwise source inputs. The finite calculation records phi(Q) and phi(2Q) separately for every Q2..39. Every Q in this range satisfies Q/phi(Q)<=15/4.

The raw bound at u190000 does not pass uniformly. Floating diagnostics give a negative all-scale slack near-.01131 for Q2 and-.02173 for Q6. These failures are diagnostics of the chosen upper bound, not impossibility statements. The larger high-twist cutoffs above overlap the finite-family bands already computed by the zero-sum worker, so keeping190000 as a common cutoff is unnecessary.

## Source formula and parity

At convolution scale z=wy, delta_z=wDelta and

    t=max(2Q,w*u/4), f=Q/phi(Q).

On .02<=w<=8 and either new high band, w*u/4>=1500>2Q. Thus t=wu/4 exactly. Summing the following source declarations before the final AM-GM simplification gives the raw normalized envelope:

* `MinorArcs/FirstChoiceTypeI1.typeI1_first:227`;
* `MinorArcs/FirstChoiceTypeI2c.typeI2_first:16`;
* `MinorArcs/FirstChoiceTypeII.typeII_first:329`;
* `MinorArcs/Assembly.norm_S_le_parts:64`.

The resulting function is

    C(z,t)=log(1+log(4t)/(2log(9z^(1/3)/(2.004t)))),
    B(z,f,t)=sqrt(f/t)*sqrt((C(z,t)*(logt+.002)+log(4t)/2)
                          *(.30214logt+.7468))
       +2.5257/sqrt(t)+13.2*f/t
       +2*(16.267logt+24.42)/t
       +3.77*z^(-1/6)+3logz/z.

The reciprocal-totient coefficient13.2 is2*(3.8+2.8). The logarithmic constants are1+15.267 and2.96+21.46. The power constant is.014+.556+3.2=3.77. No source term is removed.

These specialized source declarations hold for arbitrary natural Q. Their proofs already handle the Type I ratio2Q/phi(2Q). The final raw formula contains Q/phi(Q); this is not an invitation to identify the two ratios. The certificate computes and records both and only substitutes the reduced ratio into the displayed raw formula. For example Q3 has Q/phi(Q)=3/2 while2Q/phi(2Q)=3. Neither the even-Q identity nor an exact value of a primitive character is assumed.

Original analytic inputs remain conditional, including Mobius/Liouville, prime moments, the first-choice totient replacement and the other producer bounds. The script proves scalar implications of those estimates, not their removal from PlattGRH.

## Approximation hypotheses

The source phase identity and coprimality come from the parity-aware reduced approximation. On .02<=w<=8 and y>=1e25,

    z>=2e23, T=z^(1/3)>58000000>6e6,
    Q<=39<T/6,
    wu<=9600000<(4/3)T.

Thus Approx2 holds with H=3T^2/4 and Q<=H. It follows that t<=T/3 as required by the source first choice. The change from .05 to .02 in the smoothing cutoff is explicitly included in these checks and in the Gaussian tail budget.

## Uniformity in u and y

For fixed z, the raw envelope decreases in t on the entire rectangle1500<=t<=2400000. The proof is the one independently reviewed for q1, now with an arbitrary positive factor f. Put

    ell=logt>6, v=log(9z^(1/3)/(2.004t))>4,
    a=ell/2+log2, C=log(1+a/v),
    A=C*(ell+.002)+a, B=.30214ell+.7468.

Then C'<1/v and

    A'/A+B'/B<=2/ell+(2/v)*(1+.002/ell)<1.

Therefore sqrt(f*A*B/t) decreases. The remaining t-dependent terms decrease separately, while the z-only terms stay fixed. This reduces every high band to its lower endpoint u0. The raw formula also increases with f, so f<=Fmax is bounded by substitution of Fmax=2 or15/4. No monotonicity of phi is invoked.

For each of399 w-bins of width.02, put tmin=w0*u0/4, tmax=w1*u0/4. Freeze C at z=w0*y,t=tmax and evaluate the other factors at tmin. With C frozen the same product decreases since its logarithmic derivative is at most2/ell<1.

The all-scale variable is

    r=1/(log(y)/3+log(9/601200)), 0<r<=rmax.

At the frozen endpoints,

    C<=log(1+aq*r/(1+hr*r)),
    aq=log(4tmax)/2,
    hr=log(300000/tmax)+log(w0)/3.

The denominator is positive on the entire compact r-interval, checked exactly for each bin. The upper expression increases with r even if hr is negative. Each of32 r-cells therefore uses its upper endpoint for B and its lower endpoint for the reviewed affine-in-R lower bound of ghatY(y,150000). This covers every scale; it does not sample y.

The Gaussian bin masses use the same reviewed fourth-derivative remainder84*(w1-w0)^5/2880. The full tail contribution is

    17*.02^3/3+17*(65/8)*10^(-13).

All acceptance comparisons use fractions, directed rational log/root enclosures and exact ceilings. `resume_small_q_high_model.py` is a separate diagnostic and does not decide certificate success.

## Exact overlap with the original factor4 finite-family branch

The input table is `zero-sum/resume_base_gap_finite_family_20261111.json`, SHA256

    BE725BE94D16589C47E4F2387559B994BBA8F75A008121D100930313935CFB7A.

This is the conservative bound|F_U|<4, not the later sharper interpolation proposal. It proves the whole gap for all Q>=32 and additional small Q, conditional on the shared finite spectral contract and its analytic bridges. Its residual list below40 is

    1,2,3,4,5,6,7,8,9,10,11,13,14,15,16,17,19,23,29,31.

The previously reviewed q1 hybrid handles1 separately. For every other residual, the finite-family interval is[1200000/49,Ufinite]. The script checks exactly that Ufinite>=the appropriate high-start cutoff. The closed bands overlap, so there is no missing boundary.

| Q | f | finite-family endpoint | high start |
|---:|---:|---:|---:|
|2|2|395262|300000|
|3|3/2|434028|300000|
|4|2|558985|300000|
|5|5/4|512780|300000|
|6|3|868056|600000|
|7|7/6|583360|300000|
|8|2|790524|300000|
|9|3/2|889340|300000|
|10|5/2|1025562|600000|
|11|11/10|704688|300000|
|13|13/12|758228|300000|
|14|7/3|1166722|600000|
|15|15/8|1126141|300000|
|16|2|1117970|300000|
|17|17/16|855344|300000|
|19|19/18|899979|300000|
|23|23/22|983171|300000|
|29|29/28|1096147|300000|
|31|31/30|1131292|300000|

Thus the two high rectangles are sufficient to complete the small-denominator part of the original factor4 finite-family strategy. This statement remains contingent on independent review of this certificate and the finite-family derivation. It does not assert a completed unconditional minor theorem, and it does not alter any central coverage count.

## Result status

The exact replay output is `resume_small_q_high_certificate.json`; scalar margins are appended after completion. The source arguments, finite arithmetic and integration bounds remain paper-level results awaiting Lean formalization. The original shared finite.555 certificate itself remains unproved. Later improvements to the etaU Mellin bound may reduce the finite workload, but no such improvement is needed for the overlaps in this note.


## Completed exact replay

Both rectangles passed all32 scale cells, for64 exact scalar checks in total. The minimum margins are

    Fmax=2, u>=300000: 1018323773/10^12=.001018323773;
    Fmax=15/4, u>=600000: 2848347157/(5*10^11)=.005696694314.

The first minimum occurs in r-cell4; the second in r-cell10. Each scalar cell includes all399 w-bins and both tails. The script also checked all19 exact overlaps with the original factor4 finite-family table. No sampled scale decides these results.

The zero-sum worker subsequently reported a sharper actual-etaU bound1.625 under the SAME shared uniform finite.555 certificate. That separate profile covers every Q>=4 in the full twist range and gives finite prefixes972954 for Q2 and1068377 for Q3. If that sharper profile passes its independent review, only the first rectangle is needed for Q2,Q3, together with the separately reviewed q1 hybrid. The high certificate itself does not require this improvement: its frozen baseline overlaps already suffice with|F_U|<4. Neither profile is silently substituted for the other in the saved JSON.

Independent review is requested before incorporating these results into a proposed full base-gap closure. The finite spectral certificate, global QRH and original Type I/II producer replacements remain unresolved mathematical inputs of that proposed package.
