# Half-length time transform for the real finite polynomial

2026-11-11. Paper derivation and exact symbolic/integer metadata. No Fourier, elementary, L-function, prime or zero values were evaluated. No build, declaration or source edit was made. Frozen predecessors remain unchanged.

## 1. Result and inherited domain

The actual Hermitian frequency array can be evaluated by one positive-sign complex transform of length N/2. Its complex output packs consecutive even and odd real values of the same raw polynomial. The sparse frequency support permits packing with only J complex products, rather than N/2 products. A complete rounding bound below fits the already accepted raw-sign time-gate allocation, including phase-modified inputs for polyphase queries.

A campaign search for Hermitian, real FFT, half-length and packed-transform constructions found frequency conjugacy and the existing full-length schedules, but no earlier half-length time-transform derivation. This note supplies that finite arithmetic step. It does not remove an inverse-character channel or any Gaussian/character transform.

Fix one actual primitive nonprincipal character, its fixed canonical unit phase and the exact stored coefficient centers. Let

    N=2^k0, 18<=k0<=31, m=N/2, Delta=5/64,
    J=ceil(25N/192), omega=2*pi/(N Delta),
    A_-j=conj(A_j), A_0 real,
    U(t)=sum_{j=-J}^J A_j exp(i*j*omega*t).

The array is zero outside these frequencies, including the Nyquist slot. In fact J<N/4=m/2, since J<=25N/192+1 and N>=2^18. This stronger support fact is used in the sparse packing, not merely J<N/2.

Use the reviewed raw-sign interface: |F_b(t)-omega U(t)|<3eps/4 on the admitted [0,V], eps=2^-82/3^theta, and the fixed phase makes U real. The admitted endpoint tilts are 64 and 128. The finite arithmetic theorem also applies to any separately admitted intermediate tilt with the same bounds; it does not establish that analytic admission. The uniform coefficient bound is B=3125000000001<2^42.

Let L=6/(N Delta) and H=44/(7N Delta), so L<omega<H. A raw sample error <=eps/(64H) is sufficient for the existing raw interpolation/sign contract. The exact conservative sign radius remains 109eps*N*Delta/704, with target-domain, central, multiplicity and completeness obligations unchanged.

## 2. Exact positive-transform packing

Write zeta=exp(2*pi*i/N). First regard A as a length-N array with signed frequencies embedded at j or N-j. For 0<=j<m define

    E_j=A_j+A_(j+m),
    O_j=zeta^j (A_j-A_(j+m)),
    C_j=E_j+i O_j.

The positive UNNORMALIZED length-m DFT gives

    sum_{j=0}^{m-1} C_j zeta^(2jr)
       = U(2r Delta) + i U((2r+1)Delta),  0<=r<m.          (1)

To prove (1), split the length-N sum into j and j+m. At an even output 2r their phase ratio is one, giving E. At an odd output 2r+1 their ratio is minus one, giving O. Linearity then gives (1). The Hermitian assignment makes both U values real, so the real and imaginary projections recover the two samples. The sign of i is positive because the DFT exponent is positive.

For the actual sparse support only the following packed entries are nonzero:

    C_0=(1+i)A_0;
    for 1<=j<=J, set T_j=zeta^j A_j,
    C_j=A_j+i T_j,
    C_(m-j)=conj(A_j)+i conj(T_j).                         (2)

The sets 1..J and m-J..m-1 are disjoint. Formula (2) follows from zeta^(m-j)=-conj(zeta^j). All other packed slots are exact zero. There is no missing Nyquist or central coefficient. C_0 is explicit and is not counted among the J products.

For a stage-normalized positive FFT, let Z_r=(1/m)sum C_j zeta^(2jr). Then the raw output reconstruction is exactly

    U(2r Delta)=m Re Z_r,    U((2r+1)Delta)=m Im Z_r.       (3)

Multiplication by m is an exact power-of-two shift in a dyadic representation. Its error scales by m as well. There is no extra root, omega multiplication, or complex output recombination after the FFT. A query at an even or odd integer grid index chooses the appropriate component.

## 3. Full packing and FFT error

All errors in this section are complex Euclidean norms. Certify each used unit root to absolute error <=u. Every named rounding returns a dyadic complex number with norm error <=u. Exact sign flips, conjugations, coordinate swaps and power-of-two division precede their stated roundings.

For the base array, compute T_j with one rounded complex product. Compute each packed sum in (2) and round it once. Round C_0 once. Since the coefficient centers are exact, a product error is at most (B+1)u and every packed input error is at most (B+2)u. The exact packed magnitude is at most 2B, including C_0. Exact zero slots need no rounding.

For a nonzero polyphase class ell/d, d in {2,4,8}, first compute

    A'_j=round_u(A_j exp(2*pi*i*j*ell/(dN)))

for positive j, and define its negative partner by exact conjugation. The exact phase-modified coefficients still have magnitude <=B and are Hermitian. Their input error is a=(B+1)u. Feed these centers into the same packing (2), retaining A_0. A packed phase product has error at most

    a+B u+a u+u.

