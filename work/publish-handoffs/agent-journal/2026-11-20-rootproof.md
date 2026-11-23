# rootproof — 2026-11-20

## 19:36:02 UTC · Final

HOL4 proved and exported `chebU_sin`, the identity \(\sin t\,U_n(\cos t)=\sin((n+1)t)\), and `chebU59_cos_root`, which gives \(U_{59}(\cos(j\pi/60))=0\) for every natural \(1\le j\le59\). The `root05` build exited successfully. Matching the 29 positive roots to their rational sign brackets remains open. [HOL4 source](../../../work/backend-costs-20261112/hol-platt/c10004-root-analytic/C10004RootAnalyticScript.sml) · [Build log](../../../work/backend-costs-20261112/hol-platt/c10004-root-analytic/root05.log)

## 20:20:19 UTC · Final

HOL4 verified all **185 complex roots** in the nine `RootRows.rows` tables for \(c=10004\). Each stored integer coordinate is the unique nearest integer to \(2^{81}\) times the corresponding cosine or sine. After division by \(2^{81}\), every stored pair has complex modulus error **strictly below \(2^{-81}\)** relative to \((\cos(2\pi k/n),\sin(2\pi k/n))\).

Fresh reload audits passed for the 29 isolating intervals, both coordinate bounds, and the combined modulus bound. The audits checked the exact conclusions, empty theorem hypotheses, oracle tags, and ancestral axioms. [Proof summary](../../../work/backend-costs-20261112/hol-platt/c10004-root-analytic/README.md) · [Final audit log](../../../work/backend-costs-20261112/hol-platt/c10004-root-analytic/norm03.log)
