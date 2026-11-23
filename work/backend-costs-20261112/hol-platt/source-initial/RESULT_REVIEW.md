# Actual complex initializer accuracy accepted

Initial03 passed the seven exact-conclusion reload roots and all current source/dependency/output bindings against the corrected integer producer. This is a recorded-result/reload review, not an independent whole-kernel replay.

The final source_initial_accuracy theorem assumes only that the actual guarded initializer returns SOME initial. From that result it derives the domain and grid ordering, proves the exact integer shift preserves the amplitude, and proves the actual complex state differs from complex_of_real(sqrt(D/A)) by strictly less than 2^-amplitude_bits. It also proves the exact amplitude has complex modulus at most one. There is no assumed value identity, external inverse-root witness or assumed initial-accuracy bound. A separate accepted identity relates the target to complex_of_real(1/sqrt(A/D)) for positive A,D.

The actual program now returns (int # int) option, as required by source_state. The upstream rational-coordinate mismatch found during this integration was corrected and fully re-audited in sourceint01, followed by stateint01, inverseint01 and boundsint01. Their archived pre-correction versions remain available. The final initializer statements are unchanged from the original candidate. Only the standalone si_grid_factor helper required an explicit natural-base annotation, documented in STATEMENT_CORRECTION.md. The other six statements are byte-identical; the current complete audit is identical to the initial02 audit. No producer assumption was weakened.

All seven roots passed exact conclusion, empty hypotheses, DISK_THM-only import tags, empty axiom tags and ancestry restricted to the four standard HOL axioms. Fifteen expected-source pins, six run-source pins, fifty-one dependency/tool pins and three output pins were rehashed and matched. The corrected producer and both directly used analytic parent theories were additionally checked against their accepted output manifests. All three phases and the container exited zero.

Successful phases consumed 32.22 CPU seconds; container elapsed time was 124.9411236 seconds. This excludes prior libraries, dependency repairs and failed/diagnostic work. It is not an initialization throughput benchmark.

The initial-accuracy ingredient is now proved for successful calls. Actual logarithm/exponential step accuracy, exact analytic time-step identities, source assembly, transforms, signs and zero counts still require proof and complete measurements. The campaign forecast is unchanged and the full research goal remains active. No initial03 process remains running.

## Accepted bindings

- SourceInitialScript.sml: 3be1d8bd0a5994b71bb4498f46f86c0dc6b9cf5bcf05ac9e32484fa6980dd57c
- initial_audit.sml: 942de7368f5b3d30cd1ded8d01bea5eee9c5a95cca6a5afb3a4d1d81953b69af
- source_expected.sha256: efa981bee36f01bf0320d19f4081fee46adfd557544cd2a17639a505f77a75e4
- .hol/objs/SourceInitialTheory.uo: 6b5a7949a5e275be640c2824e3d7b9b81209beb91867c0ce25144b6daca233bb
- .hol/objs/SourceInitialTheory.dat: 0f9cdd96a427b907d5c8450e3be8df77cb3a86707744db36b9eda33d20cb72d2
- initial03_audit.log: 41441464f7ebcb970394d42288055658c6bcd080e11da3d1541d43045c87a184
