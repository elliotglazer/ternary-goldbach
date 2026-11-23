# rootkernel — 2026-11-20

## 19:38:59 UTC · Final

HOL4 verified all 29 disjoint, strictly descending bins in \((0,1)\). The exact scaled \(U_{59}\) recurrence has opposite signs at every pair of endpoints. HOL4 also rejected the reversed list and a two-unit perturbation of the first center, and verified all 185 twiddle pairs across the nine transform lengths.

A fresh HOL process checked the three exact theorem statements, their empty hypotheses, and the allowed axiom ancestry. All three carried only the `DISK_THM` reload tag. [Audit log](../../../work/backend-costs-20261112/hol-platt/c10004-root-check/root07.log)

The analytic identification of the isolated roots with \(\cos(j\pi/60)\) remains outside these finite theorems.

## 19:53:43 UTC · Finding

gAAAAABrAKVIcbamEvHTQ71IAtQla3T1PWpxjg1SSoq53ntao_jrR9r5E9R_v1sapk4iOi74hwqn8suXwAP1D9FgY9R-GYQ0TiQlFncUwS1uieuWReZO1nWjBjeWgJFbqyfwRnd3i1mBknCOxU0pKbcW7QhsjwGo2XA0Wud2z1Kr2enbwTCo4TVjfNV6uNsjPFrIYfSpuSS15vOVKqPVMqSBaxvZNAYkJrzYigRk69pbRZW-OS82zBhz2eNn4irEMbnwYeyVUzEqjOhDuiXBzwtucY_wr0xL0NaFdU2HzmDeSktWKeAPIS7BoRN-730_swapbxZ_QnCq8CVdAw-RHg9j8Ln84RJ0VE9n46OHU7hPkDcEq4z14ZWtBQoTM-zysIZOQ-zQev_t9q30EQVpueNLXD8cDdqcTiqeWfpRIG8ufFf0LZFl4vAh64M3_3-Kd158DNthB9GAPje6l60QSwkMByMgjLkxaw==

## 20:07:24 UTC · Final

Stock HOL4 checked all 448 complex outputs on each of two conductor-10004 slabs. Median kernel time per complex output over five interleaved trials was:

| Heights | Effective degree | Delayed scalar | Mixed scalar |
|---|---:|---:|---:|
| 1–64 | 9 | 49.51 µs | 50.40 µs |
| 6337–6400 | 19 | 83.67 µs | 93.87 µs |

Including Boolean discharge and structural checks, the hard slab took 96.55 µs per output for delayed scalar and 105.88 µs for mixed scalar. Preparing fresh literal inputs for HOL added 14.47 and 19.15 CPU seconds respectively per hard slab. Both measurements cover band 1 and the first two fine cells.

The eight-height comparison also favored delayed scalar over packed Horner. HOL4 separately proved the generic rounded-up reciprocal division theorem and passed a fresh-process audit. [Benchmark report](../../../work/backend-costs-20261112/hol-platt/c10004-lane-horner/README.md)

## 20:20:16 UTC · Finding

gAAAAABrAKuBbhBJAz4Hwc0LtK6B5g1Ww7bQjpqanbxNp6G2NaEXP7JlX_eNpW9-rhe2YBub7E9ADvTkxkZKFLYlNu9I31MtIH_udVlMl4SJnawKHwd9KEMiqDA9aRi_3X66iPyfaq1J61ibPhvZub-LmsDQWmNbCLMkSG32Uv41ZWZWJlrJnYpw3Ony79nb7gPre-C2BNxs8Xw0vodA18oX8Dc6KY0JVW-5mgVJ2RDd2_lMcCYnpRlcaU5c_Z8iqIb2DoGo4-XT37EskPbRo-Z7MUcWe34ONADZcIR0GvwEFM7Xzen1xDC0MS8K5eVw10cYbHDWUXkY72aFB5n1t6tC2yJzBLuie5GqfjJFdBNge41XWoWHqOEZ8L8M9X9-n5M1NKsl4C_6BZYILGA9-en0i03YoVEtc5uap_Zako9EhR1H-QPZ-i3mTpbd8m8i1lPwlkdHdWnTG-2p4NcuTKcZky-ylyOcNdqy5oXbbZepSusGp8VT6O0Sf1DPB0oAGbBCPfX0dYP6lQB90JsW8aycC54qUYiWwZWD9BE2Coh8yLjgN8vASEeL5OGN-dMqR3-ijwREPRbysl_oYUXt_EmRC9w70Y3H_5rGTPVU7Ky5dZAdWoctocLYqBHLHiz9_ztH5oHBfnmd9QKapKlNonbncVqrYLAS9GLkVP2oL7y1nEOvefQVF9moL8KSACcOHPlcMTR7Ip23EYT-4WkpGZjnoroeM7x6qQ==
