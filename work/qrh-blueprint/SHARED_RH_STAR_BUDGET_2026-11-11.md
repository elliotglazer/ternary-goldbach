# Use the stronger star estimate already supplied by shared RH

2026-11-11. Conditional paper assembly, pending independent review. No actual spectrum, numerical value, compiled theorem or runtime claim is supplied.

The cheapest shared finite-RH route should not automatically use the looser direct-sieve bound B<1915. If its plus/base-gap certificate already proves ordinary finite RH above the star cutoff, that same certificate supplies much stronger star energies. Using them costs no additional zero-location certificate. It still requires the analytic star proof and finite count bounds to be formalized and checked. This distinction changes which error allocation is economical.

## Closed carrier and the line statistic

Retain R=132900, x>=4.9e26, y=x/49>=Y=10^25 and the actual A,B,Q_A,Q_B definitions from the reviewed weighted-statistic construction. For each nonprincipal primitive conductor c, let

    D_c=1063200/qt(c),
    Hstar(c)=ceil(max(300,(704/343)*D_c)).

Assume the actual closed finite-RH property through Hstar(c). A taller ordinary-RH certificate may supply this by restriction, for both signs of the ordinate and every true multiplicity. Work with the complete carrier through Hstar itself; do not enlarge it to the taller certificate height. Principal c=1 is separate, and the absence of primitive conductors exactly 2 mod 4 needs its algebraic proof.

On this carrier every beta=1/2. Hence each factor y^(2 beta-2)=1/y<=1/Y. The independently reviewed floor300 count comparison therefore directly gives

    Q_A < 2.321e-19,
    Q_B < 1.753e-12.

These bounds use the full nonprincipal conductor family and the exact Gauss/cofactor weights. Squarefree support remains relevant to A; it does not remove any B terms. Unlike the weaker mixed-strip argument, there is no factor12/5 or10^6. Those factors existed only to allow beta larger than1/2. Neither finite RH nor this argument asserts an exact numerical zero count.

## Full star norms and the cubic budget

The reviewed full-strip tail, low Gram bound and coprime-removal proof give G=7e6, T_A<8e-9 and T_B<.00048, uniformly on the unbounded scale y>=Y. Thus

    sqrt(A) <= sqrt(G*Q_A)+T_A <1.284e-6,
    sqrt(B) <= sqrt(G*Q_B)+T_B <.004.

Both strict comparisons follow by squaring positive rational differences. In particular A<1.648656e-12 and B<1.6e-5. These are conditional actual-energy conclusions from the full star proof, not estimates of an isolated primitive sum. High zeros still use the full-strip tail; they are not assumed to satisfy RH.

Keep the full plus residual radius rho=8.85e-7. The prior integrated bound holds since16*150000*19*rho^2<.006^2. Consequently X/x<j=8.79 and the integrated principal/removal norm p=1.902e-6 remain valid. Their principal and finite inputs are retained. On the same physical tagged arcs, the reviewed cubic identity gives

    error/(x^2/49)
      <=sqrt(j)*(p+sqrt(A)+rho*sqrt(B))+rho*C,
    C=914205504131/4687500000.

Use sqrt(j)<2.965 and the preceding norm bounds. Relative to the original cubic allowance E=64019155993729/312500000000000000, the exact rational reserve is

    E-2.965*(1.902e-6+1.284e-6+8.85e-7*.004)-(8.85e-7)*C
       =228023139/10000000000000 >0.

The principal norm is included once inside the full star norm, with the necessary external Cauchy factor sqrt(j). All cross terms are retained. The Fourier tail, base-gap estimate, final mass/minor/nonprime budget, threshold and finite coverage remain unchanged. This argument does not need the new direct-B coefficient theorem or its sieve composition. It also does not remove principal estimates required elsewhere in the proof.

## How much plus error is permitted

The orthogonal principal/nonprincipal split and outer-removal bound give the sufficient nonprincipal plus energy cap

    Eplus <= (8.85e-7-516e-15)^2-(2.83e-7)^2.

The conservative downward-rounded cap7.03135e-13 is valid. A uniform bound8.385e-7 on each actual Gauss-weighted coprime nonprincipal coefficient implies this energy cap by character Parseval. This coefficient already includes the inner coprime removal. The principal constant-vector error2.83e-7 and outer removal516e-15 are then paid by the displayed formula.

If the separate exact even-family support lemma is used, another sufficient allocation is8.385e-7 for odd primitive conductors and1.1858e-6 for conductors divisible by4. The reason is that every supported ancestor at4|q also has4|c and the supported-label fraction is at most1/2. Therefore the even energy is bounded by(1.1858e-6)^2/2<7.03135e-13. No even primitive ancestor occurs when4 does not divide q. This option depends on that support proof; the uniform8.385e-7 option does not.

These are targets for a new plus-height proof, not permission to substitute a shorter height into an existing theorem. The low, tail, origin, vertical and coprime terms must all fit the chosen coefficient. Its closed RH profile must dominate Hstar as well as the separate base-gap requirement. The smaller four-band profile recently reviewed can also use this star argument, but a further relaxation needs a fresh source proof and cost inventory.

## Evidence and status

The exact checker check_shared_rh_star_budget_20261111.py verifies four source/report pins, both line-count roundings, positive root comparisons, the Z constraint, the exact cubic reserve, the downward energy rounding and the two coefficient allocations. Its immutable receipt is shared_rh_star_budget_20261111.json. All arithmetic is integer/Fraction arithmetic; no analytic functions, zeros or primes were evaluated.

The key reused source result is zero-sum/WSTAR_LOWER_FLOORS_AND_SQUAREFREE_PROFILE_2026-11-11.md, SHA E1D58C8EC2EDB7FD8F3BF77F1D3833F3E400200D14AD30B396F59FA8CB5EE794, independently reviewed at SHA422940369A04ED695A45EF28F20F154349932CEBC0242EEEE15FF3373D5CE6A4. The actual-function cubic normalization is independently checked in audit/REVIEW_JOINT_PLUS_STAR_FRONTIER_2026-11-11.md, SHA98323DCEF9DF7E7E4F2A2D9BDAEFC691CDDC4D6BD048E441FFD8E82B816F6505. Their finite count, analytic and formalization dependencies remain unchanged.

The direct-B route remains a research alternative when avoiding nonprincipal star spectra is beneficial. For a shared ordinary-RH certificate already extending above Hstar, the present stronger estimate offers more plus-error room and avoids additional direct-B proof work. No end-to-end cost dominance is claimed until the changed plus-height and complete checking costs are supplied.
