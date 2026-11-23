# Shorter ordinary finite-RH heights for the actual base gap

2026-11-11. Research paper proof and exact rational/Taylor checks. No zeros, characters, prime sums, or analytic function values were evaluated. No Lean build, declaration, source edit, or frozen-artifact change occurred.

The actual base-gap consumer at R=132900 can use the following nonprincipal ordinary finite-RH heights:

    Hbase(c)=ceil(27000000/c),  c odd, 1<c<=132900;
    Hbase(c)=ceil(54000000/c),  4 divides c, c<=265800.

Principal RH through 10^8 remains unchanged. These heights suffice for the relaxed actual coprime energy bound E_U,m<(.029)^2 uniformly over the full base-gap domain and every y>=10^25. The proof uses the actual `Cor933.cor_9_3_3` error and its unconditional full-strip tail, not a QRH strip or the old `Cor713` finite-RH wrapper. The resulting additive bound is below .03*y, enough for the actual ghat consumer. It does not establish the old .014 guard or .0121 source intermediate.

## 1. Domain and the finite premise

Let x>=4.9e26, y=x/49, and R=132900. The original denominator m in the base-gap membership argument has the exact ranges

    m odd: 1<=m<=R,       4R/(49m)<=|d|<4R/m;
    m even: 2<=m<=2R,     8R/(49m)<=|d|<8R/m.

The additive phase is a/m+d/y, up to an integer, and a is a unit modulo m. `BaseGap2.gap_point:185–227` gives this geometry before its numerical specialization. The denominator used for the rational approximation to twice the phase is m/gcd(m,2); it is not the character modulus. `BaseGap2.S_etaStar_eq_expTsum:229` gives the actual coefficient sequence Lambda(n)*etaU(n/y), with no extra factor 49 and no replacement of d by d/49.

For any ambient character with nonzero Gauss sum, let c be the conductor of its inverse primitive ancestor. Then c divides m. Primitive conductors are odd or divisible by four; the exact-2-adic-valuation-one case factors through its odd part by the trivial unit group modulo 2. Consequently

    c odd implies c<=R and |d|<=D_c=531600/c;
    4|c implies c<=2R and |d|<=D_c=1063200/c.              (1)

For the first line with m even, m/c is an even positive integer, so m>=2c. These bounds preserve every supported primitive ancestor and every imprimitive ambient character. The open upper bounds from geometry may safely be weakened to the closed bounds in (1).

For c>1 set the unrounded working height T_c=27000000/c in the odd case and 54000000/c in the even case. Assume ordinary finite RH for each actual primitive character at the closed height Hbase(c)=ceil(T_c): every nontrivial zero with |Im rho|<=Hbase(c) has Re rho=1/2. This includes real nontrivial zeros and repeated zeros; no simplicity or gap assumption is added. Monotonicity immediately supplies the same statement at T_c.

For every c in (1),

    203<T_c<=100000000/c,
    T_c/(pi D_c)>16.1>10.                              (2)

Both parity branches have the same minimum 27000000/132900, and pi<3.1416 verifies the ratio. Thus T_c>=max(10pi|d|,50). The source theorem is admissible. The following sections prove its error small enough; admissibility alone is not the conclusion.

## 2. The exact source error being bounded

`Cor933.lean:382–395,490–493` supplies, for primitive c>1,

    |Schar(chi,Lambda*etaU_y,d/y)|/y <= err933New(c,T_c,d,y),

where

    err933New = E2b +1.37259 E1b/sqrt(y)
                      +1.92182 E0b/y
                      +2.74517 Vb/(2pi*y*sqrt(y)).        (3)

`ZeroSumBound.lean:303–313` defines

    E2b=EB(T)[2Z3/(1-rhoB)+2c3/(1-rhoB)^2]
         +EA(T,d)[2Z3/(1-rhoA)+2c3/(1-rhoA)^2],
    EB(T)=.892 T exp(-.1598T),
    EA(T,d)=.588 u^2 exp(-.1065u^2), u=T/(pi|d|),
    rhoB=exp(-.1398*4.4),
    rhoA=exp(-1.93*4.4/(pi(|d|+1))),
    c3=48.4/[T log(10/3)].

At d=0 the source defines EA=0, so no division-by-zero interpretation is needed. The finite low part uses ordinary RH only through T. The tail window estimate and `norm_G_tail` cover all 0<Re rho<1 above T. `ExplicitBound.norm_Ssum_le:95–115` passes finite zero sums to the actual function and includes the zero-at-0 and left-line contributions. No global 7/8 or other QRH strip is required.

