from pathlib import Path
p=Path('work/qrh-campaign/agents/integration/BLUEPRINT_QRH_PROVIDER.md')
s=p.read_text(encoding='utf-8')
needle='The parallel local fixed-gap research uses the existing zero-free region'
insert='''The parent\'s proposed alternate budget uses a major-arc constant of `1.0404` with the current minor-arc constant of `1.0376`, leaving `0.0028 x²/κ`. To use that variant, the assembled count bound and final numerical comparison must both be proved with `0.0028`. The current `final_inequality_crude` proves the comparison with `0.0114`, so it does not by itself certify the smaller margin. These are proposed intermediate bounds; the current source has not changed.

There is numerical room for that variant in the existing nonprime estimate. Write `xOf N = N/c`, where the existing `xOf_denom_bounds` gives `c ≤ 2.02` and `κ = 49`. The normalized crude nonprime loss is bounded by

    6.7e6 * 49 * 4.0804 * log N / sqrt N.

This expression decreases for `N ≥ 10^27`. A floating-point consistency check at `10^27` gives `0.0026336197747554345`, below `0.0028` by about `0.00016638`. A certified endpoint estimate and the monotonicity proof remain required in Lean. The major-arc bound `1.0404` itself remains a separate analytic obligation. [Numerics.lean, lines 10–12 and 71–74](https://github.com/calr3/ternary-goldbach/blob/23b2d68ca344203d4384e0aff7affa4ec034bef9/TernaryGoldbach/Helfgott/Numerics.lean#L71), [Defs.lean, line 80](https://github.com/calr3/ternary-goldbach/blob/23b2d68ca344203d4384e0aff7affa4ec034bef9/TernaryGoldbach/Helfgott/Defs.lean#L80)

'''
assert needle in s
p.write_text(s.replace(needle,insert+needle), encoding='utf-8')
print('Blueprint lines',len(p.read_text(encoding='utf-8').splitlines()))

