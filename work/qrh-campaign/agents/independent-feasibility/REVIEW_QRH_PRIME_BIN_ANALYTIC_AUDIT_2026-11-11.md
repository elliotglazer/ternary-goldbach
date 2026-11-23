# Independent review of the QRH prime-bin analytic estimate

2026-11-11. **PASS within this bounded source/math-review scope, with one documentary theorem-name erratum recorded below. Global QRH provider not validated.** No build, numerical function evaluation, source edit or spectral computation.

## Scope and finding

I read the current checkpoint and provider frontier, then independently inspected the analytic argument below PrimeBin. Source commit: `4eaee87548250b2682affda7d05d947c05554bae`. No local defect was found in the inspected contour, logarithmic-derivative, buffer, or scaling argument. This is not validation of the full QRH provider or its transitive analytic foundations.

Paths and one-based lines below are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL`. Hashes identify the exact source bytes; a listed hash does not mean every imported theorem was independently proved.

## 1. The zero-free input is genuine and does not assume QRH

`Hecke/ZeroSupremum.lean` defines beta as the supremum of the real parts of actual positive-real-part zeros, with a 1/2 sentinel and the principal pole excluded. Its upper bound beta<=1 uses only the Euler nonvanishing region Re(s)>1. `Moments/PrimeGlobal.lean:13–22` shows the finite family zeroMaximum is <=beta when beta>=.51. The caller at :28 uses a=beta and the strict margin 2e>0; it does not assume beta<=7/8.

`Hecke/DetectorZeros.lean` defines the finite zero set using the closed rectangle .51<=Re(s)<=1 and |Im(s)|<=height. Finiteness uses analytic discreteness of the actual nonprincipal L-function, nonzero at 2. It is not a sampled list. `nonzero_on_buffered_disk` uses all its zeros: for |t|<=(3i+2)T and T>2, the closed disk centered at 2+it of radius 2-a-2e has Re(s)>=a+2e>=.51 and imaginary part at most 3(i+1)T in absolute value. Indeed its radius is at most 1.49<T. Zeros to the right of 1 are excluded by Euler nonvanishing. The strict maximum<a+2e therefore excludes a zero even on the disk boundary. Multiplicities are unnecessary for this maximum/nonvanishing argument; their absence is not a zero-count claim.

This is a conditional zero-free-region estimate applicable with the actual unknown beta. The later argument forcing beta down remains separate. An import containing later beta-related lemmas is not itself a circular use: the inspected proof calls have the dependency just described. No transitive import/axiom audit is claimed.

## 2. How the logarithmic-derivative bound is proved

`Hecke/PrimeDyadicControl.lean:28–67` reduces an imprimitive nonprincipal character to an actual primitive character psi. The local identity is L_chi=L_psi*F, with F the finite Euler-deletion product. A zero of L_psi in the disk would give a zero of L_chi, so the supplied zero-free hypothesis transfers in the required direction. The derivative identity at :13 keeps F'/F; it does not erase the conductor correction.

For the primitive factor, `Hecke/LogarithmicActual.lean:50` invokes the generic control through `Hecke/Logarithmic.lean:54`. I read the full `LogarithmicControl.lean` proof, including the following substantive steps:

- On a nonvanishing disk, a continuous logarithm exists; the local inverse of exp makes it holomorphic (:18–64).
- Normalize the logarithm to the Euler logarithm at the center. Local exp injectivity followed by analytic identity gives equality on the inner disk (:66–85), so its norm there really is uniformly bounded. No arbitrary branch constant is silently bounded.
- On the disk of radius 2-a-3e, polynomial growth |L|<=C^M gives Re(g)<=M log C. Borel–Caratheodory gives |g|<=K log C on radius 2-a-4e, where K=(4M+4A)/e (:87–107 and :294–328).
- For z in radius 2-a-8e, a Cauchy circle of radius 2e lies inside the holomorphic disk, and its norm is bounded by the preceding outer bound. Thus |g'(z)|<=K log C/(2e) (:351–373). The local exponential derivative proves g'=L'/L (:405–417).

All radii have positive gaps for .5<=a<=1 and 0<e<.001. The constants A and M are chosen before the character, center height, finite family, and bin. This proves the required uniformity conditional on the actual growth and inner-log inputs.

The same generic theorem also proves |L|+|1/L|<=D C^epsilon by three-circles applied to g, with theta(e)=1-log(1+e)/log(200/49)<1, then exp(K(log C)^theta)<=D C^epsilon. I checked its radius and exponent directions. This stronger subpower branch is not needed for the prime-bin derivative estimate: that estimate uses the Borel–Caratheodory/Cauchy branch. Neither branch gives a useful numerical constant just from this existence proof.

The actual growth input is explicit. `Hecke/LogarithmicInput.lean:122–153,195–226` uses a uniform strip estimate of size constant*Q^(3/5)*(3+|t|)^2 and Euler bounds to its right. `Hecke/Logarithmic.lean:25–52` converts it into C^M with C=2Q(3+|t|)^2 and a uniform M. The inspected `Hecke/Presentation.uniform_strip_bound` and `Hecke/StripActual.uniform_strip_bound` derive the strip input from the completed functional equation, normalized Gauss factor, exponential growth and right-edge Euler estimates. They do not invoke the desired beta bound. Their underlying functional-equation/Gamma/strip interpolation foundations are retained as unreviewed leaves below.

I additionally read `Hecke/EulerLog.lean:16–180`. The inner bound comes from the explicit series -sum_P log(1-a(P)N(P)^(-s)). For Re(s)>=3/2, each term is bounded by (3/2)N(P)^(-3/2), independent of the character and imaginary part. The summable majorant gives both normal convergence/differentiability and a uniform norm bound; the equality of its exponential with the Euler series is delegated to `HeckeBoundary.exp_log_euler_eq_series`. Thus the remaining Euler-log cut is that product identity and the underlying prime-norm summability, not an unspecified inner-bound assumption.

For the finite deletion, `Hecke/DeletionDerivative.lean` differentiates each factor 1-a*N^(-s), uses |a|<=1 and Re(s)>=1/2 to bound the inverse denominator, and sums log N over the distinct removed primes. Consequently the original-character bound retains

    B log(2Q(3+|t|)^2) + localBound(1/2) log Norm(radical Q).

The primitive modulus norm is <=Q; both logarithmic terms have the correct monotonic direction. `PrimeDyadicControl:85–121` extends the disk estimate to the whole rectangle a+8e<=Re(s)<=2, |Im(s)|<=H, with the uniform cost at H=(3i+2)T.

## 3. Actual polynomial, contour and tail normalization

`Hecke/PrimeDyadic.lean` defines the coefficient as ideal Mangoldt times the actual character coefficient, the series as -L'/L, and the normalized polynomial as D^(-1/2) times the smoothed ideal sum. Its Mellin formula retains D^(s+shift-1/2). In particular, taking real parts on the new line yields the exponent a+8e-1/2, not a or a+8e.

I read the full `Hecke/PrimeDyadicContour.lean` and `PrimeDyadicEstimates.lean`. The finite rectangle is translated by shift=sigma-i*freq. With left l=a+8e-sigma, right r=2-sigma, and vertical truncation V, the condition |freq|+V<=H places every point of the translated rectangle in the proved nonvanishing/log-derivative domain. The contour identity is

    right vertical = left vertical + i*(bottom horizontal-top horizontal).

The signs agree with the counterclockwise boundary identity. The complete original vertical integral is split using its actual integrability; the outside |t|>V part remains on the right line. No assumption of decay on the shifted line outside the zero-free rectangle is made.

The three norm terms are respectively bounded by

    C2 D^(a+8e-1/2) K pi,
    2 Cn D^(3/2) K |2-a-8e|/(1+V)^n,
    Cn D^(3/2) eulerBound(2) pi/(1+V)^n,

all multiplied by 1/(2pi). The central estimate uses the integrable Cauchy majorant; each horizontal join uses its actual finite length; the right tail uses the absolutely convergent Euler log-derivative series. The closed/open interval endpoint conversions affect sets of measure zero only. The actual Mellin-inversion and Euler-series identities are called explicitly, and remain foundation leaves rather than hidden numerical assumptions.

## 4. Uniformity after conductor and height scaling

`Hecke/PrimeDyadicScale.lean` turns the retained bin cost into a logarithm of U using Q<=U, U>=2 and (3+H)^2<=U^eta. Thus complexity<=2U^(1+eta), log complexity<=(2+eta)log U, and log Norm(radical Q)<=log U. The elementary log U<=U^kappa/kappa pays for it with kappa>0.

In this paragraph kappa is the positive intermediate slack, not the final squared-energy exponent with the same source variable name. `PrimeDyadicScaled.lean` then sets D=U^r, 0<=r<=R. Its constants precede the finite family and all varying conductor/frequency data. It keeps both terms:

    C*C2*U^((a-1/2+8e)r+kappa)
    + C*Cn*U^(2R+kappa)/(1+V)^n.

The replacement 3r/2<=2R and |2-a-8e|<=2 is valid under the stated ranges. `PrimeDyadicSource.lean` pays 8eR+kappa<=epsilon and chooses a uniform finite decay order for V=Z^tau/2, U=Z^d, d<=dmax. No limit in d or character family is hidden in this choice. The family cardinality does not enter the constant because each selected character receives the same pointwise bound, rather than a sum over the family.

I also checked the outer prime extraction and ray averaging when reviewing the companion report below. Their use does not license dropping the conductor/height hypotheses. In particular, an arbitrary prescribed frequency is handled only after satisfying the scale relation, as in the separate PrimeHeight application.

## 5. Companion report and final bounded verdict

I read the complete `major-constants/QRH_PRIME_BIN_ANALYTIC_AUDIT_2026-11-11.md`, SHA256 `17767311F6AD4213FFD9A8A2C9678CC2AE73F1829CC27672128CF10211B49C7E`, and independently matched all 33 source hashes in its manifest. Its derivation and qualified verdict agree with the inspected source. No mathematical correction is required.

There is one documentary erratum in its section 7: the actual called theorem is `CompactProfileFamily.compact_family_fourier_weighted_bound`, at `CompactProfileFamily.lean:105`, rather than `compact_fourier_weighted_bound`. This does not change the argument or the identified remaining proof cut. The author was notified; its frozen report need not be changed.

For the report's normalization and extraction claims, I independently read `Hecke/Dyadic.lean:40`, `Hecke/PrimeRay.lean`, `Hecke/PrimeAnnular.lean`, `Hecke/PrimePowers.lean`, and `PrimeLogProfile.lean`. The frequency convention is **shift=sigma-i*freq**, so the normalized prime summand contains (NI/D)^(-sigma+i*freq). The norm comparisons depend on |freq|, but the sign is retained in the actual contour identity.

The log profile is genuinely smooth even at its artificial denominator zero: its cutoff makes it identically zero near that zero. On the actual compact support with log D>=2(|log A|+|log B|)+1, 1+log(y)/log D>=1/2, so the cutoff is inactive and the profile equals W(y)/log(Dy). Joint smoothness and fixed compact logarithmic support justify invoking the uniform Fourier-decay theorem over both profile and real Mellin parameters. This is not an assertion that inverse log is globally smooth without a cutoff.

The exact finite Mangoldt sum has weight Lambda(I)/log NI, equal to one at prime ideals, in [0,1] elsewhere and zero outside prime powers. Nonprime prime powers are powerful ideals. The invoked powerful-ideal count yields the unnormalized O(X^(1/2+xi)) error; the actual D^(-1/2) normalization leaves O(D^xi). With xi=epsilon/(R+1), xi*r<=epsilon. I checked the support-to-annulus and norm inequalities; I did not independently reprove the powerful-ideal count.

The ray average is h^(-1) times a sum over exactly h characters, h>0. A triangle inequality therefore preserves the pointwise constant, without a square-root cancellation claim. Each twist must satisfy the nonprincipal and modulus hypotheses separately. Squaring after setting a=beta gives exponent (2beta-1)r+2epsilon, bounded by the final kappa*r+2epsilon because r>=0. These are actual source formulas, not schematic replacements.

The combined review moves the frontier past the abstract bin-estimate wrapper to the explicit buffered-logarithm and finite-contour calculation. It leaves the foundation boundaries in section 6 intact. It does not close the global provider or supply any new finite spectral coverage.

## 6. Remaining proof cut

The inspected argument supplies the analytic mechanism below the bin bound, not every foundation used by that mechanism. The next cut consists of:

1. Actual completed Hecke functional equation, primitive/Gauss normalization, Gamma-ratio and strip-growth/interpolation estimates used by `StripActual` and `Strip`.
2. The Euler product/exponential identity and underlying ideal/prime-norm summability, plus the Euler log-derivative identity. The inner-log majorant and its use were inspected above.
3. Full primitive-character extraction and finite Euler-deletion identities, beyond their correctly directed use here.
4. Compact-profile Mellin inversion and uniform decay, and the exact ideal-Mangoldt-to-prime extraction inputs. The finite contour argument does not replace these.
5. The other energy/inverse/cell arguments in the provider frontier, followed by target-toolchain elaboration and actual transitive axiom validation.

These are named arguments still requiring validation, not demonstrated false statements. No finite-RH certificate or new QRH premise was added. PlattGRH has not been removed by this source-reading exercise.

## Exact source pins

| Source | SHA256 |
|---|---|
| `Moments/PrimeGlobal.lean` | `8FFC0F6629F775AA1BD9DA2CC1FB61F4D37DD710B214035299C800EC8DFFFE9E` |
| `Hecke/PrimeBin.lean` | `49DF819F59D7D7D0F15BDEDBFC198CA579E1F5AA72C7553D717E3CACD3FBB79B` |
| `Hecke/ZeroSupremum.lean` | `F27256644A64572823B53CAE87483C4726192FF906EE7F64AE30E13F77E57242` |
| `Hecke/DetectorZeros.lean` | `2ABE0E6D801CA5F3C136FDF89E5DD4F36C0FAFE25ED012E9EC157019FC0F06B8` |
| `Hecke/PrimeDyadic.lean` | `31806E0A1915B831ECE1B5F6F761D57C494C57DE5BF977E214050F9C1A8AF9E7` |
| `Hecke/PrimeDyadicSource.lean` | `0BE9777D15BAAF0FE6A036557471D7DB230EDA1CE85BE78DC6E00A579D7CF5DC` |
| `Hecke/PrimeDyadicScaled.lean` | `552CB44406A2B1E18D155F9C7737CA519BA855DF74A96CAA0621B687C35F9A0D` |
| `Hecke/PrimeDyadicScale.lean` | `881F005A043DB04485041EC6D7DBA697605F0CC6786E87548FE8508B5E15160D` |
| `Hecke/PrimeDyadicBuffered.lean` | `8E2644D6485311E8A2E7ED92E1994DA7F0B1C130D9A55C4DB17CA1620231E469` |
| `Hecke/PrimeDyadicControl.lean` | `3B33CC3222945C05C787BD48C81A3CADF07402969C735FE1CE630565A98FF752` |
| `Hecke/PrimeDyadicEstimates.lean` | `D3A54812759CC07B61029AA3C1AD46C7259941879FA36743AAE17ECFF674DB2E` |
| `Hecke/PrimeDyadicContour.lean` | `F1BC317704DCCE609D1D659CCCF735E128D63F0326701875FD95B17F2166C01C` |
| `Hecke/DyadicControl.lean` | `4BB0247DB8AB9C55F551207E1CDC00ED51DBC4BE8504E532B5553E1D49A30F1C` |
| `Hecke/LogarithmicActual.lean` | `3B6586669D48F18C1C291F8CF81086DB7250CB05013F3086057F8C4D26300599` |
| `Hecke/Logarithmic.lean` | `03F29A2484577DBDDAB8B7092A7B131945CF179A87C2724320DFCF4A6AB10A8B` |
| `LogarithmicControl.lean` | `D337B355A705123E90D7FC5F2A6521464ACA6BB520737A5C26931ED97B7552E5` |
| `Hecke/LogarithmicInput.lean` | `9ADCC4FDE13E8A257CDC81F4A1DA752949FCFCF339B856A40411BFE901DC6F0D` |
| `Hecke/Presentation.lean` | `F3C534C8949E50796A732770171A829B81D3035DB2DD03C62DFC4EE2B1AFF2DC` |
| `Hecke/StripActual.lean` | `003AED36D61C7295441B12AD6BC0C7F71EDC2214AD9E3FE495872E819166FDAF` |
| `Hecke/DeletionDerivative.lean` | `9D4085237057FF4C782EE5B737CFEF2F5271ADD6CAE75027D8F20070DAB3E4C6` |
| `Hecke/EulerLog.lean` | `D3D3921F0F777FC6CF2093690A2318156E0F904B129BBAD5F8BFAF69F72F4FDF` |
| `Hecke/DyadicTailBudget.lean` | `19BF6655E9B74ADB19078331BE48D528B089162E812291AC841601CD94F7A829` |
| `Hecke/PrincipalStrip.lean` | `E0EB332CD6C696C75989C373A549836574C3AE0E31B0C43B39AC82CA314794E4` |
| `Hecke/Dyadic.lean` | `15E88379D7386D4D0A873C8D2467EF28AF8ED5FB7392219D634F616B9D36C2A2` |
| `Hecke/PrimeRay.lean` | `CA691B3732199B35B2C7A6BF1F8C1F7815D50069DC899E0DEE928DABAF7DF895` |
| `Hecke/PrimeAnnular.lean` | `63308889A785B3E031666785BD8D2EB69265AD1503B8802BB4EB0E0BF9E16815` |
| `Hecke/PrimePowers.lean` | `F7EF767AE1B7785B25C4DB74586525076C79CD690AD014D39080789B532732E4` |
| `PrimeLogProfile.lean` | `6489106535C2B6DB1E3FB1602D5829D29AE04C63EDBE42AD04215B1FF00AD4F1` |
| `Hecke/Family.lean` | `B18557C5C055910287507F1ED2B1F7BB31EDE318CB62A2A10A3140F1995A9408` |
| `Hecke/PrimeDyadicEuler.lean` | `6F87DE3B233284AB2F3EB8F2130BEF58C7D2E08A8CC5A65D2C19F1437938793F` |

Context documents read (not theorem evidence):

- `work/qrh-blueprint/RESEARCH_CHECKPOINT_2026-11-11.md`: `D7671F6C2531E9F210D38B19CB9560EB3923F223BA67EF6F31ECD181BD23EA47`.
- `work/qrh-blueprint/QRH_PROVIDER_MATH_FRONTIER_2026-11-11.md`: `C04DB4F7B65BDDDD6994508D9FE6DCDF21035A2A7E735475B0076108F62E1902`.
