# Independent review of the odd shared-RH plus height

2026-11-11. PASS for the conditional odd-conductor source/paper implication. No correction requested. The stated profile gives the claimed weighted coprime coefficient below7.41e-7, uniformly in the stated x and twist ranges. No even-conductor estimate, actual finite-RH instance, merged certificate or runtime claim is established here.

Author `major-constants/ODD_PLUS_SHARED_RH_HEIGHT_2026-11-11.md`, SHA256 `C4EE2B2F674F6376D987C778FC7886A03A93BC81E61C0BC56D0B1C25E2E4A14D`; script `51125999FDFB867FCC8D142AB51358F76EF1B0A59457C05444BE6340477E2014`; receipt `A8BC18047E60F92264A705892D757F5F0AFF7B299372C66CB038695CD27463CE`.

I read the complete frozen packet and independently reconstructed its exact inequalities. The unchanged source identities were checked in my preceding coupled-profile review, SHA `A410B45323B9EB77E006E6E47403C6C4A8EC69E2E59E6C66FF44089E80FED6A5`. This review checks the new odd twist, heights, tail constants and their composition with those identities. No author program was imported or executed and no analytic values or builds were produced.

## Domain and unchanged terms

For odd primitive nonprincipal c<=132900, c>=3 and d_c=531600/c. The new height is the integer ceiling of200+max(240,3.1416*u(c)*d_c), with u=21,20,19.5,19.2 on the four stated bands. The exact lower bound d_c>=4 shows that the240 branch is inactive. Nevertheless T>=440 is a valid common lower bound; exact enumeration gives minimum442.

Closed GRHUpTo remains an explicit hypothesis on every actual nontrivial zero, with both ordinate signs, real zeros and the boundary included. Modulus one remains outside this argument. For abs(delta)<=d_c, the height satisfies Prop942's T>=200+max(10*pi*abs(delta),50). The source zero-twist EA branch needs no division by delta.

Every new u is at most the corresponding coupled-profile u, and240<=255. Ceiling monotonicity gives Todd<=Tcoupled throughout, so the reviewed comparison with the old unconditional BP/E1 endpoint bounds applies. No RH statement at the larger endpoint is introduced. Thus E1<=7.66e6/sqrt(c) and Z3g<=177.26 remain valid. The first yields scaled error <3.47e-7 because sqrt(x)>2.21e13. The T-independent E0 and vertical subproofs in Thm714:430-482 still give1e-17/sqrt(c) each. Their conductor, twist and x domains are unchanged.

## New high-zero bound

In Thm714.E2_gen_le:101, take T1=240, Z=177.26, C=.1, IB=2.1768. The exact growth inequality48.4<=.1*440*1.2039 pays for the smaller height; retaining the older .09 without this check would not be justified. The prefactor129.24 and both geometric denominators remain.

The source IA_le includes the additive1 in abs(delta)+1. With the odd twist it gives

    IA<=1+3.1416*(abs(delta)+1)/8.492
      <=1.371+196700/c.

Both rational comparisons are strict. This halving of the inverse-conductor coefficient is valid for odd inducing conductors even when the ambient modulus is even.

I independently bounded the EB and four EA exponential tails using positive degree20 Taylor sums at z/128, raised to128. This differs from the author's degree16/64 construction. It verifies the same bounds without evaluating exp. The source decreasing-tail lemmas apply for T-200>=240 and ratios>=u>=19.2, so these are uniform bounds rather than endpoint samples.

With a=1.371 and K=196700, expansion gives the three positive terms

    (2Za+2Ca^2)*sqrt(c)
      +(2ZK+4CaK)/sqrt(c)+2CK^2/c^(3/2).

The upper/lower square-root witnesses bound each term in its appropriate direction on each closed bounding band. In particular the c^(-3/2) term is retained. All four saved G and E2 fractions reconstruct exactly. Each E2 result is <3.93e-7 after multiplication by sqrt(c). The global365 factor applies only to the EB term and follows from c<=132900<365^2; it is not a character-count factor.

## Ambient induction, removals and consumer scope

The actual ArcChars proof uses the primitive ancestor of psi inverse, with c dividing q and conductor inversion preserving c. If q is odd, qt(q)=2q>=2c. If q is even and c odd, coprimality of2 and c gives2c dividing q, so qt(q)=q>=2c. Hence the ambient twist1063200/qt(q) is at most531600/c in both cases. This inclusion needs no assumption that the ambient modulus is odd.

The Gauss norm is <=sqrt(c). The inner coprime removal therefore contributes at most365e-15; the author's516e-15 allowance is conservative and compatible with the whole-family contract. All four primitive errors plus that allowance give

    3.47e-7+3.93e-7+2e-17+516e-15 <7.41e-7<8.385e-7.

The coefficient includes the inner removal. The principal error2.83e-7 and outer-removal term516e-15 remain separate in the orthogonal energy formula. I checked the stated square and cap inequalities. An even component must independently meet the relevant whole-family energy contract; this odd bound alone cannot establish it. No half-support factor is needed for this odd estimate.

Both Hbase=ceil(27e6/c) and Hstar=ceil(max(300,704*d_c/343)) are below Todd, by the stated positive slope comparisons before ceilings. I checked all66,449 odd integers as well as every saved example. These are height comparisons only; the base-gap and star analytic proofs remain dependencies. Under shared ordinary RH, the complete star carrier is restricted to Hstar, not enlarged to Todd.

The shared-RH budget's independent review is now frozen at SHA `E0A20B5BF33FB7FBF3C2C71ECE1FEAFCA03C54661B1C21B27A21DAEADACB72A2`. The author's historical pending language need not be changed. That reviewed composition supplies the stated strong star norms after its hypotheses; the current odd theorem does not require the direct-B1915 sieve alternative.

## Evidence and remaining work

Independent checker `zero-sum/review_odd_shared_rh_height_20261111.py`, SHA256 `A966ACB9E828CDD32E84726CBBA8BFE5AAB21218FF47B3BA29937B0632D54E31`; receipt `zero-sum/review_odd_shared_rh_height_20261111.json`, SHA256 `84393B0A23B783A3C4ECB2C8AAB767C8941550B44AF1B65E6C8837023D49F6D0`. All50 checks passed, including all six dependency pins, fresh rational tail witnesses, every band fraction and example, and the full odd height comparison.

The unchanged source pins are Prop942 `35B170971DBD0F1C6646CD86ECE8C3A86021085C1B07730141CD6311D9CA5716`, Thm714 `7BBF8F06B1A0B703A0C00FF1E5E64997792C4E93629CED591FCB6A646301FD3F`, and ArcChars `0A5BA0770CC02C94C0A802FF78FC297FE7B5776153516033ECC189331A6041CF`. Relevant entry lines are Prop942:50/76, Thm714:101/208/221/247/430-482, and ArcChars:314/378-440.

Actual finite RH, principal/head inputs, the separate even component, auxiliary count certificates, source localization replacing broad PlattGRH wrappers and formal kernel validation remain outstanding. This review does not infer a complete checking cost or a successful spectral computation.
