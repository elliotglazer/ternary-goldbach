# Independent review of the finite log and theta recurrence

Date: 2026-11-11. Reviewer: statement_audit. Research and source review only. No Lean build, prime recount, canonical edit, or frozen-package edit was performed.

## Verdict

PASS for the mathematical recurrence, exact arithmetic replay, and the restricted finite prime-power dependency. No blocking defect found. This is not a declaration, axiom, or theorem-closure audit: the new concrete count proofs, recurrence composition, and repaired finite nonprime theorem still require Lean implementation and kernel checking.

The reviewed ledger is `prime-estimates/RESUME_PSI_LOG_RECURRENCE_LEDGER_2026-11-11.md`, SHA256 `27B2C225C2A5646DCD01948E35FA12FB3D3627E2A538D4127CC2900622624B1A`. Its script is `resume_psi_log_recurrence_integer_audit_20261111.py`, SHA256 `49B99133E50A381DFFC601872A23E3F779E509E7A94F500BABAA047FECD36589`; the saved JSON is `4C91320C74F8F8D95260F8D2FFCE5C0AF6CD3379915F8B25B81B7A237D2CDFF1`.

## Source and logarithm checks

Read the pinned target source at commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`, including SmallPsi lines 21–94, SmallMertens lines 17–70, PsiSieve lines 412–418, PsiSieve3 lines 233 onward, and the exact stg2813 declaration at PsiSieveMain line 28149. Per-file hashes are recorded in `resume_psi_log_recurrence_review_20261111.json`.

Small.T12 sums degrees 0 through 11. Small.T12up adds exactly `13*f^12/(12*12!)`. The tail starts at degree 12; each subsequent ratio is at most 1/13 for 0<=f<=1. Both source analytic implications have positive denominator and positive argument premises. Euclidean division supplies 0<=r<S and hence all fractional-part premises. The strict upper check is `chkStep u S 1 x`; its third argument must remain 1. The lower check is weak, as stated.

With F=11!, the homogeneous polynomial P satisfies T12(r/S)=P/(F*S^11). Since 12!=12F, the upper polynomial is `(144*S*P+13*r^12)/(144*F*S^12)`. All factors cleared from denominators are positive. The powers of 10 are `10^(10*q)`, matching the source definitions of ELpow and EHpow. The separately recomputed quotient and remainder at each bound are necessary and present. The Horner initialization and descending coefficients match the expanded degree-11 polynomial.

No floating-point comparison or truncated natural subtraction occurs in the acceptance checks. The Python assertions require ordinary execution without `-O`; the review used that mode. The script is an arithmetic audit of these fixed trusted input files, not an adversarial parser or a replacement for Lean.

## Exact replay and its scope

Ran the reviewed author script through the new reviewer wrapper `resume_psi_log_recurrence_review_20261111.py`. It exited 0. Its complete JSON output, redirected to `resume_psi_log_recurrence_replay_20261111.json`, is byte-for-byte identical to the pinned producer JSON. This reruns the author's arithmetic implementation; it is not represented as a second independently authored recurrence checker.

The run checks all 12,880 logarithm inequalities at 6,440 endpoints including the seed, all 6,439 scaled transitions, both polynomial representations at every numerator, and all 125,271 subcell adjacencies and count sums. It reaches exactly 5,000,000,000 with theta numerators 4,999,882,220,821,805,278 and 4,999,930,929,840,072,558. The largest log-comparison integer has 1,155 bits. Minimum checkpoint margins are 63,519,486,670,203/S at index 14 and 121,697,722,610,142/S at index 415.

This run does not re-establish primality or count soundness. The prior independent full recount is separate evidence, and neither external computation is a Lean count theorem. The recurrence script's input hashes identify 96 count-data JSON files; it does not replace the prior receipt/protocol review.

## Transition, seed, and endpoints

The source identity thS_sub is exactly a prime log sum over Ioc a b. For every counted prime, the old left lower log is a valid lower bound and the newly checked right upper log is a valid upper bound. Thus the updates L'=L+c*ell and U'=U+c*u' are correct. A right lower log substituted on the lower side would be unsound; the implementation does not make that substitution.

The semantic invariant includes the actual count equality. A supplied count or external hash must not become an unproved premise of the final public result. The old outerT3 proof is useful for its local sum argument, but its specific count routine, strict upper range, and old RtT budget cannot be reused unchanged for the new interval.

stg2813 really supplies the theta and logarithm seed at exactly 10^9 in its last three conjuncts. Its first conjunct alone only supplies an earlier half-open interval; the ledger selects the correct other conjuncts. The numerical seed agrees with source. Rechecking its logarithms does not independently prove its theta enclosure.

Every row satisfies b=min(B,a+floor(a/4000)) and a<b. The final clipped width is allowed. Closed intervals between adjacent checkpoints cover [A,B], and B is included. Exporting only the final endpoint theorem would lose the internal checkpoint estimates; composition must retain them, as the ledger requires.

For a<=v<=b, with natural a,b and v>=10^9, a<=floor(v)<=b. The nonnegative prime log sum is monotone, so no floor correction of size 1 is needed. This argument depends on bounding theta at both integer endpoints, rather than replacing the center v by floor(v) inside a pre-existing absolute-error estimate.

## Finite nonprime repair

The dependency reduction is valid for this finite E interval. Only 10^9<=N<=5*10^9 is needed; all such N lie in the repaired nonprime_mid domain 10^6<=N<10^12. Neither the global P6 large-N branch nor nonprime_small below 10^6 is needed by this consumer.

Read LambdaMu.nonprime_sum_le4 at 589, log_le_div_e at 671, the conditional original nonprime_mid at 678, PsiTwoSided.thS_add_ppS and psi_Icc_eq at 65 and 73, SmallPsiTableMain.small_table at 1082, SmallPsi700.psi_lt_small_700 at 12, and the scratch FiniteBoundary proof. The unconditional finite table supplies |psiN(m)-m|<=sqrt(m) for 12<=m<10^6. For 701<=m<10^6, sqrt(m)>=26.47 and .03883*26.47>1 supply psiN(m)<=1.03883m. The existing small-700 bound covers the other positive arguments; m=0 is immediate.

For 10^6<=N<10^12, the three root arguments in nonprime_sum_le4 are strictly below 10^6, and its square-root argument is at least 12. Thus no conditional global psi producer is necessary. Writing w=N^(1/12), the remainder is bounded by w^6+1.03883*w^4+9.39643*w^3. Independently checked the exact shifted polynomial coefficients for `.4262*w^3-1.03883*w-9.39643` at w=3.162. They are all positive, starting with 495541922771/625000000000. Also checked 3.162^12<10^6 and 20/e<7.3576 using the source rational lower bound for e.

The identity psi(N)-thS(N)=NP(N) follows from psi_Icc_eq and thS_add_ppS; NP is nonnegative. For v in [A,B], N=floor(v) stays in the finite domain. Combining sqrt(N)<=sqrt(v), sqrt(v)>31622, and 1.4262/31622<17/360000 gives the asserted k*v allowance.

A wording scope caution: the paragraph beginning 'For v>=A' must be read under the section's standing v<=B. That step cannot be exported as an unrestricted all-v theorem from this finite repair. This is not a defect in the stated final closed-interval conclusion.

## Interpolation and remaining proof work

Independently recomputed h+e=7/20000 and h+(e+k)*(1+h)=572053/1440000000 for h=1/4000,e=1/10000,k=17/360000. Both are strictly less than 1/2300. Nonnegative NP gives the lower side, while the upper side uses k*b and the right theta checkpoint. Since v>=a>0, the strict coefficient slack yields |psiR(v)-v|<v/2300 even if the checkpoint bounds themselves are weak. Finally exp(1)>2.7 and 27^23>5*10^9*10^23 prove log(v)<23; positivity of log(v) gives the requested .01*v/log(v) bound. All endpoints, including A and B, are included.

Existing carrier identities theta_eq and psiR_nat have no PlattGRH binder. Calling the original conditional nonprime_mid, nonprime_small, or full psi_two_sided unchanged would retain PlattGRH. The proposed repaired finite proof must actually replace those calls. Broad imports alone are not evidence of an unwanted theorem premise, but no compiled transitive axiom audit was performed here.

Outstanding formal work remains the count proofs, source-seed consumption, optional integer/rational checker equivalence, actual checked log inequalities, invariant composition with all checkpoints, finite nonprime repair, and real interpolation. The ledger accurately labels these as unimplemented. No final Goldbach or finite E theorem is promoted to Lean-proved by this review.
