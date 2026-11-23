# Erratum to the spectral certificate strategy

This companion corrects Section3 of `RESUME_SPECTRAL_CERTIFICATE_STRATEGY_2026-11-11.md`, frozen SHA256 `9EADB2E516E16C33AB0B0B618C771723712716ABA38B54F4965A37BF158A46CB`. The frozen file is unchanged.

The displayed aggregate Euler identity is restricted to c>1. At conductor one the defined function is the entire pole-corrected zetaF, agreeing with (s-1)zeta(s) away from1. Therefore, for Re(s)>1,

    -F_1'(s)/F_1(s)
      =sum_(n>=1) Lambda(n)n^(-s) - 1/(s-1).

The uncorrected Dirichlet series is the negative logarithmic derivative of zeta, not of zetaF. The relevant pinned source is `TernaryGoldbach/Explicit/ZetaDatum.lean:222`. The rectangle argument already uses zetaF, so its pole treatment and zero-count implication are unchanged.

The independent review also makes the proposed checker requirements explicit: neighboring panels must share the same rational endpoint vertices, including closure; the function must be holomorphic on a neighborhood of the rectangle; reflected panels must retain the correct orientation; the primitive-character enumeration must be complete; and the approximation remainder must hold throughout each panel. Endpoint samples alone do not suffice.

See [the independent review](../moebius/SPECTRAL_CERTIFICATE_STRATEGY_REVIEW_2026-11-11.md), SHA256 `2E39BDF6741A252F6A9F6DE8F9812AFFB5611D431AE424543536B4A48D0922CE`. It accepts the rectangle implication and dynamic base-gap height compatibility with this correction and these checker requirements.

No height checks were rerun, no contour experiment began, and no spectral or Lean proof status changed.
