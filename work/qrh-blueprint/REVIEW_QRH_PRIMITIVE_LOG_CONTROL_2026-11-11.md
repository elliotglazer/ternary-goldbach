# Independent reconstruction of primitive logarithmic control

2026-11-11. Verdict: PASS for the bounded mathematical/source implication. This is not a Lean elaboration, an axiom audit, or validation of the complete QRH provider. The independently reconstructed argument below agrees with the author report within its stated scope.

## Exact object and logical scope

The source is `work/openai-math`, commit `4eaee87548250b2682affda7d05d947c05554bae`. Paths here are relative to `lean/OAI/NumberTheory/DirichletL`.

`Hecke/Family.lean` defines characters of the Eisenstein ideal residue quotient, trivial on units, with an auxiliary positive integer period. These are not arbitrary Hecke infinity types, and this theorem is not itself a statement for every ordinary Dirichlet character. The complexity in `Hecke/Logarithmic.lean` is

    C(eta,t) = 2 * Norm(eta.modulus) * (3+|t|)^2.

It uses the ideal modulus rather than the auxiliary period and is at least exp(1).

The function controlled by `Hecke/LogarithmicActual.disk_control` is `regular eta`. It is the actual L-function for a nonprincipal character. For a principal character it is the actual entire pole-removed function divided by s+1. Away from 0 and 1 this equals `(s-1)/(s+1) * L(s)`. The entire pole-removed definition and its nonzero value at 1 are retained. Raw totalized L-values at the pole cannot replace it.

For fixed 0<e<1/1000 and epsilon>0, the theorem chooses D>0 and B>=0 before the primitive character, a in [1/2,1], and t. Its explicit hypothesis is that regular is nonzero on the open disk centered at 2+it of radius 2-a-2e. It concludes the subpower bound on the closed disk of radius 2-a-6e, and the logarithmic-derivative bound on the closed disk of radius 2-a-8e. The zero-free hypothesis has not been proved merely by proving this implication.

## Actual inner logarithm

`Hecke/EulerLog.lean` sums the actual terms `-Log(1-a(P)Norm(P)^(-s))`. Every prime ideal has norm at least 2, and the coefficient has norm at most 1. On Re(s)>=sigma>1 the norm of each term is at most `(3/2)Norm(P)^(-sigma)`. The source proves summability of this majorant and locally uniform convergence before taking derivatives or comparing infinite sums.

`Hecke/Boundary.exp_log_euler_eq_series` exponentiates the absolutely convergent logarithm with `HasSum.cexp` and identifies its product by uniqueness. `IdealEuler.lean` supplies the actual Euler product through the absolutely convergent Mobius inverse series: the double sum is reorganized by ideal product, the Mobius divisor sum leaves only the unit ideal, and the resulting product is 1. Nonvanishing is established before inversion. This review does not independently reprove the underlying Mobius Euler theorem, ideal norm summability or divisor-fiber identity.

For the principal branch, add `Log(1-2/(s+1))`. This is holomorphic on Re(s)>1, exponentiates to `(s-1)/(s+1)`, and has norm at most 3 on Re(s)>=3/2. A common inner bound is therefore `A=3+eulerLogBound`, independent of the character and height. It bounds the logarithm on the closed radius-49/100 disk. The identity of its exponential with regular holds on the larger open radius-1/2 disk.

## Polynomial growth and its uniformity

The actual strip arguments in `Hecke/Strip.lean`, `Hecke/StripActual.lean`, `Hecke/Presentation.lean` and `Hecke/PrincipalStrip.lean` supply a common bound on Re(s)>=-1/10:

    |regular eta(s)| <= Cstar * Norm(modulus)^(3/5) * (3+|Im(s)|)^2,
    Cstar = 108 * (1+leftConstant) * reciprocalBound(11/10).

The left boundary uses the actual functional equation, a shifted Gamma ratio, and the absolutely convergent dual series at real part 11/10. The completion-scale power yields the conductor exponent 3/5. The nonprincipal strip proof divides by `Q^(3/5)*(s+2)^2`, applies Phragmen-Lindelof to bounded boundary values, and restores the denominator with the stated height cost. Its sufficient exponential-growth constants may depend on the character. They are not the final boundary bound and do not introduce character dependence into Cstar. The principal proof first handles the entire pole-removed function and then pays the factor at most 3 for `(s+2)/(s+1)` on the strip. Ideal presentation transports the actual character and preserves the modulus norm.

