# Joint m159 costs and a bounded head/correction screen

2026-11-11. Conditional cost supplement. The m159 construction has an independent mathematical review; the other N/m pairs below are only exact remainder and cost screens. No function values, prime or zero calculations, builds, new Lean declarations, or frozen-file edits were made.

The accepted replacement keeps V7000, D4096, N1500, P28 and changes m256 to m159. It preserves the same fine P20 output, denominator16384 and normalization8192. The new cost comparison has substantially less correction work while retaining all head, state, translation and output work. The strongest next bounded candidate from this screen is N1450/m184, subject to the explicit price test and uncompleted error checks below.

## 1. Accepted input and unchanged scope

Root author `work/qrh-blueprint/JOINT_SEED_159_CORRECTIONS_2026-11-11.md`, SHA256 `E6F0F3B277828EA451E05F3608478F760C83F02FEE1B70A899FA40434781CBE9`, has independent PASS at `audit/REVIEW_JOINT_SEED_159_CORRECTIONS_2026-11-11.md`, SHA256 `09DEF5ABB358A807936270B07E61FFEE624EF0F04C3E17AC47A1179D944E2E82`. I read both in full. This supplement consumes that reviewed result rather than treating fewer corrections as automatically preserving error.

In the actual combined rising product, k<=27 and m159 imply factor real part at most344.5. The squared norm bound uses7000^2+344.5^2<7009^2. Also sqrt(b)<39. Those two bounds give the reviewed finite remainder below2^-116 and retain the previous conservative E, source, translated-output and isolated-alpha error allowances. The new finite sums need their own actual numerical certificates. There is no containment claim about old approximate centers.

Let J159 denote this accepted construction and J256 the immutable fourth row reviewed earlier. B,Q,C keep their former meanings. All comparisons use the same final-band lengths H20199,20366,20519,20839, with64001 earlier heights. In particular +640 uses H20839, total84840 and last ordinate424195/64<7000. No auxiliary success is assumed.

## 2. Exact cost update

J159 has18239844 gamma scales and separately gamma additions per final height, and1409368 E stages. Everything else in J256's displayed per-height row is unchanged:

| Category | J159 |
|---|---:|
| Head scales |165928500|
| Head additions |172074000|
| Source slots |114716|
| Coarse anchors |4097|
| R stages |27|
| Translation updates |4300800|
| Extra normalization scales and separately rounds |327700|
| Arguments, fine updates and separately EM copies |6148097|

Relative to J256, each height loses11127452 gamma scales, the same number of gamma additions, and794818 E stages. The existing loop can omit these operations. The one-time new finite-remainder proof and its implementation are not assigned zero cost. Fewer operations is not a proof of a particular runtime saving or of equality of the resulting approximate centers.

The phase/state union remains7049217. The final transition retires901120 and introduces none, so every retained state updates at the first final height. No union-sized subtraction is allowed from H*6148097. The log recipe remains960 anchors and148013397 nonanchor Horner stages, all already required before the final band. Gamma setup now needs159 constants through Bernoulli index318, of which95 are beyond the old m64 baseline. The same extra D4096 lambda entry is needed.

Retain the earlier nonnegative category prices h,a,g,b,e,o,v,r,t,n,s,c, where n prices the extra normalization scale plus round. These are common prices only within a stated model. Let F_i,159=S_i-S_159-(I_i-I_159)s; I_159=0. Then the updated exact tests are as follows.

J159 beats B when

    4082788(g+b)+155846e+1597440t+327700n+r
      <342528757h+355939948a+106488o+4096v
        +13414400(s+c)+F_B,159/H.

J159 beats Q when

    10898020(g+b)+778430e
      <98119053h+101753092a+3633152(s+c)+F_Q,159/H.

J159 beats C when

    1597440t+327700n+r
      <153588000h+159732000a+38388380(g+b)+2990266e
        +106488o+4096v+6148096(s+c)+F_C,159/H.

These replace the respective correction/E coefficients in the m256 comparison; they do not change that frozen report. If costs vary by route, order or width, replace the products by actual sums. A common upper bound does not justify an ordering of actual implementations.

For the optional setup model, let Gamma_m be the complete additional certified gamma setup beyond m64 to m, Lambda the extra D4096 lambda setup, i non-log argument initialization, l a log stage and z an anchor certificate. Then

    F_B,159=12513280(i-s)+262778019l+41z-Gamma_159-Lambda+Delta_B,159,
    F_Q,159= 2732032(i-s)+ 57371790l+42z-Gamma_159       +Delta_Q,159,
    F_C,159= 6148096(i-s)+148033557l- z+Gamma_256-Gamma_159
                                                      -Lambda+Delta_C,159.

Gamma_m is a full setup cost, not m-64 constant-time operations. The positive gamma difference in F_C,159 is new; it no longer cancels as it did against J256. The J256-to-J159 difference is H*[11127452(g+b)+794818e]+Gamma_256-Gamma_159 plus all remaining setup/implementation differences. Treating those last differences as zero requires an explicit common implementation.

## 3. Parametric remainder screen

For the same V,D,P, examine only N in{1400,1450,1500,1550,1600,1660,1720} and integer64<=m<=256. Define exact integer upper bounds

    W(N,m)=floor(sqrt(4*7000^2+(4m+53)^2))/2 rounded down, then add1,
    S(N)=floor(sqrt(N+2))+1.

