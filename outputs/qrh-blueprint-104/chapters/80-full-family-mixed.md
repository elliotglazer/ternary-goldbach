# Full-family finite mixed moment: a sufficient beta certificate

Research only, against ternary-goldbach commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. No Lean build, canonical source edit, new axiom or assumed replacement theorem was introduced. The companion `resume_family_mixed_20261111.py` and JSON perform exact finite arithmetic. They do not locate or certify any zeros.

The diagnostic succeeds. With the explicit finite heights below, a proved uniform bound beta<=111/200=.555 for every active primitive character would suffice for the finite mixed-moment target, using the factor-25 operator and genuine fourth-moment inequalities. The same certificate is compatible with the major-constants worker's separate full-family Aplus/Astar/N calculation. It is not currently proved. This result replaces an unspecified finite mixed aggregate with a concrete sufficient spectral certificate, without claiming that certificate is inexpensive.

An alternative direct modulus calculation is stronger for Cross alone: beta<=29/50=.58 suffices. Both methods retain two independent characters, all multiplicities and the exact imprimitive Gauss support.

## 1. Finite carriers and available kernel ingredients

Keep x>=x0=4.9e26, y=x/49>=1e25 and Q=Qset(150000). Thus q is odd and<=150000, or even and<=300000. Let Dq=1200000/qt(q). For every active primitive conductor c put Dc=1200000/qt(c) and

    Hp(c)=ceil(200+max(1000,(704/7)*Dc)),
    Hs(c)=ceil(max(1000,(704/343)*Dc)).

These are the heights from independent-feasibility/RESUME_HYBRID_CERTIFICATE_2026-11-11.md. Hp is always larger than Hs. Its tail argument uses global QRH above these heights and the actual smoothing bounds, rather than applying the finite beta certificate there.

For the finite calculation let z_chi,+ and z_chi,* be the actual normalized nontrivial-zero sums, cut at Hp(c) and Hs(c), respectively. Multiplicity is retained. The hypothetical certificate to be established is

    every nontrivial zero of every active primitive character with
    |gamma|<=Hp(c) has beta<=b.

The global QRH/reflection strip still supplies 1/8<=beta<=7/8. No zero spacing, simplicity, or quartet identification for nonreal characters is used.

The source Jensen estimates give at most400 zeros, counted with multiplicity, in any height interval of length h=3.48 needed here. The whole finite carrier therefore has multiplicity at most

    Np(c)=ceil(400*(2*Hp(c)/3.48+2)),
    Ns(c)=ceil(400*(2*Hs(c)/3.48+2)).

The count uses arbitrary translated windows, not a presumed separation between zeros. Every relevant center is below10^8 in absolute value, and c<=300000. The source BP/BPz2 polynomial bounds support the uniform400 constant as detailed in the hybrid note.

For etaPlus, the actual squared-smoothing Gram estimate from mellin/RESUME_PRINCIPAL_2026-11-11.md is

    |Mellin(etaPlus^2)(sigma+i*t)|
       <=min(4,428/(25/16+t^2)),  -.75<=sigma<=.75.

Full-line Plancherel and the400-point window bound give the row constant

    Kp=23000,
    integral_R |sum_low a_rho F+(rho,delta)|^2 ddelta
      <=Kp*sum_low |a_rho|^2.

Repeated indices represent multiplicity. This analytic Gram bridge remains a paper derivation, not a new compiled source theorem. Its scalar row comparison follows from

    800*(16+428/(3*3.48^2))<23000.

The pointwise bound |F+(rho,delta)|<3.95 follows from the source Gaussian envelope and the generic GaussianEnvelope lemma already kernel-checked in the earlier campaign. Its actual etaPlus wrapper still needs formal integration. The conservative star bound |F_U(rho,delta/49)|<4 follows from the actual eta2-Gaussian convolution and holds throughout the QRH strip for every real delta.

The first, stronger direct Cross calculation below needs only Kp and the star pointwise bound. The factor-25 calculation also uses the star Gram row derived in Section4.

## 2. Direct mixed bound with exact Gauss support

Write n(c) for the number of primitive characters modulo c, including n(1)=1. Its exact local factors are n(p)=p-2 and n(p^a)=p^(a-2)*(p-1)^2 for a>=2. In particular n(c)=0 when v2(c)=1.

For each primitive character, the finite beta certificate and Kp give

    integral_R |z_chi,+(delta)|^2 ddelta
      <=23000*Np(c)*x^(2b-2).

The pointwise absolute sum, with multiplicity, gives separately

    |z_chi,*(delta)|^2 <=16*Ns(c)^2*y^(2b-2).

This is a valid L2-times-Linfinity argument. The second statement is not inferred from the first or from an ordinary star L2 bound.

For each q define the exact arithmetic quantities

    Aq = [sum_(c|q, q/c squarefree, gcd(c,q/c)=1)
              c*n(c)*23000*Np(c)]/phi(q),
    Bq = [sum_(c|q, q/c squarefree, gcd(c,q/c)=1)
              c*n(c)*16*Ns(c)^2]/phi(q).

