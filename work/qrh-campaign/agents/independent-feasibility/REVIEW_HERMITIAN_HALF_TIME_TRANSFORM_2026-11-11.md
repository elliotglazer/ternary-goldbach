# Independent review of the Hermitian half-length time transform

2026-11-11. PASS at conditional paper and exact-metadata scope, with the explicit row-specific coefficient-bound qualification in section 2 below. This review binds `major-constants/HERMITIAN_HALF_TIME_TRANSFORM_2026-11-11.md`, SHA256 `16BA0E67BF7B674FD29748303DB44CBF0E43808727D053FCC008B3C22886F8A6`. The frozen author files remain unchanged. No transform, root, L-function, zero, prime or other analytic values were evaluated. No builds or source changes were made.

## 1. Exact polynomial and packing

I read the complete author note and script, its receipt, the accepted raw-sign interface and independent review, and the normalized off-grid arithmetic contract. The input is the exact finite polynomial defined by the stored coefficient centers. Its Hermitian negative entries are exact conjugate assignments and its central coefficient is real. This is not an additional assertion about a separately rounded analytic coefficient array.

For N=2m, split a positive-sign length-N transform into entries j and j+m. At even output 2r the two phases agree. At odd output 2r+1 their ratio is -1. Thus the transforms of

    E_j=A_j+A_(j+m),   O_j=zeta_N^j(A_j-A_(j+m))

are exactly U(2r Delta) and U((2r+1)Delta). Transforming E+iO gives their real/imaginary packing because both exact outputs are real. This proves the sign and index convention without evaluating a root of unity.

The actual J<N/4 support ensures that positive indices j and reflected packed indices m-j are disjoint. At the latter index, the minus sign in the odd component cancels the identity zeta_N^(m-j)=-conj(zeta_N^j). Hence the stated pair uses A_j+iT_j and conj(A_j)+i conj(T_j), with T_j=zeta_N^j A_j. C0=(1+i)A0 and all other zero entries account for the complete array. There is no Nyquist contribution.

The normalized half transform returns these two samples divided by m. Projection and the exact dyadic shift by m recover the samples and multiply their absolute errors by m. There is no output omega factor in the raw-sign consumer. This packing does not merge a nonreal character with its inverse character. Both existing positive-height channels remain necessary.

## 2. Complete error and the coefficient-bound qualification

The predecessor butterfly contract uses complex Euclidean errors. Exact inputs of magnitude at most 2B give

    e_next <= (1+u/2)e + (B+2)u.

The exact packed inputs have that magnitude bound. For a polyphase input, let a=(B+1)u be its phase/root/product error. The subsequent phase product and packed addition contribute

    e0 <= (2+u)a+(B+2)u <= (3B+5)u,

provided a<=1. The same bound covers the base array. Negative entries reuse the stored positive product and its conjugate; no statistical independence is assumed. The separate C0 round is included.

After k0-1 stages, the geometric factor is less than two under u<=1/(2k0). Therefore

    ehalf <= [(2k0+4)B+4k0+6]u
           <= (2k0+4)(B+2)u.

With the inherited raw gate u<=eps Delta/[448(2k0+4)(B+1)], multiplication by m=N/2 yields

    m ehalf <= eps N Delta (B+2)/[896(B+1)]
              < eps N Delta/448 < eps/(64H),
    H=44/(7N Delta).

This derivation is valid for every certified B>=1, not only the uniform B=3125000000001 fixed in the author's section 1. The safety conditions also follow uniformly from eps<=2^-82, k0>=18 and the same gate. In particular `(B+2)/(B+1)<=3/2`, and `(B+1)u` is bounded independently of B.

This parametric reading is required when reusing an existing row-specific gate based on B_row=2 Wbar^2+1. Use B_row throughout the error derivation and its own gate. It would be invalid to use the larger uniform-B error coefficient with a looser smaller-row allowance without another comparison. The author's numeric receipt checks the uniform-B case; its formulas prove the general case. The fixed-theta aggregate counts alone do not certify the precision assignments of the separately selected minimal-theta family. That transfer still needs the explicit per-row source, B_row, N and gate bindings stated in the author note.

