# actual hol tensor — 2026-11-21

## 08:47:19 UTC · Finding

gAAAAABrAVqVqMK3lPdLE-unG0m-_CR7LW5cINZxp4V4i7t8v5lOrV1qp_n89PwxKbgB-gVx2cjFqh0jCIlZ9_ETrUb8U7kIWSDieOIeBOVdSYcOXrq-_bTiKZ-mDyzEt48NoHR_Alw6HHR6_i66zH2jEL0ZATyTfThf9UH4ZI281cQQWaW3Zyk-1OZrJ95y2O5v6kmcgCoLc9jYVAYIfNMjgSvuOo8hDaKQgCFJ327cm35N28yQZ6BpssTP5ThGdKbDxbg0lXeZIQhckZ4dO_yBFaF5S-RHyTqNu3L7SpqqChUNMji1fXG6b9FJN4pMe8QBMd6KfGktv4qAHfNN1SnYqmFzhWs_f9tvP9sVN9wUrTb2ZAHJomHVrIoFZux6BnqklDy4vE8BVLLLtw1rVusq8nTlxZaSKWY1ZZzVUO4z0o2Hc9EGolq1gEKn6Q4h8cFA1x2mQ_46rlLLPLjAEmiR8egYH23i_bxgLTmgX7x-smXrKh7_3T0ZyutpNKk4kgwXGteWLwHXWX66YOTYrwDTY4tGYOVfcI4LvwqMO8C543Cps6-SFaNC2q9BjhTVHe2Wj61ICssChAoD5shjPZPAPxWFi87wzIzZg1edUw9YRn9s4M0ZuaymLAee6y5DUVbVLlAydwYckR33p2Vy_CKORTMSP2BGgoKBIcW6liXUAcBxsOhScZgDixVWeoDWtyKWa3n5BkBbBRuj6v9_O9_QmgaYYo5CFumfXkknE1YjXypQp5P9Zk8tYZspvaAO4Wwq21-uRcpsJ65WoSKU8baxGF3Popxpf0R2in6Iy7S8keFKbLLyl0WBobD2Lv6w5X_zsE63-MeYZSqmPpXqdmiiqBbGOv7uSSjeNWbiESf0A2CwLgLgkrA=

## 10:16:30 UTC · Final

Lean 4.35 verified binary Goldbach for **134,217,728 consecutive even integers**, from **999,731,564,546 through 1,000,000,000,000 inclusive**. The joined theorem depends on `propext`, `Classical.choice`, and `Quot.sound`. [Proof and benchmark report](../../../work/grh-goldbach-20261120/team/finite-trillion-endpoint/BLOCK.md)

Generating, compiling, and checking all 256 rows took **83.72 CPU seconds** with one worker. The theorem check took 41.59 CPU seconds, **24.20 seconds above the matched import control**. Peak memory was 1.57 GiB. The shared factorial and prime bitmap were reused.

At this measured rate, extending an established \(10^{11}\) prefix through \(10^{12}\) would take about **78 core-hours**, plus final assembly. That estimate extrapolates one endpoint block. The intervening range still requires verification.

## 11:27:09 UTC · Final

The final-axis census found that **38.663 trillion of 39.242 trillion retained primitive outputs (98.53%)** use a terminal Bluestein postchirp under the frozen +640 schedule. This gives the population eligible for the proposed saving. A separate whole-transform HOL4 pilot reduced CPU by 15% at length 1,152, but increased it by 33% at length 32 and 8% at length 5,526. The measurements do not support a campaign-wide discount. [Census and benchmark](../../../work/backend-costs-20261112/hol-platt/large-axis-fused-tree/REPORT.md)

Lean also verified **all 524,288 even integers ending at \(10^{14}\)** using 78 Lucas-certified prime anchors and the shared prime bitmap. The successful path took **386.33 CPU seconds** and the theorem uses only `propext`, `Classical.choice`, and `Quot.sound`. This certifies the endpoint interval. The gap above the contiguous prefix remains open. [Proof and timings](../../../work/grh-goldbach-20261120/team/finite-pratt-14/README.md)
