# Joining the GRH and Goldbach proof exports

On 20 November 2026, Lean compared the type of `LFunction_eq_zero_re` in MIT's challenge with the hypothesis of `plattGRH_of_release_statement` in our adapter. Both are `DirichletLZerosOnLine`. All 52,875 named declarations reached by the interface comparison agreed between the two independently serialized files. MIT's published solution-to-challenge comparison covers this same GRH theorem. [MIT verification](https://math.mit.edu/~drew/grh/) · [MIT statement comparison](https://math.mit.edu/~drew/grh/con-leche-compare.log)

| Artifact checked locally | Bytes | SHA-256 |
| --- | ---: | --- |
| MIT solution, compressed | 7,699,933,588 | `61a8938ad5f5e57397c1c0e3b954916af546d9004ade01c3555744a681b05381` |
| MIT challenge, uncompressed | 350,862,311 | `bd484ac9886a96f26b1d9a7a59ebd45b7a70d102c015d4f31f9302bbdd6ab2b9` |
| Goldbach adapter, uncompressed | 351,029,726 | `c00f195d68252c52a093444118ffd589546a3e070317add933ed7daee1e70443` |

Run the interface check with Lean 4.35.0 from this directory after decompressing the two statement artifacts.

```sh
lean -j1 -M8192 --run KernelJoin.lean --interface \
  ../../../sources/challenge.ndjson goldbach-adapter.ndjson \
  LFunction_eq_zero_re plattGRH_of_release_statement
```

The normal mode constructs an application from two actual theorem declarations and submits it to Lean's kernel. The small control exports were produced on 4.33.1 with the release exporter. Lean 4.35.0 accepted `GoldbachLinkControl.use GoldbachLinkControl.given` with an empty axiom list. Substituting the proved proposition `True` in the same application gave exit 1 and a kernel application type mismatch.

```sh
lean -j1 --run KernelJoin.lean control-provider.ndjson control-consumer.ndjson \
  GoldbachLinkControl.given GoldbachLinkControl.use GoldbachLinkControl.result
lean -j1 --run KernelJoin.lean control-provider.ndjson control-consumer.ndjson \
  GoldbachLinkControl.unrelated GoldbachLinkControl.use GoldbachLinkControl.result
```

Passing `--export new-file.ndjson` before the two input paths writes the checked result as one standalone proof with its dependencies. The 40,181-byte control output has SHA-256 `d3f3fc7689eaed04099e4b8469c0fe6af04b0688e068295218919377972ce9db`. Both `leanchecker --from-export control-joined.ndjson` and `con-leche --verified --jobs=1 control-joined.ndjson` accepted that file. Con-leche reported 26 declarations.

The local comparison checks the interface. A closed large Goldbach result requires the full GRH solution, a checked export of the Goldbach proof with Dirichlet GRH as its hypothesis, and kernel acceptance of their application. The local adapter proves only `DirichletLZerosOnLine → TernaryGoldbach.PlattGRH`.
