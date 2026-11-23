# Wstar: critical-line baseline, complete-carrier obstruction, and a shorter cutoff

2026-11-11. Paper/source and exact integer/rational metadata only. No zero, L-function, Mellin, prime or FFT values were evaluated; no Lean declaration or build was made. This report does not assert an actual finite spectral bound or adopt a replacement for the current route.

The coarse weighted statistic cannot succeed with the original conductor-3 height: its actual value already exceeds the proposed target by more than 19, even without assuming RH. This is an obstruction to that sufficient statistic, not to Wstar. At the source star-tail cutoff, rigorous count majorants instead leave room for the critical-line baseline, and even for the sufficient finite strip beta<=0.5075. A fresh full-strip high-tail argument below supplies the missing remainder estimate without global QRH. The finite strip or weighted spectral data are still absent. The separate plus, pointwise base-gap and principal inputs remain required.

## 1. Exact statistic and carriers

Use the definitions of `audit/WSTAR_WEIGHTED_SPECTRAL_STATISTIC_2026-11-11.md`, with R=132900, x>=4.9e26, y=x/49, Y=10^25, and Dq=8R/qt(q), where qt(q)=2q for odd q and q otherwise. Qset consists of odd q<=R and even q<=2R. A primitive conductor c is eligible at q when q/c is squarefree and coprime to c. Retain every primitive nonprincipal character, both ordinate signs, real nontrivial zeros, and true orders. Inversion permutes labels and is not a reason to halve the sums.

For a complete closed carrier through Hc, write Cchi(Hc) for its count with multiplicity and

    Schi = sum_rho m(rho) Y^(2 beta-2),
    omegaA(c) = sum_eligible_q mu(q)^2 c/phi(q)^3,
    omegaB(c) = sum_eligible_q c/phi(q),
    QA = sum_c omegaA(c) sum_chi Schi,
    QB = sum_c omegaB(c) sum_chi Schi.

The sufficient targets are QA<=4/(7*10^18), QB<=4/(7*10^6), together with TA<=10^-6 and TB<=1 for the actual remainders. The parent Gram bound G=7*10^6 gives sqrt(A)<=sqrt(G QA)+TA and sqrt(B)<=sqrt(G QB)+TB. Its off-line 400-per-window hypothesis must be established in the chosen finite domain. It is not automatically valid through all historical Platt heights.

The same-character functional equation and conjugation imply that J(rho)=1-conj(rho) preserves zeros and their orders. It preserves each complete closed height carrier, including real zeros and corners of the height cutoff. Its orbits have size one or two. For a two-element orbit,

    Y^(2 beta-2)+Y^(-2 beta) >= 2/Y;

at a fixed point beta=1/2 the weight is 1/Y. Consequently Schi>=Cchi(Hc)/Y unconditionally. Equality is the all-critical-line baseline. A count upper bound gives an upper bound for this hypothetical baseline, not for actual Schi without additional spectral information.

## 2. Rigorous count bounds without evaluating zeros

Here c>1 is primitive and nonprincipal. The accepted closed-count/endpoint argument gives, almost everywhere in t>0,

    Cchi(t)=Gca(t)+Schi(t)+S_(chi^-1)(t),
    Gca(t)=2 theta_a,c(t)/pi.

The count includes real zeros. The canonical Euler-log branch of S is retained; a nonreal character's initial argument is not reset to zero. The accepted elementary Turing bound is

    |integral_l^u Schi(t) dt| < 42+6.93 log(cu/(2pi)),
    50<l<u.

There is no height cap or RH hypothesis. Exceptional heights do not affect the integral. Closed counts are monotone, so using averages on either side of T gives valid endpoint inequalities even if a zero has ordinate exactly T.

For either parity alpha=1/4 or 3/4 and v=t/2, normalized Binet gives

    theta = v(log(ct/(2pi))-1)
          + (v/2)log(1+alpha^2/v^2)
          + (alpha-1/2)atan(v/alpha)
          - v/[12(alpha^2+v^2)] + Im E,
    |E|<=1/(48 alpha^2)<=1/3.

The real Binet normalization constant has no imaginary part. For t>50, the absolute discrepancy from the first term is at most

    alpha^2/t + pi/8 + 1/(6t) + 1/3 < 1.

