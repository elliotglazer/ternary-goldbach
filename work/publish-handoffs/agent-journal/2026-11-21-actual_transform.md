# actual transform — 2026-11-21

## 07:49:39 UTC · Finding

gAAAAABrAU0R6K84ym2J6cUpY21P25BFsLE-zCF5SRim82waRvWDlsO_s21wAVmr1xsdHcTGHbcNVT4gE1P8ZBtacIzbaYbpr1G5Fv6MSoFBbtAKNiO3__msKSjJUzTpdtmhK62WDZYY9vhoK9ieJLr-asiXAUJLppt6e8Yd6ZBvn3Q85F8aRbJycLf2Qwr67jDKhQk8RBrHcBWdCVS8_oqWkm0EpESDIJ9UlW1oT7-8I-cYG0YLqiIrFdjlUAitGSrL5GlitpyGvakG1F1QARuY5uv52coBK8xn7eveDyGgh6Ax5B1tzer38aM7aSu61fSmk67A9MSTetCEvF4JmExVRuOEb_FAneJ1qQZhdB5a0fRSwyRAdb_CsHj8SiUmQ8u92o9WEt6KwRiXBEQqhNTEu6Eyc6Lo2skVYmwmpCWFeZ3o3vbEb8aIR9PrkpF6t5h1KKIFJxUxCnAnwT-xQvH8KAK6KLIFzHAClmmSpTs5GhZ8gLHzlPQYLTZPu9KmlSG98oF3B3lV6ly-pCTI10KKGe7axv4Nu9xd-qzAyJqnXGEpNvb0MpodJXEc8sawKLDGHPMYKegOLwnRKZ_HIoY89EccZA0Ct4KK7FfKrWbl2RkUGP1dYRWeSYjWvWooTT0u7LKp41cKjoPR5ZR_2Gn9UD6RHx3v-rh0dEvAsQXZiCs97mocc4sp7odCf5sS_i5RytN1Z2Bi59E5xGY2Yv-7QsVf9xZ3q1da73aP67x8dDHVefVOJTF8xCIPM1R5V00r2RrY8wQXtHUrGyX9Xqooku1yEWIirA==

## 08:00:38 UTC · Final

Lean verified binary Goldbach for every even integer from 4 through **11,207,959,552**. The proof extends the released \(10^{10}\) theorem by 603,979,776 consecutive even integers. Its axiom audit reports `propext`, `Classical.choice`, and `Quot.sound`. [Joined theorem](../../../work/grh-goldbach-20261120/team/small-prefix/contiguous-extension/ExtendedPrefixB.lean) · [Audit](../../../work/grh-goldbach-20261120/team/small-prefix/contiguous-extension/ExtendedPrefixB.log)

The two extension stages took **279.61 CPU seconds** for certificate production and serial Lean builds combined. Peak memory was **2.03 GiB**, and the workspace used **13.66 MiB** for sources, compiled objects, scripts, and receipts.

At \(10^9\), the factorial checker beat the LCM checker in both run orders by 5.73–6.06 CPU seconds. The extension therefore retained the factorial checker. At the measured extension rate, the remaining range through \(10^{11}\) would take **3.72 CPU-hours** for certificate production and shard checks, or **4.82 CPU-hours** if common setup and joins recur every four shards. Both estimates assume costs observed near \(1.1\times10^{10}\) persist as the primality cutoff rises.
