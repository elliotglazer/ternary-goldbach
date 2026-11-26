# Ternary Goldbach at `d6b1bfd5`

The public theorem `PalomarTernaryGoldbach.ternary_goldbach` states that for every odd natural number $n>5$, there exist primes $p,q,r$ with $p+q+r=n$. Repeated primes are allowed. The statement has no RH, GRH, or finite-verification hypothesis. [Public theorem](https://github.com/elliotglazer/ternary-goldbach/blob/d6b1bfd523e2c54b6e4bb72844deeddf8341879a/GoldbachSolution.lean#L7-L12)

## Where GRH enters

`CompletedGoldbach.ternary_goldbach` applies `GoldbachFinite.completed_of_release` to two declarations from the bundled compact GRH proof. The first, `riemannHypothesis`, supplies ordinary RH. The second, `LFunction_eq_zero_re_of_isPrimitive`, says that for each nonzero modulus $d$, each primitive Dirichlet character $\chi$ modulo $d$, and each zero $s$ of its $L$-function with $0<\Re(s)<1$, one has $\Re(s)=1/2$. Both declarations follow from `New.grh`. [Final application](https://github.com/elliotglazer/ternary-goldbach/blob/d6b1bfd523e2c54b6e4bb72844deeddf8341879a/CompletedGoldbach.lean#L9-L12) · [GRH exports](https://github.com/elliotglazer/ternary-goldbach/blob/d6b1bfd523e2c54b6e4bb72844deeddf8341879a/CompactGRH/src/Main.lean#L8-L17) · [Conditional theorem and its finite inputs](https://github.com/elliotglazer/ternary-goldbach/blob/d6b1bfd523e2c54b6e4bb72844deeddf8341879a/CompletedFiniteRows.lean#L13-L23)

## Why the binary check reaches the ternary cutoff

The finite certificate covers every even $m$ with $4\le m\le564{,}386{,}325{,}504$. The proof needs only $B=564{,}383{,}557{,}524$, an even bound smaller by $2{,}767{,}980$. It uses this prefix to prove ternary Goldbach for every odd $5<n\le H$, where $H=2\times10^{19}$. [Certified binary prefix](https://github.com/elliotglazer/ternary-goldbach/blob/d6b1bfd523e2c54b6e4bb72844deeddf8341879a/ProductPrefix564386325504.lean#L7-L13) · [Choice of cutoff](https://github.com/elliotglazer/ternary-goldbach/blob/d6b1bfd523e2c54b6e4bb72844deeddf8341879a/LowerCutoff.lean#L11-L18)

For $n\le 10^{15}+4$, the proof subtracts $3$ when $n\le100{,}328{,}530{,}944+3$. Above that threshold, a checked list of primes supplies an odd prime $p$ with $4\le n-p\le100{,}328{,}530{,}944$. [Small-range proof](https://github.com/elliotglazer/ternary-goldbach/blob/d6b1bfd523e2c54b6e4bb72844deeddf8341879a/LowerPrefix.lean#L12-L22) · [Prime-list coverage](https://github.com/elliotglazer/ternary-goldbach/blob/d6b1bfd523e2c54b6e4bb72844deeddf8341879a/LadderToQuadrillion.lean#L1888-L1889)

For $10^{15}+4<n\le H$, put $x=n-4$. Ordinary RH supplies an odd prime $p$ satisfying $x-126.2\sqrt{x}<p\le x$. The proof obtains $4\le n-p<B+2$ using $\sqrt H\le4{,}472{,}135{,}955$ and $126.2\cdot4{,}472{,}135{,}955+2=564{,}383{,}557{,}523\le B$. Since $n-p$ and $B$ are even, $n-p\le B$. The binary prefix gives $n-p=q+r$. [Prime-in-interval theorem](https://github.com/elliotglazer/ternary-goldbach/blob/d6b1bfd523e2c54b6e4bb72844deeddf8341879a/PrimeInterval.lean#L15-L22) · [Subtraction and parity](https://github.com/elliotglazer/ternary-goldbach/blob/d6b1bfd523e2c54b6e4bb72844deeddf8341879a/FiniteAtHeight.lean#L16-L44)

The analytic argument covers odd $n\ge H$. It uses certified bounds for $\log n<56$ and tail estimates for $\log n\ge56$. These ranges cover every odd $n>5$. [Range assembly](https://github.com/elliotglazer/ternary-goldbach/blob/d6b1bfd523e2c54b6e4bb72844deeddf8341879a/NumericAssembly.lean#L24-L32) · [Analytic split](https://github.com/elliotglazer/ternary-goldbach/blob/d6b1bfd523e2c54b6e4bb72844deeddf8341879a/LargeTail.lean#L38-L49)

## Verification status

This note traces the source at the linked commit. At the time of writing, a successful cold build and protected Palomar Comparator verdict for that commit are still pending. The earlier Lean 4.33.1 receipt records a different build that used precompiled RH and GRH objects. [Verification status and historical receipt](https://github.com/elliotglazer/ternary-goldbach/blob/d6b1bfd523e2c54b6e4bb72844deeddf8341879a/README.md)
