# Independent review of the four-band plus-height budget

2026-11-11. PASS for the conditional source/paper implication and exact scalar inequalities. No correction requested. The new heights suffice for the stated larger plus error, and the resulting cubic estimate fits the old allowance under the separate actual-function hypotheses A<=9e-12 and B<1915. This is not a finite-RH certificate, a completed formal replacement, or a cost measurement.

Reviewed author `major-constants/COUPLED_PLUS_HEIGHT_CUBIC_BUDGET_2026-11-11.md`, SHA256 `6767F9E14E5B6D7264D972085EA9C70359C87544403D37DAE315CBEF2510FC54`; script `48310E18F09209DC367261E68B259F21A49AE3D5F0C698F1A0844A7B8730A94A`; receipt `0223AE0090DFB1FF7C8DEC1CD67523BA388F8A943AEA3D1CFEBFA720295BB213`.

I read the complete frozen packet, its reviewed fallback and cubic-reallocation contracts, and the source error/transfer bodies. I reconstructed the arithmetic independently without importing or executing the author script. No analytic function, transform, zero or prime was evaluated. Prior artifacts were not changed.

## Source normalization and the height domain

The domain remains x>=4.9e26, y=x/49, R=132900. The new premise is actual closed-height GRHUpTo for each primitive nonprincipal conductor at

    ceil(200+max(255,3.1416*u(c)*1063200/qt(c))),
    u(c)=23,21.5,20.5,19.5 on the four stated half-open bands.

It includes real zeros and zeros at the height endpoint; it assumes neither simplicity nor a sign-grid success. The principal input through 1e8 remains separate. Empty primitive families do not create a missing conductor case. In particular, the author's quantification over all even conductors is safe; any later omission of c=2 mod 4 needs the usual impossibility argument.

`Prop942.errP:50` has exactly four terms. `prop_9_4_2:76` needs T>=200+max(10*pi*abs(delta),50), which follows from u>=19.5, T-200>=255 and abs(delta)<=1063200/qt(c). At delta=0 the source EA branch is zero. The ceiling only increases T. Comparing the unrounded max expressions proves Tnew<=Tfallback for every conductor, including band transitions. I also checked all 265799 integers from 2 through 265800 with a separate integer ceiling formula.

The old E1 and BP count constants are unconditional scalar bounds, not certificates of zeros at the old height. The explicit nonnegative factors in `ZeroSumGen.E1g:191` are monotone in T. Thus the reviewed fallback comparison yields E1<=7.66e6/sqrt(c) and Z3g<=177.26. This is not an appeal to monotonicity of a signed zero sum. The origin and vertical subproofs inside `Thm714.errP_le_of:430-482` are independent of T and still give 1e-17/sqrt(c) each. Their c<=300000, abs(delta)<=600000 and x domains hold. I use these subproofs, not the complete old theorem with its incompatible small E2 premise.

## Reconstructing the new E2 bound

`Thm714.E2_gen_le:101` retains both geometric denominators, the prefactor129.24, and the count expression 2Z*I+2C*I^2. With T1=255, C=.09 and T>=455, the exact inequality 48.4<=.09*455*1.2039 supplies `c3g_le:221`. The unchanged rhoB inverse bound is 2.1768.

The constant term in `IA_le:208` contains abs(delta)+1. It has not been dropped:

    IA <= 1+3.1416*(abs(delta)+1)/8.492
       <= 1.371+393400/c.

Both final comparisons are strict rational inequalities. The odd-conductor replacement of its smaller twist by1063200/c is an upper bound.

Writing a=1.371 and K=393400, the exact expansion is

    sqrt(c)*(2Z*(a+K/c)+2C*(a+K/c)^2)
      =(2Za+2Ca^2)*sqrt(c)
        +(2ZK+4CaK)/sqrt(c)+2CK^2/c^(3/2).

All coefficients are positive. Replacing the first square root by su and both inverse powers by the lower endpoint/sl bounds therefore proves the author's whole-band G(L,U) estimate. No claim that the unexpanded expression is monotone is needed. The four lower-square and upper-square witnesses check exactly.