Adding its uncertain A'_j and rounding adds a+u. Therefore, when a<=1, the packed input error satisfies

    e_0 <= (3B+5)u.                                      (4)

The second packed entry uses conjugation of the same stored product and input; their errors have the same norms. No independence is assumed. Base packing is bounded by (4) as well.

Use the accepted normalized butterfly schedule, with a product rounding and two output roundings per butterfly. Its exact input bound here is 2B. At each stage,

    e_next <= (1+u/2)e + (B+2)u.

For depth k=k0-1 and u<=1/(2k0), geometric amplification is below two. Thus

    e_half <= 2(3B+5)u+(k0-1)(2B+4)u
            = [(2k0+4)B+4k0+6]u
            <= Ctime(B+2)u,  Ctime=2k0+4.                 (5)

This includes every input, root, product, sum and C_0 round specified above. Apply the same sufficient raw-sign allowance as the reviewed full transform:

    u <= eps*Delta/[448*Ctime*(B+1)],
    u <= 1/(2k0).                                       (6)

The tiny inherited eps ensures a<1 and e_half<1. Multiplication by m in (3) gives

    raw error <= m e_half
      <= eps*N*Delta*(B+2)/[896(B+1)]
       < eps*N*Delta/448
       < eps/(64H).                                    (7)

Consequently the existing raw sample interface accepts the new circuit at the same sufficient gate allowance. This is a proof about (6), not a claim that every previously serialized sample has been generated with that allowance. Roots needed by the new packed inputs must carry the same accuracy contract.

For an optional fresh uniform dyadic schedule, u=2^-244 at theta64 and u=2^-345 at theta128 also satisfy the final target (7) directly for every admitted N. The exact receipt checks these alternatives separately. They need not satisfy the sharper per-row sufficient formula (6); their direct error proof is what licenses them. No implementation should confuse these two ways to select a sufficient u.

A direct polyphase output uses (7) at its actual off-grid target. It needs no interpolation remainder; the old larger raw sign radius is still conservative. If the half transform supplies coarse samples to local interpolation, all inherited stencil, kernel and target-only analytic-error bounds remain unchanged. Only the finite polynomial is periodic. Both positive channels of a nonreal inverse-character pair remain distinct.

## 4. Integer magnitude and representation

The exact packed nodes have norm <=2B. The approximate normalized FFT nodes have norm <2B+1<2^44. Approximate unit roots have norm <2. Every exact product/addition before a butterfly output round has norm <2^46. These are conservative uniform bounds on integer parts, not precision lengths.

After the exact m shift, a raw stored center has magnitude below 2^74 because m<=2^30. The true raw value also satisfies |U|<NB<2^73. Its potentially much larger integer part must be retained when interpolating raw U. The output grid becomes m times the normalized grid. It is valid to store an unchanged significand with an exponent shift; storing on a fixed fine raw grid instead requires shifting that significand and enlarging its bit length. No additional accuracy is created by this representation change.

If normalized coordinate roundings use the dyadic grid 2^-b, stored normalized numerators have fewer than b+44 magnitude bits. Ordinary FFT product/sum temporaries can conservatively use fewer than 2b+48 bits before their next round. These bounds assume roots have already been returned on that grid. They do not cover the internal construction of those roots.

The initial A_j may have a finer denominator. If their coordinates lie on grid 2^-a, the first packed root-product temporaries require a bound involving a+b, conservatively a+b+46 magnitude bits. Packed additions involving an unrounded A_j need max(a,b)+46 bits. C_0 is rounded explicitly, so all inputs to the subsequent FFT have the chosen b-grid. If coefficient centers are stored as arbitrary rationals instead, their actual numerator and denominator bounds replace a. It would be wrong to apply the 2b FFT bound to an unexamined source coefficient representation.

## 5. Typed work, roots and storage

Let F(n)=n log2(n)/2. Compare complete generic complex radix-two schedules at the SAME accepted gate contract; special twiddles or zero pruning are not silently credited.

|Category per character, base grid|Full length N|Packed length m|
|---|---:|---:|
|Complex products|F(N)|F(m)+J|
|Complex additions|2F(N)|2F(m)+2J|
|Complex rounding gates|3F(N)|3F(m)+3J+1|
|Exact butterfly divisions by two|2F(N)|2F(m)|
|Packed-input conjugations|old negative-frequency construction separate|2J|
|Packed-input multiplications by i|none|2J plus C_0 duplication|
|Potential raw real outputs|N|N|
|FFT workspace complex slots|N|m|

The old negative-frequency copy count J must be replaced or retained according to the actual input layout, not subtracted twice. The new 2J conjugations and coordinate/sign operations are typed data operations, not additional general complex products. C_0's extra round is one per character. Output component extraction and exact shifts are charged for the consumed outputs; a full stored real array has N entries in both routes.

