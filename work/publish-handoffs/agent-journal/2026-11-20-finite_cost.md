# finite cost — 2026-11-20

## 16:56:08 UTC · Finding

gAAAAABrAHuqf1TKy_mXTCmJoZLEdFkUPrM_jJ-CU3lX1UXLZifkK4JEYAcrR5hQn5sf1nwgnbQ5vZuwsl9y_RcULQB2fbUeCGLeht3-Ap1jrRnAe5WeVkeycDAGhdK-VVw45ygXad9jzC2d3Pdu421ZFKtxRhk5COXslDjX84DzpLBHtbHR68wYyIUUWGLOkymFnAmU1I44y27i1GgaoM0_XrqMX0_7D6mEz74rc0uQmNxD3QJAN9FgaRvBnY-saq_zviNjtusnEDI_go9RtI5ixmbl4yTC-noPHh6QSSiSnjR-rHTwRDQhrSf7ZurYfbO6ahyvihYTWE-8b0uH9uiqS5sys4ozI60fpdK-obFsUMWtPhdTA4bztfY16XKLZE9bOFyitc2XBwqfbJZ4aIc7Hg1cKy0Xz2QURcqwr_89BuBl-_jJC54n42-tURSKVCzl6SUv2yCSpGnBMihYMe0Ce2imAKlClYdhWDP2PB6Yh8b6meB-AYUiXq0IDL-mtCc2L8O14s5K4LNpeed2Q4ern9I_AXWz12IZnSQ847P44pUtpF03uXkkBL0mkIHZfCCPhdgaSE6DlhdIiRTmpGZsMtpFqGXziFok2MzXY_hFiyGwJID77IIuRKYgeNsOYtrb0XnVxh_l82Q8_InPACOzpmkCGFYtru3FunStH90dzACfi8Hq0-l0F88SmKM2jHGupLgstyMXE4aGoVFc2uU_gIFLtlscrjL95sX3NQwoZQf7mpsDBSIdl8g9vJZCvG5Y_UGGLvfd

## 16:56:13 UTC · Final

The \(10^{16}\) binary Goldbach computation projects to **102,000 physical core-hours** for certificate production and first Lean acceptance. The modeled range is **52,000 to 706,000 core-hours**. A 12-hour run would require about **12,140 comparable cores at 70% utilization**, once the checker is ready.

The decision to rent a fleet turns on a measurable threshold. With 16,384 cores and 12 hours, each block can consume at most **381 CPU-seconds** after reserving the modeled shared-table cost. The forecast assumes 271 seconds. A full-scale Lean block benchmark and measurements of table preparation and I/O are still needed.

The executable model, results and assumptions are in the [estimate](../../../work/grh-goldbach-20261120/team/finite-cost/estimate.md).

## 16:58:18 UTC · Final

At **1 ms per accepted rung**, the least expensive modeled Saouter ladder uses binary Goldbach through **\(5.75\times10^{15}\)** and costs **115,000 core-hours**. At **0.1 ms**, the optimum falls to \(1.59\times10^{15}\) and **44,400 hours**. At **10 ms**, it rises to \(1.98\times10^{16}\) and **315,000 hours**.

Binary checking alone costs an estimated **37,100 hours** through \(2.51\times10^{15}\), or **110,400 hours** through \(1.1\times10^{16}\). The estimates charge the shared table once. Ladder totals assume each ordinary window yields a certified prime at the stated throughput. Exceptional repairs remain unpriced. [Comparison and reproducible model](../../../work/grh-goldbach-20261120/team/finite-cost/ladder.md)

## 17:53:31 UTC · Finding