Thus |Gca(t)-g_c(t)|<1, where g_c(t)=t/pi*(log(ct/(2pi))-1). In all the intervals used below g_c is increasing. Put l=.99T, u=1.01T and b=42+6.93 log(cu/(2pi)). Monotonicity and the two Turing bounds imply

    g_c(l)-1-200b/T < Cchi(T) < g_c(u)+1+200b/T.       (1)

The companion avoids transcendental evaluation. Choose integers k and ell satisfying

    (8/3)^k > cu/6,       3^ell < (7/44)cl.

The elementary inequalities 8/3<exp(1)<3 and 3<pi<22/7 give logarithm upper k and lower ell. With b_k=42+6.93k, (1) is weakened to

    l*(7/22)*(ell-1)-1-200b_k/T < Cchi(T)
       < u*(k-1)/3+1+200b_k/T.                       (2)

All tested l exceed 50 and ell>=1. Ceilings of the upper expression are valid integer majorants for either parity. These are analytic count inequalities, not inferred counts from a main asymptotic term.

## 3. Exact conductor inventory and the baseline comparison

The script enumerates conductors odd c<=R or 4|c<=2R, c>1. Its primitive counts are multiplicative, with local values p-2 at p and (p-1)^2 p^(e-2) at p^e, e>=2. It enumerates the exact inducing support at each of the 199350 moduli. Every modulus checks

    sum_eligible_c c*number_primitive(c) = phi(q)^2.

The principal c=1 term is then excluded. No character value is computed. For each profile, insert the uniform per-character count majorant from (2) into the two exact weights. Each nonnegative modulus contribution is rounded upward to a multiple of 10^-12, before division by Y. The total rounding overcount is less than 199350*10^-12/Y. The receipt stores the integer numerators and exact rational final values.

The original profile is H_old(c)=10^8/c for odd c or c<=125000, and 200+75*10^6/c otherwise. The cap profiles mean min(H_old,cap). The star-tail profile is

    Dc=8R/qt(c),
    Hstar(c)=ceil(max(1000,(704/343)Dc)).              (3)

For example Hstar(3)=363700, Hstar(5)=218220, and Hstar(10001)=1000. This profile can exceed H_old at some large conductors; it is not a subset of the old spectral request everywhere.

| Carrier profile | Upper bound for all-line QA | Upper bound for all-line QB |
|---|---:|---:|
| cap 500 | 1.988e-21 | 2.917e-12 |
| cap 1000 | 4.124e-21 | 5.002e-12 |
| Hstar | 2.335e-19 | 5.966e-12 |
| H_old | 2.831e-17 | 8.695e-12 |

All displayed decimals round upward. The QA target is about 5.714e-19 and the QB target about 5.714e-7. An upper bound exceeding a target alone proves no failure. The following lower bound does.

Conductor 3 has one primitive nonprincipal character and omegaA(3)>=3/4 from q=3 and q=6 alone. Formula (2) gives

    C3(2200000)>1677059777081/220000,
    C3(10^8/3)>7349999949952057/50000000.

Reflection therefore implies QA divided by its target is greater than, respectively,

    35218255318701/35200000000000 > 1,
    154349998948993197/8000000000000000 > 19.

Thus the target is impossible for any complete carrier with H3>=2200000, even if all other contributions are dropped. No Gram-domain extension to H_old is needed to prove this obstruction to QA itself.

Conversely, the Hstar upper bound proves a sufficient finite spectral option: if every retained nontrivial zero has beta<=203/400, then Schi<=Y^-1*10^(3/8)*Cchi(Hstar). Since (12/5)^8>1000, the factor 10^(3/8)<12/5. The exact receipt checks (12/5) times both Hstar baseline bounds is below its target. This does not certify the strip. It merely supplies a finite, inclusive, multiplicity-aware condition that would imply QA and QB. No assumption on high zero real parts beyond 0<beta<1 is needed in the next section.

## 4. Fresh full-strip tail at Hstar

This section reuses the Gaussian analytic rule and scalar comparisons from the reviewed hybrid packet, not its QRH-normalized conclusion. The actual positive mixture is

    FU(s,d)=integral_[1/4,1] eta2(r) r^(s-1) Gr(s,dr,0) dr.

For every beta>0 its absolute mixing mass is

    4((1-2^(-beta))/beta)^2 <=4(log 2)^2<2.

