# Independent review: interpolation for every selected integer theta

Date: 2026-11-11. Verdict: PASS, with no correction required. This is an applicability proof using reviewed parameter admissions and a reviewed interpolation construction, not a new spectral computation or replay of the entire selector inventory.

Author: `integration/MINIMAL_THETA_INTERPOLATION_APPLICABILITY_2026-11-11.md`, SHA-256 `BEE442CFF66187EAEEC930441D0AE414725A198A72B394A47701DB27E1D6B8FC`.

I read the full supplement, minimal-theta report, mandatory bucket clarification, independent selector review and relevant backend allocations. All eight input hashes match. No analytic functions, transform values, primes or zeros were evaluated; no builds, parameter searches or frozen-file edits were performed.

## Scope of the extension

The previous interpolation statement explicitly selected theta64 or theta128. The new supplement correctly supplies an additional proof for each selected integer 64<=theta<=128, rather than describing those cases as already covered. The admitted 130 cohort/theta parameter sets and 29,996 selected conductor/guard rows are supplied by the earlier reviewed finite metadata. This review does not independently rerun those hundreds of thousands of checks.

The needed uniform facts are exactly the ones supplied by those admissions: V>=2theta, 1<=cV/theta<=Wbar<=1250000, X=10, n0=8192, Delta=5/64, P=N*Delta>=max(2VK/theta,V+2K,6), and J=ceil(PX/6)<N/2. They preserve the full time/frequency/Gaussian tail proofs. Checking only the time length would not establish this; the independent selector review explicitly checked the other conditions for every integer theta.

For each row epsilon=2^-80/(4*3^theta)>=epsilon128. The finite polynomial from that row's own stored centers therefore has the same global derivative majorants as before: M<=44(2*1250000^2+1), Omega<=242/21. The previously proved worst-case remainder is below epsilon128/16 and hence epsilon/16. The 340-node rational kernels and their norm bound less than4 do not depend on theta, conductor, parity or N. No interpolation from endpoint parameter tests is involved.

Changing theta changes the coefficient values and tilt. Equal N gives equal array dimensions, not equal functions or reusable old numerical boxes. The supplement preserves this distinction and requires new certificates bound to the selected row's centers.

## Corrected bucket and exact time allocations

The minimal-theta report's exact-bucket sentence is expressly excluded. The mandatory clarification retains hT rounded additions, with complex norm error per addition at most epsilon/(32*C*Bpref*n0). At a fixed parity/frequency, at most n0 summands contribute, so their l1 accumulation is at most epsilon/(32*C*Bpref). It combines with the separately bounded Gaussian input error before the character transform. No additional phi(c) factor is needed for unit-modulus character entries, and no intrinsic transform error is thereby discharged. These allocations, their costs, and the original coordinate-to-norm rounding obligations remain in force.

With k=log2(N), Ctime=2k+4 and B=2Wbar^2+1, the supplement divides the selected row's entire sufficient time tolerance by16:

    min(1/(2k), epsilon*Delta/[56*Ctime*(B+1)])/16
      =min(1/(32k), epsilon*Delta/[896*Ctime*(B+1)]).

The equality holds exactly for positive16. The original safety condition is strengthened, and the error term bounded linearly by this tolerance is reduced from epsilon/8 to epsilon/128. The omega approximation becomes epsilon/[256*N*(B+1)] and the final time-output multiplication rounding epsilon/256. Each is also the old allocation divided16; together they contribute at most epsilon/128. Thus every algebraic T-grid output has total error at most epsilon/64, including all scaling. This is not an unscaled normalized-DFT allowance.

A dyadic radius meeting an old local tolerance still meets its divided tolerance after increasing its fractional-bit exponent by4. The statement is relative to each selected theta's own tolerance and coefficient bound. It is not a claim about total signed word width, every stage's precision, or elapsed time. A shared cache must satisfy the smallest tolerance among its actual uses.

The new interpolation then has, as before, target-only analytic/coefficient error less than3epsilon/4, weighted sample error less thanepsilon/16, interpolation remainder less thanepsilon/16, and kernel/evaluation error at mostepsilon/16. Their sum is strictly below15epsilon/16<epsilon. The target analytic error is added once because the interpolated samples belong to the exact finite T, not to F_b or Y.

## Boundaries, dimensions and remaining obligations

Periodic index reduction remains legal only for T. Its complete N-output FFT arithmetic bound applies even outside the physical prefix; no assertion about periodicity or negative/top values of F_b or Y is required. Every final target remains in [0,V]. For numerical Y outputs the selected theta's positive-scale allocation and off-grid scale certificates must also be supplied. For strict signs only, that positive scaling can be omitted using the proved identity. Neither case changes the canonical Turing phase or proves a count surplus.

Relative to the selected minimal-theta row, N, J, n0, character dimensions, coefficient work and all hT bucket operations are unchanged. The stricter time allocations do not require new Gaussian or character work. The 340-term query and kernel costs are inherited from the previous interpolation proposal, not included retroactively for free in the original coarse inventory. Retaining or recomputing the T samples remains necessary; the exported Y prefix alone is insufficient.

The accepted input bundle is the minimal-theta report `73337A5EB2688E5B1A5196A901232A314D89F3E48B5EEFC013CA178A8FFA238A`, bucket clarification `4ACF800D0F7C773FA5A2DF013BD5F1341ED3CC98C0F9D257D81A2EE63B480D41`, selector review `58215EA3A0D697D229AD746F6FCE340DE913165D63599DC197798E705392308B`, interpolation author `19E411982E0D504C52F604145D6404ACB3BEBA51B662CB7BB1CDBD5D31E83081` and own interpolation review `B815BBEEF96C0E8D1259A915E8BB0F3BEB98BBD1CFB9473B038E0B3D64F3A38F`. The remaining three checked inputs are the interpolation script/receipt and backend named in the author ledger.

Actual coefficient/sample values, ordinary-rule arithmetic implementations, strict signs, central evidence, auxiliary sufficiency and complete finite-RH certificates remain open. This review makes no new all-row execution or performance claim.
