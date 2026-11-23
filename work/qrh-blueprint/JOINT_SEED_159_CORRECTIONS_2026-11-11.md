# Use the Euclidean factor bound to reduce corrections to159

2026-11-11. Conditional mathematical refinement, pending independent review. The m224 report and its independent review remain unchanged. At the same V7000, D4096, N1500 and P28, it is sufficient to use m159 corrections. No new precision, mesh, elementary argument or output requirement is introduced.

The improvement comes from two elementary bounds in the finite Euler–Maclaurin remainder. First, b lies in[1501,1502], so sqrt(b)<39 since1502<39^2. Second, the combined rising product is (s)_(k+2m), with s=1/2+it, |t|<=7000 and k<=27. Every factor s+j has0<=j<=k+2m-1, and therefore

    |s+j|^2 <=7000^2+(k+2m-1/2)^2
              <=7000^2+(344.5)^2 <7009^2.

Thus W=7009 is a valid bound for every rising factor at every required order. This replaces the much looser triangle bound V+32+2m. The source product has no factors outside this range. The E recurrence ends earlier still: its largest index is k+2m-1<=344, and its last multiplicative factor is s+343.

The same actual finite remainder as in the reviewed joint construction now satisfies

    error_k <=156/(k+317.5) * (7009/(1501*4096))^k/k!
                            * (7009/9006)^318
             <= R :=156/317.5 * (7009/9006)^318 <2^-116.

These are exact rational comparisons after the two squared inequalities. The script verifies every k in0,...,27. Re(s+k)+318>1 and |s+k-1|>=1/2 still hold, including k=t=0, so the finite EM formula and its pole term are retained. No infinite-series convergence claim is used.

The ratio7009/9006 is less than17/20, so the old E7u error and geometric correction magnitude bounds remain conservative. R and lambda are unchanged and keep8u and2u. With159 rounded correction terms,31*159*u is smaller than the old7936*u allowance. Hence the entire inherited source bound10507*delta+278753*u+R remains below .107*eta, and the unchanged translated numerical output remains below .557*eta. All later analytic shift and target remainders, normalization8192, P20 output, final Horner costs and magnitude arguments remain as in the independently reviewed joint construction. The full isolated-alpha error stays below .16*2^-82. Numerical coefficient radii still exclude the separately accounted analytic translation bias.

There are114716 source slots. Relative to m256, this removes97 correction terms per slot:11127452 gamma scales and the same number of additions per height. The E index drops from538 to344, removing794818 E stages per height. Relative to m224, it removes7456540 gamma scales and additions and532610 E stages per height. The new totals are18239844 gamma terms and1409368 E stages per height. Setup needs159 gamma constants, with exact Bernoulli indices through318. Only95 of them are additional to the old m64 baseline.

All head operations, elementary argument sets, state lifetimes, output transport and downstream transforms are unchanged. The same loop implementation loses these operations without adding another listed category. This is not a claim of global optimality, measured runtime, or equivalent approximate centers. The shorter finite sum has a new proved remainder and requires its own actual numerical certificates when implemented.

Evidence: m224 author `E438F4EF3AEC8352947B046E55C07418D9DA233B5E602B6FEF5CB402600F61F5`; m224 independent review `7A74329B1D51F9E0113ECB76DC68DC1DC7F4182EAF29209DE47CE068EF84D888`. The earlier actual EM identity and all-order Bernoulli estimate are inherited from the reviewed m256 joint construction `AA1A7464A38CA5FDEDF21F000965C765DE22DFB2C8D4F796EC5C0B0A7A8F1D9F`, reviewed at `2F057C0F2507452AC959587E13FD1AE8F9117FC75CBC3BA1C6364E8C5BF0064A`. The new standalone checker and JSON use only rational/integer metadata, no analytic evaluations, builds or production scans.
