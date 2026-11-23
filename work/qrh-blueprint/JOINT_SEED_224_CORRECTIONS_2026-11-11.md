# Remove 32 correction terms from the joint seed construction

2026-11-11. A conditional paper refinement of the independently reviewed joint seed construction. Fix V=7000, D=4096, N=1500 and P=28, but use m=224 instead of256. The output remains P20 with normalization8192 and the same16385 fine anchors. This note is a new proposal awaiting independent review; it is not an implementation or numerical certificate.

## The finite remainder still fits

The predecessor's actual continued-Hurwitz coefficient is unchanged. Its finite Euler–Maclaurin identity holds for every positive integer m with Re(s+k)+2m>1. Here b=N+1+a lies in[1501,1502], s=1/2+it, |t|<=7000 and0<=k<28. The denominator s+k-1 still has magnitude at least1/2. No pole term or half term is removed.

Set W=V+32+2m=7480 and r=W/(6*1501). The same periodic-Bernoulli bound gives

    |U_k-U_k^EM| <= 4*sqrt(b)/(k+2m-1/2)
                    * (W/(bD))^k/k! * (W/(6b))^(2m)
                  <= R = [4*1502/(447.5)]*(7480/9006)^448
                  < 2^-116.

The final inequality is an exact rational comparison. It uses the sharper actual ratio7480/9006, rather than replacing that ratio by17/20 before taking the448th power. The other inequalities use sqrt(b)<=1502, b>=1501, W/(bD)<1 and k!>=1. The companion script checks each required k-dependent majorant as well. This bounds the actual finite remainder, not convergence of an infinite asymptotic series.

## All prior error allowances remain valid

The ratio r is less than17/20, so the existing E recurrence error7u remains valid. The unchanged R and lambda recurrences retain their8u and2u bounds. Each rounded gamma-E term still costs at most31u. There are224 terms instead of256, so the old7936u correction allowance is conservative. The geometric bound on the true correction sum remains below13. The predecessor's pole, half, Z, F and head error estimates therefore remain valid without changing any precision.

Consequently the original common bound

    e_seed <=10507*delta+278753*u+R < .107*eta,
    delta=2^-118, u=2^-122, eta=2^-100

holds at every source endpoint and order. The unchanged translated output has numerical error at most2*e_seed+351*2^-110<.557*eta. The analytic translation bias, P20 target remainder, coefficient amplification and final Horner rounding are unchanged, so the already reviewed full isolated-alpha bound below .16*2^-82 applies. The numerical eta radius still describes the finite translated polynomial, with analytic translation bias added separately.

The magnitude proof remains valid: the shorter correction sum is bounded by the same geometric majorant, giving the same source and intermediate magnitude caps. Exact rational temporary widths still need implementation-specific bounds. The new centers need not equal, or lie in immutable boxes around, the old centers.

## Concrete work removed

The set of elementary arguments, height recurrence, source coefficients, output shifts, denominator construction for existing terms, and final normalization are unchanged. The complete argument union remains7049217, with6148097 final active arguments and no final-band initialization. The final four height counts remain20199,20366,20519 and20839.

There are114716 source coefficient slots per height. Removing32 terms therefore removes3670912 gamma scales and3670912 gamma additions per height. The largest E index falls from538 to474, removing64*4097=262208 E stages per height. The retained totals are25696384 gamma terms and1941978 E stages per height. The initial gamma table needs only indices1 through224, with Bernoulli indices through448 rather than512. Relative to the original m64 baseline,160 new gamma constants remain required.

For the same loop-based arithmetic implementation, the new schedule deletes these operations and adds none of another listed category. This is stronger than a trade between head and correction costs. It does not prove lower wall time across arbitrary different implementations, remove the one-time proof of this refinement, or establish the global optimality of224. It also does not choose between the m224 construction and another head length with fewer corrections.

## Evidence and remaining scope

Predecessor: `work/qrh-campaign/agents/major-constants/JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md`, SHA256 `AA1A7464A38CA5FDEDF21F000965C765DE22DFB2C8D4F796EC5C0B0A7A8F1D9F`.

Independent predecessor review: `work/qrh-campaign/agents/audit/REVIEW_JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md`, SHA256 `2F057C0F2507452AC959587E13FD1AE8F9117FC75CBC3BA1C6364E8C5BF0064A`.

The companion `check_joint_seed_m224_20261111.py` verifies the input pins, rational remainder and inherited error inequalities, and the per-prefix saved counts. No analytic function, prime or zero is evaluated. No Lean/MM0 build or source edit is performed. Actual elementary enclosures, sign and completeness certificates, formal analytic foundations and end-to-end proof costs remain obligations.
