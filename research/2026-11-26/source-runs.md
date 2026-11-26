# Source replay journal

The first compact run stopped during the challenge build. The later runs in this table supplied the retained preflight logs and the source-build results that led to the accepted combined theorem. All timestamps are UTC. A dash means the attempt did not record that quantity. The module counts are newly completed Lake targets for that run. Qualifying earlier artifacts let later runs compile additional dependents. The runs overlap in time where the finite and GRH builds ran together.

| Start, November 26 unless indicated | Candidate | Target | Exit | Newly built | Result |
| --- | --- | --- | ---: | ---: | --- |
| Earlier compact trial | [`e0722a0e`](https://github.com/elliotglazer/ternary-goldbach/commit/e0722a0e5d3ebac13fba180599f4dd4551e98921) | Challenge | 1 | — | ProofWidgets package-lock failure |
| 00:09:04 | [`0b68b493`](https://github.com/elliotglazer/ternary-goldbach/commit/0b68b493791e5f7569021f0cd13454151af47584) | Joint source | 1 | — | Interrupted after ten failed targets |
| 01:51:10 | [`e9f3c8ad`](https://github.com/elliotglazer/ternary-goldbach/commit/e9f3c8adb418f4e497787ef93175066acb1c8f72) | Joint preflight | 1 | — | source preflight failed |
| 02:33:29 | [`d6b1bfd5`](https://github.com/elliotglazer/ternary-goldbach/commit/d6b1bfd523e2c54b6e4bb72844deeddf8341879a) | Joint preflight | 1 | — | source preflight failed |
| 04:01:01 | [`4d574858`](https://github.com/elliotglazer/ternary-goldbach/commit/4d57485856bf3346fa2ed54894a7411f404b66d1) | Main | 1 | 83 | failed |
| 05:26:39 | [`bdca1b47`](https://github.com/elliotglazer/ternary-goldbach/commit/bdca1b47d0be84f96dfadad0dfd3b4c4eecc1c7a) | Main | 1 | 66 | failed |
| 05:34:46 | [`ddd0f6b3`](https://github.com/elliotglazer/ternary-goldbach/commit/ddd0f6b32b08f31d0e4a5dcfa7e6a1f9ecf25443) | CompletedFiniteRows | — | 454 observed | Host shut down before the result was written |
| 07:23:49 | [`24954b28`](https://github.com/elliotglazer/ternary-goldbach/commit/24954b2814714e7fe324bcdc0304c0a9ddefb909) | Main | 1 | 45 | failed |
| 07:41:11 | [`24954b28`](https://github.com/elliotglazer/ternary-goldbach/commit/24954b2814714e7fe324bcdc0304c0a9ddefb909) | CompletedFiniteRows | 124 | 22 | timed out |
| 08:04:21 | [`333aa9bb`](https://github.com/elliotglazer/ternary-goldbach/commit/333aa9bb21fd87ef1f6be2159dbffc2c8da75962) | Main | 1 | 71 | failed |
| 09:06:11 | [`9e6a0519`](https://github.com/elliotglazer/ternary-goldbach/commit/9e6a0519ba41540a0fb11ee606bb5f1e79d86b98) | Main | 1 | 21 | failed |
| 09:33:38 | [`731247bf`](https://github.com/elliotglazer/ternary-goldbach/commit/731247bfc6c8d14f034396c049cf80ee604c3c4b) | Main | 1 | 18 | failed |
| 09:39:16 | [`b6535e79`](https://github.com/elliotglazer/ternary-goldbach/commit/b6535e79fde64adc5288e02ad3393bd1eca94631) | CompletedFiniteRows | 124 | 31 | timed out |
| 09:56:05 | [`86170f19`](https://github.com/elliotglazer/ternary-goldbach/commit/86170f1982b616fce1486fdb2c64d1a69558a0cf) | Main | 1 | 34 | failed |
| 10:32:01 | [`cb1dffe1`](https://github.com/elliotglazer/ternary-goldbach/commit/cb1dffe10fd5a86ab53fb71a4812eb73786ed530) | Main | 1 | 11 | failed |
| 10:41:22 | [`cb1dffe1`](https://github.com/elliotglazer/ternary-goldbach/commit/cb1dffe10fd5a86ab53fb71a4812eb73786ed530) | CompletedFiniteRows | 0 | 207 | passed |
| 11:07:48 | [`8e9b8aef`](https://github.com/elliotglazer/ternary-goldbach/commit/8e9b8aefb683106c0c2ca08fac57e24ff2ad7a4a) | Main | 1 | 12 | failed |
| 11:20:54 | [`6bfbe26f`](https://github.com/elliotglazer/ternary-goldbach/commit/6bfbe26fbd87822d1f9c4434dde84489dab7ff8e) | Main | 1 | 23 | failed |
| 11:31:51 | [`53d3fc49`](https://github.com/elliotglazer/ternary-goldbach/commit/53d3fc49f3eb5617cd6c5e19a7f1d0f1af01193e) | Main | 1 | 43 | failed |
| 11:44:36 | [`3ca2fcf7`](https://github.com/elliotglazer/ternary-goldbach/commit/3ca2fcf7e3dd1897ff242d8e482aa7f82abe263b) | Main | 0 | 13 | passed |

## Where the repairs landed

The earlier failed builds exposed more of the import graph as fixes landed. On the penultimate GRH attempt, the three previous failures compiled, including the localizations used by the Galois representation. One newly reachable proof in `New.Rows.Separation` still left metavariables in the weight of a splitting character. Giving Lean the character, exponent and tame part explicitly fixed it. `New.Main` and `Main` then compiled. [Final repair](https://github.com/elliotglazer/ternary-goldbach/commit/3ca2fcf7e3dd1897ff242d8e482aa7f82abe263b)

The finite build at `cb1dffe1` reused 525 validated modules and compiled 207 more. The repaired GRH build compiled the last 13 with 781 validated predecessors. A separate step checked the full closures against the final source and compiled the two connecting modules. The subsequent Palomar rehearsal began with a fresh solution build. [Finite closure](https://github.com/elliotglazer/ternary-goldbach/tree/e735b1634f13ad9d8c4ba4c8876963ac9e1a6810/verification/community-grh/compact/finite-terminal-22f442fa) · [Whole-theorem join](https://github.com/elliotglazer/ternary-goldbach/tree/c6368decde84d4be04943117a2bfef991f9b1831/verification/community-grh/compact/joined-theorem-3ca2fcf7)

The [machine-readable records](evidence/source-attempts.json) contain all source-located error headers recovered from the retained logs listed there, including repeated and cascading errors. A compiler abort may have a failed Lake target without a source location. For the interrupted first joint run, only the summary was recovered in the cited archive. For the interrupted finite run, the log shows 454 distinct completed modules. Its successor checked which sources and artifacts it could reuse. [Rehearsal and recovery chronology](rehearsal.md)