The actual Gauss weights give integral_Iq Eplus_low<=Aq*x^(2b-2) and the pointwise bound Estar_low<=Bq*y^(2b-2). Hence

    Cross_low <=(xy)^(2b-2)*Cmix,
    Cmix=sum_(q in Q) Aq*Bq.

There are two independent characters inside Aq*Bq. Nothing replaces the product by a same-character diagonal. The actual Iq is kept until the legitimate upper bound of the plus integral by its full-line integral. The principal Fourier term is already subtracted in the zero residual. Euler/coprime corrections are separate.

Exact conductor enumeration gives

    Cmix <6.794e36.

The enclosed coefficient is approximately6.793862716720364e36. Each rational summand is rounded upward at denominator2^80; the script also records the lower enclosure. It verifies sum_(admissible c) c*n(c)=phi(q)^2 independently for every q in Q, which checks the complete Gauss support and character enumeration.

At x0*y0=49*10^50 the diagnostics are

| b | Bound for Cross_low |
| ---: | ---: |
| .5 | 1.387e-15 |
| .54 | 1.893e-11 |
| .555 | 6.728e-10 |
| .57 | 2.391e-8 |
| .58 | 2.585e-7 |
| .59 | 2.794e-6 |

Exact rational-power checks prove, in particular,

    b=.555 implies Cross_low<1e-9;
    b=.58 implies Cross_low<2.6e-7<6.975e-7.

The numerical crossing for the6.975e-7 allocation is approximately b=.58417093. This is the crossing of this sufficient estimate, not a necessary limit on possible certificates or on the true mixed moment.

## 3. The factor-25 integral requires a fourth moment

Use the previous exact conductor operator:

    P_c,±=sum_(chi primitive mod c)|z_chi,±|^2,
    W_c,±=(c/phi(c))*P_c,±,
    Cross_low=integral <Pi_delta T W_+,Pi_delta T W_*>.

Pi_delta is the actual arc projection. The audited arithmetic result ||T||^2<25 gives Cross_low<=25 I_low, where

    I_low=integral_R ||W_+(delta)||_2*||W_*(delta)||_2 ddelta.

A first valid but wasteful bound uses ||W_+||2<=||W_+||1 and the pointwise star norm. It gives

    I_low <=1.42001701821e39*(xy)^(2b-2).

This passes the target2.79e-8 for b=.54 but fails for b=.55. It is not the preferred estimate. It demonstrates the cost of discarding conductor structure before integration.

Instead, prove actual fourth moments through a supremum-times-integral inequality. For nonnegative P_c,

    integral P_c^2 <=sup_delta(P_c)*integral P_c.

The pointwise estimates above and the independent Gram rows therefore give, with v_c=c*n(c)/phi(c),

    integral W_c,+^2
      <=v_c^2*(3.95^2)*23000*Np(c)^3*x^(4b-4),
    integral W_c,*^2
      <=v_c^2*16*Ks*Ns(c)^3*y^(4b-4).

Here Ks=49*102000=4998000. Summing c and applying Cauchy-Schwarz in delta is now justified and yields

    I_low <=(xy)^(2b-2)*sqrt(Cp4*Cs4),
    Cp4=sum_c v_c^2*(3.95^2)*23000*Np(c)^3,
    Cs4=sum_c v_c^2*16*4998000*Ns(c)^3.

This step explicitly proves the required fourth-moment bounds. It makes no L2-to-L4 inference without a pointwise factor. The sums P_c^2 retain all independent primitive-character pairs in the same conductor family; T then handles their induction into common moduli.

The exact arithmetic enclosures give

    Cp4 <1.296424e37,
    Cs4 <7.010475e38,
    sqrt(Cp4*Cs4)
      <=95333870301485388358447821110540879235
      <9.533388e37.

The integer square-root ceiling in the script bounds the square root of the rational upper product. At b=.555=111/200, it verifies by raising to the100th power that

    I_low<1e-8<2.79e-8.

The actual enclosed diagnostic is9.44002e-9. At b=.5 it is1.94559e-14. At b=.56 this particular bound is3.10367e-8 and misses; its numerical crossing is b approximately.55955243. The stronger direct-modulus estimate in Section2 avoids this loss and continues to b=.58.

## 4. Actual etaU Gram lemma used in the fourth moment

The major-constants worker supplied this derivation, which I independently reconstructed. Let dmu(r)=eta2(r)dr/r on[1/4,1], so mu has total mass4log(2)^2<2. The actual convolution is

    etaU(t)=integral (t/r)^2 exp(-t^2/(2r^2)) dmu(r).

In the square, set A=(r^-2+s^-2)/2 in[1,16] and k=sigma+4 in[13/4,19/4]. Since r^-2*s^-2<=A^2, the zero-frequency Mellin integral of the double-mixture component is

    (1/2)*r^-2*s^-2*A^(-k/2)*Gamma(k/2) <=4.5.

Here A^(-sigma/2)<3, and Gamma(k/2)<3 by splitting its defining integral at1 and comparing the upper part with t^2 exp(-t). Integrating the double measure gives a bound18.

