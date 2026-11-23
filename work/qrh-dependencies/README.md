# Isolated QRH dependencies

Prepared from openai/math commit 4eaee87548250b2682affda7d05d947c05554bae.

PrimeNumberTheoremAnd is at c39a751132c88b6e8080b74c74023fd95b3d8be0. rellich-kondrachov is at 70f85d4c1bf99c6e7d61e8be4daa6f3664d08d23. The exact upstream lean4341 compatibility patches in this directory have been applied to these isolated checkouts. git HEAD remains at each original pin and git diff records the patch. They have not been repinned or compiled.

patched-module-closure.json records patch SHA256 hashes, 19 reachable external-project modules, and the Mathlib imports needed by the two direct QRH imports. Its empty lexical-marker list does not establish an axiom audit. The original unpatched closure is in module-closure.json.

No Lake package configuration was executed. No cached package or artifact was modified. Lean v4.35 compatibility still needs compilation and any necessary audited port changes.