Compact r support and the Gaussian integral justify absolute Fubini. At an actual nontrivial zero 0<beta<1, `ZeroSumBound.norm_G_tail:105` applies directly: its domain is -1<=beta<=1, not QRH. For |d|<=Dc/49 and H=Hstar(c), (3) implies H>=32pi Dc/49 and H>=1000. Write D=Dc/49. In the k-th height window, k=floor((|gamma|-H)/4.4),

    |FU(rho,d)| <=2[EB(H) rhoB^k + EA(H,D) rhoA(D)^k]. (4)

Here EB=.892H exp(-.1598H), EA=.588u^2 exp(-.1065u^2), u=H/(pi D); rhoB=exp(-.1398*4.4), rhoA=exp(-1.93*4.4/(pi D)). At d=0 the EA term is exactly zero, not a division by zero argument. For 0<|dr|<=D, monotonicity of u^2 exp(-.1065u^2) above u=10 and monotonicity of the geometric factor give (4). D is a positive upper bound even when the actual twist vanishes.

The actual full-strip finite-window lemma `ZeroSumGen.count_tail_windowG:121` gives, including both signs and true multiplicities,

    count_k <=2 Z3g(BP(c),H)+2 c3g(11,H)(k+1).

At c<=265800 and 1000<=H<=363700 the reviewed polynomial-growth calculation gives Z3g<400 and c3g<53/H. This is a base-height estimate plus a linear growth term valid for every k, not a claim of a fixed 400 count at arbitrarily large heights. Consequently the geometric sum for either rho is bounded by

    800/(1-rho)+.106/(1-rho)^2 <10^10.                (5)

For example the old common bound 1/(1-rhoA)<=1+600001/2.7 and 1/(1-rhoB)<3 suffices; our D is smaller than that old range. The endpoint estimates EA<10^-44 and EB<10^-65 use only u>=32 and H>=1000. They were checked by the pinned positive rational Taylor comparisons in the hybrid scalar script. Combining (4)-(5), even replacing its factor 2 by 1000, yields

    sum_(|gamma|>H) m |FU(rho,d)|
       <1000*10^10*(10^-44+10^-65)<10^-30.            (6)

The sum can first be over any source finite rectangle. Window bounds are uniform in that rectangle; positive summability follows by the geometric series. The reviewed actual finite-carrier/order and good-height limit join then identifies the tail in the actual explicit formula. For y>=Y, y^(beta-1)<=1, so the normalized high-zero remainder is also below 10^-30. The old hybrid bound's extra y^-1/8 is deliberately not used. This is precisely the full-strip high-tail mechanism already visible in the source high branch; the whole low-RH theorem is not invoked.

The low Gram window assumption is separate. At Hstar, a full-strip window of length 3.48 lies in a radius-2.7 disk centered on Re=2, since 2^2+1.74^2<2.7^2. The same polynomial Jensen bound and log(10/2.7)>1 give the checked 400 cap throughout this finite domain (and the few surrounding windows). Do not substitute the radius-2.3 critical-line window lemma. This permits the full-strip G=7e6 parent proof at Hstar.

## 5. Full remainder and what smaller cutoffs would require

The sharp vertical join is unconditional at its own declarations: etaU has constant 900 on Re=-1/2, zero-value bound 600, and the source DN(c) bound. Together with the local m(0)<=400 bound it gives normalized vertical plus zero-at-zero error below 10^-18 at y>=Y on these twists. These zero-at-zero terms are separate from nontrivial real zeros, which already belong to the closed low carrier.

`ArcCharsStar.coprime_split_star:85` bounds the prime-power removal by 10^-12*y. The same nonnegative majorant bounds its character-twisted version because |chi(n)|<=1. Combining it with (6) gives a uniform primitive-to-coprime remainder norm e<2*10^-12. No principal pole is inserted in this nonprincipal calculation; the principal v term in the parent Wstar reduction is still an independent input.

Parseval's exact Gauss mass gives the remainder character energy at q at most phi(q)e^2. Using |P|<1, arc length 2Dq<=8R, phi(q)<=2R and the exact metadata bound

    sum_(q in Qset,squarefree) 1/phi(q)
       <6738254872143/500000000000<14,

the remainder measures obey

    TA^2 <= e^2*(8R)*14 < e^2*4000^2,
    TB^2 <= e^2*(3R/2)*(8R)*(2R) < e^2*(240000000)^2.

Thus TA<8e-9<10^-6 and TB<4.8e-4<1. The principal q=1 overcount in these measure estimates is harmless. All estimates hold for unbounded y>=Y; a pointwise explicit-formula limit and measurable residual are sufficient for the final finite direct-sum integrals.

