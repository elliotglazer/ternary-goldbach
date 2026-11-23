# The four-quadrillion prime interval

For `10^15 ≤ x ≤ 10^27`, set `v = √x`, `a = −12.6/v`, `b = −113.6/v` and `δ = 2.8/v`. Set `Y = 2·10^14` and `H = 5·10^14`. The desired interval is `(x−4·10^15+4,x]`. The sharper interval used to extract a prime is `J = (x exp(−126.2/v),x]`.

| Expression | Bound | Check |
| --- | --- | --- |
| Main term `x M(1)` | ≥ `100.9996 v` | [Assembly](./Assembly.lean), [receipt](./assembly02.json) |
| Low-zero sum with multiplicities | < `98.977 v` | [Low-zero project source](../local-window/LocalLowZeros.lean), [upstream replay](../local-window/closure/README.md) |
| Middle zeros `Y < abs(Im ρ) ≤ H` | ≤ `0.001 v` | [Expanded coefficient](./ZeroBudget.lean), [receipt](./zero03.json) |
| High zeros `abs(Im ρ) > H` | ≤ `1` | [Expanded x·TailBH](./ZeroBudget.lean), [receipt](./zero03.json) |
| Vertical contour | ≤ `255` | [Expanded x^(-1/2)·Vg/(2π)](./Vertical.lean), [receipt](./vertical02.json) |
| Smoothed mass outside J | ≤ `0.511 v` | [Exact difference](../local-leak/LeakOutside.lean), [receipt](../local-leak/LeakOutside.json) |
| Weighted nonprime mass in J | ≤ `362880` | [Local prime powers](../local-powers/LocalPowers.lean) |
| Extraction and odd ternary transfer | From inner mass to a prime, then from binary through `4·10^15` to ternary through `10^27` | [Assembly](./Assembly.lean), [Transfer](./Transfer.lean), [receipt](./transfer01.json) |

The independent standard-axiom checks for the main term, complete vertical integral coefficient, middle and high zero coefficients, prime extraction, and finite transfer consumed 97.2 CPU seconds in the successful runs. Each successful file printed its axiom inventory. These timings cover these four modules only. The coarse bound `LWH 5e14 ≤ 1e18` follows from an inequality on a symbolic finite sum. The proof does not enumerate its 83 trillion windows.

[WeightedBound.lean](./WeightedBound.lean) uses the pinned project's actual explicit-formula limit, rectangle zeros, divisor multiplicities, middle-zero bound, high-zero bound, and Gaussian coefficients. Its endpoint accepts the actual low-zero bound and the exact Gaussian leakage difference. [PrimeInterval.lean](./PrimeInterval.lean) connects those two providers and exports the RH-conditional interval and the resulting finite ternary assertion conditional on binary Goldbach through `4·10^15`. The two integration modules require their own successful imports and axiom audit before claiming this composite theorem.

[check_join.py](./check_join.py) replays those two modules with the pinned Lean 4.35 binary at trust level zero, reads the nonoverlapping upstream artifacts as they are published, and records its source, input, and result hashes. An invocation with `--wait-minutes 570` started on November 20 Pacific while the shared upstream replay was running. Without the wait argument it reports unavailable imports immediately. An upstream compilation failure or a linking error still requires attention. The high-range ternary theorem, the finite binary certificate, and the connection to the external GRH proof are independent obligations.
