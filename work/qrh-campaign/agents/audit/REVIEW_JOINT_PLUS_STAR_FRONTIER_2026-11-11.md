# Review of the joint plus/star frontier

2026-11-11. PASS for the conditional mathematical implication and exact scalar rows. No correction requested. No actual energy, finite-RH certificate or runtime improvement is established. No analytic evaluations, builds or source edits were performed.

The reviewed root note is `work/qrh-blueprint/JOINT_PLUS_STAR_FRONTIER_2026-11-11.md`, SHA256 `BA12BDC77B0FFAA154B99F64ECBDCDBED9FA9C4D39D3265CD79A16B5B5D75C4F`. Its checker is `18CFCB19014B7602F3984105F9A1BE5AB0D8AC13C1359D140364EC726891F573`; its receipt is `AA2D645CADEE8E0EFEFB0252A954470C24F4B90DC65E3A2F7DC4F4D23E28D030`. All three pins and all three input-report pins match.

## Actual norms and normalization

I read the complete note and checker, and compared the formulas with the actual-function and source checks in my separately frozen reallocation review, `REVIEW_PLUS_STAR_CUBIC_BUDGET_REALLOCATION_2026-11-11.md`, SHA256 `AD993398C6E41DCCE3A9826C0FA5BF6DA89A3B0139672429D7BD61E797DE9F0E`.

On the same finite tagged arc carrier, let s=Sp/x, r=s-a_q P, and Ss/y-As/y=u+v. The delta-to-beta Jacobian is 1/x and y=x/49. Therefore

    49^2 Wstar/x^3 = ||s(u+v)||_2^2,
    ||s(u+v)||_2 <= p+sqrt(A)+rho*sqrt(B).

Here p=1.902e-6 is the complete integrated principal/removal norm. It is added once, without another sqrt(j) inside this norm. The full cubic bound has a separate factor sqrt(X/x)<=sqrt(j), so the external factor sqrt(j) in the new note is necessary and correct. With A<=a^2, a>=0, and B<=1915 this term is at most sqrt(j)*(p+a+rho*sqrt(1915)). No cross term is dropped by treating u and v as separate energies.

The plus mixed moment still satisfies 49^2 Wplus/x^3<=49*rho^2*v0, v0=7.78*2.85. Its cubic coefficient is bounded by rho*C using the already checked rational AM-GM envelope, where

    C=49*(j+a0)/9+9*v0/2,
    a0=.640208*13.59756, j=8.79.

Thus the displayed joint inequality is the direct sufficient condition for the actual physical cubic discrepancy. It does not need an intermediate rounded star parameter. The unchanged Fourier tail and the unchanged original error allowance are compatible with this replacement. The earlier source check binds `MajorTotal.pointwise_bound:760`, `per_modulus:808`, and the Fourier-energy calculations at lines 887 and 905 to source SHA256 `106293987C887D3586DC3483260B135853730F3A20466D0D7E71ABC61AB9F84A`.

## Uniform moment and principal prerequisites

Changing rho could invalidate the old X and p estimates unless the integrated residual bound is checked again. The new note does check it. Every displayed rho satisfies

    16*150000*19*rho^2 < .006^2.

Consequently the prior X/x<j bound and weighted-principal bound remain applicable with exactly their previous constants. The finite harmonic estimate and the principal finite inputs remain dependencies. This is a uniform implication for x>=4.9e26, not a pointwise numerical sample.

The direct B<1915 result retains its principal-only localization, coefficient and finite-arithmetic premises. They are not proved by the joint inequality. A remains an actual unaveraged, Gauss-weighted energy on the stated carrier. Neither a smaller conductor subset nor a discretized estimate can replace it without a separate theorem.

## Exact rows and downward energy caps

The positive rational witnesses 2.965^2>j and 43.762^2>1915 dominate both square roots. All coefficients they multiply are nonnegative. For each of the five rows I independently verified

    E - 2.965*(p+a+43.762*rho)-C*rho > 0,

and verified that replacing rho by rho+1e-9 makes this rational envelope exceed E. The slope C+2.965*43.762 is positive, so this proves the stated grid maximality for that envelope. It does not claim maximality for the original square-root expression or other possible allocations.

The full plus residual follows from nonprincipal energy epsilon through the orthogonal principal decomposition and the outer-removal triangle bound. The sufficient cap is

    epsilon <= (rho-516e-15)^2-(2.83e-7)^2.

Each difference rho-516e-15 and each cap is strictly positive. For all five displayed decimal caps, I checked that the decimal is at most the exact cap and that adding 1e-18 would exceed it. Thus each is the claimed downward rounding, not a nearest-rounded value that might be too large. This cap includes the principal constant-vector energy and the outer additive removal in their correct order.

The five rows are reproduced exactly by the independent calculation. In particular A<=9e-12 permits rho=5.86e-7 with sufficient nonprincipal plus energy 2.63306e-13, while retaining B<=1915. The A=0 row is a formal endpoint only.

## Independent evidence and remaining scope

Independent checker: `audit/review_joint_plus_star_frontier_20261111.py`, SHA256 `06E9439DC38894DA325A2B6115DEB93BECE1453BED1B6B6BEDBF84D3CC1E3BA9`.

Independent receipt: `audit/review_joint_plus_star_frontier_20261111.json`, SHA256 `5441B735272B8947F4E062A49C0AC53744DAFC7D16B1BFE1EF889CDB8C16E086`.

All 30 checks passed. They reconstruct the source coefficients, all five exact rows, root bounds, positive caps, integrated Z constraints, and downward decimal rounding using only integers and Fractions. The producer checker was neither imported nor executed.

A new plus-height theorem may use these larger energy caps only after proving its full low/tail/vertical/removal estimate and the required conductor, twist and closed-height coverage. Base-gap, principal and final finite-coverage obligations remain separate. The inequality itself neither changes the final theorem premises nor establishes any spectral or runtime saving.