At c3, the cap500/cap1000 profiles are far below the Gaussian twist threshold H>=10pi Dc/49. Their attractive baseline rows do not come with (4)-(6). A smaller carrier therefore needs a genuinely better joint twist/height estimate, such as retaining |P(delta)|^2 in the tail rather than discarding it. That is the complementary weighted-kernel task. There is no justification for subtracting cumulative upper counts or for assuming the discarded zeros lie on the line.

The concrete next finite spectral target from this calculation is Hstar with the actual weighted QA/QB test, or the sufficient beta<=.5075 strip through that profile. It is neither an actual certificate nor a demonstrated computational saving. It resolves the paper remainder gap for that profile while exposing why a much taller carrier is counterproductive for this particular coarse statistic. Plus-residual energy, pointwise etaU/base-gap energy, the principal certificate and all formal analytic/checker work remain separate.

## Pins and reproduction

Run only the integer/rational inventory with `work/qrh-campaign/interval-env/Scripts/python.exe work/qrh-campaign/agents/zero-sum/wstar_critical_baseline_metadata_20261111.py`. It performs no analytic function evaluations. An initial slower metadata version was interrupted before producing a receipt; the final script was completed successfully. Its output is not spectral evidence.

Paths below are relative to `work/qrh-campaign/agents/`, except the three Lean files relative to `work/ternary-goldbach/TernaryGoldbach/`.

| Input | SHA256 |
|---|---|
| audit/WSTAR_WEIGHTED_SPECTRAL_STATISTIC_2026-11-11.md | AFDBBF90157F5170666C481D512D475A1F719366C8FB785D312A213864C38D0B |
| integration/ELEMENTARY_TURING_PAPER_ASSEMBLY_2026-11-11.md | 72275B5CBA95FDD4F933C2150399C214B2509D9EF91D08A494104466DC8D597C |
| prime-estimates/FINITE_U_HARDY_NORMALIZATION_2026-11-11.md | 06C9D3BF785BB183339D8EC64BE0B5AAD05331184C35356F575A8C126ADB724E |
| zero-sum/FAMILY_PRODUCTION_ENDPOINT_ADDENDUM_2026-11-11.md | 6759192EED071A69B064D793CA307FD563BCB436ACCFB28238C77C5AB74E87F4 |
| independent-feasibility/RESUME_HYBRID_CERTIFICATE_2026-11-11.md | D9D4807F8465EBDA115F0675F4A9EE4DBFF30EED85719AADA963B5F2C0E49B2F |
| independent-feasibility/hybrid_tail_check_2026_11_11.py | 45322AE9C8927CD1B786FCF7243C6EC4B9CD96DED0E23F27756FA7B2C3AE0370 |
| mellin/RESUME_HYBRID_REVIEW_2026-11-11.md | ED23082F7F8BC5C19CBB94B47EC47663EEAB4CBF6C4EA7B0E6CED82D9E100694 |
| major-constants/RESUME_FAMILY_CAPS_2026-11-11.md | 2990B5B5D7ABA1B8262FB18800CA5CE61DC347B7C5748405A5886D9EE45BBAF3 |
| zero-sum/SHARP_VERTICAL_SOURCE_JOIN_2026-11-11.md | FBB5FC9E71CB2199F36331D7BB8AFE1E565A3D8C01F95E0CECF69A9D775D0AA4 |
| zero-sum/ZERO_SUM_SOURCE_JOIN_2026-11-11.md | 600F627B397F7A8E83AE20578D8BA7A7C5EBEC536578EA5EC41D1E3AAC25ABDA |
| Explicit/ZeroSumBound.lean | A1294627F676EC49BED1BD86407A9460DC569B77AF8CBE8D65F1F49129BF17D4 |
| Explicit/ZeroSumGen.lean | 9096C5D611A09FFCF5A4516BFDDC1E518B9917C52B5BC206216AF86A31A52389 |
| MajorArcs/ArcCharsStar.lean | B95DE4A83BAF37008B21FCFF90A0188AA230548C8776DE6C5F2905C19DA9DF10 |
| zero-sum/wstar_critical_baseline_metadata_20261111.py | 1CD94C0545DB1DE770EFF1A8C04BA857181D35D2B67E2528832FD75F701B58B6 |
| zero-sum/wstar_critical_baseline_metadata_20261111.json | A5CA555478A01B9785FB7F04D754AB547CCE280775862DB76863511CB29FAE18 |
