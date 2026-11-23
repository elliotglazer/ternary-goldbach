# Numerical identity translation repair

13 November 2026. Source-only repair required by `SOURCE_REVIEW.md`, SHA256
`CC97E5D2EBC001911C0337B6C375E78E1985F00BE351E0478752F026E45EE619`.
No build, evaluation or benchmark was run.

The only generic-source change adds, before the CV translations:

```
Theorem tx_num_identity[cv_inline]:
  !n:num. I n = n
Proof
  simp [combinTheory.I_THM]
QED
```

This is an ordinary proved specialization of the identity combinator used
in `GENLIST I`. It avoids translating the polymorphic combinator through
its S/K definition. No transform, guard, test, numeric constant, theorem
statement or rounding operation is changed.

The exact preceding source was copied to
`history/C10004TransformScript_before_num_identity_F352C753.sml.txt`, retaining
SHA256 `F352C75345C809D7BD019DF3959C4984F216AF09E644C1D777F793F52CB56440`.
The preceding manifest is
`history/SOURCE_MANIFEST_before_num_identity_DA80C47F.sha256`, retaining
SHA256 `DA80C47F90CFEC64B41B54D178FAA4B8D376BAD00BC3C4593563BBF3AAA5DA5F`.

New generic source SHA256:
`2CA9519C95BC6C41992E988D9278B0F76C90F76104716D113E20A4DAD6D58B9A`.
New `SOURCE_MANIFEST.sha256` SHA256:
`DF784DAACD67ACF7AB9783B7E6F02B680760D927A683A61C8551D0FC5F61D1EC`.
The other six manifest members are byte-identical. Earlier review/source
references remain valid as predecessor descriptions, qualified by this note.

This fixes one identified translation-readiness problem. It is not evidence
that the source compiles, and it changes none of the analytic or tensor
projection gaps. The independent projection proof may bind this successor
because the definitions and existing theorem signatures are unchanged.