In the disk centered at 2+it, the height factor increases by at most 4. Since Q>=1 and Q^(3/5)<=Q, this gives `|regular|<=2*Cstar*C(eta,t)`. The generic absorption lemma chooses

    M = 2 + log(max(1,2*Cstar)),

independently of eta,a,t,e, and yields `|regular|<=C^M` on the required open disk. This is a qualitative uniform constant. No value of Cstar, M, D or a special function was numerically evaluated.

The functional equation, strong theta pair, regularized Mellin construction, normalized Gauss norm, Gamma growth and shifted-ratio facts remain underlying mathematical inputs. Their consuming strip assemblies were read; this review does not claim all of those foundations have been independently validated.

## From a zero-free disk to a subpower reciprocal

The complete generic proof in `LogarithmicControl.lean` was read. Its steps are substantive and preserve the required uniformity.

1. A nonvanishing holomorphic function on a disk has a continuous logarithm. Local inverses of exp make this logarithm holomorphic. Shift it by a constant so that its center value agrees with the actual Euler logarithm. Local inverse uniqueness followed by the identity theorem makes the two logarithms agree throughout the inner disk. Thus the bound A holds on a disk, not only at its center.
2. The polynomial bound implies `Re(g)<=M*log(C)`. Borel-Caratheodory gives `|g|<=B0*log(C)` on radius `2-a-4e`, where `B0=(4M+4A)/e`.
3. Three-circles interpolation between the radius-49/100 disk and radius `2-a-4e`, evaluated on radius `2-a-6e`, gives

       |g| <= A*B0*(log(C))^theta_e,
       theta_e = 1-log(1+e)/log(200/49),  0<theta_e<1.

   The uniform exponent follows from `(1+e)*(2-a-6e)<=2-a-4e` and the upper bound `log((2-a-4e)/(49/100))<=log(200/49)`. The proof of three circles uses the actual function `g(center+exp(w))` on a vertical strip and the boundedness supplied by the outer disk. It does not assume boundedness on an infinite strip without proof.
4. For fixed K and theta<1, `exp(K*x^theta)<=D*exp(epsilon*x)` for all x>=1. The source proves the large-x comparison and separately absorbs the bounded interval. Taking x=log(C) controls both exp(Re(g)) and exp(-Re(g)), so both regular and its reciprocal have the required subpower bound. The final sum pays a factor 2.

Borel-Caratheodory alone would give a fixed power of C. The three-circles step and its strict, uniform theta<1 are what give every positive epsilon. The proof contains that step; it is not an omitted assumption.

For the derivative, a Cauchy circle of radius 2e about a point in radius `2-a-8e` remains inside the domain where the outer logarithm bound holds. Hence `|g'|<=B0*log(C)/(2e)`. Differentiating exp(g)=regular and using nonvanishing identifies g' with regular'/regular. This establishes B independently of the later character, height and a.

## Application using the actual zero supremum

`primitive_reciprocal_subpower` takes a to be the source's actual `HeckeZeroSupremum.beta`. Its known range [1/2,1] and the definition-level nonvanishing to its right supply the disk premise. There is no assumed beta<=7/8 in this step. Points with real part between beta+8e and 2 lie in the smaller disk by the same-height identity. Points farther right use the Euler reciprocal bound.

For the principal character, the transfer factor `(s-1)/(s+1)` has norm at most 1 on the right half-plane. At s=1 the source handles the reciprocal's zero value separately, using the actual pole-removed nonvanishing for regular. The raw meromorphic function is not asserted holomorphic and nonzero at its pole.

## Review boundary

No local mathematical defect was found in this reconstruction. The result is a conditional source implication with the actual functions, correct pole normalization and uniform quantifiers. It neither proves the desired global zero bound nor verifies the provider on the target toolchain. The branch-log existence, Borel-Caratheodory, Hadamard, Cauchy and Phragmen-Lindelof library results remain trusted mathematical inputs for this review; their Lean implementations and transitive axioms were not audited here. No source was changed and no Lean build or analytic evaluation ran.

