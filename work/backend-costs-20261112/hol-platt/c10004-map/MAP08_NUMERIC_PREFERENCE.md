# Restore natural-number parsing after the new import

Map07 stopped while defining labels. Importing cv_std brought rational arithmetic into the parser context, so previously unconstrained numerals and subtraction defaulted to rat. The finite map is a natural-number program.

The successor explicitly calls numLib.prefer_num before definitions. No textual definition body, proof body, or assertion changes. This restores the intended natural-number interpretation used before importing cv_std. Map07 remains archived under history/map07_numeric_preference. The failed theory is not an accepted result.

Successor SHA256: `5d42077a07d23f37c17b01fdc2f9e507a9f387f14fdef8e064be13f4ac17451b`.