In log t coordinates the component has H(u)=exp(k*u-A*exp(2u)). Absolute integration of its second derivative gives

    integral |H''| <=4k(k+1)*integral H <=109.25*integral H.

The identity follows by integrating the three terms k^2, -4(k+1)Aexp(2u), and4A^2exp(4u), then using the exact Gamma recurrences. Two integrations by parts consequently give

    |Mellin(etaU^2)(sigma+i*t)|
       <=min(18,1985/(1+t^2)), -.75<=sigma<=.75.

Gaussian domination and the positive lower bound k>=13/4 justify the endpoint limits and Fubini; these analytic bridges still require Lean proofs. With400 points per3.48-window, the Schur row is bounded by

    800*(72+1985/(3*3.48^2))<102000.

Full-line Plancherel applies first in the star twist variable d. Changing to delta=49d multiplies its L2 integral by49, which is why Ks is4998000. Omitting this factor would give an incorrect mixed bound.

## 5. Full budget, uniformity, and unresolved certificate

The previous corrected mixed interface accepts

    Astar_actual<=2.5e-7,
    I_low<=2.79e-8,
    total mixed remainder norm<=1e-6.

Section3 supplies the finite-I implication if the uniform b=.555 certificate is proved. Its stronger I_low<1e-8 gives Cross_low<2.5e-7 through factor25. Adding a remainder norm1e-6 would give Cross_actual<2.51001e-7, still well below7e-7. The direct-modulus bound is stronger again.

The complete paper remainder ledger is now available from major-constants/RESUME_FAMILY_CAPS_2026-11-11.md. It gives uniform per-character errors dplus<2e-15 and dstar<2e-12 between the finite nontrivial-zero sums and the actual coprime residuals. These include the high zeros, vertical integrals, possible zero-at-zero residues and primitive-to-coprime correction. The source pole terms are subtracted in the residuals. In particular, this ledger is not just a high-zero estimate. The etaU GoodSmoothing and explicit-formula bridges, identified in that note, still require their analytic formalization.

There is a small mixed transfer that does not assume J<=10. The same finite certificate gives

    integral_sum Eplus_low =N_low+Ep_low<.001+4e-8<.002.

Also Ns(c)<=Ns(1)<3e8 and sum_(q in Q)phi(q)<=9e10. The star Gram row therefore gives

    integral_sum Estar_low
      <=49*102000*(3e8)*(9e10)*y^(-.89)
      =1.34946e26*y^(-.89)<10000.

The last comparison is verified by exact100th powers at y=1e25. It is decreasing for larger y. With Gauss-error energy at most phi(q)*d^2, Minkowski in the exact two-character Hilbert space gives

    Rmix <=dplus*sqrt(300000*10000)
            +dstar*sqrt(300000*.002)
            +dplus*dstar*sqrt(3.24e22)
          <2e-10.

The script bounds the two nontrivial square roots by54773 and25 and checks this sum with exact fractions. This transfers directly from finite zero products to actual coprime products. The earlier separate6e-9 high-tail norm and J-dependent Euler transfer must not be added again, since their terms are already contained in dplus,dstar here.

Consequently the primary factor25 route yields the full coprime conclusion

    Cross_coprime <(.0005+2e-10)^2<2.501e-7,
    Astar_coprime+Cross_coprime<5.001e-7<9.5e-7,

using the major worker's actual Astar_coprime<=2.5e-7 allocation. This is a complete quantitative sufficient implication on paper, conditional on proving the finite spectral certificate and the stated analytic bridges, not an assertion that the actual coprime bound has been established in Lean. The later coprime-to-full additive-sum transfer is a different step and is unchanged.

All estimates are uniform for x>=x0. The finite data, heights, counts and Gram constants are independent of x, and (xy)^(2b-2) decreases because b<1. The coefficient arguments in the Gram inequalities handle every oscillatory phase. No monotonicity of the actual zero sums is asserted.

The exact active family contains5,543,640,188 primitive characters. The crude total plus and star multiplicity upper bounds are1,740,063,512,485,802 and1,278,926,120,257,689. These are conservative analytic count bounds, not actual zero totals or a proposed list to enumerate. The result does not claim that computing a complete certificate at these heights is cheaper than the historical finite-RH computation. It identifies a weaker real-part condition that is numerically sufficient.

The finite certificate must exclude zeros with beta>.555 through Hp(c) for every active primitive character, with a rigorous completeness argument and actual multiplicities. A weighted or conductor-dependent certificate could be smaller, but no omitted conductor block is declared negligible here. The already proved global QRH statement alone does not establish this finite condition.

## Validation status

The companion script exits0 and preserves the exact Gauss support at every q. Its decisive beta comparisons use integer/Fraction powers, not floating-point logarithms. Decimal thresholds and tables are diagnostics only. The actual kernel and remainder derivations are paper results with identified source ingredients. The finite spectral certificate and formal versions of the analytic bridges and explicit-formula transfers remain open. No conclusion about the original Goldbach theorem is claimed.