The optional fresh uniform gates 2^-244 and 2^-345 pass the direct final-error test at theta64 and theta128 for every admitted depth. They are separate sufficient schedules and need not meet the more restrictive formula for the inherited gate. The independent script checks both routes and propagates the actual rational recurrence stage by stage before comparing it with the closed bound.

The existing target-only analytic comparison is applied once. Local interpolation consumes the resulting coarse raw samples under its old error budget. Direct polyphase output does not need a local interpolation remainder. Periodicity belongs to U, and no actual L-function sign or zero follows until the corresponding strict sign and completeness checks succeed.

## 3. Width, roots and typed costs

The integer-magnitude bounds in the note are conservative. Exact normalized nodes have norm at most 2B and approximate nodes have norm below 2B+1. Product and output-sum temporaries fit the stated larger bound. The raw m shift changes the output exponent and error; it creates no additional accuracy. An exponent representation can retain the significand, while an output fixed to a finer common grid requires the corresponding larger integer. Raw sample storage and interpolation must retain this integer range.

The first packed source coefficient can lie on a finer grid 2^-a than the chosen FFT grid 2^-b. Its first root product therefore needs a+b dependent temporary widths. The author correctly separates that from the subsequent b-grid FFT temporaries. The root-construction proof, arbitrary rational source denominators, signed encoding and rounding-witness costs are not covered by a count of FFT products.

For a complete generic radix-two schedule, F(n)=n log2(n)/2. Packing adds J products, 2J complex additions and 3J+1 complex rounds to F(N/2) butterflies. The full-to-half product reduction is N(k0+1)/4-J, strictly positive throughout the domain. Exact conjugations, coordinate swaps, input copies, output selection and shifts remain typed data operations. The old negative-frequency construction cannot be subtracted twice. Polyphase setup adds the same J phase products to either full or half route before the additional half-route packing.

The half FFT root exponents on the N grid are the even indices below m. Adding packing exponents 1 through J gives exactly N/4+ceil(J/2) entries in the conservative root set, all inside the old N/2 table. Reusing a table requires the same sign and sufficient precision. A fresh subset can cost less to construct, but it still requires certified roots and storage. Additional polyphase roots retain their original order dN and setup obligations.

The m-complex workspace packs N real outputs. This reduces the specified workspace, not every cache, source array, proof object or parallel copy. A persistent service still retains its N real answers or pays its chosen recomputation policy. Padded transforms larger than the checked N range require an explicit extension of the error and width proof.

## 4. Independent exact evidence

Owned script `independent-feasibility/review_hermitian_half_time_20261111.py`, SHA256 `48C6908C07C17E4F6E242B6AFA0090C6890CCDF3E319E61908CFE66BF4B7B793`, and receipt `independent-feasibility/review_hermitian_half_time_20261111.json`, SHA256 `312A14BEB21538FC0DC8F08622F8DC60E6E2C5263C847232BC34734CFA468F5B`, pass 23144 exact checks. The author script was read but neither imported nor executed.

The checks verify all seven input pins; separate even/odd phase congruences for finite abstract arrays; sparse index disjointness and root-set sizes; the stagewise rational error recurrence for both sufficient gate schedules; the formal affine-in-B coefficient identity and representative row-bound safety checks; and all eight saved whole-family count rows. Both saved conductor-parity totals sum to the complete domain used in each row. This does not independently regenerate the predecessor conductor inventory.

The main fixed-theta product totals are reproduced as 63071376038601 at theta64 and 43822509521403 at theta128. All 18477108 primitive labels and all N real outputs per array remain. These are complex-product counts for a specified circuit. They establish neither equal bit cost per product nor elapsed-time savings. The inherited Gaussian, character-transform, source-coefficient, principal, auxiliary, strict-sign and count work remains outside the reduction.

The complete input manifest is retained in the script and receipt. It binds the author report, author script and receipt, raw-sign author and independent review, off-grid arithmetic predecessor, and the saved whole-family inventory. This review accepts the finite algebraic replacement and its sufficient error interface. Implementation proofs, actual source-array data, root and rounding certificates, successful signs and finite-RH completion remain open.