The numerical lemmas in `Cor713` before line802 do not have a PlattGRH binder. Only the final convenience wrapper obtains RH from that bundled hypothesis. We use the former scalar inequalities and `Cor933` with the newly stated finite premise; we do not call the latter wrapper.

## 3. Reusing the low and vertical scalar bounds legitimately

Because T_c<=10^8/c, positivity and monotonicity of BP, the floor-defined Jl, and square roots give

    E1b(c,T_c)<=E1b(c,10^8/c)<=3.42e6/sqrt(c).

This is monotonicity of a defined upper bound, not a claim that the actual low-zero sum is unchanged. `Cor713:311–419` gives the BP, Z3, E1 and rhoB inequalities. In particular, throughout the present domain,

    Z3(c,T_c)<=177.26,
    rhoB<=.5406, 1/(1-rhoB)<2.18,
    c3(T_c)<41/T_c and c3(T_c)<.2.                      (4)

The last two follow from log(10/3)>=1.2039 and T_c>203. Also |d|<=1063200/c<1200000/c, so the existing E0b<=15300 and Vb<=2.1e16 bounds in `Cor713:510–564` apply directly. For sqrt(y)>3.16e12 and c<=265800<516^2, the last three terms of (3), after multiplication by sqrt(c), are bounded by

    1.5e-6 +2e-17.                                     (5)

The two small terms are each at most 1e-20 before multiplication by sqrt(c). Their sum after multiplication is at most 1.032e-17. All these bounds improve as y increases; there is no upper restriction on y.

## 4. New full-strip tail allocation

The elementary function t exp(-.1598t) decreases for t>=203. The positive degree120 exponential Taylor polynomial proves exp(-32)<1.3e-14. Thus

    EB(T_c)<=.892*203*1.3e-14.

Using (4), the B-tail multiplier is below 775. Its contribution after multiplication by sqrt(c) is therefore at most

    Bcap=.892*203*1.3e-14*775*516 <9.42e-7.              (6)

For the other regime, the source's `gauss_sq_anti` or direct differentiation shows u^2 exp(-.1065u^2) decreases for u>=10. By (2), u>=16.1. Since .1065*(16.1)^2>27.6 and the degree120 Taylor polynomial proves exp(-27.6)<1.1e-12,

    EA(T_c,d)<=Acap=.588*(16.1)^2*1.1e-12.              (7)

For t>0, 1/(1-exp(-t))<=1+1/t. Since pi/(1.93*4.4)<.371, write a=1.371, b=.371, K=1063200. Uniformly in both parity branches,

    1/(1-rhoA)<=a+bK/c.

Now c<=265800, sqrt(c)<516, T_c>=27000000/c, and 1/sqrt(c)<=1. Expanding the square rather than replacing the inverse factor by a uniform maximum retains the needed conductor decay. The A-tail contribution multiplied by sqrt(c) is at most

    Acap * {354.52*(a*516+b*K)
       +(82/27000000)*[a^2*265800*516+2abK*516+b^2*K^2]}
       <.023567.                                      (8)

Every bound in (8) is rational. In particular the term containing c3 is obtained from

    sqrt(c)/T_c * (a+bK/c)^2
       <= [a^2 c sqrt(c)+2abK sqrt(c)+b^2K^2/sqrt(c)]/27000000.

This is why a uniform bound on rhoA followed by a separate maximum over conductors would lose useful information. It is not a claimed cancellation in the zero sum.

Adding (5), (6), and (8) proves the complete source bound

    sqrt(c)*err933New(c,T_c,d,y)<.02357<.024.            (9)

The source low-zero, high-zero, exceptional-zero and vertical pieces are all paid. The proof covers both signs of d and the closed auxiliary range (1), including d=0 even though the actual gap excludes it.

## 5. From primitive bounds to the actual ambient-modulus energy

Let b_y(n)=Lambda(n)*etaU(n/y). For every supported nonprincipal primitive ancestor, (9) gives the unrestricted normalized character bound .024/sqrt(c). The actual unrestricted Gauss-weighted energy at ambient modulus m therefore satisfies

    Efull_m=(1/phi(m)) sum_(supported c>1) c sum_(chi primitive c)
                          |Schar(chi,b_y,d/y)/y|^2
             <=.024^2 * Dnp_m/phi(m) <=.024^2.           (10)

