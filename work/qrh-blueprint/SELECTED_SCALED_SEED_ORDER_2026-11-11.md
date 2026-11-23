# Select P27 for the current shifted-seed comparator

2026-11-11. This is a local choice within the reviewed scaled, coarse-to-fine seed construction. It does not select a globally optimal spectral algorithm. Use coarse order P27 and final order20 in the current shifted-seed comparator. Preserve P24 without shifting and independent fine P20 as alternatives until full arithmetic prices are available.

The scaled seed review proves the same sufficient base and internal precisions for P27 and P28: base radius2^-118, internal rounding2^-122, exported coefficient radius eta=2^-100. Both use the original D for normalization, including at midpoint outputs. Both satisfy the same final alpha-error requirement2^-82 when shift rounding is2^-110 and final Horner rounding is2^-100. Both use the same elementary argument sets, heights, EM head lengths, m=64 corrections, and final P20 transform inputs.

P27's certified alpha error uses the fraction

    10065943424467492228678097495
    /32076363635089380005973590016

of the2^-82 budget, less than one third. P28 has a smaller error bound, but the present consumer requests only2^-82. P27 can export that same larger certified radius; its actual tighter error need not become a different downstream interface. This choice requires keeping the other error allocations fixed. It does not say that P28 could never permit savings if some other allocation were redesigned.

At those fixed precisions, P27 omits the top coarse coefficient and one corresponding recurrence layer. It needs330 rather than350 midpoint updates per midpoint. The lower coefficient recurrences, exact rational arguments and their bit-width caps do not increase. The existing uniform width proof remains valid. A different midpoint numerical center is permitted under the common exported error contract; no identity with P28 output centers or containment in old fixed boxes is claimed.

The reviewed coarse-grid inventory gives the following extra work in P28 relative to P27:

| Category | P28 minus P27 |
| --- | ---: |
| Independent coarse coefficient slots | 717521408 |
| Head reciprocal scales | 2068094728192 |
| Head accumulator additions | 2068094728192 |
| Contracting E stages | 717521408 |
| Bernoulli weighted terms | 45921370112 |
| Midpoint shift stages | 14350428160 |

Elementary setup and total height/argument pairs are identical. The final P20 Horner and character transforms are identical in their schedules. Short coefficient and endpoint assembly loops also get shorter, not longer, under P27. Thus P28 adds work without strengthening the required output contract in this particular allocation. P27 is the appropriate default comparator here. Neither the table nor its subset argument is an end-to-end runtime estimate, and different realized centers could affect later adaptive margins if those margins are exploited instead of using the fixed exported contract.

The prerequisites are the frozen scaled seed report251B95AE92B6277C0B14C69F3CFE697F3100FD27C2D7963E4B42676FF4DAB231 and its review043E2E1630B19EC8EED9496FAA5D9AE6AF9C20944F7F2F5589B48E5A119C4F26; the shared EM report1E1D5099D398EE978D635729873F4D3941BC186BD91D086198B39962DF8E564E and reviewC4D2F0385C84FDC42B70D451378284E278EBA2527D0DC7B74BC9F85AECE73E4F; and the shifted-jet report861CA2C6F326C57AABDA40B72D723D537223BC0986F0AC25AAE5C6CD37DB2895 with reviewF190270EC3A359A1251E24C1039826EFE13897499DE540EA9F877331804748BB. No new numerical seed values or builds were used.