I separately proved each exponential upper bound using degree20 positive Taylor polynomials for exp(z/128), raised to128. This differs from the author's degree16/64 witness and proves the same four EA caps and EB(255)<=4.6e-16. Only rational arithmetic is involved. The source monotonicity extends these witnesses to T-200>=255 and the required ratios >=u. Substitution reproduces every saved G and E2 fraction and proves all four scaled errors <1.49e-7. The EB factor516 is solely an upper bound for sqrt(c); there is no extra label count.

Combining all four terms and sqrt(x)>2.21e13 gives scaled primitive error <3.47e-7+1.49e-7+2e-17. The margins remain strict.

## Ambient characters and the revised cubic allowance

`ArcChars:378-440` passes to the primitive ancestor of psi inverse. Its conductor divides q, conductor inversion preserves c, and the Gauss norm is <=sqrt(c). If c is odd, the source divisibility/parity argument gives 2c<=qt(q); if c is even, c<=qt(q). This proves the required twist inclusion and conductor range. The coprime removal is at most1e-15*x before multiplication by the Gauss bound. Adding516e-15 gives a per-character weighted coefficient <5e-7.

Parseval has 1/phi(q) and at most phi(q) nonprincipal terms. Consequently Eplus<2.5e-13, without an extra phi factor. The orthogonal principal split and outer removal give rho=5.75e-7 because

    (5e-7)^2+(2.83e-7)^2 < (rho-516e-15)^2,
    rho-516e-15>0.

The inner removal already included in the weighted coefficient and this outer removal are different operations. The principal coefficient comes from its separate reviewed input.

The author correctly avoids the old upper-J lemma at the old Eplus constant. The new direct bound 16*150000*19*rho^2<.006^2 gives the same residual integrated radius. Since .640208*13.59756<2.951^2 and (2.951+.006)^2<8.79, X<=8.79x follows. The reviewed weighted-principal estimate1.902e-6 remains available with this same residual radius.

I reconstructed C=914205504131/4687500000 and Eold=64019155993729/312500000000000000 from their original expressions. With 2.965^2>8.79 and43.762^2>1915, the exact inequality

    2.965*(1.902e-6+3e-6+rho*43.762)+rho*C < Eold

holds. The first factor is the outer Cauchy factor sqrt(X/x), applied once to the already integrated star-product norm. Every term is nonnegative, so the root substitutions are in the correct direction. This verifies the stated A9e-12/B1915 composition, not the weaker A1e-10 hypothesis from a different packet.

The height comparisons with the separate base-gap and floor300 star profiles also hold before ceilings. Thus taking their union adds no height to this candidate. This assertion does not replace their analytic premises with a height comparison alone.

## Evidence and remaining obligations

Independent script `zero-sum/review_coupled_plus_height_20261111.py`, SHA256 `ADD9CC3407C27CBC5D39C33DFA06DAABE608F1EDECCF89ABE900B5CC21DC0151`; receipt `zero-sum/review_coupled_plus_height_20261111.json`, SHA256 `B5A3B5EDC8EDF0AF8203964D0693ACAF8061896C9503D20DC8250030A2C4C242`. It performs62 exact checks, including all author/dependency pins, every saved band fraction and height example, independent positive-polynomial bounds, the cubic reserve, and all265799 integer profile comparisons. The latter are metadata, not analytic evaluations.

The receipt binds all nine author dependencies. Key source pins are:

| Source relative to work/ternary-goldbach/TernaryGoldbach | SHA256 |
|---|---|
| MajorArcs/Prop942.lean | 35B170971DBD0F1C6646CD86ECE8C3A86021085C1B07730141CD6311D9CA5716 |
| MajorArcs/Thm714.lean | 7BBF8F06B1A0B703A0C00FF1E5E64997792C4E93629CED591FCB6A646301FD3F |
| MajorArcs/ArcChars.lean | 0A5BA0770CC02C94C0A802FF78FC297FE7B5776153516033ECC189331A6041CF |

The reviewed fallback supplies the already audited unconditional BP/E1 and finite-RH localization. The reviewed cubic packet supplies the physical-arc identities, principal bound and conditional B source-sieve input. Their deeper analytic/formal obligations remain dependencies. Actual finite RH, A<=9e-12, the B theorem's principal-only localization and coefficient premises, principal certificates, auxiliary counts, formal replacement of old blanket PlattGRH wrappers, and the other final consumers are not supplied here. No spectral work or total-runtime saving follows from these scalar checks alone.