## Source evidence

The [author report](../qrh-campaign/agents/prime-estimates/QRH_PRIMITIVE_LOG_CONTROL_AUDIT_2026-11-11.md), SHA256 `8C6BA5471677B6478AFF83D4EE6F3C3060FAF982888FEA96321CCAA31BBEAA31`, was read in full after the main independent reconstruction. No correction is required. All 21 author source hashes were checked separately. The author traces the additional lattice convergence and actual theta-pair interfaces; the reviewer also inspected the four supplemental ranges listed below. The lattice norm series requires exponent less than -2 and follows by the rank-two lattice theorem and the actual period equivalence. The ideal series then follows by the injective ideal-generator map, with the zero ideal handled separately.

The author's optional disk-overlap consequence is valid at paper scope. For intersecting disks centered on Re(s)=2, their intersection contains a point on that line. Each normalized logarithm agrees with the Euler logarithm throughout its connected intersection with Re(s)>1 by analytic uniqueness. Equality therefore extends throughout the connected disk intersection. This does not supply an existing Lean gluing declaration, and no gluing theorem is needed by the reviewed disk wrapper.

Hashes identify whole-file bytes. Read spans indicate the source inspected; neither whole-file reading nor a hash asserts that every imported result has been validated.

| Source | Read span | SHA256 |
|---|---|---|
| LogarithmicControl.lean | 1-547 | D337B355A705123E90D7FC5F2A6521464ACA6BB520737A5C26931ED97B7552E5 |
| Hecke/Logarithmic.lean | 1-75 | 03F29A2484577DBDDAB8B7092A7B131945CF179A87C2724320DFCF4A6AB10A8B |
| Hecke/LogarithmicActual.lean | 1-98 | 3B6586669D48F18C1C291F8CF81086DB7250CB05013F3086057F8C4D26300599 |
| Hecke/LogarithmicInput.lean | 1-228 | 9ADCC4FDE13E8A257CDC81F4A1DA752949FCFCF339B856A40411BFE901DC6F0D |
| Hecke/EulerLog.lean | 1-322 | D3D3921F0F777FC6CF2093690A2318156E0F904B129BBAD5F8BFAF69F72F4FDF |
| Hecke/Family.lean | 1-102 | B18557C5C055910287507F1ED2B1F7BB31EDE318CB62A2A10A3140F1995A9408 |
| Hecke/Origin.lean | 1-81 | D42011FD72DAEACF02EAD1440212E55E3E722031B82983782D1E5948CF78F33D |
| Hecke/Strip.lean | 1-321 | E6E35BDEA0A7595D8AD88FB185A8C38367E8EC1878C9312E3D2BB0BE3C4F8AB8 |
| Hecke/StripActual.lean | 1-197 | 003AED36D61C7295441B12AD6BC0C7F71EDC2214AD9E3FE495872E819166FDAF |
| Hecke/PrincipalStrip.lean | 1-233 | E0EB332CD6C696C75989C373A549836574C3AE0E31B0C43B39AC82CA314794E4 |
| Hecke/Presentation.lean | 1-99 | F3C534C8949E50796A732770171A829B81D3035DB2DD03C62DFC4EE2B1AFF2DC |
| Hecke/Boundary.lean | 1-220 | B0248FC7BEDCAB9F88A5F5D7BBF4908B75BDEA3E4AF9A2CEF47106A85A472599 |
| IdealEuler.lean | 1-230 | D8EC594DEDB83661937B1DA00600AFE85A4A319434CE1C0B64543EF06A24BB59 |
| QuadraticSieve/DyadicColumns.lean | 203-244 | 06DD20DAD9FB49BFC615256402AA6664FAFB5125CB6AC11C701118057A47F87C |
| Eisenstein/FourierCoefficients.lean | 471-513 | 428826F42C6D0830F305FC778DF97BE96E93DBCBF0467143A38FEEC674BC901C |
| Hecke/ZeroSupremum.lean | 1-92 | F27256644A64572823B53CAE87483C4726192FF906EE7F64AE30E13F77E57242 |
| Hecke/Primitive.lean | 56-163 | 6E465C53301C4E1F20BF61A0CF03BC458D5C55138F9AA8459548329CEC644747 |
