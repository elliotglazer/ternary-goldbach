# Ternary Goldbach research notebook

This is the working history of Elliot Glazer's Lean project with GPT-6.2 Astra. It began with a question about replacing a hypothesis in Charlie Reams's formalization of Harald Helfgott's proof. It ended up using the community Dirichlet GRH proof, a different split between the finite and analytic ranges, and a much smaller binary Goldbach calculation than the one first proposed.

On November 26 a fresh Lean 4.35.0 process imported `PalomarTernaryGoldbach.ternary_goldbach`. It states that every odd natural number greater than five is a sum of three primes. Lean printed exactly `propext`, `Classical.choice` and `Quot.sound`. The last dated measurement included in this edition is from the separate protected Palomar rehearsal. At 12:40 UTC it had completed 655 project modules. It had yet to export or independently check the full solution. [The public source candidate](https://github.com/elliotglazer/ternary-goldbach/tree/3ca2fcf7e3dd1897ff242d8e482aa7f82abe263b) · [Exact theorem and axioms](https://github.com/elliotglazer/ternary-goldbach/blob/c6368decde84d4be04943117a2bfef991f9b1831/verification/community-grh/compact/joined-theorem-3ca2fcf7/fresh-import.log) · [Protected rehearsal measurement](evidence/performance-1240.json)

## Read the research

| Question | Where to look |
| --- | --- |
| What did the original agents try, what did they measure, and why did the plan change? | [November 10–24 campaign journal](early-campaign.md) and the [original dated agent reports](https://github.com/elliotglazer/ternary-goldbach/tree/97a45946f7d31239ecd466e637116a774f24b7d3/work/publish-handoffs/agent-journal) |
| Where do the classical three-primes results enter? Why was the direct Zinoviev route set aside? | [Analytic research and source map](analytic.md) |
| Which GRH source was used, and what did it cost to make it importable? | [Source comparison, port and Lean repairs](community-grh.md) |
| Why verify even integers up to 564,386,325,504? How do the certificates reach that endpoint? | [Finite computation and scheduling experiments](finite-and-scheduling.md) |
| What happened to the failed builds, and how did their results contribute to the successful proof? | [Linux replay and Palomar rehearsal](rehearsal.md) and [the source-run ledger](source-runs.md) |
| Which experiments can a reader check at file or module level? | [Working notes](field-notes/README.md), [compiler experiments](evidence/README.md), and [guide to the records](reproduce.md) |
| Where are the earlier alternatives, including the HOL4, MM0, Rocq, and Lean benchmarks? | [November 22 archive and release assets](https://github.com/elliotglazer/ternary-goldbach/releases/tag/research-2026-11-22) and the [technical artifact index](evidence/public-artifacts.tsv) |
| Which revisions changed a claim or supplied a repair? | [Published experiment history](evidence/published-history.tsv) and [dated branch tips](evidence/branches.tsv) |

The published-history table covers 240 commits reachable from 16 branch tips at the snapshot. The technical index identifies 3,581 versioned files. The Linux journal records 20 source attempts, including timeouts and one finite run that ended without a terminal receipt. A separate dataset preserves 606 timed compiler trials across 558 Lean modules. These counts describe different experiments. The commit and file records include the links needed to inspect or restore the underlying work.

## The successive proof targets

| Date in 2026 | What was checked |
| --- | --- |
| November 10–13 | The QRH work identified which zero bounds would be needed and measured representative certificate computations. The initial blueprint still had an open analytic implication. |
| November 20–23 | Full Dirichlet GRH offered a way to supply the zero locations. The work shifted to a prime-gap reduction and a feasible binary cutoff. The November 22 archive had a contiguous Lean binary result through 100,328,530,944. |
| November 24 | Lean 4.33.1 checked the closed Goldbach theorem using the published upstream RH/GRH objects. The local finite proof reached 564,386,325,504. [Original kernel receipt](https://github.com/elliotglazer/ternary-goldbach/blob/b37fd3e56064346ff058edb45f81cebf5ce39474/proof/evidence/CompletedGoldbach-receipt.json) |
| November 25–26 | The source integration moved to the compact Lean 4.35 edition. Both source roots passed. The final join checked their sources, compiled both connecting modules, and imported the theorem in a new Lean process. [Join evidence](https://github.com/elliotglazer/ternary-goldbach/tree/c6368decde84d4be04943117a2bfef991f9b1831/verification/community-grh/compact/joined-theorem-3ca2fcf7) |
| November 26, 12:40 UTC | Palomar's stock verifier had exported the independent challenge and was compiling the solution from source on the 32-vCPU, 64-GiB profile. [Checkpoint](evidence/performance-1240.json) |

The chapters use the dated project records, including proposals that later failed. The accompanying data retain source versions, failed diagnostics, durations, module dependencies and receipt digests. The November 22 archive supplies the earlier individual research reports and large inputs. This organization follows the cumulative handoffs in [the Diophantine project](https://github.com/elliotglazer/diophantine-z-q). [Download this notebook and its data](../../handoff/ternary-goldbach-research-2026-11-26.zip) · [File checksums](SHA256SUMS)