More unambiguously, the implemented formula is W=isqrt(4*7000^2+(4m+53)^2)//2+1. Thus W^2>7000^2+(27+2m-1/2)^2 and S^2>N+2, including perfect-square edge cases. These are integer metadata, not evaluated analytic function values.

The actual remainder's factors satisfy the same Euclidean bound, so a sufficient scalar screen is

    R(N,m)=8S/(4m-1) * [W/(6(N+1))]^(2m) <2^-116,
    W/[(N+1)D]<1,    W/[6(N+1)]<17/20.                (1)

The first ratio and the factorial/denominator factors make k=0 a valid common upper bound for all0<=k<=27. This uses the already reviewed finite EM formula. The second ratio permits the same conservative E contraction allowance. Equation (1) is not the full source/output error proof: the N- and m-dependent head and endpoint errors, correction sums, stored magnitudes, normalization and lifetime interpretation must also be checked before acceptance.

The companion tests every integer m in the declared bounded range. The first passing m for each N is:

| N | m | W | S | Final arguments | Retired from prior grid |
|---:|---:|---:|---:|---:|---:|
|1400|220|7016|38|5738497|1310720|
|1450|184|7012|39|5943297|1105920|
|1500|159|7009|39|6148097|901120|
|1550|141|7007|40|6352897|696320|
|1600|127|7006|41|6557697|491520|
|1660|114|7005|41|6803457|245760|
|1720|104|7004|42|7049217|0|

“First passing” refers only to this sufficient test and m range. It is not a minimum possible correction order, an optimized bound, or a globally optimal N/m choice. All seven final grids are subsets of the existing D4096 grid through x1722. Hence they have the same required argument union7049217, zero final introductions, and the same conservative log setup. Their retained fine states still need the first transition update. No smaller sparse-log construction is assumed.

At fixed D,P, head costs and retained-state costs increase with N; correction and E costs increase with m. The listed pairs therefore expose opposing coordinates rather than a count-only winner. They do not improve the lower four bands or the target contractions/transforms. The full normalized coefficient contracts are approved here only for N1500/m159 through the cited review.

## 4. One next candidate and its falsifiable price test

Consider N1450/m184. Relative to J159 it removes5530950 head scales,5735800 head additions and204800 fine-state updates and EM copies per final height. It adds2867900 gamma scales, the same number of gamma additions and204850 E stages. Other displayed counts, the log grid, phase union, lambda table, output normalization and shifts are identical. It requires25 more gamma constants, through Bernoulli index368 instead of318.

Let Delta be S_159-S_1450 after separating the gamma setup difference. If the complete new error proof is accepted, this candidate wins in the common-price model precisely when

    2867900(g+b)+204850e+(Gamma_184-Gamma_159)/H
      <5530950h+5735800a+204800(s+c)+Delta/H.           (2)

There is no introduced-state correction in (2), because both final grids introduce zero states. Retiring an additional204800 states is not an RSS measurement. Existing earlier-band consumers still require all7049217 arguments.

This is a bounded next research choice. First check the complete N1450/m184 error and magnitude composition against the same actual continued-Hurwitz target. Then price its head-versus-correction tradeoff in the intended ordinary proof representation. Reject it as an optimization if (2) fails. Wider coefficient denominators, exact Bernoulli witnesses, one-time proof changes and route-dependent gate costs belong in that comparison. Do not infer a saving from N decreasing alone, or assume that fewer E stages at larger N selects the opposite branch.

## 5. Evidence and retained limits

Owned `joint_seed_m159_cost_screen_20261111.py`, SHA256 `D91EC28FD860780C95412B13F8C4167E0EB364B8490D6A9FD71D0567D6185F93`, passed2757 integer/rational checks. Its receipt `joint_seed_m159_cost_screen_20261111.json` has SHA256 `DDF48DE42BBB771591E25ABA23327A8B283DDE84DABD8F609ABB348E5A291BB2`. The script imports no producer and computes no modular roots, elementary functions or spectral values. It reconstructs the m159 category changes, all four common height scenarios, and the bounded squared-inequality/power comparisons in (1).

The receipt verifies six input pins: the m159 author and review above; root checker `7F0B7BD1C597629D6DBD687730E767C5CB660286F6B5CBA57599EF24757E84A4`; root receipt `EF16593CF667377CD68CA9D3C37343E3364ECA06CABACCC9B8465931E2D83D45`; the m256 cost extension `zero-sum/JOINT_FINAL_SEED_CONDITIONAL_COST_COMPARISON_2026-11-11.md`, `369DD6AB04FC68ACB675BBFB24518E2CD025C0D8416D07A99A5BC747F7E86249`; and my independent four-row cost receipt `C77F6F4E1C5A8B63A632ABDC35119A659AAF2BB6E283A8D4148B4295A6A4C598`. The associated m256 cost review remains frozen at `AC7305BA2D2DAA361FEB52BE6FFC98AA95E0E485DFDF01C334547B8C9B6DF7D3`.

Actual leaf certificates, successful output enclosures, sign/count closure and standard-axioms Lean/MM0 acceptance remain open. Common fractional precision is not a bound on all exact operand widths. This supplement selects no measured runtime winner and supplies no final core-hour estimate.