gAAAAABrAIkd_0nroDQcXagEtWWyOwT2FmA_BFJ83wwYbtJQ3E6u3aRAAA3qkyXvSroXhyWvrz0JLW1-hJXFrUdtREiNYCMpV-uFuosHuqJjR6yzGPaCzuxmqre8uGRZoesbcLv6Mg6nvhfaaHjp6-5zLPOhxpZcRZyiS7oguC_vNz7PSGb8VNVeheXrd1_4GNV5kCu26hKpbc-qBWr_Wam2_ssM2qNNjg_ywYJBIFmTb94G9aXDgW-rG8g131uMUFMnltSBpdpHrNF2xU6kkC5Uoaz995ND2rbX0SS-Qj_Zh_Izz0wDQyCUPYcXp9l2ZTyC2buLYapKfsVc5gAJ2CAspAchdJRkBAWFOynHTqQSRF2BFR26xZV4x_8yuVLmLKKY2O-Rjt7FuERQG2_mX3XwiF2zs3ekeDZBD7v7mQda10wt3N4rH2y50FTU4gHxOL06dsUue0e-1x6qMHv3w3XCIY1L4xl5DwTrbqGMK433bsM_bcdTmuEkLa13hleME4FSC9nh-CPtplGddGEqBpjQ89xiVvmQ2iWGFhK3t7PEv1385OkNBIGEmOZBo2LXmyJ7fwrydP-rHRS5letta4kTa7QuXChl89H7Vpj2NQs0jdA7r0q6WlAVrOBH-Z5oiYK-8DYIbEOBSimHDiuWOSiOj1dJ3NlF0V7A-NniisCYY0pNiESzwz-AZGmH6pV0loe_z3unTR8Ph0b5B3jXlbxFpwI3B4fK1YgupLV7nfQg4XnGbvH2J5yDFtbGY5Y_yfW4FJ-TBn6QuPbpCIjIOeHAQplmKg5nlNTP-Evl7wIr-ejvFVDFuJR3Tyhyz_IkQUaiVqhqRK0aLkLJnJMIOgt4BBM6So1n8Rsg_-45DdXJieKzqULE2YKuNwWQkRX-GEZfNNgweqWibch8yMZIzl8wdot_WB6kuw==

## 18:30:06 UTC · Finding

gAAAAABrAJGwAUUXqxN_Yc0QgvIZBQwlfpjUy0xiQbJTr9yb-2XgZcmjlVZavkjSuNVMot6wYXZ3DWavRMiH6tGHEh_po4itHx5R7Y13aZ8t1GyE--fYxe08Aj4BBQTnt7Ypv8453llafIqNBWkfeLWxFPk81_EvOdlygg9qR5_W-32e7P1rfp9Q-Qkb6b8A2KDWwDnYyuUZh2DklXDudxZRS9oQH7YNhCjA9bAbYhl5-DBNjrypXQhYg73p8zSMqPIqGR5bv-6V065yarXyUQp7MWGZMk-rHHyO_14n2QiQq9FC1U3v4-SSyoI_LwYhLyPnHLyum-GFtDl1t2uv4hy5Ht6cIdLxAKJorbNpLuEG3RM8CfB-y-t2_VaJ6A6JHco5gua9o8o-p18g93_OmsBz0EJeqssW257dUo_b450tXpJ3ohgMfnP8PWgyivaFQWoOUTxSlXBJfObbXnUnLlxrpbQ7Y3dvRe2TDFZCZydTcj0bVrOyVGNRbNrECwNv40qJZiNATsonstJpEi48QIW6yPSIwCcnRvLWYqkoL5ueLICQRE-ffZE6A4UyfT2mb03VbbxL1q6qprhUCMxdf4h-C8dHHQTurP1TB1EUKOX3Eonev3MKMOcMl_7KrdUkiEJI8xbJ8C3ebt1yqJJ1_wZxq_gHuiDedYBEAprkvhwzugV8gc4t6oYcRp0oWrcf05uEPkByahs1V-xWl0CF2CVbi6nkFW0ExhhOe5rwFbimMicXveGWMraci0e2QoZNmTSrdZLSjN15otm9btgyR9P-2ZS5lmR7h4W1MSzT9Bp3S8eXZ9uyJb8=

## 18:34:22 UTC · Final

Lean now verifies **16,384 consecutive even integers through \(4\times10^{15}\)** using the three standard axioms. A separate checked proof shares one set of 38 prime anchors across two distinct source windows, reducing the final theorem’s warm assembly time to 12 ms for both windows together.

At production tile width, Lean checked the arithmetic and interval proofs for **524,288 consecutive evens**. Closing these two theorems requires primality certificates for the 43,755 marked source primes and 164 anchors.

The revised **binary-only** estimate is **60,300 core-hours through \(4\times10^{15}\)** or **123,800 through \(10^{16}\)**. It remains a planning estimate until a full production block demonstrates the assumed throughput, including certificate generation and final assembly. [Theorems, timing receipts, and reproduction commands](</work/grh-goldbach-20261120/team/finite-cost/implementation.md>)
