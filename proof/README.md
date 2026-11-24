# The closed ternary Goldbach theorem

Stock Lean 4.33.1 accepted `CompletedGoldbach.ternary_goldbach : TernaryGoldbach.Statement`. The statement says that every odd natural number greater than five is a sum of three primes. The final run imported the compiled RH and primitive Dirichlet GRH release. The saved theorem lists `propext`, `Classical.choice`, and `Quot.sound` as its axioms. [Theorem](CompletedGoldbach.lean) · [Kernel log](evidence/CompletedGoldbach.log) · [Saved-object audit](evidence/CompletedGoldbach-metadata.log) · [Receipt and hashes](evidence/CompletedGoldbach-receipt.json)

## Read the proof

1. A prime-gap bound and the binary Goldbach certificate through **564,386,325,504** cover odd inputs through **2 × 10¹⁹**. [Finite reduction](FiniteAtHeight.lean) · [Binary prefix](ProductPrefix564386325504.lean)
2. In the intermediate range, four groups of minor-arc inequalities certify 223 intervals. Uniform estimates cover the infinite tail once the natural logarithm of the input reaches 56. [Analytic reduction](ProfileAssembly.lean) · [Interval argument](ProfileRoute.lean) · [Infinite tail](LargeTail.lean)
3. The finite and analytic results leave two hypotheses. The last declaration supplies their released proofs. [Combination](CompletedFiniteRows.lean) · [Final declaration](CompletedGoldbach.lean)

## Restore the complete sources

From a checkout of this branch, run the following commands. The restore script joins the binary parts and checks the resulting 208,483,891-byte ZIP against the SHA-256 recorded by the original run. The ZIP contains the Lean sources, the saved theorem, the numerical certificates, the build manifest, the audit logs and the upstream notices. The selected sources above can also be read directly on GitHub.

```sh
python3 proof/restore_bundle.py lean-sources.zip
python3 -m zipfile -e lean-sources.zip proof-replay
```

## Recheck

For a quick check of the saved theorem's type, proof application and exported axiom metadata, use Lean 4.33.1 directly in the repository checkout.

```sh
cd proof/evidence
lean --run InspectModule.lean CompletedGoldbach.olean
```

To compile the local source modules, run `python3 reproduce.py /absolute/path/to/mathlib4` from the extracted `proof-replay` directory with a populated mathlib checkout at `0df444a360eaa60ab8c11dca51a86af692955474`. The script checks source hashes, fetches four pinned upstream files, and compiles in the order recorded in `sources.json`.

For the final kernel link, run the following from `proof-replay` after that compilation. Set `MATHLIB` to the absolute path of the same checkout and `GRH_LIB` to the absolute path of the extracted `alp-oleans/lib` directory containing `Main.olean` and its dependencies. The upstream release index provides the archives and checksums. [GRH release index](https://photos.proofsandreasons.io/alp-oleans-357309b5dd12/)

```sh
export LEAN_PATH="$PWD:$GRH_LIB:$MATHLIB/.lake/build/lib/lean"
for d in "$MATHLIB"/.lake/packages/*/.lake/build/lib/lean; do
  export LEAN_PATH="$LEAN_PATH:$d"
done
lean -j1 --run grh-link/LinkWithAxioms.lean close
lean --run grh-link/InspectModule.lean CompletedGoldbach.olean
```

The receipt pins the original statement, the release's `Main.olean`, and the saved proof object. The separate endpoint benchmark records a native full-block result and a kernel result for the terminal tile. [Run report](evidence/analytic-progress.json) · [Endpoint benchmark](evidence/endpoint-benchmark.json)
