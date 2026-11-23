# The relaxed plus residual also preserves the major L2 upper bound

2026-11-11. Paper and exact rational argument. This closes one conditional consumer join; it does not prove the proposed actual nonprincipal energy estimate. No numerical prime/L-function evaluation, Lean declaration or build was performed.

The reviewed direct plus-energy target gives the actual residual inequality

    sum_(b in Bset q) |S etaPlus x (b/q+beta)-Ap(q,beta)|^2
      <= (rho*x)^2, rho=8.85e-7,

for every q in Qset R and |beta*x|<=8R/qt(q), at the selected R132900 and x>=4.9e26. Here Ap=(mu(q)/phi(q))*Fourier(etaPC)(-beta*x)*x. Its author noted that the old L2Major proof separately uses a smaller nonprincipal constant and cannot simply be called with the new target. The following direct integrated argument avoids that call and still proves X<=8.79x.

## Integrated residual bound

Use the same tagged arc space D as INTEGRATED_CUBIC_RESIDUAL_CONTRACT_2026-11-11.md. Put

    Z=integral_D |Sp-Ap|^2,
    X=integral_D |Sp|^2, Y=integral_D |Ap|^2.

Each q interval has length16R/(qt(q)*x). Integrating the displayed bound, which already includes the sum over b, yields

    Z <= 16R*rho^2*x * sum_(q in Qset R) 1/qt(q).       (1)

There is no extra factor phi(q). All quantities integrated are nonnegative and continuous on the finite intervals.

For any natural 1<=R<=150000, Qset R consists of odd positive q<=R and even q=2k with1<=k<=R. Since qt(q)=2q in the odd case and qt(2k)=2k,

    sum_(q in Qset R) 1/qt(q)
      = (1/2) sum_(1<=q<=R, q odd) 1/q + (1/2) sum_(1<=k<=R) 1/k
      <= H_R.                                         (2)

Use the coarse elementary bound H_R<=19. Indeed R<2^18, the term1 contributes1, and each of the18 blocks 2^j<n<=2^(j+1), j=0,...,17, contains at most2^j terms bounded by1/2^j. Enlarging to the full blocks only increases this positive sum. This avoids a new logarithm enclosure.

Equations(1)-(2) give

    Z <=16*150000*19*rho^2*x
      = (3571506/100000000000)*x <(.006)^2*x.            (3)

This bound is valid whenever the same pointwise residual hypothesis is supplied throughout the required arc domain. The available direct-energy proposal supplies it only at its declared R132900; no broader theorem about actual residuals is inferred from the general geometry.

## Main term and Minkowski

The Fourier L2 and source mass upper estimates give, without the nonprincipal RH estimate,

    Y <=a*x, a=.640208*13.59756=13601979207/1562500000
       <(2.951)^2.

Equivalently Y<(2.951)^2*x. The right-hand coefficient bound follows from exact rational arithmetic. The main-term norm computation uses card(Bset q)*|mu(q)/phi(q)|^2=mPhi(q). The nonnegative sum at R132900 is bounded by the existing150000 upper sum; it does not use a lower-mass transport.

Minkowski gives sqrt(X)<=sqrt(Y)+sqrt(Z). Since x>0, the two strict rational bounds imply

    sqrt(X)<(2.951+.006)*sqrt(x)=2.957*sqrt(x),
    X<8.743849*x<8.79*x.                               (4)

Thus the direct plus target, retained principal estimate and coprime removal imply the exact upper-X premise used by the existing major error allocation. The smaller old Cn need not be re-established for this consumer. This also supplies X for the new integrated cubic contract if its separate Wplus/Wstar targets are proved.

## Scope and source join

The source definitions and constants are those checked in the root integrated cubic contract and the independent review of major-constants/DIRECT_PLUS_RESIDUAL_ENERGY_TARGET_2026-11-11.md. Qset and qt occur in MinorArcs/LargeSieveArcs.lean:34 and the accompanying weights file. MajorTotal.lean:907 bounds the Fourier etaPC integral; SumMuPhi.lean:108 gives the mass upper13.59756. The periodic arc partition and reduced-radius adapters remain necessary to identify X with the physical major-arc energy.

The new argument proves only an upper bound. The lower major-arc energy used by the minor arcs still needs its own principal/main-term argument and the selected reduced mass. The new nonprincipal energy theorem E_q<=7.02e-13 is still unproved. Principal RH through1e8 and its localized wrappers are retained premises. Star residuals, pointwise base-gap, remaining minor estimates, finite certificates and final kernel checking are unaffected.

The precursor report SHA is E69701B4AE8145B016015A2C355151DFAA5D4946D2281BAE3CC08A86422196B1; its independent review SHA is89DEB7CACE2D0AC4030C349D5E8E715C0B8DFFC69A7D33383D701DAB836F6B12. The integrated cubic contract SHA is943DE38EE628CFA9E7221100E75933D101C7593B613945F19B7CBDF90E97C128. This supplement supersedes only the earlier statement that the upper-J join had not been supplied. It does not supersede any warning about the unproved aggregate target or claim reduced computation.