There is no unweighted family average in this step. The factors c cancel the 1/c in the squared character bound, and Dnp_m is the number of supported nonprincipal ambient labels. Inverse labels permute the primitive characters at the same conductor. `Bombieri.norm_sq_gaussSum` gives exactly the support c|m, squarefree(m/c), gcd(c,m/c)=1. No positive supported term is omitted.

The actual energy E_U,m uses b'_m=coprimePart(m,b_y). The source removal bound is d0=2e-9. Vector Minkowski and the exact total squared Gauss mass sum_psi |tau_psi|^2=phi(m)^2 give

    sqrt(E_U,m)<=sqrt(Efull_m)+d0 sqrt(phi(m))
                  <=.024+516*2e-9=.024001032<.029.      (11)

Thus E_U,m<841/10^6 on the whole required continuum. This includes every ambient imprimitive character with nonzero Gauss weight. At m=1,2 the nonprincipal energy is zero and the principal/removal argument remains necessary.

Retaining the principal-only base-gap estimate through height10^8, the existing source-faithful main-term bound is below .000544, its principal residual below2e-6, and the outer plus principal removals cost4e-9. Equations (10)–(11) give the actual additive bound

    |S etaStar x alpha|/y
       <.000544+.000002+.000000004+.024001032
       =.024547036<.03<ghatY(y,R).                     (12)

The endpoint and natural-R ghat adapter are the ones recorded in `AGGREGATE_NONPRINCIPAL_BASE_GAP_TARGET`. This is the actual `MinorTotal` implication. It deliberately does not recover the earlier .014 guard; formalization must replace that sufficient intermediate by (12), without calling a theorem that still assumes the stronger guard.

## 6. The union of height requirements

This packet reduces only the base-gap nonprincipal demand. It does not certify the finite spectra or replace the plus and major-star consumers. The global requirement is the conductorwise maximum of their independently justified heights and Hbase, with principal RH10^8 and any separate exact head-data obligations retained.

The plus candidate communicated during this work has form

    Hplus(c)=ceil(200+max(260,u(c)*3.1416*1063200/qt(c))),
    u(c)=23.3, or19.89 on its stated high-even branch.

For every branch, u(c)>=19.89 and 19.89*3*531600>27000000. Since qt(c)=2c for odd c and c for even c, the real expression inside this ceiling exceeds T_c. Hence Hbase(c)<=Hplus(c), if that plus candidate is independently proved on the same domain. The base-gap proof does not depend on that candidate or its success. A star candidate with its own floor may still dominate the plus demand at some conductors. Those maxima must be formed from final reviewed packets, not from this comparison alone.

Relative to the source's working height10^8/c, this is a genuine shorter base-gap premise, with ceilings explicitly retained. No global spectral-volume or runtime saving is asserted before taking the complete union. The old broad PlattGRH wrapper cannot remain in the new proof as a hidden assumption.

## Evidence and remaining formal work

New exact script `base_gap_reduced_rh_height_scalars_20261111.py`, SHA256 **27E62CD6FF069CCCE573BAC53AE2E5EAF6C1EB66022243D1B91D4A0E48532351**. Receipt `base_gap_reduced_rh_height_scalars_20261111.json`, SHA256 **BEF081E4A8946038FE8695A1A62255E1355A54449DACDA2ED929202BF345D226**. All32 checks passed, with ten retained source/report hashes. The exponential comparisons use finite positive Taylor polynomials; no exponential, logarithm, square root, L-function or zero evaluator was called.

The source pins include `Cor933`554F00DE4FA6F8F0B6B184F8E8535B8AC5C28C0DB47FA2A95119B6BA4899F66E, `Cor713`11325BE6F77A7A762747542F30E2A9035782765A801C603F14107E84ED5D7433, `ZeroSumBound`A1294627F676EC49BED1BD86407A9460DC569B77AF8CBE8D65F1F49129BF17D4, and `ExplicitBound`151587294597BB275C2973E9E7D149605673936903780AE72C8D5E9F5E729D3B. The exact aggregate consumer report is **CFDA417AFFF112EBDF7BBB822FE7C884F3F8FCB4307BBC2F5AAC3B6856D5D264**. The receipt contains the remaining complete hashes and paths.

Remaining work consists of supplying actual finite-RH certificates, proving the new scalar/monotonicity lemmas in the target system, localizing the principal wrapper, and connecting the natural-R gap argument directly to ghat. This paper proof does not validate all transitive source dependencies, build compatibility, or final axioms. It introduces no new mathematical assumption beyond the stated ordinary finite-RH premises and the already retained source/consumer inputs.