The product reduction is exactly

    F(N)-F(m)-J = N(k0+1)/4-J >0.

For polyphase add J phase products/roundings to BOTH alternatives for each nonzero class. The packed route then follows (4). A length-dN padded Hermitian transform can also be packed, using m=dN/2 and its correctly moved negative-frequency slots; a precision extension beyond the checked k0<=31 must be supplied if dN exceeds that range. This note does not silently extend (6)'s finite size receipt.

The half FFT uses roots with N-grid exponents 0,2,...,m-2. Packing needs exponents 1,...,J. Their union has at most

    N/4+ceil(J/2)

entries, including the exact unit root in this conservative count. It is a subset of the old N/2 root table. Thus an adequate old cache suffices; a fresh implementation can generate the smaller union instead. A polyphase class additionally needs its signed phase roots of order dN, exactly as before. Root certification, setup arithmetic, cache precision and sharing must still be charged.

Packed coefficients occupy m complex slots. They can be formed directly from J positive coefficients and A_0; a separate length-N array is unnecessary. An in-place half FFT retains m complex outputs that represent N real raw samples. A persistent query service still needs those outputs or a priced reconstruction/storage scheme. Root caches, source coefficients, exact temporaries, proof objects and parallel copies are additional to the workspace count. The halving of complex slots is not a halving of every memory category or bit width.

## 6. Saved whole-family schedule comparison

This section consumes the reviewed fixed-theta whole-small-family receipt, not a new conductor enumeration. Let S=sum N over its character arrays, F=sum F(N), Jsum its saved `frequency_conjugate_copies`, and C its primitive-label count. Then

    sum F(N/2)=F/2-S/4,
    new products=F/2-S/4+Jsum,
    new additions=2*new products,
    new rounds=3*new products+C.

The receipt supplies all eight theta64/theta128 and extra-node 0/167/320/640 rows. Main rows are:

|theta|Old time products F|Half FFT butterflies|Packing products|New total complex products|
|---:|---:|---:|---:|---:|
|64|129247714213888|61383878115328|1687497923273|63071376038601|
|128|89858217607168|42619662827520|1202846693883|43822509521403|

These are operation categories, not real-product totals or runtime measurements. For example a generic complex product can use four real products and two real additions, but its actual proof/bit cost depends on operands and gates. The half circuit fits the same sufficient raw gate precision, yet its packed coefficients have twice the old normalized magnitude bound. Section 4 pays that extra integer range.

All 18477108 primitive character labels remain. Gaussian work, character transforms, fixed phase, analytic approximation, local interpolation, strict signs, auxiliary/Turing certificates and principal work are not reduced by these counts. The fixed-theta rows are not silently relabeled as a newly optimized tilt inventory. An admitted minimal-theta family can use the same per-N formulas when its corresponding saved S,F,Jsum and precision contracts are bound explicitly.

## 7. Evidence and outstanding work

The exact script performs 3172 checks. It verifies general packing coefficient identities as formal root-of-unity phase polynomials, the sparse phase identity, root-set cardinalities on small finite fixtures, all admitted per-row error inequalities, optional dyadic budgets and all eight saved schedule compositions. It evaluates no Fourier transform and no analytic values. The general proof is the even/odd decomposition in section 2 and error propagation in section 3.

An implementation still needs ordinary proofs for its finite transform circuit, exact source-array binding, packed input construction, rounding/root certificates and output-index map. Actual strict signs and completeness remain separate. This report establishes a conditional arithmetic replacement; it neither proves finite RH nor predicts elapsed verification time.

Pins, relative to `work/qrh-campaign/agents`:

|File|SHA-256|
|---|---|
|audit/SMALL_THETA_RAW_POLYNOMIAL_SIGN_INTERFACE_2026-11-11.md|076030481DEB4A922356A5BC0B8CCB243DF3FBB15A0DD427A29DEB044E82D430|
|zero-sum/REVIEW_SMALL_THETA_RAW_POLYNOMIAL_SIGN_INTERFACE_2026-11-11.md|5683768E8F7B8B93FD4CD2E45CDBED40BFA9CC1BAE238CF920A22B40FEBB820A|
|major-constants/SMALL_THETA_OFFGRID_ARITHMETIC_SCHEDULE_2026-11-11.md|8B299BFBDB936C6B85E0AEE6A3D61B0104A2D40D9E604DA98E1E8A76AAD8A0B9|
|prime-estimates/small_family_theta_inventory_final_20261111.json|26ED3C86420123A7629DB41C07999990A53A4DAAA4C7146C3FC64D527B578B69|
|major-constants/hermitian_half_time_fft_20261111.py|7655A0319E84137D611FA20DE0261462EB3098077BA4EABFD5BF4EE2369B9AB6|
|major-constants/hermitian_half_time_fft_20261111.json|8630BC8723E8D0658152CD7B807E4E8FE6D68F2C1F236192B1E8B0E09DEA5BB2|
