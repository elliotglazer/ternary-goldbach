# Map02 numerical identity translation repair

13 November 2026. Coordinator-authorized source repair only. No build, evaluator, proposal generator, or finite-domain enumeration was run for this change.

The preserved map02 log shows that all original definitions parsed. Automatic translation specialized `GENLIST I 2301`, then tried to translate the polymorphic definition of `I`, and then `S`. It rejected a function-typed argument of `S`. No finite check or final map theorem had been accepted. This is a translation failure, not evidence against the finite assertions.

The successor adds one proved numerical application equation immediately before the existing automatic translation:

```
Theorem map_num_identity[cv_inline]:
  !n:num. I n = n
Proof
  simp [combinTheory.I_THM]
QED
```

Every existing definition, check, final theorem statement, and proof is byte-identical to the map02 source. Removing the inserted comment/theorem block exactly recovers that complete file. There is no new premise, alternate predicate, or Python-supplied map. The original `GENLIST I` terms remain the source objects being checked.

This uses the actual stock translation mechanism. `cv_stdScript.sml:321` registers `combinTheory.I_THM` with `[cv_inline]`. `cv_memLib.sml:133–138` stores these proved equations, and `cv_repLib.sml:203–204` applies them in a proof-producing rewrite before translating the resulting term. The numerical specialization removes `I n` from the generated numerical list body before the translator needs the higher-order definition of `I`. `combinTheory.I_THM` is itself proved from the ordinary combinator definitions. This repair does not require importing the larger `cv_std` theory or rebuilding any dependency.

The inline equation can also apply to numerical `GENLIST I` specializations in a later consumer. Such a consumer must actually load the theorem's registered data, or register its own proved numerical equation. It must not assume that reading this note affects translation. The layout author was notified of the same issue.

The original map02 source, existing review/parser-repair note, and outer/inner map02 logs are archived under `history/map02_identity_translation/` with `SHA256.json`. Existing receipts remain unchanged. This repair targets the observed failure; subsequent translation, finite evaluation and theorem assembly still require a successful fresh attempt.

| Artifact | SHA256 |
| --- | --- |
| map02 source | 7A3307716CE158DE2B04DA6CB80EDA84A38E345E455A79391AB36054689C4BD1 |
| Successor C10004MapScript.sml | 1915881A88C625BD70ED70F6F86DFBA80368D4A2C13C3F45777BD3A570D338BE |
| map02_theory.log | 808F9E57FC6382885F5A2D8C5BEE5AFFFC08C9AFF767C7D8D122D12190CD95B1 |
| map02_theory.time | D310276B5CE5D66BC8EA5BFA9500D9BFBABBE0DE0DD2AAE554D2DA8CBF2349DF |
| Archived inner theory log | 127F29492A9D7AC788605BD8367C97C1EE3FD52B982D038BB861DA5B478D2D8F |
| cv_stdScript.sml | 164613275038DB55FEEF0E252DA5B20B36FE22D542705EED2319FC7D514B4615 |
| cv_repLib.sml | 4B1ADF399CA233B0B1394CA6A6D1F8063D4AF793D72435308BB5D123B268F66C |
| cv_memLib.sml | E0CD0485AFCBCD9DC35F80D65FF4409209F9EBA44F2C374E143F692D6A89B4F6 |
| cv_transLib.sml | 182DABE3CDFD677E1EC8ED4DDD0E8EA3F6D6584D801CAE7F13EE01A203C5647F |

The library files are under the pinned HOL checkout's `src/num/theories/cv_compute/automation`. A coordinator-reviewed map03 can use the unchanged runner and resource limits. No compiled finite-map or character/DFT claim is made here.
